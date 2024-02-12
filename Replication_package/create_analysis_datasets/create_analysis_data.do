/* THIS PROGRAM CALLS THE SUB-PROGRAMS THAT FORMAT AND CLEAN CDR, SANCTION, AND PELL FILES */

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

* CREATE CDR DATA;
qui do infile_cdr.do;

* CREATE SANCTIONS + SANCTION APPEALS DATA;
qui do infile_sanction.do;

* CREATE POSTSECONDARY CAREER SCHOOL SURVEY DATA SET;
qui do infile_pcss.do;

* CREATE PELL DATA (INCLUDES CDR, CLOSURE INFO, AND FIPS CODES);
qui do infile_pell.do;

* ADD INFORMATION ON CHAINS AND SECTORS FOR FP SCHOOLS; 

compress;
save "${intermediate}/formatted_analysis_data", replace; 

use "${intermediate}/formatted_analysis_data", clear;

* ADD INFORMATION ON FP CHAINS;
merge m:1 opeid using "${intermediate}/chain_ids", update;

drop if _m == 2; 
bysort chain_id year: gen count = _N; replace chain_id = . if count ==1; replace chain_name = "" if count ==1; 
gen anychain = chain_id ~=.;

encode state, gen(staten); 
bysort chain_id : egen min = min(staten);
bysort chain_id : egen max = max(staten);

gen chain_cat = _m == 3; recode chain_cat (1 = 2) if min ==max; 
drop min max staten; 
replace chain_cat = . if anychain ==0; 
drop _m; 

compress;

* FIX FOR-PROFIT CHAIN LOCATIONS THAT WERE INCORRECTLY CLASSIFIED AS PUBLIC OR NONPROFITS;
replace control = 3 if chain_cat ~=. ; 

save "${intermediate}/formatted_analysis_data", replace; 

use "${intermediate}/formatted_analysis_data", clear;

* ASSIGN FP SCHOOLS TO INDUSTRY CATEGORIES BASED ON 1990 NAME; 
do "${programs}/industry_class_rev.do";

use "${intermediate}/formatted_analysis_data", clear; 

* ADD INFOMRATION ON FP INDUSTRY;
merge m:1 opeid using "${intermediate}/industry_class", update; 
drop if _m == 2; drop _m; 
foreach v of var tech - mech_eng {;
	recode `v' (. =0); 
};

* ASSIGN UNCLASSIFIED FOR-PROFITS TO THE TECH CATEGORY;
egen dum = rowtotal(tech - mech_eng); replace tech = 1 if control == 3 & dum == 0; drop dum; 

* PEPS IDENTIFIES SCHOOLS THAT OFFER CORRESPONDENCE PROGRAMS;
bysort opeid: egen dum = min(corres); replace corres = dum; drop dum;

* IDENTIFY SCHOOLS THAT ARE LIKELY TO BE HOME-STUDY/CORRESPONDENCE PROGRAMS;
gen dum = strpos(name2,"corresp")>0 | strpos(name2,"home")>0; bysort opeid: egen dum2 = max(dum); 
replace corres = 1 if dum2 == 1; drop dum dum2; 

compress; 

save "${intermediate}/formatted_analysis_data", replace; 

* OPTION TO ERASE INTERMEDIATE FILES TO CONSERVE SPACE;
capture erase "${intermediate}/pell_opeid2000.dta";
