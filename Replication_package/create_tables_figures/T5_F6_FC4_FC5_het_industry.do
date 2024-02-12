/* CREATES OUTPUT USED IN TABLE 5: HETEROGENEITY BY INDUSTRY */
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
drop if inlist(fips,4013, 6037, 6059, 6073, 12025, 17031, 26163, 36061, 42003, 42101, 48113, 48201, 36005, 36047, 36081, 36085);

drop if abs(t)  >10; 
 
gen lnrecips = ln(recipients);
gen lnrecips_2 = ln(recipients + 1); 

egen syid = group(opeid sanct_year); 

* DROP SCHOOLS THAT DO NOT HAVE ANY PELL RECIPIENTS IN 10-YEAR WINDOW AROUND SANCTION YEAR;
bysort syid : egen max = max(recipients ) ; drop if max == 0; drop max; 

** LIMIT TO FIRST EVENT FOR TREATED OBS;
forv i = 1/9 {;
	bysort opeid t (sanct_year): gen priorsanc`i'= sanc[_n-`i'] if opeid == opeid[_n-`i'] & t == t[_n-`i'] & sanct_year == sanct_year[_n-`i']+`i';
	recode priorsanc`i' (. = 0);
	
	bysort opeid t (sanct_year): gen priornum`i'= anysanc_num6_fips[_n-`i'] if opeid == opeid[_n-`i'] & t == t[_n-`i'] & sanct_year == sanct_year[_n-`i']+`i';
	recode priornum`i' (. = 0);
};

foreach v of var prior* {; drop if `v'>0; };

gen post = t>=0; 

forv i = 2(2)6 {;
	replace number_schools_fips`i' = number_schools_fips`i'+1 if group ==`i';
	gen number_unsanc_fips`i' = number_schools_fips`i' - anysanc_num`i'_fips;
};

* INTERACT TREATMENTXPOST WITH SECTOR INDICATORS;
foreach v of var sanc anysanc_rs*_fips {;
foreach n of num 2(2)6 {;
	gen G`n'`v' = `v' if group == `n'; recode G`n'`v' (. = 0); 
};
};

** (1) POOLED - SAME V DIFFERENT INDUSTRY;
gen G6anysanc_rsind_fips1 = 0;
egen G6anysanc_rsind_fips0 = rowtotal(anysanc_rstech_fips anysanc_rshealth_fips anysanc_rsbeauty_fips anysanc_rscomp_bus_fips anysanc_rscul_art_fips anysanc_rsmech_eng_fips); 

foreach v in tech health beauty comp_bus cul_art mech_eng {;

	replace G6anysanc_rsind_fips1 = anysanc_rs`v'_fips if `v' ==1;  
	replace G6anysanc_rsind_fips0 = G6anysanc_rsind_fips0  - anysanc_rs`v'_fips if `v' == 1; 
	
	
};	  	

foreach v of var G*anysanc_rs2_fips G*anysanc_rs4_fips G2anysanc_rs6_fips G4anysanc_rs6_fips {; replace `v' = ln(`v'+1); };

replace G6anysanc_rsind_fips1 = ln(G6anysanc_rsind_fips1 +1) if group ==6; replace G6anysanc_rsind_fips1 = 0 if group ~=6; 
replace G6anysanc_rsind_fips0  = ln(G6anysanc_rsind_fips0 +1) if group ==6; replace G6anysanc_rsind_fips0 = 0 if group ~=6; 

xi: reghdfe lnrecips_2 i.post|G2sanc i.post|G4sanc i.post|G6sanc 
	i.post|G2anysanc_rs2_fips i.post|G4anysanc_rs2_fips  i.post|G6anysanc_rs2_fips 
	i.post|G2anysanc_rs4_fips   i.post|G4anysanc_rs4_fips    i.post|G6anysanc_rs4_fips   
	i.post|G2anysanc_rs6_fips i.post|G4anysanc_rs6_fips  
	i.post|G6anysanc_rsind_fips1 i.post|G6anysanc_rsind_fips0 if abs(t)<=8, a(syid t year fips##c.t group##c.t ) cl(opeid);

test  _IposXG6anyb1  = _IposXG6anyc1 ; loc p = r(p); 

outreg2 using "${output}\T5_het_industry.txt", keep(_I*) replace dec(3) sym(**,*,+) se aster(se) 
	addstat("pval - fp industry", `p');


** (2) BEAUTY VERSUS OTHER;
gen G6anysanc_rsbeauty_fips1 = G6anysanc_rsind_fips1*beauty;
gen G6anysanc_rsbeauty_fips0 = G6anysanc_rsind_fips0*beauty;
gen G6anysanc_rsnonbeauty_fips1= G6anysanc_rsind_fips1*(1-beauty);
gen G6anysanc_rsnonbeauty_fips0= G6anysanc_rsind_fips0*(1-beauty);

gen G6sancbeauty = G6sanc*beauty;
gen G6sancnonbeauty = G6sanc*(1-beauty);

replace G4anysanc_rsbeauty_fips = ln(G4anysanc_rsbeauty_fips +1) if group == 4; 
recode G4anysanc_rsbeauty_fips (. = 0); 
replace G2anysanc_rsbeauty_fips = ln(G2anysanc_rsbeauty_fips +1) if group == 2; 
recode G2anysanc_rsbeauty_fips (. = 0); 
gen G2anysanc_rsnonbeauty_fips = ln((G2anysanc_rs6_fips - G2anysanc_rsbeauty_fips ) +1) if group == 2; 
recode G2anysanc_rsnonbeauty_fips (. = 0); 
gen G4anysanc_rsnonbeauty_fips = ln((G4anysanc_rs6_fips - G4anysanc_rsbeauty_fips ) +1) if group == 4; 
recode G4anysanc_rsnonbeauty_fips (. = 0); 

xi: reghdfe lnrecips_2 i.post|G2sanc i.post|G4sanc i.post|G6sancbeauty i.post|G6sancnonbeauty 
	i.post|G2anysanc_rs2_fips i.post|G4anysanc_rs2_fips  i.post|G6anysanc_rs2_fips 
	i.post|G2anysanc_rs4_fips   i.post|G4anysanc_rs4_fips    i.post|G6anysanc_rs4_fips   
	i.post|G2anysanc_rsbeauty_fips i.post|G2anysanc_rsnonbeauty_fips
	i.post|G4anysanc_rsbeauty_fips i.post|G4anysanc_rsnonbeauty_fips
	i.post|G6anysanc_rsbeauty_fips1 i.post|G6anysanc_rsbeauty_fips0 
	i.post|G6anysanc_rsnonbeauty_fips1 i.post|G6anysanc_rsnonbeauty_fips0 
	if abs(t)<=8, a(syid t year fips##c.t group##c.t ) cl(opeid);

test  _IposXG6anyb1 =  _IposXG6anyc1 ; loc p_beauty = r(p); 
test   _IposXG6anyd1 =  _IposXG6anye1; loc p_nonbeauty = r(p); 

outreg2 using "${output}\T5_het_industry.txt", keep(_I*) ap dec(3) sym(**,*,+) se aster(se) 
	addstat("pval - fp beauty", `p_beauty',"pval - fp nonbeauty", `p_nonbeauty');

** (3) BY INDUSTRY;
foreach v of var tech health comp_bus cul_art mech_eng {;
	gen G6sanc`v' = G6sanc*`v'; 
	gen G6anysanc_rs`v'_fips1 = ln(G6anysanc_rs`v'_fips +1) if `v' == 1 & group == 6; 
	recode G6anysanc_rs`v'_fips1 (. = 0); 
	gen G6anysanc_rs`v'_fips0 = ln(G6anysanc_rs`v'_fips +1) if `v' == 0 & group == 6; 
	recode G6anysanc_rs`v'_fips0 (. = 0); 
	replace G4anysanc_rs`v'_fips = ln(G4anysanc_rs`v'_fips +1) if group == 4; 
	recode G4anysanc_rs`v'_fips (. = 0); 
	replace G2anysanc_rs`v'_fips = ln(G2anysanc_rs`v'_fips +1) if group == 2; 
	recode G2anysanc_rs`v'_fips (. = 0); 
};

xi: reghdfe lnrecips_2 i.post|G2sanc i.post|G4sanc i.post|G6sanctech i.post|G6sanchealth 
	i.post|G6sancbeauty i.post|G6sanccomp_bus i.post|G6sanccul_art i.post|G6sancmech_eng     
	i.post|G2anysanc_rs2_fips i.post|G4anysanc_rs2_fips  i.post|G6anysanc_rs2_fips 
	i.post|G2anysanc_rs4_fips   i.post|G4anysanc_rs4_fips    i.post|G6anysanc_rs4_fips   
	i.post|G2anysanc_rstech_fips i.post|G2anysanc_rshealth_fips 	i.post|G2anysanc_rsbeauty_fips
	i.post|G2anysanc_rscomp_bus_fips	i.post|G2anysanc_rscul_art_fips i.post|G2anysanc_rsmech_eng_fips
	i.post|G4anysanc_rstech_fips i.post|G4anysanc_rshealth_fips 	i.post|G4anysanc_rsbeauty_fips
	i.post|G4anysanc_rscomp_bus_fips	i.post|G4anysanc_rscul_art_fips i.post|G4anysanc_rsmech_eng_fips	
	i.post|G6anysanc_rstech_fips1 i.post|G6anysanc_rstech_fips0 
	i.post|G6anysanc_rshealth_fips1 i.post|G6anysanc_rshealth_fips0 
	i.post|G6anysanc_rsbeauty_fips1 i.post|G6anysanc_rsbeauty_fips0 
	i.post|G6anysanc_rscomp_bus_fips1 i.post|G6anysanc_rscomp_bus_fips0 
	i.post|G6anysanc_rscul_art_fips1 i.post|G6anysanc_rscul_art_fips0 
	i.post|G6anysanc_rsmech_eng_fips1 i.post|G6anysanc_rsmech_eng_fips0 	
	if abs(t)<=8, a(syid t year fips##c.t group##c.t ) cl(opeid);

test _IposXG6anyb1 = _IposXG6anyc1; loc p_tech = r(p);
test _IposXG6anyd1 = _IposXG6anye1; loc p_health = r(p); 
test _IposXG6anyf1 = _IposXG6anyg1; loc p_beauty = r(p);
test _IposXG6anyh1 = _IposXG6anyi1; loc p_comp_bus = r(p);
test _IposXG6anyj1 = _IposXG6anyk1; loc p_cul_art = r(p) ;
test _IposXG6anyl1 = _IposXG6anym1; loc p_mech_eng = r(p);

outreg2 using "${output}\T5_het_industry.txt", keep(_I*) ap dec(3) sym(**,*,+) se aster(se) 
	addstat("pval - tech", `p_tech',"pval - health", `p_health',"pval - beauty", `p_beauty',"pval - comp/business", `p_comp_bus',"pval - culinary/arts", `p_cul_art', "pval - mechanics/engin", `p_mech_eng');

** F7: INDUSTRY ANALYSES EVENT STUDY CHARTS;
* NUMBER OF RECIPIENTS EXPOSED TO SANCTION IN SAME VERSUS DIFFERENT SECTOR;
char t[omit] -1;

gen G24anysanc_rsbeauty_fips = G4anysanc_rsbeauty_fips if group == 4; 
replace G24anysanc_rsbeauty_fips = G2anysanc_rsbeauty_fips if group == 2;
replace G24anysanc_rsbeauty_fips = 0 if group == 6;

gen G24anysanc_rsnonbeauty_fips = G4anysanc_rsnonbeauty_fips if group == 4; 
replace G24anysanc_rsnonbeauty_fips = G2anysanc_rsnonbeauty_fips if group == 2;
replace G24anysanc_rsnonbeauty_fips = 0 if group == 6;

xi: reghdfe lnrecips_2 i.t|G2sanc i.t|G4sanc i.t|G6sancbeauty i.t|G6sancnonbeauty 
	i.t|anysanc_rs2_fips i.t|anysanc_rs4_fips   
	i.t|G24anysanc_rsbeauty_fips i.t|G24anysanc_rsnonbeauty_fips
	i.t|G6anysanc_rsbeauty_fips1 i.t|G6anysanc_rsbeauty_fips0 
	i.t|G6anysanc_rsnonbeauty_fips1 i.t|G6anysanc_rsnonbeauty_fips0 
	if abs(t)<=8, a(syid t year fips##c.t group##c.t ) cl(opeid);


outreg2 _ItXG* _ItXany* using "${output}\F7_event_study_coeffs.txt", st(coef) noaster replace; 
outreg2 _ItXG* _ItXany* using "${output}\F7_event_study_coeffs.txt", st(ci_low) noaster ap; 
outreg2 _ItXG* _ItXany* using "${output}\F7_event_study_coeffs.txt", st(ci_high) noaster ap;


* READ IN COEFF AND CI ESTIMATES;
insheet using "${output}/F7_event_study_coeffs.txt", clear;
for any 2 3 4 \ any coef cil cih : rename vX Y;

gen own_pub = _n >=8 & _n<=23; 
gen own_np = _n >=29 & _n<=44;
gen own_fp_beauty = _n >=50 & _n<=65;
gen own_fp_nonbeauty = _n >=71 & _n<=86;
gen comp_pub = _n >=92 & _n<=107;
gen comp_np = _n >=113 & _n<=128;
gen other_comp_beauty = _n >=134 & _n<=149;
gen other_comp_nonbeauty = _n >=155 & _n<=170;
gen fp_comp_beauty_same = _n >=176 & _n<=191;
gen fp_comp_beauty_diff = _n >=197 & _n<=212;
gen fp_comp_nonbeauty_same = _n >=218 & _n<=233;
gen fp_comp_nonbeauty_diff = _n >=239 & _n<=254;

egen keep = rowmax(own_* *comp_* ); 
drop if keep ==0;	drop keep;

gen t = real(subinstr(substr(v1, -2,2),"_","",.))-11;
replace t = real(subinstr(substr(v1, -2,2),"a","",.))-11 if t==.;
replace t = real(subinstr(substr(v1, -2,2),"b","",.))-11 if t==.;
replace t = real(subinstr(substr(v1, -2,2),"c","",.))-11 if t==.;

drop v1; 

foreach v of var coef cil cih {; destring `v', replace; };	

set obs 193; 
replace coef = 0 in 193; replace cil = 0 in 193; replace cih = 0 in 193; replace t = -1 in 193; 
foreach v of var own_* *comp_* {; replace `v' = 1 in 193; };	

** FIGURE 6;
* UNSANCTIONED (NON-BEAUTY) COMPETITORS OF SANCTIONED SCHOOLS IN SAME INDUSTRY (PANEL A); 
	tw (rline cil cih t, sort lc(navy) lw(thin) lp(longdash) ) (connected coef t, sort lc(navy) mc(navy)) if  fp_comp_nonbeauty_same ==1,
		graphr(fc(white)) legend(off)
		xlab(-8(1)8, labs(small)) xti("Years before/after competitor sanction(s)") 
		ylab(-0.2(0.05)0.15, gmin gmax labs(small)) yti("Point estimate, 95% CI") yli(0);
	graph export "${output}/F6A_event_study_lnln_fpcomp_same_nonbeauty.pdf", as(pdf) replace;			

* UNSANCTIONED (NON-BEAUTY) COMPETITORS OF SANCTIONED SCHOOLS IN DIFFERENT INDUSTRY (PANEL B); 
	tw (rline cil cih t, sort lc(navy) lw(thin) lp(longdash) ) (connected coef t, sort lc(navy) mc(navy)) if  fp_comp_nonbeauty_diff ==1,
		graphr(fc(white)) legend(off)
		xlab(-8(1)8, labs(small)) xti("Years before/after competitor sanction(s)") 
		ylab(-0.2(0.05)0.15, gmin gmax labs(small)) yti("Point estimate, 95% CI") yli(0);
	graph export "${output}/FC5B_event_study_lnln_fpcomp_beauty_diff.pdf", as(pdf) replace;			


** APPENDIX FIGURE C.4;
* SANCTIONED BEAUTY FP OWN ENROLLMENT (FC4, PANEL A);
	tw (rline cil cih t, sort lc(navy) lw(thin) lp(longdash) ) (connected coef t, sort lc(navy) mc(navy)) if  own_fp_beauty ==1,
			graphr(fc(white)) legend(off)
			xlab(-8(1)8, labs(small)) xti("Years before/after sanction") 
			ylab(-2(.5)1, gmin gmax labs(small)) yti("Point estimate, 95% CI") yli(0);
	graph export "${output}/FC4A_event_study_ln_sanctionedbeautyfp.pdf", as(pdf) replace;			

* SANCTIONED NONBEAUTY FP OWN ENROLLMENT (FC4, PANEL B);
	tw (rline cil cih t, sort lc(navy) lw(thin) lp(longdash) ) (connected coef t, sort lc(navy) mc(navy)) if  own_fp_nonbeauty ==1,
			graphr(fc(white)) legend(off)
			xlab(-8(1)8, labs(small)) xti("Years before/after sanction") 
			ylab(-4(.5)1, gmin gmax labs(small)) yti("Point estimate, 95% CI") yli(0);
	graph export "${output}/FC4B_event_study_ln_sanctionedfp_nobeauty.pdf", as(pdf) replace;			

** APPENDIX FIGURE C.5;
* UNSANCTIONED BEAUTY COMPETITORS OF SANCTIONED BEAUTY SCHOOLS (FC5, PANEL A); 
	tw (rline cil cih t, sort lc(navy) lw(thin) lp(longdash) ) (connected coef t, sort lc(navy) mc(navy)) if  fp_comp_beauty_same ==1,
		graphr(fc(white)) legend(off)
		xlab(-8(1)8, labs(small)) xti("Years before/after competitor sanction(s)") 
		ylab(-0.2(0.05)0.15, gmin gmax labs(small)) yti("Point estimate, 95% CI") yli(0);
	graph export "${output}/FC5A_event_study_lnln_fpcomp_same_beauty.pdf", as(pdf) replace;			

* UNSANCTIONED BEAUTY COMPETITORS OF SANCTIONED BEAUTY SCHOOLS (FC5, PANEL B); 
	tw (rline cil cih t, sort lc(navy) lw(thin) lp(longdash) ) (connected coef t, sort lc(navy) mc(navy)) if  fp_comp_beauty_diff ==1,
		graphr(fc(white)) legend(off)
		xlab(-8(1)8, labs(small)) xti("Years before/after competitor sanction(s)") 
		ylab(-0.2(0.05)0.15, gmin gmax labs(small)) yti("Point estimate, 95% CI") yli(0);
	graph export "${output}/FC5B_event_study_lnln_fpcomp_beauty_diff.pdf", as(pdf) replace;			
