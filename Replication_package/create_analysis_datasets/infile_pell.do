/* THIS PROGRAM CREATES pell_merged_1974_to_2012.dta USING ORIGINAL PELL GRANT ADMIN DATA */
/* PELL GRANT ADMIN DATA FILES FOR AY 2000 - PRESENT ARE AVAILABLE FOR DOWNLOAD AT: https://www2.ed.gov/finaid/prof/resources/data/pell-institution.html */
/* EARLIER FILES CAN BE REQUESTED BY EMAILING THE CONTACT LISTED ON SAME PAGE */


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

* CROSSWALK BETWEEN PELL ID AND OPEID USING 2013 PEPS DATA (CURRENT DATA FILES AVAILABLE AT: https://www2.ed.gov/offices/OSFAP/PEPS/dataextracts.html);
insheet using "${data}/SCHIDS062813.txt", names clear; 
keep opeid pell_id_current pell_id_prev; rename pell_id_current pellid; drop if pellid ==.;

* DEAL WITH DUPLICATES (PELLID MATCHING TO MULTIPLE OPEIDS);
* DROP BRANCH CAMPUSES;
tostring opeid, replace; gen last = substr(opeid,-2,2); keep if last == "00"; drop last;

* IF PREVIOUS PELL ID AND MULTIPLE OBS, USE THIS;
bysort pellid: gen count = _N; replace pellid = pell_id_prev if count == 2 & pell_id_prev ~=.; drop count;

* WITH OTHER MULTIPLES, KEEP OB WHERE PELLID = OPEID;
bysort pellid: gen count = _N; destring opeid, replace; 
gen dum = count == 2 & pellid*100 == opeid; 
bysort pellid: egen max = max(dum); drop if max == 1 & dum == 0; drop count max dum;

* DROP THE REMAINING FOUR BY HAND BY CHECKING SCHOOL NAME, CITY, STATE, ETC. BY HAND;
drop if pellid == 15035 & opeid == 2140500;
drop if pellid == 15520 & opeid == 2507100;
drop if pellid == 16727 & opeid == 2355900;
drop if pellid == 16929 & opeid == 2521700;

save "${intermediate}/SCHIDS062813", replace;

keep pell_id_prev opeid; rename pell_id_prev pellid; drop if pellid == .;
save "${intermediate}/SCHIDS062813_prev", replace;

* 1974 (REFERS TO 1973-74 ACADEMIC YEAR (E.G., SEPT 1973 - AUG 1974);
insheet using "${pell}/AY1974Pell.txt", names clear; 

gen year = 1974;

drop initialauthorizationamount ;
rename currentedapprovedauthorizationam totaldisbursed;
rename recips recipients;
	
merge 1:1 pellid using "${intermediate}/SCHIDS062813", update; drop if _m == 2; drop _m; 
/*tostring pellid, replace; gen opeid = real(pellid+"00"); drop pellid;*/

merge 1:1 pellid using "${intermediate}/SCHIDS062813_prev", update; drop if _m == 2; drop _m; 

replace opeid = pellid*100 if opeid ==.;

* FIX INCORRECT OPEIDS MANUALLY MATCHING TO 2000 PELL GRANT FILE BY NAME AND LOCATION;
recode opeid (406600 = 748400) (167200 =  1072700) (789000 = 2065300);

save scrap, replace; 			

* 1975-1976;
forv y = 1975/1976 {;

	insheet using "${pell}/AY`y'Pell.txt", names clear;

	rename awardyear year;
	drop opeid; 
	drop initialauthorizationamount ;
	rename currentedapprovedauthorizationam totaldisbursed;
	rename recips recipients;
	
	merge 1:1 pellid using "${intermediate}/SCHIDS062813", update; drop if _m == 2; drop _m; 
	
	merge 1:1 pellid using "${intermediate}/SCHIDS062813_prev", update; drop if _m == 2; drop _m; 
	
	replace opeid = pellid*100 if opeid ==.;
	 			
	append using scrap; save scrap, replace;
	
* CLOSE LOOP OVER YEARS;
};

* 1977 - 1982;
forv y = 1977/1982 {;

	insheet using "${pell}/AY`y'Pell.txt", names clear; 

	rename awardyear year;
	drop if year == .;
	drop opeid; capture drop v*; 
	drop initialauthorizationamount ;
	rename currentedapprovedauthorizationam totaldisbursed;
	rename recips recipients;
	rename insttype institutiontype ;
	
	merge 1:1 pellid using "${intermediate}/SCHIDS062813", update; drop if _m == 2; drop _m; 
	
	merge 1:1 pellid using "${intermediate}/SCHIDS062813_prev", update; drop if _m == 2; drop _m; 
	
	replace opeid = pellid*100 if opeid ==.;

	tostring zip, replace;
	
	append using scrap; save scrap, replace;
	
* CLOSE LOOP OVER YEARS;
};

* 1983-1990;
forv y = 1983/1990 {;
	insheet using "${pell}/AY`y'Pell.txt", names clear;

	gen year = `y';
	rename grants totaldisbursed;
	rename recips recipients;
	
	merge 1:1 pellid using "${intermediate}/SCHIDS062813", update; drop if _m == 2; drop _m; 
	
	merge 1:1 pellid using "${intermediate}/SCHIDS062813_prev", update; drop if _m == 2; drop _m; 
	
	replace opeid = pellid*100 if opeid ==.;

	append using scrap; save scrap, replace;
	
* CLOSE LOOP OVER YEARS;
};

* 1991-1997;
forv y = 1991/1997 {;

	insheet using "${pell}/AY`y'Pell.txt", names clear;

	gen year = `y';
	capture drop type control;
	
	rename grants totaldisbursed;
	rename recips recipients;
	
	merge 1:1 pellid using "${intermediate}/SCHIDS062813", update; drop if _m == 2; drop _m; 
	
	merge 1:1 pellid using "${intermediate}/SCHIDS062813_prev", update; drop if _m == 2; drop _m; 
	
	replace opeid = pellid*100 if opeid ==.;

	append using scrap; save scrap, replace;
	
* CLOSE LOOP OVER YEARS;
};

* 1998;
insheet using "${pell}/AY1998Pell.txt", names clear;

gen year = 1998;
	
rename awards totaldisbursed;
rename recips recipients;
rename institutiontypecontrol typecontrol;
	
merge 1:1 pellid using "${intermediate}/SCHIDS062813", update; drop if _m == 2; drop _m; 

merge 1:1 pellid using "${intermediate}/SCHIDS062813_prev", update; drop if _m == 2; drop _m; 

replace opeid = pellid*100 if opeid ==.;

append using scrap; save scrap, replace;

* 1999;
insheet using "${pell}/AY1999Pell.txt", names clear; 

gen year = 1999;

capture destring totaldisbursed, replace force; 
replace totaldisbursed = round(totaldisbursed);

rename schooltype typecontrol;

gen pellid = opeid/100; drop opeid; 

merge 1:1 pellid using "${intermediate}/SCHIDS062813", update; drop if _m == 2; drop _m; 

merge 1:1 pellid using "${intermediate}/SCHIDS062813_prev", update; drop if _m == 2; drop _m; 

replace opeid = pellid*100 if opeid ==.;

append using scrap; save scrap, replace;

* CLEAN UP; 
erase "${intermediate}/SCHIDS062813_prev.dta";
erase "${intermediate}/SCHIDS062813.dta";

* 2000-2006;
forv y = 2000/2006 {;

	insheet using "${pell}/AY`y'Pell.txt", names clear; 

	gen year = `y';
	
	capture destring totaldisbursed, replace force; 
	replace totaldisbursed = round(totaldisbursed);
	
	rename schooltype typecontrol;
	
	append using scrap; save scrap, replace;
	
* CLOSE LOOP OVER YEARS;
};
	
* 2007 - 2012;
forv y = 2007/2012 {;

	insheet using "${pell}/AY`y'Pell.txt", names clear;

	gen year = `y';
	
	foreach v of var schooltype {; replace `v'= proper(`v'); };

	capture destring totaldisbursed, replace force; 
	capture destring recipients, replace force;
	replace totaldisbursed = round(totaldisbursed);
	
	tostring zipcode, gen(zip); drop zipcode;
	
	rename schooltype typecontrol;
	
	append using scrap; save scrap, replace;
	
* CLOSE LOOP OVER YEARS;
};
	
move opeid name; move year name;
sort opeid year;

drop if opeid == . & name == "";

foreach v of var name address city {; replace `v'= proper(ltrim(rtrim(itrim(`v')))); };

* MANUALLY FIX RECORDS THAT ARE MISSING OPEIDS;
recode opeid (. = 531900) if name =="Foothills Technical Institute";
recode opeid (. = 1084800) if name == "Quapaw Technical Institute";
recode opeid (. = 735300) if name == "Nei College Of Technology"; 
recode opeid (. = 337901) if name == "University Of Pittsburgh At Titusville";
recode opeid (. = 548836) if name == "Louisiana Technical College - Sowela Campus";
recode opeid (. = 337903) if name == "University Of Pittsburgh - Bradford";
recode opeid (. = 338200) if name == "University Of Pittsburgh At Johnstown";
recode opeid (. = 337904) if name == "University Of Pittsburgh - Greensburg";
recode opeid (. = 817200) if name == "Southwest Kansas Technical School";
recode opeid (. = 1101701) if name == "Herzing College";

* FIX RECORDS THAT ARE IDENTIFIED AS DUPLICATES OBS OF THE SAME SCHOOL (E.G., SAME ADDRESS AND NAME, BUT DIFFERENT OPEIDS);
qui do "${programs}/fix_duplicates.do"; 

* GENERATE SEPARATE VARIABLES FOR SCHOOL LEVEL & CONTROL;
encode typecontrol, gen(dum);
gen control = 1 if inlist(dum,7,8,9,10); replace control = 2 if inlist(dum,1,2,3,4,5); replace control = 3 if dum == 6;
lab define control 1 "Public" 2 "NP" 3 "FP"; label val control control;

gen level = 2 if inlist(dum,2,3,8,9); replace level = 1 if inlist(dum,4,10); drop dum; drop typecontrol;
lab define level 1 "4 year" 2 " 2 year" ; label val level level;

* DROP OBS THAT ARE NOT IN US 50;
foreach s in "AS" "FM" "GU" "MH" "MP" "PW" "PR" "T" "VI" {; drop if state == "`s'"; };

* FIX ZIPCODES TO REPRESENT 5 DIGIT ZIP (ZIP2 REPRESENTS 4 DIGIT EXTENSION);
gen length=length(zip);
replace zip = "0"+zip if inlist(length,4,8);
replace length = length(zip);
replace zip =substr(zip,1,5) if length ==9;
drop length;

* DROP OBS OF BRANCH CAMPUSES THAT NEVER SHOW UP WITH PELL GRANT RECIPIENTS;
tostring opeid, replace; gen dum = real(substr(opeid,-2,2)); drop if recipients == . & dum ~=0; 

* COLLAPSE BRANCH CAMPUSES INTO MAIN CAMPUSES;
gen length = length(opeid); 
replace opeid = substr(opeid,1,4)+"00" if dum ~=0 & length == 6;
replace opeid = substr(opeid,1,5)+"00" if dum ~=0 & length == 7;

drop length;

bysort opeid year: gen count = _N;

preserve;
	
	keep if count>1 ; 
	collapse (sum) recipients totaldisbursed, by(opeid year);
	save scrap, replace;

restore;

* DROP BRANCH CAMPUSES;
drop if count>1 & dum ~=0; 

* DROP ONE OF EACH OF THE DUPLICATE OBS FROM 1975 - 1984;
bysort opeid year (recipients): gen first = _n == 1;
drop if count >=2 & first == 0 & dum ==0; drop first ; 

foreach v of var recipients totaldisbursed {; replace `v' = . if count>1; }; drop count;

merge 1:1 opeid year using scrap, update; 

drop dum _m pellid pell_id_prev; destring opeid, replace;

gen in_pell = 1; 

compress; 

save "${intermediate}/pell_merged_1974_to_2012", replace; 

** NOW ADD INFO ON CDRS;
preserve;

	use "${intermediate}/cdr_1990_to_2009", clear; 

	keep opeid name year city state zip nbr nbd control level drate; 
	
	gen in_cdr = 1; 
	
	save scrap, replace;

restore;

merge 1:1 opeid year using scrap, update; rename _m merge_pell_cdr; recode in_cdr (. = 0); 

* ADD SANCTION INFO; 
merge 1:1 opeid year using "${intermediate}/sanctions_1991_to_2010", update; 
replace in_cdr = 1 if _m>=3; drop _m; 

* DROP OBS THAT ARE SYSTEM OFFICES ONLY (RECIPIENTS ARE DISTRIBUTED ACROSS LOCATIONS BELOW); 
foreach n in 686300 878800 854600 913500 991100 {;
	drop if opeid == `n'; 
};

save scrap, replace; 

capture destring opeid, replace; 

* ADD IMPUTED PELL/CDRS FROM SYSTEMS THAT REPORT RECIPIENTS IN ONLY ONE LOCATION FOR SOME YEARS;
foreach f in public dvry itt {;

preserve;

di "`f'"; 

	insheet using "${intermediate}/imputed_`f'_recipients.txt", clear;
	drop if opeid == .;  capture gen drate = .; 
	gsort opeid year -drate imputed_recipients;
	bysort opeid year: gen first = _n == 1; 
	keep if first == 1; drop first; 
	merge 1:1 opeid year using scrap, update; drop _m; 
	save scrap, replace; 
	
restore;

* CLOSE LOOP OVER IMPUTATION FILES; 
};

use scrap, clear; 
replace recipients = imputed_recipients if imputed_pell_ind == 1;
replace nbr = imputed_nbr if imputed_nbr_ind == 1;
drop imputed_recipients imputed_nbr; 

* DROP OBS FROM TERRITORIES;
drop if inlist(opeid,1001000 , 1034300 , 1100900,3033000);

* IMPUTE ADDRESS, LEVEL, CONTROL ACROSS ALL YEARS FOR A GIVEN INSTITUTION USING MODAL VALUE;
foreach v of var name state zip address city {;
	bysort opeid: egen dum = mode(`v'), minmode;
	replace `v' = dum if `v' ==""; 
	drop dum;
};

foreach v of var control level {;
	bysort opeid: egen dum = mode(`v'), minmode;
	replace `v' = dum if dum ~=.; 
	drop dum;
};

* NOW ADD INFO ON SCHOOL CLOSURES FROM PEPS; 
do "${programs}/add_closed_school_info.do";

drop _m;

* AGAIN IMPUTE ADDRESS, LEVEL, CONTROL ACROSS ALL YEARS FOR A GIVEN INSTITUTION USING MODAL VALUE;
foreach v of var name state zip address city { ;
	bysort opeid: egen dum = mode(`v'), minmode;
	replace `v' = dum if `v' ==""; 
	drop dum;
};


foreach v of var control level {;
	bysort opeid: egen dum = mode(`v'), minmode;
	replace `v' = dum if dum ~=.; 
	drop dum;
};

* CREATE FILE WITH ONE OB PER OPEID-YEAR FOR SCHOOLS THAT HAVE AT LEAST 1 PG RECIP OR BORROWER IN ANY YEAR;
* WILL LATER DROP OPEID-YEAR OBS FROM BEFORE THE SCHOOL IS OPEN OR AFTER IT IS CLOSED;
preserve;

	keep opeid year recipients totaldisbursed control level;
	reshape wide recipients totaldisbursed, i(opeid) j(year);
	reshape long recipients totaldisbursed, i(opeid) j(year); 
	recode recipients (. = 0); recode totaldisbursed (. = 0); 
	
	save scrap, replace;
	
restore;

merge 1:1 opeid year using scrap, update; drop _m; 

erase scrap.dta;

recode in_pell (. = 0); 
recode in_cdr (. = 0);

foreach v of var name address city {; replace `v'= proper(ltrim(rtrim(itrim(`v')))); };

* ADD INFO FROM POSTSECONDARY CAREER SCHOOL SURVEY ; 
merge 1:1 opeid year using "${intermediate}/pcss_has_opeid", update; 

* DROP OBS OF SCHOOLS IN THE PCSS THAT NEVER SHOW UP IN PELL OR LOAN DATA;
bysort opeid : egen max = max(_m); bysort opeid : egen min = min(_m); 

drop if min ==2 & max == 2; drop min max;
rename _m merge_pcss;  

* ADDITIONAL MATCHES;
merge 1:1 opeid year using "${intermediate}/pcss_adtl_matches", update; drop if _m == 2; replace merge_pcss = _m if _m>=3; drop _m;

replace state = stabbr if state =="" & stabbr ~=""; 

* AGAIN IMPUTE ADDRESS, LEVEL, CONTROL ACROSS ALL YEARS FOR A GIVEN INSTITUTION USING MODAL VALUE AFTER ACCOUNTING FOR PCSS RECORDS;
foreach v of var name state address city { ;
	bysort opeid: egen dum = mode(`v'), minmode;
	replace `v' = dum if `v' ==""; 
	drop dum;
};

* SET ZIPCODES TO BE CONSTANT WITHIN AN INSTITUTION;
bysort opeid: egen dum = mode(zip), minmode; 
replace zip = dum; drop dum; 

foreach v of var control level {;
	bysort opeid: egen dum = mode(`v'), minmode;
	replace `v' = dum if dum ~=.; 
	drop dum;
};


* KEEP SCHOOLS WITH EITHER PELL RECIPIENTS OR STUDENT BORROWERS IN THE 10 YEAR WINDOW AROUND THE 1ST AND LAST SANCTIONS (1981-2010); 
*drop if year<1981 | year>2010; 

gen dum = year>=1981 & year<=2010; 

bysort opeid: egen in_pell_max = max(in_pell*dum); 
bysort opeid: egen in_cdr_max = max(in_cdr*dum); 

drop dum; 

drop if in_pell_max == 0 & in_cdr_max ==0; 
compress; 

* DROP 13 SCHOOLS FOR WHICH WE CANNOT DETERMINE CONTROL (NONE HAVE PG ENROLLMENT AFTER 1982); 
drop if control == .; 

gen len = length(zip); replace zip = "0"+zip if len == 4; drop len; 
	
rename fips fips_alt; 

** MERGE ON COUNTY FIPS CODES TO ZIP CODES BY DECADE;
preserve;

	do "${programs}/infile_zip_countyfips_xwalk.do"; 
	
restore;

* 1974-1995: USE 1990 XWALK;
preserve;

	use zipcty_xwalk, clear;
	keep zip fips1990 state1990 county1990; 
	foreach v in fips state county {; ren `v'1990 `v'; };
	save scrap, replace;

restore;

merge m:1 zip using scrap, update; 
drop if _m ==2; drop _m;
foreach v of var fips county {; replace `v' = "" if year>1995; };

* 1996-2005: USE 2000 XWALK;
preserve;

	use zipcty_xwalk, clear;
	keep zip fips2000 state2000 county2000; 
	foreach v in fips state county {; ren `v'2000 `v'; };
	save scrap, replace;

restore;

merge m:1 zip using scrap, update; 
drop if _m ==2; drop _m;
foreach v of var fips county {; replace `v' = "" if year>2005; };

* 2006+: USE 2010 XWALK;
preserve;

	use zipcty_xwalk, clear;
	keep zip fips2010 state2010 county2010; 
	foreach v in fips state county {; ren `v'2010 `v'; };
	save scrap, replace;

restore;

merge m:1 zip using scrap, update; 
drop if _m ==2; drop _m;

** NEXT, USE ALTERNATE ZIP CODE - COUNTY XWALK; 
preserve;
		
	do "${programs}/infile_xwalk2.do";

restore;

merge m:1 zip using zip_temp, update; 

drop if _m == 2; drop _m;

bysort opeid: egen dum = mode(fips), minmode;
replace fips = dum; drop dum; 

** MANUALLY ENTER FIPS CODES FOR 32 INSTITUTIONS THAT DON'T MATCH VIA ANY CROSSWALK;
preserve;
	insheet using "${zip}/missing_fips.txt", names clear;
		
	tostring fips, replace;
	gen length=length(fips);
	tab length;
	replace fips= "0"+fips if length ==4;
	drop length;
		
	keep opeid fip;
	
	save missing_fips, replace;
			
restore;

merge m:1 opeid using missing_fips, update; 
drop if _m == 2 ; drop _m;
erase missing_fips.dta; 

bysort opeid: egen dum = mode(fips), minmode;
replace fips = dum; drop dum; 

* DROP 4 SCHOOLS THAT WE ARE UNABLE TO MATCH TO ZIP CODE, CITY, OR COUNTY;
drop if fips =="";  

erase zipcty_xwalk.dta; erase scrap.dta; erase zip_temp.dta; 

compress; 

save "${intermediate}/pell_opeid2000", replace;

* DROP OBS FROM 31 PUBLIC/NP SCHOOLS THAT NEVER HAVE LEVEL INFO (ONLY HAD PELL RECIPIENTS IN PRE-1982 YEARS, NO INFO AFTER THIS POINT;
drop if level == . & inlist(control,1,2); 

* ASSUME THAT 1 PUBLIC SCHOOL, 3 NP SCHOOLS, AND 53 FPS WITHOUT INFO ON LEVEL ARE 2-YEAR SCHOOLS;
recode level (. = 2);
 
foreach v of var loss_loans_* sanc_reason_* any_appeal_* sanc_upheld_* {; recode `v' (. = 0); };

* DEFAULT RATES IN T-1 AND T-2;
rename drate drate0; 
bysort opeid (year): gen drate1 = drate0[_n-1] if opeid == opeid[_n-1] & year == year[_n-1]+1;
bysort opeid (year): gen drate2 = drate0[_n-2] if opeid == opeid[_n-2] & year == year[_n-2]+2;

* FIX FOR-PROFIT SCHOOL THAT ENDED UP BEING CLASSIFIED AS PUBLIC;
replace control = 3 if opeid == 2068000; /*United Career Center */

	