/* CREATES OUTPUT USED IN APPENDIX TABLE TC.3: ESTIMATED PRE- AND POST-SANCTION TRENDS IN PELL GRANT RECIPIENT ENROLLMENT*/

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

use "${intermediate}/stacked_data_2yearinsts_rev", clear; 

* DROP COUNTIES WITH MORE THAN 50 SCHOOLS (WITH PELL RECIPIENTS) PER YEAR, ON AVERAGE;
destring fips, replace; 
drop if inlist(fips,4013, 6037, 6059, 6073, 12025, 17031, 26163, 36061, 42003, 42101, 48113, 48201,36005, 36047, 36081, 36085);

drop if abs(t)>10;

gen lnrecips = ln(recipients);
gen lnrecips_2 = ln(recipients + 1); 

egen syid = group(opeid sanct_year); 

* DROP SCHOOLS THAT DO NOT HAVE ANY PELL RECIPIENTS OVER WINDOW AROUND SANCTION YEAR;
bysort syid : egen max = max(recipients ) ; drop if max == 0; drop max; 

** OPTION TO LIMIT TO FIRST EVENT FOR TREATED OBS;
forv i = 1/9 {;
	bysort opeid t (sanct_year): gen priorsanc`i'= sanc[_n-`i'] if opeid == opeid[_n-`i'] & t == t[_n-`i'] & sanct_year == sanct_year[_n-`i']+`i';
	recode priorsanc`i' (. = 0);
	
	bysort opeid t (sanct_year): gen priornum`i'= anysanc_num6_fips[_n-`i'] if opeid == opeid[_n-`i'] & t == t[_n-`i'] & sanct_year == sanct_year[_n-`i']+`i';
	recode priornum`i' (. = 0);
};

foreach v of var prior* {; drop if `v'>0; };

* INTERACT TREATMENTXPOST WITH SECTOR INDICATORS;
foreach v of var sanc anysanc_rs*_fips {;
foreach n of num 2(2)6 {;
	gen G`n'`v' = `v' if group == `n'; recode G`n'`v' (. = 0); 
};
};

gen G24anysanc_rs6_fips = G2anysanc_rs6_fips + G4anysanc_rs6_fips; 

foreach v of var anysanc_rs2_fips anysanc_rs4_fips anysanc_rs6_fips G24anysanc_rs6_fips G6anysanc_rs6_fips {; replace `v' = ln(`v'+1); };

forv i = 2(2)6 {;
	replace number_schools_fips`i' = number_schools_fips`i'+1 if group ==`i';
	gen number_unsanc_fips`i' = number_schools_fips`i' - anysanc_num`i'_fips;
};

egen number_unsanc_fips24 = rowtotal(number_unsanc_fips2 number_unsanc_fips4); 


** TEST EQUALITY OF PRE (T-4 TO T-1) TRENDS AND POST (T=1 TO T=4) TRENDS FOR UNSANCTIONED FOR-PROFIT COMPETITORS AND UNSANCTIONED OTHER COMPETITORS OF SANCTIONED FOR-PROFITS; 
* INDICATORS FOR PERIODS PRE/POST;
replace t = t+1; 
gen t1 = t<=-4; 
gen t2 = t>=-3 & t<=0;
gen t3 = t>=1 & t<4;
gen t4 = t>=4 ; 

* INTERACT WITH TIME TREND;
foreach v of var t1 t2 t3  t4 {; gen t`v' = t*`v'; };

* INTERACT WITH SANCTION/COMPETITOR SANCTION TREATMENT VARS;
foreach v of var G2sanc G4sanc G6sanc anysanc_rs2_fips anysanc_rs4_fips G24anysanc_rs6_fips  G6anysanc_rs6_fips {;

forv t = 1/4 {;	

	gen tt`t'X`v' = tt`t'*`v'; 
	
};

};
	
** APPENDIX TABLE C.3 ESTIMATES;
xi: reghdfe lnrecips_2 tt*XG2sanc tt*XG4sanc tt*XG6sanc tt*Xanysanc_rs2_fips tt*Xanysanc_rs4_fips   
	tt*XG24anysanc_rs6_fips  tt*XG6anysanc_rs6_fips   if abs(t)<=8, a(syid t year fips##c.t group##c.t ) cl(syid);

* COLLECT P-VALS FROM EQ TESTS;
test tt2XG2sanc = tt3XG2sanc; loc p_sanc2 = r(p);
test tt2XG4sanc = tt3XG4sanc; loc p_sanc4 = r(p);
test tt2XG6sanc = tt3XG6sanc; loc p_sanc6 = r(p); 
test tt2Xanysanc_rs2_fips = tt3anysanc_rs2_fips; loc p_comp2= r(p);
test tt2Xanysanc_rs4_fips = tt3anysanc_rs4_fips; loc p_comp4= r(p);	
test tt2XG24anysanc_rs6_fips = tt3XG24anysanc_rs6_fips; loc p_othcomp6 = r(p);
test tt2XG6anysanc_rs6_fips = tt3XG6anysanc_rs6_fips; ;loc p_fpcomp6 = r(p);
	
outreg2 using "${output}/TC3_trend_ests.txt", keep(_I*) ap dec(3) sym(**,*,+) se aster(se) 
	addstat("pval - sanc pub", `p_sanc2', "pval - sanc np",`p_sanc4',"pval - sanc fp",`p_sanc6',"pval - comp spub",`p_comp2',
	"pval - comp snp", `p_comp4',"pval - oth comp sfp", `p_othcomp6', "pval - fp comp sfp", `p_fpcomp6');
	
	