/* CREATES OUTPUT USED IN FIGURES 5 & 6 */
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
	
	bysort opeid t (sanct_year): gen priornum`i'= anysanc_num_fips[_n-`i'] if opeid == opeid[_n-`i'] & t == t[_n-`i'] & sanct_year == sanct_year[_n-`i']+`i';
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

** F5 & F6;
char t[omit] -1; 

xi: reghdfe lnrecips_2 i.t|G2sanc i.t|G4sanc i.t|G6sanc 
	i.t|anysanc_rs2_fips i.t|anysanc_rs4_fips   
	i.t|G24anysanc_rs6_fips i.t|G6anysanc_rs6_fips if abs(t)<=8 , a(syid t year fips##c.t group##c.t ) cl(opeid);

* F5&6 ESTIMATES; 
outreg2 _ItXG* _ItXany* using "${output}/F5_F6_event_study_coeffs.txt", st(coef) noaster replace; 
outreg2 _ItXG* _ItXany* using "${output}/F5_F6_event_study_coeffs.txt", st(ci_low) noaster ap; 
outreg2 _ItXG* _ItXany* using "${output}/F5_F6_event_study_coeffs.txt", st(ci_high) noaster ap;
	
** POOLED FP COMPETITOR ESTIMATES (F5B);
xi: reghdfe lnrecips_2 i.t|G2sanc i.t|G4sanc i.t|G6sanc 
	i.t|anysanc_rs2_fips i.t|anysanc_rs4_fips   
	i.t|anysanc_rs6_fips  if abs(t)<=8, a(syid t year fips##c.t group##c.t ) cl(opeid);

* F5B ; 
outreg2  _ItXanysb* using "${output}/F5B_event_study_coeffs.txt", st(coef) noaster replace; 
outreg2 _ItXanysb* using "${output}/F5B_event_study_coeffs.txt", st(ci_low) noaster ap; 
outreg2 _ItXanysb* using "${output}/F5B_event_study_coeffs.txt", st(ci_high) noaster ap;


*** CREATE EVENT-STUDY FIGURES;
** F5A, F5C, F5D, F6; 
* CREATE OUTPUT FOR TREND-ADJUSTED SERIES; 
*qui do F5_F6_supp_pretrend_adj.do; 
	
insheet using "${output}/pretrend_adj.txt", names clear; 
drop in 1/341;
gen t = real(substr(v1,-1,1)) ;
gen type = substr(v1,-4,3);
gen group = substr(v1,1,4);
drop v1; 
destring v2, replace;
drop if v2 == .; 
gen type2 = 1 if type =="est";
replace type2 = 2 if type == "cil";
replace type2 = 3 if type == "cih";
drop type; 
reshape wide v2 , i(group t) j(type2);

for any 1 2 3 \ any coef_adj cil_adj cih_adj : rename v2X Y; 

for any own_pub own_np  own_fp comp_pub comp_np other_comp_fp fp_comp_fp
	\ any "TG2S" "TG4S" "TG6S" "TR2_" "TR4_"  "T24R" "T6R6"
	: gen X = group == "Y"; 

drop group;	

save scrap, replace; 

* OUTPUT FROM MAIN SPEC;
insheet using "${output}/F5_F6_event_study_coeffs.txt", clear;
for any 2 3 4 \ any coef cil cih : rename vX Y;

gen own_pub = _n >=8 & _n<=23; 
gen own_np = _n >=29 & _n<=44;
gen own_fp = _n >=50 & _n<=65;
gen comp_pub = _n >=71 & _n<=86;
gen comp_np = _n >=92 & _n<=107;
gen other_comp_fp = _n >=113 & _n<=128;
gen fp_comp_fp = _n >=134 & _n<=149;

egen keep = rowmax(own_* *comp_* ); 
drop if keep ==0;	drop keep;

gen t = real(subinstr(substr(v1, -2,2),"_","",.))-11;
replace t = real(subinstr(substr(v1, -2,2),"a","",.))-11 if t==.;

drop v1;
	
foreach v of var coef cil cih {; destring `v', replace; };	

set obs 113; 
replace coef = 0 in 113; replace cil = 0 in 113; replace cih = 0 in 113; replace t = -1 in 113; 
foreach v of var own_* *comp_* {; replace `v' = 1 in 113; };	

merge 1:1 own_pub own_np  own_fp comp_pub comp_np other_comp_fp fp_comp_fp t using scrap, update;

foreach v of var cil_adj cih_adj coef_adj {; 
	recode `v' (. = 0) if t == -1; 
};
	
** SANCTIONED FP;
* F5A: OWN ENROLLMENT; 
	tw (rline cil cih t, sort lc(navy) lw(thin) lp(longdash) ) (connected coef t, sort lc(navy) mc(navy)) 
		(rline cil_adj cih_adj t if t>=-1, sort lc(midblue) lw(thin) lp(shortdash) ) (connected coef_adj t if t>=-1, sort lc(midblue) mc(midblue) ms(Oh)) 
		if  own_fp ==1,
			graphr(fc(white)) legend(order(2 4) lab(2 Baseline) lab(4 Trend-adjusted))
			xlab(-8(1)8, labs(small)) xti("Years before/after sanction") 
			ylab(-4.5(.5).5, gmin gmax labs(small)) yti("Point estimate, 95% CI") yli(0);
	graph export "${output}/F5A_event_study_ln_sanctionedfp.pdf", as(pdf) replace;			

* F5C: FP COMPETITOR ENROLLMENT; 
	tw (rline cil cih t, sort lc(navy) lw(thin) lp(longdash) ) (connected coef t, sort lc(navy) mc(navy)) 
		(rline cil_adj cih_adj t if t>=-1, sort lc(midblue) lw(thin) lp(shortdash) ) (connected coef_adj t if t>=-1, sort lc(midblue) mc(midblue) ms(Oh)) 
		if  fp_comp_fp==1,
		graphr(fc(white)) legend(order(2 4) lab(2 Baseline) lab(4 Trend-adjusted))
		xlab(-8(1)8, labs(small)) xti("Years before/after competitor sanction(s)") 
		ylab(-0.08(0.02)0.08, gmin gmax labs(small)) yti("Point estimate, 95% CI") yli(0);
	graph export "${output}/F5C_event_study_lnln_fpcomp.pdf", as(pdf) replace;			
	
* F5D: OTHER COMPETITOR ENROLLMENT; 
	tw (rline cil cih t, sort lc(navy) lw(thin) lp(longdash) ) (connected coef t, sort lc(navy) mc(navy)) 
		(rline cil_adj cih_adj t if t>=-1, sort lc(midblue) lw(thin) lp(shortdash) ) (connected coef_adj t if t>=-1, sort lc(midblue) mc(midblue) ms(Oh)) 
		if  other_comp_fp==1,
		graphr(fc(white)) legend(order(2 4) lab(2 Baseline) lab(4 Trend-adjusted))
			xlab(-8(1)8, labs(small)) xti("Years before/after competitor sanction(s)") 
			ylab(-0.08(0.02)0.08, gmin gmax labs(small)) yti("Point estimate, 95% CI") yli(0);	
	graph export "${output}/F5C_event_study_lnln_othercomp.pdf", as(pdf) replace;			
	
** SANCTIONED PUBLIC;
* F6A: OWN ENROLLMENT; 
	tw (rline cil cih t, sort lc(navy) lw(thin) lp(longdash)) (connected coef t, sort lc(navy) mc(navy)) 
		(rline cil_adj cih_adj t if t>=-1, sort lc(midblue) lw(thin) lp(shortdash) ) (connected coef_adj t if t>=-1, sort lc(midblue) mc(midblue) ms(Oh)) 
		if  own_pub ==1,
			graphr(fc(white)) legend(order(2 4) lab(2 Baseline) lab(4 Trend-adjusted))
			xlab(-8(1)8, labs(small)) xti("Years before/after sanction") 
			ylab(-3.5(1)1.5, gmin gmax labs(small)) yti("Point estimate, 95% CI") yli(0);
	graph export "${output}/F6A_event_study_ln_sanctionedpub.pdf", as(pdf) replace;			

* F6C: COMPETITOR ENROLLMENT; 
	tw (rline cil cih t, sort lc(navy) lw(thin) lp(longdash)) (connected coef t, sort lc(navy) mc(navy)) 
		(rline cil_adj cih_adj t if t>=-1, sort lc(midblue) lw(thin) lp(shortdash) ) (connected coef_adj t if t>=-1, sort lc(midblue) mc(midblue) ms(Oh)) 
		if  comp_pub==1,
			graphr(fc(white))  legend(order(2 4) lab(2 Baseline) lab(4 Trend-adjusted))
			xlab(-8(1)8, labs(small)) xti("Years before/after competitor sanction(s)") 
			ylab(-0.1(0.05)0.3, gmin gmax labs(small)) yti("Point estimate, 95% CI") yli(0);
	graph export "${output}/F6C_event_study_lnln_compsancpub.pdf", as(pdf) replace;			

** SANCTIONED NP;
* F6B: OWN ENROLLMENT; 
	tw (rline cil cih t, sort lc(navy) lw(thin) lp(longdash)) (connected coef t, sort lc(navy) mc(navy)) 
		(rline cil_adj cih_adj t if t>=-1, sort lc(midblue) lw(thin) lp(shortdash) ) (connected coef_adj t if t>=-1, sort lc(midblue) mc(midblue) ms(Oh)) 
		if  own_np ==1,
			graphr(fc(white)) legend(order(2 4) lab(2 Baseline) lab(4 Trend-adjusted))
			xlab(-8(1)8, labs(small)) xti("Years before/after sanction") 
			ylab(-3(1)1, gmin gmax labs(small)) yti("Point estimate, 95% CI") yli(0);
	graph export "${output}/F6B_event_study_ln_sanctionednp.pdf", as(pdf) replace;			

* F6D: COMPETITOR ENROLLMENT; 
	tw (rline cil cih t, sort lc(navy) lw(thin) lp(longdash)) (connected coef t, sort lc(navy) mc(navy)) 
		(rline cil_adj cih_adj t if t>=-1, sort lc(midblue) lw(thin) lp(shortdash) ) (connected coef_adj t if t>=-1, sort lc(midblue) mc(midblue) ms(Oh)) 
		if  comp_np==1,
			graphr(fc(white)) legend(order(2 4) lab(2 Baseline) lab(4 Trend-adjusted))
			xlab(-8(1)8, labs(small)) xti("Years before/after competitor sanction(s)") 
			ylab(-0.05(0.05)0.25, gmin gmax labs(small)) yti("Point estimate, 95% CI") yli(0);
	graph export "${output}/F6D_event_study_lnln_compsancnp.pdf", as(pdf) replace;			

restore;

** F5B; 
* OUTPUT FOR TREND-ADJUSTED SERIES; 
insheet using "${output}/pretrend_adj2.txt", names clear; 
drop in 1/294;
gen t = real(substr(v1,-1,1)) ;
gen type = substr(v1,-4,3);
gen group = substr(v1,1,4);
drop v1; 
destring v2, replace;
drop if v2 == .; 
gen type2 = 1 if type =="est";
replace type2 = 2 if type == "cil";
replace type2 = 3 if type == "cih";
drop type; 
reshape wide v2 , i(group t) j(type2);

for any 1 2 3 \ any coef_adj cil_adj cih_adj : rename v2X Y; 

for any own_pub own_np  own_fp comp_pub comp_np comp_fp 
	\ any "TG2S" "TG4S" "TG6S" "TR2_" "TR4_"  "TR6_" 
	: gen X = group == "Y"; 

drop group;	

keep if comp_fp == 1; 
save scrap, replace; 

insheet using "${output}/F5B_event_study_coeffs.txt", clear;
for any 2 3 4 \ any coef cil cih : rename vX Y;
drop v1; 
	
keep if _n >=113 & _n <=128;
	
gen t = _n; replace t = t-9; replace t = t+1 if t>=-1; 

foreach v of var coef cil cih {; destring `v', replace; };	

set obs 17;
replace coef = 0 in 17; replace cil = 0 in 17; replace cih = 0 in 17; replace t = -1 in 17; 
	
merge 1:1 t using scrap, update;

foreach v of var cil_adj cih_adj coef_adj {; 
	recode `v' (. = 0) if t == -1; 
};
	
* F5B: POOLED COMPETITORS OF SANCTIONED FP; 
tw (rline cil cih t, sort  lc(navy) lw(thin) lp(longdash)) (connected coef t, sort lc(navy) mc(navy)) 
	(rline cil_adj cih_adj t if t>=-1, sort lc(midblue) lw(thin) lp(shortdash) ) (connected coef_adj t if t>=-1, sort lc(midblue) mc(midblue) ms(Oh)) ,
		graphr(fc(white)) legend(order(2 4) lab(2 Baseline) lab(4 Trend-adjusted) size(small))
		xlab(-8(1)8, labs(small)) xti("Years before/after competitor sanction(s)") 
		ylab(-0.08(0.02)0.08, gmin gmax labs(small)) yti("Point estimate, 95% CI") yli(0);
	graph export "${output}/F5B_event_study_ln_sanctionedfp.pdf", as(pdf) replace;			

* CLEAN UP;
erase scrap.dta; 
	
	

	