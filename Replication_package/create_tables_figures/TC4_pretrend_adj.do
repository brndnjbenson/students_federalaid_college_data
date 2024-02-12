/* CREATES OUTPUT USED IN APPENDIX TABLE TC.4: THE EFFECT OF SANCTIONS ON PELL GRANT RECIPIENT ENROLLMENT: TREND-ADJUSTED ESTIMATES */

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

foreach v of var G*anysanc_rs2_fips G*anysanc_rs4_fips G*anysanc_rs6_fips {; replace `v' = ln(`v'+1); };

forv i = 2(2)6 {;
	replace number_schools_fips`i' = number_schools_fips`i'+1 if group ==`i';
	gen number_unsanc_fips`i' = number_schools_fips`i' - anysanc_num`i'_fips;
};

egen number_unsanc_fips24 = rowtotal(number_unsanc_fips2 number_unsanc_fips4); 

gen post = t>=0; 

drop if abs(t)>8;

** RECENTER SERIES AROUND 0 SO THAT OMITTED CATEGORY IS SAME FOR YEAR BY YEAR ESTS AND TREND ESTS;
gen tadj = t+1; 

** TEST EQUALITY OF PRE (T-4 TO T-1) TRENDS AND POST (T=1 TO T=4) TRENDS FOR UNSANCTIONED FOR-PROFIT COMPETITORS AND UNSANCTIONED OTHER COMPETITORS OF SANCTIONED FOR-PROFITS; 
* INDICATORS FOR PERIODS PRE/POST;
gen t1 = tadj<=-4; 
gen t2 = tadj>=-3 & tadj<=0;
gen t3 = tadj>=1  & tadj<6;
gen t4 = tadj>=6 ; 

* INTERACT WITH TIME TREND;
foreach v of var t1 t2 t3 t4 {; gen t`v' = tadj*`v'; };

* INTERACT WITH SANCTION/COMPETITOR SANCTION TREATMENT VARS;
foreach v of var G2sanc G4sanc G6sanc G*anysanc_rs2_fips G*anysanc_rs4_fips G*anysanc_rs6_fips  {;

forv t = 1/4 {;	

	gen tt`t'X`v' = tt`t'*`v'; 
	
};

};

* CREATE INTERACTIONS BETWEEN YEAR PRE/POST AND SANCTION INDICATORS/COMPETITORS SANCTIONED;
char t[omit] -1;
foreach n of num 2(2)6 {; xi, prefix(TG`n'S) i.post|G`n'sanc ; drop TG`n'Spost_*; }; 
foreach n of num 2(2)6 {; 
	xi, prefix(T2R`n') i.post|G2anysanc_rs`n'_fips; drop T2R`n'post_*; 
	xi, prefix(T4R`n') i.post|G4anysanc_rs`n'_fips; drop T4R`n'post_*; 
	xi, prefix(T6R`n') i.post|G6anysanc_rs`n'_fips; drop T6R`n'post_*; 

};

keep lnrecips_2 tt*XG2sanc tt*XG4sanc tt*XG6sanc tt*XG*anysanc_rs2_fips tt*XG*anysanc_rs4_fips tt*XG*anysanc_rs6_fips  
	TG* T2R* T4R* T6R* syid opeid t tadj year group fips  ;

expand 2, gen(type); 

* TYPE = 0 IS TREND REGRESSION, TYPE = 1 IS MAIN REGRESSION;
replace t = tadj if type == 0; drop tadj;
foreach v of var tt*XG2sanc tt*XG4sanc tt*XG6sanc tt*XG*anysanc_rs2_fips tt*XG*anysanc_rs4_fips tt*XG*anysanc_rs6_fips  {;
	replace `v' = 0 if type == 1; 
};
   

foreach v of var TG2S* TG4S* TG6S* T2R* T4R* T6R*  {; replace `v' = 0 if type ==0; };

foreach v of var fips  t year syid group {; gen `v'_0 = `v' if type ==0; recode `v'_0 (. =0 ); gen `v'_1 = `v' if type ==1; recode `v'_1 (. = 0); drop `v';};

save expanded_data2, replace;

use expanded_data2,clear;

log using trend_corrected_ests, replace; 

reghdfe lnrecips_2 tt*XG2sanc tt*XG4sanc tt*XG6sanc tt*XG*anysanc_rs2_fips tt*XG*anysanc_rs4_fips tt*XG*anysanc_rs6_fips  
	TG2S* TG4S* TG6S* T2R* T4R* T6R*  type if abs(t_0)<=8 & abs(t_1)<=8, a(syid_0 syid_1 t_0 t_1 year_0 year_1 fips_0##c.t_0 fips_1##c.t_1 group_0##c.t_0 group_1##c.t_1) cl(opeid);

* SANCTIONED INSTITUTIONS;
lincom  TG2SposXG2san_1 - (4* tt2XG2sanc);
lincom  TG4SposXG4san_1 - (4* tt2XG4sanc);
lincom  TG6SposXG6san_1 - (4* tt2XG6sanc);

test   (TG6SposXG6san_1 - (4* tt2XG6sanc)) = (TG4SposXG4san_1 -(4*tt2XG4sanc ))= (TG2SposXG2san_1 -(4*tt2XG2sanc ));

* UNSANCTIOED COMPETITORS OF SANCTIONED PUBLICS;
lincom  T2R2posXG2any_1 - (4*tt2XG2anysanc_rs2_fips );
lincom  T4R2posXG4any_1 - (4*tt2XG4anysanc_rs2_fips );
lincom  T6R2posXG6any_1 - (4*tt2XG6anysanc_rs2_fips );

test    (T6R2posXG6any_1 - (4*tt2XG6anysanc_rs2_fips )) = (T4R2posXG4any_1 - (4*tt2XG4anysanc_rs2_fips )) = ( T2R2posXG2any_1 - (4*tt2XG2anysanc_rs2_fips)); 

* UNSANCTIONED COMPETITORS OF SANCTIONED NONPROFITS;
lincom  (T2R4posXG2any_1 - (4*tt2XG2anysanc_rs4_fips ));
lincom  (T4R4posXG4any_1 - (4*tt2XG4anysanc_rs4_fips ));
lincom  (T6R4posXG6any_1 - (4*tt2XG6anysanc_rs4_fips ));

test    (T6R4posXG6any_1 - (4*tt2XG6anysanc_rs4_fips )) = (T4R4posXG4any_1 - (4*tt2XG4anysanc_rs4_fips )) = ( T2R4posXG2any_1 - (4*tt2XG2anysanc_rs4_fips));

* UNSANCTIONED COMPETITORS OF SANCTIONED FOR-PROFITS;
lincom  (T6R6posXG6any_1 - (4*tt2XG6anysanc_rs6_fips )); 
lincom  (T4R6posXG4any_1 - (4*tt2XG4anysanc_rs6_fips ));
lincom  (T2R6posXG2any_1 - (4*tt2XG2anysanc_rs6_fips ));

test    (T6R6posXG6any_1 - (4*tt2XG6anysanc_rs6_fips )) = (T4R6posXG4any_1 - (4*tt2XG4anysanc_rs6_fips )) = ( T2R6posXG2any_1 - (4*tt2XG2anysanc_rs6_fips));

* UNSANCTIONED PUBLIC COMPETITORS;
test (T2R2posXG2any_1 - (4*tt2XG2anysanc_rs2_fips )) = (T2R4posXG2any_1 - (4*tt2XG2anysanc_rs4_fips )) = (T2R6posXG2any_1 - (4*tt2XG2anysanc_rs6_fips ));

* UNSANCTIONED NP COMPETITORS;
test   (T4R2posXG4any_1 - (4*tt2XG4anysanc_rs2_fips )) = (T4R4posXG4any_1 - (4*tt2XG4anysanc_rs4_fips )) = (T4R6posXG4any_1 - (4*tt2XG4anysanc_rs6_fips ));

* UNSANCTIONED FP COMPETITORS;
test   (T6R2posXG6any_1 - (4*tt2XG6anysanc_rs2_fips )) = (T6R4posXG6any_1 - (4*tt2XG6anysanc_rs4_fips )) = (T6R6posXG6any_1 - (4*tt2XG6anysanc_rs6_fips ));

* MARKETWIDE CHANGES IN ENROLLMENT - SANCTIONED FOR-PROFITS;
nlcom((exp(_b[T2R6posXG2any_1]-(4*_b[tt2XG2anysanc_rs6_fips] ))-1)*2.771*831) + ((exp(_b[T4R6posXG4any_1]-(4*_b[tt2XG4anysanc_rs6_fips] ))-1)*2.246*57)  
 	+ ((exp(_b[T6R6posXG6any_1]-(4*_b[tt2XG6anysanc_rs6_fips] ))-1)*14.81*126) + ((exp(_b[TG6SposXG6san_1]-(4*_b[tt2XG6sanc] ))-1)*333);

* MARKETWIDE CHANGES IN ENROLLMENT - SANCTIONED NONPROFITS;
nlcom((exp(_b[T2R4posXG2any_1]-(4*_b[tt2XG2anysanc_rs4_fips] ))-1)*2.939*1007)+ ((exp(_b[T4R4posXG4any_1]-(4*_b[tt2XG4anysanc_rs4_fips] ))-1)*2.939*38)  
	+ ((exp(_b[T6R4posXG6any_1]-(4*_b[tt2XG6anysanc_rs4_fips] ))-1)*17.25*127) + ((exp(_b[TG4SposXG4san_1]-(4*_b[tt2XG4sanc] ))-1)*137);

* MARKETWIDE CHANGES IN ENROLLMENT - SANCTIONED PUBLICS;
nlcom((exp(_b[T2R2posXG2any_1]-(4*_b[tt2XG2anysanc_rs2_fips] ))-1)*2.802*764) + ((exp(_b[T4R2posXG4any_1]-(4*_b[tt2XG4anysanc_rs2_fips] ))-1)*3.311*45)  
	+ ((exp(_b[T6R2posXG6any_1]-(4*_b[tt2XG6anysanc_rs2_fips] ))-1)*14.47*90) + ((exp(_b[TG2SposXG2san_1]-(4*_b[tt2XG2sanc] ))-1)*385);

capture log close; 