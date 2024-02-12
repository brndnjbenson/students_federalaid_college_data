
#d;
clear all;
set more off;
set matsize 11000;
set maxvar 120000;
capture log close; 

gl dir = "/home/Crowdout"; 
	
gl data = "${dir}/data/original";
gl intermediate = "${dir}/data/intermediate";
gl output = "${dir}/output";
gl programs = "${dir}/programs/callable_programs";

cd "${dir}/programs";

use "${intermediate}/formatted_analysis_data", clear;

* DROP UNNECESSARY VARS;
drop address city affil zip schlc ftptt corres accstat accred acc_* fisl va offers_* founded cohort_year; 

* ONLY KEEP OBS FROM 1982-2009;
drop if year<1981 | year>2010;

* DROP SCHOOLS THAT NEVER HAVE PELL ENROLLMENT OVER SAMPLE PERIOD;
bysort opeid: egen max = max(recipients); drop if max == 0; drop max; 

* SECTOR BY LEVEL VARIABLE (ALL MISSING VALS ARE FPS, RECODE AS 2-YEAR SCHOOLS);
** NOTE: GROUP CATS ARE 1 = PUB 4, 2 = PUB 2, 3 = NP 4, 4 = NP 2, 5 = FP 4, 6 = FP 2; 
egen group = group(control level), lab; 

** "TREATMENTS" OF INTEREST - THREATENED SANCTION (LOSS LOANS), THREATENED SANCTION (LOSS LOANS + PELL); 
rename loss_loans_only sanc_ll; rename loss_loans_pell sanc_lp;

** SANCTION IMPOSED (1995 CY AND LATER) - LOSS LOANS, SANCTION IMPOSTED (1995 CY AND LATER) - LOSS LOANS + PELL; 
foreach v of var sanc_upheld* {; replace `v' = . if year<1997; };
rename sanc_upheld_ll suphld_ll; rename sanc_upheld_lp suphld_lp; 

* YEAR CLOSED;
bysort opeid: egen min = min(year_closed);
replace year_closed = min if year_closed == . & min ~=.; 

* OPTION TO RESTRICT SAMPLE TO 2-YEAR SCHOOLS;
keep if inlist(group,2,4,6); 

* UNCATEGORIZED FPS ASSIGNED TO "TECH" CATEGORY (THESE ARE SCHOOLS NOT PRESENT OR W/OUT INFO ON NAME PRE-1990);
recode tech (. = 1) if group ==6; 

* ENROLLMENT IN T-1; 
bysort opeid (year): gen recipients_l1 = recipients[_n-1] if opeid == opeid[_n-1] & year == year[_n-1]+1; 

* INDICATORS FOR ANY SANCTION THREATENED, ANY UPHELD (1997+);
egen anysanc = rowmax ( sanc_ll sanc_lp ); egen anysuphld = rowmax(suphld_ll suphld_lp ); 

save scrap_fullsample, replace; 

keep opeid year drate* recipients state fips sanc_* any_appeal_* suphld_* year_closed chain_name chain_id chain_cat tech - mech_eng group anysanc anysuphld  recipients_l1;

preserve;

* CREATE FILE THAT INCLUDES LIST OF 2-YEAR INSTITUTIONS (AND CHAIN IDS IF ANY) THAT ARE IN OUR SAMPLE; 
	keep opeid chain_id; duplicates drop; rename opeid opeid_1;  rename chain_id chain_id_1;
	save scrap_insample, replace; 
	
* MERGE TO FILE OF SCHOOLS AND COMPETITORS WITHIN 15 MILE RADIUS; 
	insheet using "${intermediate}/matchedaddresses_15.csv", names clear; 
	merge m:1 opeid_1 using scrap_insample; drop if _m == 1; gen nocomp = _m == 2; drop _m;
	save scrap, replace; 
	
* RAJ'S RA: ALL SCHOOLS COULD BE MATCHED TO AT LEAST 1 COMPETITOR - IF THE "nocomp" SCHOOLS AREN'T IN 30 MILE RADIUS FILE, ASSUME COULDN'T BE GEOCODED AND DROP; 
	insheet using "${intermediate}/matchedaddresses_30.csv", names clear; 
	keep opeid_1; duplicates drop; save scrap2, replace;
	use scrap,clear; merge m:1 opeid_1 using scrap2; keep if _m ==3; drop _m; 
	save scrap, replace; 
		
* NOW MERGE ON COMPETITORS THAT BELONG TO ANALYSIS SAMPLE (2-YEAR SCHOOLS); 
	use scrap_insample, clear; rename opeid_1 opeid_matched; rename chain_id_1 chain_id_matched; save scrap_insample, replace; 
	use scrap, clear; rename opeid_mached opeid_matched; 
	merge m:1 opeid_matched using scrap_insample, update;
	foreach v of var opeid_matched chain_id_matched {; replace `v' = . if _m == 1; };
	foreach v of var name_matched address_matched {; replace `v' = "" if _m == 1; };
	duplicates drop; drop if opeid_1 == . ; drop _m; 
	
	bysort opeid_1: gen count = _N; drop if count>1 & opeid_matched==.; drop count; 
	replace nocomp = 1 if opeid_matched ==.; 

	save scrap_rad15, replace; 
	erase scrap.dta; erase scrap2.dta; erase scrap_insample.dta; 
	
restore;

* LOOP THROUGH SANCTION YEARS AND CREATE MEASURE OF NUMBER OF NEWLY SANCTIONED COMPETITORS WITHIN RADIUS IN EACH SY;	
forv y = 1991/2000 {;
	
preserve;

	keep if year == `y'; 
	rename opeid opeid_matched; 
	merge 1:m opeid_matched using scrap_rad15, update; keep if _m >=3 | nocomp == 1; drop _m; 
	gen sanct_year = `y'; 
	
* COMPETITOR THREATENED WITH SANCTION/RECEIVED SANCTION (1997+ ONLY);
foreach v of var sanc_ll sanc_lp suphld_ll suphld_lp anysanc anysuphld {;

foreach g of num 2(2)6 {;

	gen `v'`g'_r15 =`v' if group == `g'; 
	recode `v'`g'_r15 (. = 0); 
}; 

};

* T-1 RECIPIENTS ENROLLED IN COMPETITOR THREATENED WITH SANCTION;
foreach v of var sanc_ll sanc_lp anysanc {;

foreach g of num 2(2)6 {;
	
	gen `v'`g'_rs_r15 = recipients_l1 if group == `g' & `v' == 1;
	recode `v'`g'_rs_r15 (. = 0); 
}; 

};

* FP COMPETITOR THREATENED WITH SANCTION BY INDUSTRY;
foreach v of var sanc_ll sanc_lp anysanc {;

foreach t of var tech health beauty comp_bus cul_art mech_eng {;

	gen `v'_`t'_r15 = `v' if group == 6 & `t' == 1; 
	recode `v'_`t'_r15 (. = 0); 
	
};	

};
* T-1 RECIPIENTS ENROLLED IN COMPETITOR THREATENED WITH SANCTION BY INDUSTRY;
foreach v of var sanc_ll sanc_lp anysanc {;

foreach t of var tech health beauty comp_bus cul_art mech_eng {;

	gen `v'_`t'_rs_r15 = (recipients_l1*`v') if group == 6 & `t' == 1; 
	recode `v'_`t'_rs_r15 (. = 0); 
	
};	

};

* FP LOCATION IN SAME CHAIN THREATENED WITH SANCTION;
gen anysanc_num_schain_r15 = chain_id_1 == chain_id_matched & chain_id_1 ~=. ; 

gen pub = group == 2; gen np = group == 4; gen fp = group == 6; 

collapse (max) anysanc_ll2_r15 = sanc_ll2_r15 anysanc_ll4_r15 = sanc_ll4_r15 anysanc_ll6_r15 = sanc_ll6_r15  
				anysanc_lp2_r15 = sanc_lp2_r15 anysanc_lp4_r15 = sanc_lp4_r15 anysanc_lp6_r15 = sanc_lp6_r15  
				anysanc2_r15 anysanc4_r15 anysanc6_r15 
				anysuphld2_r15  anysuphld4_r15 anysuphld6_r15 
		(sum)  numsanc_ll2_r15 = sanc_ll2_r15 numsanc_ll4_r15 = sanc_ll4_r15 numsanc_ll6_r15 = sanc_ll6_r15  
				numsanc_lp2_r15 = sanc_lp2_r15 numsanc_lp4_r15 = sanc_lp4_r15 numsanc_lp6_r15 = sanc_lp6_r15  
				numsanc2_r15 = anysanc2_r15 numsanc4_r15 = anysanc4_r15 numsanc6_r15 = anysanc6_r15 
				numsuphld2_r15 = anysuphld2_r15  numsuphld4_r15 = anysuphld4_r15 numsuphld6_r15 = anysuphld6_r15 
				numsanc_tech_r15 = anysanc_tech_r15 numsanc_health_r15 = anysanc_health_r15 numsanc_beauty_r15 = anysanc_beauty_r15
				numsanc_comp_bus_r15 = anysanc_comp_bus_r15 numsanc_cul_art_r15 = anysanc_cul_art_r15 numsanc_mech_eng_r15 = anysanc_mech_eng_r15
				anysanc_ll_rs2_r15 = sanc_ll2_rs_r15 anysanc_ll_rs4_r15 = sanc_ll4_rs_r15 anysanc_ll_rs6_r15 = sanc_ll6_rs_r15  
				anysanc_lp_rs2_r15 = sanc_lp2_rs_r15 anysanc_lp_rs4_r15 = sanc_lp4_rs_r15 anysanc_lp_rs6_r15 = sanc_lp6_rs_r15  
				anysanc_rs2_r15 = anysanc2_rs_r15 anysanc_rs4_r15 = anysanc4_rs_r15 anysanc_rs6_r15 = anysanc6_rs_r15 
				anysanc_tech_rs_r15 anysanc_health_rs_r15 anysanc_beauty_rs_r15 anysanc_comp_bus_rs_r15 
				anysanc_cul_art_rs_r15 anysanc_mech_eng_rs_r15
				num2_r15 = pub num4_r15 = np num6_r15 = fp
				numsanc_schain_r15 = anysanc_num_schain_r15, 
				by(opeid_1 sanct_year); 
							
	save scrap_r15_`y', replace; 
	
restore; 
};

* LOOP THROUGH SANCTION YEARS, SAVE EACH PANEL AS SEPARATE FILE;
forv y = 1991/2000 {;

	use scrap_r15_`y',clear;
	rename opeid_1 opeid; 
	merge 1:m opeid using scrap_fullsample, update; drop if _m == 2; 
	drop if year < `y'-10 | year > `y'+10; 

	save scrap_r15_`y', replace;
	
};

use scrap_r15_1991; 

forv y = 1992/2000 {;
	
	append using scrap_r15_`y'; 
	
};

save scrap_stacked_r15, replace; 

forv y = 1991/2000 {;

	erase scrap_r15_`y'.dta; 
	
};

* DROP UNNECESSARY VARS;
drop stabbr count county fips_alt name2 min _m;

* INDICATOR FOR WHETHER A SCHOOL IS CLOSED;
gen closed = year>=year_closed;

* YEARS PRE/POST SANCTION;
gen t = year-sanct_year; 

gen sanc_in_year = anysanc; 
rename anysanc sanc; 

* ANY TREATMENT ASSOCIATED WITH SPECIFIC SANCTION YEAR;
foreach v of var sanc_ll sanc_lp suphld_* sanc anysuphld {; 
	replace `v' = 0 if t ~=0; 
	bysort opeid sanct_year: egen dum = max(`v'); drop `v'; rename dum `v';
};
	

gen post = t>=0; 

foreach v of var sanc_ll sanc_lp sanc anysuphld *_r15 {;

foreach g of num 2(2)6 {;

	gen G`g'`v' = `v' if group == `g'; 
	recode G`g'`v' (. = 0); 

	gen G`g'postX`v' = G`g'`v'*post; 
		
};

};

compress;

save "${intermediate}/stacked_data_2yearinsts_r15", replace;

erase scrap_stacked_r15.dta;
erase scrap_rad15.dta;
erase scrap_fullsample.dta;  
