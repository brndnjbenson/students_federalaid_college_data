/* CREATES SUPPLEMENTAL OUTPUT USED TO CREATE TREND ADJUSTED SERIES IN FIGURES 5 & 6 */

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

** RECENTER SERIES AROUND 0 SO THAT OMITTED CATEGORY IS SAME FOR YEAR BY YEAR ESTS AND TREND ESTS;
replace t = t+1; 

** TEST EQUALITY OF PRE (T-4 TO T-1) TRENDS AND POST (T=1 TO T=4) TRENDS FOR UNSANCTIONED FOR-PROFIT COMPETITORS AND UNSANCTIONED OTHER COMPETITORS OF SANCTIONED FOR-PROFITS; 
* INDICATORS FOR PERIODS PRE/POST;
gen t1 = t<=-4; 
gen t2 = t>=-3 & t<=0;
gen t3 = t>=1  & t<6;
gen t4 = t>=6 ; 

* INTERACT WITH TIME TREND;
foreach v of var t1 t2 t3 t4 {; gen t`v' = t*`v'; };

* INTERACT WITH SANCTION/COMPETITOR SANCTION TREATMENT VARS;
foreach v of var G2sanc G4sanc G6sanc anysanc_rs2_fips anysanc_rs4_fips G24anysanc_rs6_fips  G6anysanc_rs6_fips {;

forv t = 1/4 {;	

	gen tt`t'X`v' = tt`t'*`v'; 
	
};

};

* CREATE INTERACTIONS BETWEEN YEAR PRE/POST AND SANCTION INDICATORS/COMPETITORS SANCTIONED;
char t[omit] 0;
foreach n of num 2(2)6 {; xi, prefix(TG`n'S) i.t|G`n'sanc ; drop TG`n'St_*; }; 
foreach n of num 2 4  {; xi, prefix(TR`n') i.t|anysanc_rs`n'_fips; drop TR`n't_*; };
xi, prefix(T2R6) i.t|G24anysanc_rs6_fips ; drop T2R6t_*;
xi, prefix(T6R6) i.t|G6anysanc_rs6_fips ; drop T6R6t_*;

keep lnrecips_2 tt*XG2sanc tt*XG4sanc tt*XG6sanc tt*Xanysanc_rs2_fips tt*Xanysanc_rs4_fips tt*XG24anysanc_rs6_fips  tt*XG6anysanc_rs6_fips    
	TG* TR* T2R6* T6R6* syid opeid t year group fips  ;

expand 2, gen(type); 

* TYPE = 0 IS TREND REGRESSION, TYPE = 1 IS MAIN REGRESSION;
foreach v of var tt*XG2sanc tt*XG4sanc tt*XG6sanc tt*Xanysanc_rs2_fips tt*Xanysanc_rs4_fips tt*XG24anysanc_rs6_fips  tt*XG6anysanc_rs6_fips {;
	replace `v' = 0 if type == 1; 
};
   

foreach v of var TG2S* TG4S* TG6S* TR* T2R* T6R*  {; replace `v' = 0 if type ==0; };

foreach v of var fips  t year syid group {; gen `v'_0 = `v' if type ==0; recode `v'_0 (. =0 ); gen `v'_1 = `v' if type ==1; recode `v'_1 (. = 0); drop `v';};
save expanded_data, replace;


use expanded_data,clear;

log using trend_corrected_event_study, replace; 

reghdfe lnrecips_2 tt*XG2sanc tt*XG4sanc tt*XG6sanc tt*Xanysanc_rs2_fips tt*Xanysanc_rs4_fips tt*XG24anysanc_rs6_fips  tt*XG6anysanc_rs6_fips
	TG2S* TG4S* TG6S* TR* T2R* T6R*  type, a(syid_0 syid_1 t_0 t_1 year_0 year_1 fips_0##c.t_0 fips_1##c.t_1 group_0##c.t_0 group_1##c.t_1) cl(opeid);

** TREND CORRECTED ESTIMATES;
* SANCTIONED INSTITUTIONS;
foreach g of num 2(2)6 {;

forv i = 11/19 {; 
	loc k = `i'-10; 
	loc j = `k'-1;
	lincom TG`g'StXG`g'sa_`i' - tt2XG`g'sanc*`k';
	loc TG`g'S_est`j' = r(estimate); 
	loc TG`g'S_cil`j' = r(lb); 
	loc TG`g'S_cih`j' = r(ub); 
};	

};

* COMPETITORS OF SANCTIONED PUBLICS/NONPROFITS;
foreach g of num 2 4 {;

forv i = 11/19 {; 
	loc k = `i'-10; 
	loc j = `k'-1;
	lincom TR`g'tXanys_`i'- tt2Xanysanc_rs`g'_fips*`k';
	loc TR`g'_est`j' = r(estimate); 
	loc TR`g'_cil`j' = r(lb); 
	loc TR`g'_cih`j' = r(ub); 
};	
	
};

* OTHER COMPETITORS OF SANCTIONED FOR-PROFITS;
forv i = 11/19 {; 
	loc k = `i'-10; 
	loc j = `k'-1;
	lincom T2R6tXG24a_`i'- tt2XG24anysanc_rs6_fips*`k';
	loc T24R6_est`j' = r(estimate); 
	loc T24R6_cil`j' = r(lb); 
	loc T24R6_cih`j' = r(ub); 
};	
	
* FOR-PROFIT COMPETITORS OF SANCTIONED FOR-PROFITS;
forv i = 11/19 {; 
	loc k = `i'-10; 
	loc j = `k'-1;
	lincom T6R6tXG6an_`i'- tt2XG6anysanc_rs6_fips*`k';
	loc T6R6_est`j' = r(estimate); 
	loc T6R6_cil`j' = r(lb); 
	loc T6R6_cih`j' = r(ub); 
};	


outreg2 using "${output}/pretend_adj.txt", replace dec(4)
	addstat("TG2S_est0",`TG2S_est0', "TG2S_cil0",`TG2S_cil0', "TG2S_cih0",`TG2S_cih0',
	"TG2S_est1",`TG2S_est1', "TG2S_cil1",`TG2S_cil1', "TG2S_cih1",`TG2S_cih1',
	"TG2S_est2",`TG2S_est2', "TG2S_cil2",`TG2S_cil2', "TG2S_cih2",`TG2S_cih2',
	"TG2S_est3",`TG2S_est3', "TG2S_cil3",`TG2S_cil3', "TG2S_cih3",`TG2S_cih3',
	"TG2S_est4",`TG2S_est4', "TG2S_cil4",`TG2S_cil4', "TG2S_cih4",`TG2S_cih4',
	"TG2S_est5",`TG2S_est5', "TG2S_cil5",`TG2S_cil5', "TG2S_cih5",`TG2S_cih5',
	"TG2S_est6",`TG2S_est6', "TG2S_cil6",`TG2S_cil6', "TG2S_cih6",`TG2S_cih6',
	"TG2S_est7",`TG2S_est7', "TG2S_cil7",`TG2S_cil7', "TG2S_cih7",`TG2S_cih7',
	"TG2S_est8",`TG2S_est8', "TG2S_cil8",`TG2S_cil8', "TG2S_cih8",`TG2S_cih8',
  "TG4S_est0",`TG4S_est0', "TG4S_cil0",`TG4S_cil0', "TG4S_cih0",`TG4S_cih0',	
	"TG4S_est1",`TG4S_est1', "TG4S_cil1",`TG4S_cil1', "TG4S_cih1",`TG4S_cih1',
	"TG4S_est2",`TG4S_est2', "TG4S_cil2",`TG4S_cil2', "TG4S_cih2",`TG4S_cih2',
	"TG4S_est3",`TG4S_est3', "TG4S_cil3",`TG4S_cil3', "TG4S_cih3",`TG4S_cih3',
	"TG4S_est4",`TG4S_est4', "TG4S_cil4",`TG4S_cil4', "TG4S_cih4",`TG4S_cih4',
	"TG4S_est5",`TG4S_est5', "TG4S_cil5",`TG4S_cil5', "TG4S_cih5",`TG4S_cih5',
	"TG4S_est6",`TG4S_est6', "TG4S_cil6",`TG4S_cil6', "TG4S_cih6",`TG4S_cih6',
	"TG4S_est7",`TG4S_est7', "TG4S_cil7",`TG4S_cil7', "TG4S_cih7",`TG4S_cih7',
	"TG4S_est8",`TG4S_est8', "TG4S_cil8",`TG4S_cil8', "TG4S_cih8",`TG4S_cih8',
  "TG6S_est0",`TG6S_est0', "TG6S_cil0",`TG6S_cil0', "TG6S_cih0",`TG6S_cih0',
	"TG6S_est1",`TG6S_est1', "TG6S_cil1",`TG6S_cil1', "TG6S_cih1",`TG6S_cih1',
	"TG6S_est2",`TG6S_est2', "TG6S_cil2",`TG6S_cil2', "TG6S_cih2",`TG6S_cih2',
	"TG6S_est3",`TG6S_est3', "TG6S_cil3",`TG6S_cil3', "TG6S_cih3",`TG6S_cih3',
	"TG6S_est4",`TG6S_est4', "TG6S_cil4",`TG6S_cil4', "TG6S_cih4",`TG6S_cih4',
	"TG6S_est5",`TG6S_est5', "TG6S_cil5",`TG6S_cil5', "TG6S_cih5",`TG6S_cih5',
	"TG6S_est6",`TG6S_est6', "TG6S_cil6",`TG6S_cil6', "TG6S_cih6",`TG6S_cih6',
	"TG6S_est7",`TG6S_est7', "TG6S_cil7",`TG6S_cil7', "TG6S_cih7",`TG6S_cih7',
	"TG6S_est8",`TG6S_est8', "TG6S_cil8",`TG6S_cil8', "TG6S_cih8",`TG6S_cih8',
  "TR2_est0",`TR2_est0', "TR2_cil0",`TR2_cil0', "TR2_cih0",`TR2_cih0',
	"TR2_est1",`TR2_est1', "TR2_cil1",`TR2_cil1', "TR2_cih1",`TR2_cih1',
	"TR2_est2",`TR2_est2', "TR2_cil2",`TR2_cil2', "TR2_cih2",`TR2_cih2',
	"TR2_est3",`TR2_est3', "TR2_cil3",`TR2_cil3', "TR2_cih3",`TR2_cih3',
	"TR2_est4",`TR2_est4', "TR2_cil4",`TR2_cil4', "TR2_cih4",`TR2_cih4',
	"TR2_est5",`TR2_est5', "TR2_cil5",`TR2_cil5', "TR2_cih5",`TR2_cih5',
	"TR2_est6",`TR2_est6', "TR2_cil6",`TR2_cil6', "TR2_cih6",`TR2_cih6',
	"TR2_est7",`TR2_est7', "TR2_cil7",`TR2_cil7', "TR2_cih7",`TR2_cih7',
	"TR2_est8",`TR2_est8', "TR2_cil8",`TR2_cil8', "TR2_cih8",`TR2_cih8',
  "TR4_est0",`TR4_est0', "TR4_cil0",`TR4_cil0', "TR4_cih0",`TR4_cih0',
	"TR4_est1",`TR4_est1', "TR4_cil1",`TR4_cil1', "TR4_cih1",`TR4_cih1',
	"TR4_est2",`TR4_est2', "TR4_cil2",`TR4_cil2', "TR4_cih2",`TR4_cih2',
	"TR4_est3",`TR4_est3', "TR4_cil3",`TR4_cil3', "TR4_cih3",`TR4_cih3',
	"TR4_est4",`TR4_est4', "TR4_cil4",`TR4_cil4', "TR4_cih4",`TR4_cih4',
	"TR4_est5",`TR4_est5', "TR4_cil5",`TR4_cil5', "TR4_cih5",`TR4_cih5',
	"TR4_est6",`TR4_est6', "TR4_cil6",`TR4_cil6', "TR4_cih6",`TR4_cih6',
	"TR4_est7",`TR4_est7', "TR4_cil7",`TR4_cil7', "TR4_cih7",`TR4_cih7',
	"TR4_est8",`TR4_est8', "TR4_cil8",`TR4_cil8', "TR4_cih8",`TR4_cih8',
  "T24R6_est0",`T24R6_est0', "T24R6_cil0",`T24R6_cil0', "T24R6_cih0",`T24R6_cih0',
	"T24R6_est1",`T24R6_est1', "T24R6_cil1",`T24R6_cil1', "T24R6_cih1",`T24R6_cih1',
	"T24R6_est2",`T24R6_est2', "T24R6_cil2",`T24R6_cil2', "T24R6_cih2",`T24R6_cih2',
	"T24R6_est3",`T24R6_est3', "T24R6_cil3",`T24R6_cil3', "T24R6_cih3",`T24R6_cih3',
	"T24R6_est4",`T24R6_est4', "T24R6_cil4",`T24R6_cil4', "T24R6_cih4",`T24R6_cih4',
	"T24R6_est5",`T24R6_est5', "T24R6_cil5",`T24R6_cil5', "T24R6_cih5",`T24R6_cih5',
	"T24R6_est6",`T24R6_est6', "T24R6_cil6",`T24R6_cil6', "T24R6_cih6",`T24R6_cih6',
	"T24R6_est7",`T24R6_est7', "T24R6_cil7",`T24R6_cil7', "T24R6_cih7",`T24R6_cih7',
	"T24R6_est8",`T24R6_est8', "T24R6_cil8",`T24R6_cil8', "T24R6_cih8",`T24R6_cih8',
  "T6R6_est0",`T6R6_est0', "T6R6_cil0",`T6R6_cil0', "T6R6_cih0",`T6R6_cih0',
	"T6R6_est1",`T6R6_est1', "T6R6_cil1",`T6R6_cil1', "T6R6_cih1",`T6R6_cih1',
	"T6R6_est2",`T6R6_est2', "T6R6_cil2",`T6R6_cil2', "T6R6_cih2",`T6R6_cih2',
	"T6R6_est3",`T6R6_est3', "T6R6_cil3",`T6R6_cil3', "T6R6_cih3",`T6R6_cih3',
	"T6R6_est4",`T6R6_est4', "T6R6_cil4",`T6R6_cil4', "T6R6_cih4",`T6R6_cih4',
	"T6R6_est5",`T6R6_est5', "T6R6_cil5",`T6R6_cil5', "T6R6_cih5",`T6R6_cih5',
	"T6R6_est6",`T6R6_est6', "T6R6_cil6",`T6R6_cil6', "T6R6_cih6",`T6R6_cih6',
	"T6R6_est7",`T6R6_est7', "T6R6_cil7",`T6R6_cil7', "T6R6_cih7",`T6R6_cih7',
	"T6R6_est8",`T6R6_est8', "T6R6_cil8",`T6R6_cil8', "T6R6_cih8",`T6R6_cih8');



capture log close; 


** PANEL B OF FIGURE 5;

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
foreach v of var sanc {;
foreach n of num 2(2)6 {;
	gen G`n'`v' = `v' if group == `n'; recode G`n'`v' (. = 0); 
};
};

foreach v of var anysanc_rs2_fips anysanc_rs4_fips anysanc_rs6_fips  {; replace `v' = ln(`v'+1); };

forv i = 2(2)6 {;
	replace number_schools_fips`i' = number_schools_fips`i'+1 if group ==`i';
	gen number_unsanc_fips`i' = number_schools_fips`i' - anysanc_num`i'_fips;
};

egen number_unsanc_fips24 = rowtotal(number_unsanc_fips2 number_unsanc_fips4); 

** RECENTER SERIES AROUND 0 SO THAT OMITTED CATEGORY IS SAME FOR YEAR BY YEAR ESTS AND TREND ESTS;
replace t = t+1; 

** TEST EQUALITY OF PRE (T-4 TO T-1) TRENDS AND POST (T=1 TO T=4) TRENDS FOR UNSANCTIONED FOR-PROFIT COMPETITORS AND UNSANCTIONED OTHER COMPETITORS OF SANCTIONED FOR-PROFITS; 
* INDICATORS FOR PERIODS PRE/POST;
gen t1 = t<=-4; 
gen t2 = t>=-3 & t<=0;
gen t3 = t>=1  & t<6;
gen t4 = t>=6 ; 

* INTERACT WITH TIME TREND;
foreach v of var t1 t2 t3 t4 {; gen t`v' = t*`v'; };

* INTERACT WITH SANCTION/COMPETITOR SANCTION TREATMENT VARS;
foreach v of var G2sanc G4sanc G6sanc anysanc_rs2_fips anysanc_rs4_fips anysanc_rs6_fips  {;

forv t = 1/4 {;	

	gen tt`t'X`v' = tt`t'*`v'; 
	
};

};

* CREATE INTERACTIONS BETWEEN YEAR PRE/POST AND SANCTION INDICATORS/COMPETITORS SANCTIONED;
char t[omit] 0;
foreach n of num 2(2)6 {; xi, prefix(TG`n'S) i.t|G`n'sanc ; drop TG`n'St_*; }; 
foreach n of num 2(2)6  {; xi, prefix(TR`n') i.t|anysanc_rs`n'_fips; drop TR`n't_*; };

keep lnrecips_2 tt*XG2sanc tt*XG4sanc tt*XG6sanc tt*Xanysanc_rs2_fips tt*Xanysanc_rs4_fips tt*Xanysanc_rs6_fips  
	TG* TR* syid opeid t year group fips  ;

expand 2, gen(type); 

drop if type ==0 & abs(t)>8; 

* TYPE = 0 IS TREND REGRESSION, TYPE = 1 IS MAIN REGRESSION;
foreach v of var tt*XG2sanc tt*XG4sanc tt*XG6sanc tt*Xanysanc_rs2_fips tt*Xanysanc_rs4_fips tt*Xanysanc_rs6_fips  {;
	replace `v' = 0 if type == 1; 
};
   

foreach v of var TG2S* TG4S* TG6S* TR* {; replace `v' = 0 if type ==0; };

foreach v of var fips  t year syid group {; gen `v'_0 = `v' if type ==0; recode `v'_0 (. =0 ); gen `v'_1 = `v' if type ==1; recode `v'_1 (. = 0); drop `v';};
save expanded_data, replace;

use expanded_data,clear;

log using trend_corrected_event_study_pooledfp, replace; 

reghdfe lnrecips_2 tt*XG2sanc tt*XG4sanc tt*XG6sanc tt*Xanysanc_rs2_fips tt*Xanysanc_rs4_fips tt*Xanysanc_rs6_fips  
	TG2S* TG4S* TG6S* TR* type, a(syid_0 syid_1 t_0 t_1 year_0 year_1 fips_0##c.t_0 fips_1##c.t_1 group_0##c.t_0 group_1##c.t_1) cl(opeid);

** TREND CORRECTED ESTIMATES;
* SANCTIONED INSTITUTIONS;
** TREND CORRECTED ESTIMATES;
* SANCTIONED INSTITUTIONS;
foreach g of num 2(2)6 {;

forv i = 11/19 {; 
	loc k = `i'-10; 
	loc j = `k'-1;
	lincom TG`g'StXG`g'sa_`i' - tt2XG`g'sanc*`k';
	loc TG`g'S_est`j' = r(estimate); 
	loc TG`g'S_cil`j' = r(lb); 
	loc TG`g'S_cih`j' = r(ub); 
};	

};

* COMPETITORS OF SANCTIONED PUBLICS/NONPROFITS;
foreach g of num 2(2)6 {;

forv i = 11/19 {; 
	loc k = `i'-10; 
	loc j = `k'-1;
	lincom TR`g'tXanys_`i'- tt2Xanysanc_rs`g'_fips*`k';
	loc TR`g'_est`j' = r(estimate); 
	loc TR`g'_cil`j' = r(lb); 
	loc TR`g'_cih`j' = r(ub); 
};	
	
};

outreg2 using "${output}/pretrend_adj2.txt, replace dec(4)
	addstat("TG2S_est0",`TG2S_est0', "TG2S_cil0",`TG2S_cil0', "TG2S_cih0",`TG2S_cih0',
	"TG2S_est1",`TG2S_est1', "TG2S_cil1",`TG2S_cil1', "TG2S_cih1",`TG2S_cih1',
	"TG2S_est2",`TG2S_est2', "TG2S_cil2",`TG2S_cil2', "TG2S_cih2",`TG2S_cih2',
	"TG2S_est3",`TG2S_est3', "TG2S_cil3",`TG2S_cil3', "TG2S_cih3",`TG2S_cih3',
	"TG2S_est4",`TG2S_est4', "TG2S_cil4",`TG2S_cil4', "TG2S_cih4",`TG2S_cih4',
	"TG2S_est5",`TG2S_est5', "TG2S_cil5",`TG2S_cil5', "TG2S_cih5",`TG2S_cih5',
	"TG2S_est6",`TG2S_est6', "TG2S_cil6",`TG2S_cil6', "TG2S_cih6",`TG2S_cih6',
	"TG2S_est7",`TG2S_est7', "TG2S_cil7",`TG2S_cil7', "TG2S_cih7",`TG2S_cih7',
	"TG2S_est8",`TG2S_est8', "TG2S_cil8",`TG2S_cil8', "TG2S_cih8",`TG2S_cih8',
  "TG4S_est0",`TG4S_est0', "TG4S_cil0",`TG4S_cil0', "TG4S_cih0",`TG4S_cih0',	
	"TG4S_est1",`TG4S_est1', "TG4S_cil1",`TG4S_cil1', "TG4S_cih1",`TG4S_cih1',
	"TG4S_est2",`TG4S_est2', "TG4S_cil2",`TG4S_cil2', "TG4S_cih2",`TG4S_cih2',
	"TG4S_est3",`TG4S_est3', "TG4S_cil3",`TG4S_cil3', "TG4S_cih3",`TG4S_cih3',
	"TG4S_est4",`TG4S_est4', "TG4S_cil4",`TG4S_cil4', "TG4S_cih4",`TG4S_cih4',
	"TG4S_est5",`TG4S_est5', "TG4S_cil5",`TG4S_cil5', "TG4S_cih5",`TG4S_cih5',
	"TG4S_est6",`TG4S_est6', "TG4S_cil6",`TG4S_cil6', "TG4S_cih6",`TG4S_cih6',
	"TG4S_est7",`TG4S_est7', "TG4S_cil7",`TG4S_cil7', "TG4S_cih7",`TG4S_cih7',
	"TG4S_est8",`TG4S_est8', "TG4S_cil8",`TG4S_cil8', "TG4S_cih8",`TG4S_cih8',
  "TG6S_est0",`TG6S_est0', "TG6S_cil0",`TG6S_cil0', "TG6S_cih0",`TG6S_cih0',
	"TG6S_est1",`TG6S_est1', "TG6S_cil1",`TG6S_cil1', "TG6S_cih1",`TG6S_cih1',
	"TG6S_est2",`TG6S_est2', "TG6S_cil2",`TG6S_cil2', "TG6S_cih2",`TG6S_cih2',
	"TG6S_est3",`TG6S_est3', "TG6S_cil3",`TG6S_cil3', "TG6S_cih3",`TG6S_cih3',
	"TG6S_est4",`TG6S_est4', "TG6S_cil4",`TG6S_cil4', "TG6S_cih4",`TG6S_cih4',
	"TG6S_est5",`TG6S_est5', "TG6S_cil5",`TG6S_cil5', "TG6S_cih5",`TG6S_cih5',
	"TG6S_est6",`TG6S_est6', "TG6S_cil6",`TG6S_cil6', "TG6S_cih6",`TG6S_cih6',
	"TG6S_est7",`TG6S_est7', "TG6S_cil7",`TG6S_cil7', "TG6S_cih7",`TG6S_cih7',
	"TG6S_est8",`TG6S_est8', "TG6S_cil8",`TG6S_cil8', "TG6S_cih8",`TG6S_cih8',
  "TR2_est0",`TR2_est0', "TR2_cil0",`TR2_cil0', "TR2_cih0",`TR2_cih0',
	"TR2_est1",`TR2_est1', "TR2_cil1",`TR2_cil1', "TR2_cih1",`TR2_cih1',
	"TR2_est2",`TR2_est2', "TR2_cil2",`TR2_cil2', "TR2_cih2",`TR2_cih2',
	"TR2_est3",`TR2_est3', "TR2_cil3",`TR2_cil3', "TR2_cih3",`TR2_cih3',
	"TR2_est4",`TR2_est4', "TR2_cil4",`TR2_cil4', "TR2_cih4",`TR2_cih4',
	"TR2_est5",`TR2_est5', "TR2_cil5",`TR2_cil5', "TR2_cih5",`TR2_cih5',
	"TR2_est6",`TR2_est6', "TR2_cil6",`TR2_cil6', "TR2_cih6",`TR2_cih6',
	"TR2_est7",`TR2_est7', "TR2_cil7",`TR2_cil7', "TR2_cih7",`TR2_cih7',
	"TR2_est8",`TR2_est8', "TR2_cil8",`TR2_cil8', "TR2_cih8",`TR2_cih8',
  "TR4_est0",`TR4_est0', "TR4_cil0",`TR4_cil0', "TR4_cih0",`TR4_cih0',
	"TR4_est1",`TR4_est1', "TR4_cil1",`TR4_cil1', "TR4_cih1",`TR4_cih1',
	"TR4_est2",`TR4_est2', "TR4_cil2",`TR4_cil2', "TR4_cih2",`TR4_cih2',
	"TR4_est3",`TR4_est3', "TR4_cil3",`TR4_cil3', "TR4_cih3",`TR4_cih3',
	"TR4_est4",`TR4_est4', "TR4_cil4",`TR4_cil4', "TR4_cih4",`TR4_cih4',
	"TR4_est5",`TR4_est5', "TR4_cil5",`TR4_cil5', "TR4_cih5",`TR4_cih5',
	"TR4_est6",`TR4_est6', "TR4_cil6",`TR4_cil6', "TR4_cih6",`TR4_cih6',
	"TR4_est7",`TR4_est7', "TR4_cil7",`TR4_cil7', "TR4_cih7",`TR4_cih7',
	"TR4_est8",`TR4_est8', "TR4_cil8",`TR4_cil8', "TR4_cih8",`TR4_cih8',
  "TR6_est0",`TR6_est0', "TR6_cil0",`TR6_cil0', "TR6_cih0",`TR6_cih0',
	"TR6_est1",`TR6_est1', "TR6_cil1",`TR6_cil1', "TR6_cih1",`TR6_cih1',
	"TR6_est2",`TR6_est2', "TR6_cil2",`TR6_cil2', "TR6_cih2",`TR6_cih2',
	"TR6_est3",`TR6_est3', "TR6_cil3",`TR6_cil3', "TR6_cih3",`TR6_cih3',
	"TR6_est4",`TR6_est4', "TR6_cil4",`TR6_cil4', "TR6_cih4",`TR6_cih4',
	"TR6_est5",`TR6_est5', "TR6_cil5",`TR6_cil5', "TR6_cih5",`TR6_cih5',
	"TR6_est6",`TR6_est6', "TR6_cil6",`TR6_cil6', "TR6_cih6",`TR6_cih6',
	"TR6_est7",`TR6_est7', "TR6_cil7",`TR6_cil7', "TR6_cih7",`TR6_cih7',
	"TR6_est8",`TR6_est8', "TR6_cil8",`TR6_cil8', "TR6_cih8",`TR6_cih8');



capture log close; 

