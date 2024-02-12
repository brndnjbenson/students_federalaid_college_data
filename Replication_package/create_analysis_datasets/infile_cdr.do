/*** THIS PROGRAM CLEANS AND FORMATS COHORT DEFAULT RATE DATA ****/
/*** DATA ARE AVAILABLE FOR DOWNLOAD AT: https://ifap.ed.gov/DefaultManagement/press/ ***/
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

/************************************************************************************************/
/* INPUTTING .CSV FILES */

foreach year of numlist 1992/2009 {;
	insheet using "${cdr}/FY`year'PressPackage.csv", names clear;
	loc id = "gsl_id";
	if `year' > 1995 {;
		loc id = "ope_id";
	};
	if `year'> 2008 {;
		loc id = "opeid";
	};
	foreach v of var nbr_* nbd_* drate_* {;
		destring `v', replace force;
	};
	reshape long yr_ nbr_ nbd_ drate_ avg_ , i(`id') j(n);
	drop n;
	capture drop prate*;
	save "${cdr}/FY`year'PressPackage.dta", replace;
};

/*RE-ARRANGING DATA*/

* 2009;
use "${cdr}/FY2009PressPackage.dta", clear;

tostring opeid, replace;
gen dum = real(opeid+"00");
drop opeid;
rename dum opeid;

# d cr
rename yr_ cohort_year
rename nbd_ nbd
rename nbr_ nbr
rename drate_ drate
rename avg_ avg

save "${intermediate}/FY2009_modified", replace

* 2008-1997
foreach x of numlist 2008(-1)1997 {
	use "${cdr}/FY`x'PressPackage.dta", clear
	
	if `x'!=2000 {
		tostring ope_id, replace
		gen opeid = real(ope_id+"00")
		drop ope_id
	}
	else {
		rename ope_id opeid
	}
	keep opeid name addr city st_cd st_desc zip zip_ext country pgm_len sch_type yr_ nbd_ nbr_ drate_ avg_ eth_cert program con_dist region avgor_ge30
	rename yr_ cohort_year
	rename nbd_ nbd
	rename nbr_ nbr
	rename drate_ drate
	rename avg_ avg

	save "${intermediate}/FY`x'_modified", replace
}

* 1996
use "${cdr}/FY1996PressPackage.dta", clear

tostring ope_id, replace
gen opeid = real(ope_id+"00")
drop ope_id

keep opeid name addr city st_cd st_desc zip zip_ext pgm_len sch_type yr_ nbd_ nbr_ drate_ avg_ eth_cert program con_dist region avgor_ge30 ffel_cr fdslp_cr
rename yr_ cohort_year
rename nbd_ nbd
rename nbr_ nbr
rename drate_ drate
rename avg_ avg

save "${intermediate}/FY1996_modified", replace

* 1995
use "${cdr}/FY1995PressPackage.dta", clear

tostring gsl_id, replace
gen opeid = real(gsl_id+"00")
drop gsl_id

replace name = name + sub_name
drop sub_name
rename state st_cd

gen fslash= strpos(type_cntrl,"/")
gen pgm_len=substr(type_cntrl,1,fslash-1)
gene sch_type=substr(type_cntrl,fslash+1,.)
drop type_cntrl fslash

replace yr_= 1900 + yr_

rename prgms program
rename cong_dist con_dist

rename yr_ cohort_year
rename nbd_ nbd
rename nbr_ nbr
rename drate_ drate
rename avg_ avg

tostring flag_2, replace
replace flag_2= "" if flag_2=="."

save "${intermediate}/FY1995_modified", replace

* 1994
use "${cdr}/FY1994PressPackage.dta", clear

tostring gsl_id, replace
gen opeid = real(gsl_id+"00")
drop gsl_id

replace name = name + " " + sub_name
drop sub_name
rename state st_cd

gen fslash= strpos(type_cntrl,"/")
gen pgm_len=substr(type_cntrl,1,fslash-1)
gene sch_type=substr(type_cntrl,fslash+1,.)
drop type_cntrl fslash

replace yr_= 1900 + yr_

rename prgms program
rename cong_dist con_dist

rename yr_ cohort_year
rename nbd_ nbd
rename nbr_ nbr
rename drate_ drate
rename avg_ avg


save "${intermediate}/FY1994_modified", replace

* 1993
use "${cdr}/FY1993PressPackage.dta", clear

tostring gsl_id, replace
gen opeid = real(gsl_id+"00")
drop gsl_id

replace name = name + " " + sub_name
drop sub_name
rename state st_cd

gen fslash= strpos(type_cntrl,"/")
gen pgm_len=substr(type_cntrl,1,fslash-1)
gene sch_type=substr(type_cntrl,fslash+1,.)
drop type_cntrl fslash

replace yr_= 1900 + yr_

rename cong_dist con_dist

rename yr_ cohort_year
rename nbd_ nbd
rename nbr_ nbr
rename drate_ drate
rename avg_ avg

tostring flag_2, replace
replace flag_2= "" if flag_2=="."

save "${intermediate}/FY1993_modified", replace

* 1992
use "${cdr}/FY1992PressPackage.dta", clear

tostring gsl_id, replace
gen opeid = real(gsl_id+"00")
drop gsl_id

replace name = name + " " + sub_name
drop sub_name
rename state st_cd

gen fslash= strpos(type_cntrl,"/")
gen pgm_len=substr(type_cntrl,1,fslash-1)
gene sch_type=substr(type_cntrl,fslash+1,.)
drop type_cntrl fslash

replace yr= 1900 + yr 

rename cong_dist con_dist

rename yr_ cohort_year
rename nbd_ nbd
rename nbr_ nbr
rename drate_ drate
rename avg_ avg

tostring flag_2, replace
replace flag_2= "" if flag_2=="."

save "${intermediate}/FY1992_modified", replace


/*APPENDING ALL MODIFIED FILES*/
#d;

use "${intermediate}/FY2009_modified",clear;
foreach n of num  2008(-1)1992 {; merge 1:1 opeid cohort_year using "${intermediate}/FY`n'_modified", update; drop _m; };

forv y = 1992/2009 {; erase "${cdr}/FY`y'PressPackage.dta"; };

** CLEAN UP;
* DROP NON-US OBS;
drop if country ~= ""; drop country;

* DROP TERRITORIES;
foreach t in VI TT PW PR MP MH GU FM AS {; drop if st_cd == "`t'"; };
	
* DROP UNNECESSARY VARS;
drop con_dist zip_ext eth_cert program region st_desc ffel_cr fdslp_cr flag_* ;

* NOW KEEPING ADDRESSES FOR GEOCODING;
rename addr address; 
 
* FIX ONE SCHOOL THAT IS LISTED AS BEING FOREIGN BUT IS LOCATED IN MA;
replace sch_type = "Prop" if opeid == 1204200 & sch_type == "Ffp";

* MAKE SCHOOL CONTROL CODE CONSISTENT WITH OTHER FILES;
gen control = 1 if sch_type == "Pub"; recode control (. = 2) if sch_type == "Priv"; recode control (. = 3) if sch_type == "Prop"; 
drop sch_type;
lab define control 1 "Public" 2 "NP" 3 "FP"; label val control control;

* MAKE SCHOOL LEVEL CODE CONSISTENT WITH OTHER FILES;
gen level = 1 if pgm_len == "1st Prof" | pgm_len == "4 yr" | pgm_len == "5 yr" | pgm_len == "Bachelor" | pgm_len == "Bachelor's Degree"
	| pgm_len == "First Professional Degree" | pgm_len == "Grad ShTrm" | pgm_len == "Graduate/Professional (>= 300 hours)" 
	| pgm_len == "Master's Degree or Doctor's Degree" | pgm_len == "Master/Dr" | pgm_len == "U/G PrvDeg" | pgm_len == "UnderGraduate (Previous Degree Required)";
recode level (. = 2); lab define level 1 "4 year" 2 " 2 year" ; label val level level;
drop pgm_len; 

replace name = proper(name); replace city = proper(city); 

tostring zip, replace; gen length = length(zip); replace zip = "0"+zip if length == 4; drop length;

rename st_cd state; 

* ADD 2 TO YEAR VAR (YEAR LISTED IS THE COHORT YEAR, COHORT YEAR + 2 IS THE FIRST POTENTIAL YEAR THAT A SCHOOL WOULD LEARN IT IS SUBJECT TO SANCTION);
* FOR NOW, KEEP COHORT YEAR AS YEAR - WILL NEED TO MERGE TWICE, ONCE TO GET SIZE OF COHORT IN YEAR THEY LEAVE AND SECOND TO ATTACH YEAR OF RELEASE TO CDR;
gen year = cohort_year+2; 

compress; 

* FIX RECORDS THAT ARE IDENTIFIED AS DUPLICATES OBS OF THE SAME SCHOOL (E.G., SAME ADDRESS AND NAME, BUT DIFFERENT OPEIDS);
qui do "${programs}/fix_duplicates.do"; 

bysort opeid year: gen count = _N; 

preserve;

	keep if count >1; 
	collapse (sum) nbd nbr , by(opeid year);
	gen drate = round(((nbd/nbr)*100),.1);
	save scrap, replace;
	
restore; 

gsort opeid year -nbr;
by opeid year: gen first = _n == 1;
foreach v of var nbd nbr drate {; replace `v' = . if count>1; };
drop if count>1 & first ==0; 
drop count first;	

merge 1:1 opeid year using scrap, update; 

gen in_cdr = 1; 

save "${intermediate}/cdr_1990_to_2009", replace;

** CLEAN UP;
* ERASE ANNUAL FILES;
foreach n of num 1992(1)2009 {; erase "${intermediate}/FY`n'_modified.dta"; };

