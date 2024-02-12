/* THIS PROGRAM CREATES sanctions_1989_to_2008.dta USING ORIGINAL Sanctions_SUBJECT TO SANCTION.csv DATA */
#d;
clear all;
set more off;
set matsize 11000;
set maxvar 120000;
capture log close; 

gl dir = "/home/Crowdout"; 
	
gl data = "${dir}/data/original";
gl intermediate = "${dir}/data/intermediate";
gl pell = "${data}/Pell";
gl cdr = "${data}/CDR";
gl zip = "${data}/Zip Codes";
gl output = "${dir}/output";
gl programs = "${dir}/programs/callable_programs";

cd "${dir}/programs";

/* INPUTTING .CSV FILES */
foreach year in 1989 1990 1991 1992 1993 1994 1995 1996 1997 1998 1999 2000 2002 2006 2007 2008 {;
	insheet using "${cdr}/1989-2008 Sanctions_SUBJECT TO SANCTION - `year'.csv", names clear;
	capture drop if opeid == .; 
	tempfile sanction`year';
	save `sanction`year'', replace;
};

use `sanction1989', clear;
foreach year in 1990 1991 1992 1993 1994 1995 1996 1997 1998 1999 2000 2002 2006 2007 2008 {;
	append using `sanction`year'';
};

rename year cohort_year; 
rename ope_id opeid;
rename sch_nm name;
replace sanc_desc = ltrim(rtrim(itrim(sanc_desc)));

gen loss_loans_only = sanc_desc == "Immediate loss of GSL, FFEL, and FDSLP" | sanc_desc == "Immediate loss of FFEL, and FDSLP" | sanc_desc == "Immediate loss of FFEL, and FDSLP ";

gen loss_loans_pell = sanc_desc == "Limitation, suspension, or termination of Title IV" | sanc_desc == 	"Immediate loss of FFEL, FDSLP and PELL" 
	| sanc_desc == "Immediate loss of FFEL, and FDSLP and Pell"  | sanc_desc == "Immediate loss of FFEL, FDSLP and PELL"  
	| sanc_desc == "Potential or immediate loss of Pell" | sanc_desc == "Immediate loss of FFEL, FDSLP and PELL";

drop sanc_desc;

gen sanc_reason_1yr = substr(reas_desc,1,1) == "C" | substr(reas_desc,1,1) == "O";
gen sanc_reason_3yr = substr(reas_desc,1,1) == "T" ;
 
drop reas_desc ;

* ADD 2 TO YEAR VAR (YEAR LISTED IS THE COHORT YEAR, COHORT YEAR + 2 IS WHEN INFORMATION ON CDRS IS RELEASED, ALTHOUGH USUALLY ANOTHER YEAR PASSES BEFORE SANCTION);
gen year = cohort_year+2;

* FOR NOW, IF A SCHOOL RECEIVES MULTIPLE SANCTIONS IN A GIVEN YEAR, COLLAPSE INTO ONE OB;
preserve;

	collapse (max) loss_loans_only loss_loans_pell cohort_year sanc_reason_*, by(opeid year);
	save scrap, replace;

	recode loss_loans_only (1 = 0) if loss_loans_pell == 1; 

restore;

keep opeid year name ;
duplicates drop;
merge 1:1 opeid year using scrap, update; drop _m;
erase scrap.dta;

compress;

save "${intermediate}/sanctions_1991_to_2010", replace;

/* COMPLETE APPEALS DATA FOR 1995 THROUGH 2008 COHORTS (OBSERVE ALL APPEALS, REASONS, AND OUTCOMES) FROM FOIA REQ */
foreach y of num 1995(1)2000 {;

	insheet using "${appeals}/appeals_from_school_eligibility_foia_doc_`y'.csv", names clear; 
	
	recode year (. = `y'); 
	
	for any sch_nm ope_id year \ any name opeid cohort_year : rename X Y;
	replace name = proper(ltrim(rtrim(itrim(name))));

	capture drop priorloss; 
	
* ACADEMIC YEAR THAT SANCTION UPHELD;
	gen loss_year = real(substr(lossdate,-4,4)); gen loss_month = real(subinstr(substr(lossdate,1,2),"/","",.));
	replace loss_year = loss_year+1 if loss_month>=6; 
	drop loss_month lossdate; 
	
	gen loss_loans_only = sanc_desc == "Immediate loss of GSL, FFEL, and FDSLP" | sanc_desc == "Immediate loss of FFEL, and FDSLP" | sanc_desc == "Immediate loss of FFEL, and FDSLP";

	gen loss_loans_pell = sanc_desc == "Limitation, suspension, or termination of Title IV" | sanc_desc == 	"Immediate loss of FFEL, FDSLP and PELL" 
	| sanc_desc == "Immediate loss of FFEL, and FDSLP and Pell"  | sanc_desc == "Immediate loss of FFEL, FDSLP and PELL"  
	| sanc_desc == "Potential or immediate loss of Pell" | sanc_desc == "Immediate loss of FFEL, FDSLP and PELL"
	| sanc_desc == "Immediate loss of GSL, FFEL, and FDSLP, potential or immediate loss of Pell";

	gen any_appeal_ll = ~(appealtype =="" | appealtype =="na") & loss_loans_only == 1; 
	gen any_appeal_lp = ~(appealtype =="" | appealtype =="na") & loss_loans_pell == 1; 
	gen sanc_upheld_ll = appealstatus ~= "Win" & loss_loans_only == 1; 
	gen sanc_upheld_lp = appealstatus ~= "Win" & loss_loans_pell == 1; 
	
	drop sanc_desc; 
	
	gen sanc_reason_1yr = substr(reas_desc,1,1) == "C" | substr(reas_desc,1,1) == "O";
	gen sanc_reason_3yr = substr(reas_desc,1,1) == "T" ;
	
	drop reas_desc appealtype; 
	
* DEAL WITH DUPLICATE OBS; 
	collapse (max) any_appeal_* sanc_upheld_* loss_loans_* sanc_reason_* (min) loss_year , by(opeid cohort_year); 

	drop if opeid==.;

	if `y'>1995 {; append using scrap; };
	save scrap, replace; 
	
* CLOSE LOOP OVER FILE YEARS;
};
 

use "${intermediate}/sanctions_1991_to_2010", clear;

merge 1:1 opeid cohort_year using scrap, update; 
drop if _m ==2; drop _m; 

drop if opeid == .; 

foreach v of var any_appeal_* {; recode `v' (. = 0) if cohort_year>=1995 & cohort_year<=2000; };
foreach v of var sanc_upheld_* {; recode `v' (. = 1) if cohort_year>=1995 & cohort_year<=2000; };

* DEAL WITH RECORDS THAT ARE PART OF SYSTEMS THAT REPORT RECIPIENTS TOGETHER; 
recode opeid (164800	164900	165000	165200	165400	165500	475900	476500 976700 = 164700); /* City Colleges of Chicago */
recode opeid (2506100 268700	268800	268900	269000	269100	269200	269300	269400	269600	269700	269800	702200	702600	727300	861100	1009700	1005100 = 268600); /* CUNY*/
recode opeid (3000800 3000900 = 2278400 ); /* Jett Clg Cosmetology & Barbering   Memphis */

foreach v of var loss_loans_only loss_loans_pell sanc_reason_1yr sanc_reason_3yr {;
	bysort opeid year: egen dum = max(`v'); replace `v' = dum; drop dum; 
};

foreach v of var any_appeal_ll - loss_year {;
	bysort opeid year: egen dum = min(`v'); replace `v' = dum; drop dum; 
};

bysort opeid year : gen first = _n == 1; keep if first; drop first; 

* DROP OBS FROM SCHOOLS THAT AREN'T IN US 50+DC;
foreach o in 2166400 2189100 2317400 2504500  2552300 {; drop if opeid == `o'; };

compress; 

save "${intermediate}/sanctions_1991_to_2010", replace;

erase scrap.dta; 

