/* CREATES OUTPUT FOR TABLE 1: CHARACTERISTICS OF INSTITUTIONS BY SECTOR AND SANCTION RECEIPT */
/* AND APPENDIX TABLE C.2: ANALYSIS SAMPLE SANCTIONED AND COMPETITOR INSTITUTIONS BY SANCTION YEAR */

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

use "${intermediate}/stacked_data_2yearinsts_rev", clear; 

* DROP COUNTIES WITH MORE THAN 50 SCHOOLS (WITH PELL RECIPIENTS) PER YEAR, ON AVERAGE (COMMENT OUT SECOND LINE TO CREATE TC8);
destring fips, replace; 
drop if inlist(fips,4013, 6037, 6059, 6073, 12025, 17031, 26163, 36061, 42003, 42101, 48113, 48201, 36005, 36047, 36081, 36085);

drop if abs(t)  >10; 

gen lnrecips = ln(recipients);
gen lnrecips_2 = ln(recipients + 1); 

egen syid = group(opeid sanct_year); 

* DROP SCHOOLS THAT DO NOT HAVE ANY PELL RECIPIENTS OVER WINDOW AROUND SANCTION YEAR;
bysort syid : egen max = max(recipients ) ; drop if max == 0; drop max; 

** LIMIT TO FIRST EVENT FOR TREATED OBS  (COMMENT OUT CODE BELOW TO CREATE TC5);
forv i = 1/9 {;
	bysort opeid t (sanct_year): gen priorsanc`i'= sanc[_n-`i'] if opeid == opeid[_n-`i'] & t == t[_n-`i'] & sanct_year == sanct_year[_n-`i']+`i';
	recode priorsanc`i' (. = 0);
	
	bysort opeid t (sanct_year): gen priornum`i'= anysanc_num6_fips[_n-`i'] if opeid == opeid[_n-`i'] & t == t[_n-`i'] & sanct_year == sanct_year[_n-`i']+`i';
	recode priornum`i' (. = 0);
};

foreach v of var prior* {; drop if `v'>0; };

** TABLE 1; 
gen pre_sanction_rs = recipients if t<=-1 & t>=-8;
gen post_sanction_rs = recipients if t>=0 & t<=8;
gen share = recipients if t ==-1; 
gen num = 1 if t ==0; 

* PANEL A;
preserve;

	collapse (mean) pre_sanction_rs post_sanction_rs (sum) share  num, by(group);
	egen dum = total(share); replace share = share/dum; drop dum; 
	
	outsheet using "${output}/T1_panelA.txt", replace; 

restore;

* PANEL B;
preserve; 

	keep if sanc == 1; 
	
	collapse (mean) pre_sanction_rs post_sanction_rs (sum) share  num, by(group);
	egen dum = total(share); replace share = share/dum; drop dum; 
	
	outsheet using "${output}/T1_panelB.txt", replace; 

restore;

* PANELS C - E;
forv i = 2(2)6 {;

preserve;

	keep if anysanc_num`i'_fips>0 ; 
	
	collapse (mean) pre_sanction_rs post_sanction_rs (sum) share  num, by(group);
	egen dum = total(share); replace share = share/dum; drop dum; 
	
	outsheet using "${output}/T1_panelCDE_`i'.txt", replace; 

restore;

* CLOSE LOOP OVER SECTORS;
};

** TABLE C.2; 
* PANEL A;
preserve;

	keep if t ==0; keep if sanc == 1; 
	collapse (sum) sanc, by(group year); 

	outsheet using "${output}/TC2_panelA.txt", replace; 
	
restore;

* PANEL B;
preserve;

	keep if t ==0; keep if anysanc_num6_fips>0; 
	collapse (sum) num, by(group year); 

	outsheet using "${output}/TC2_panelB.txt", replace; 
	
restore;


