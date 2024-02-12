/***** THIS PROGRAM CREATES OUTPUT FOR TABLE 6 (Market-wide Borrowing and Defaulting Borrowing and Defaults Following For-Profit Sanctions), *****/
/***** APPENDIX TABLE C.16 (The Effect of Sanctions on the Number of Borrowers and Defaulters), and FIGURE 7 (EVENT STUDY FOR BORR/DEFAULTERS) ****/


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

* OPTION TO DROP COUNTIES WITH MORE THAN 50 SCHOOLS (WITH PELL RECIPIENTS) PER YEAR, ON AVERAGE;
destring fips, replace; 
drop if inlist(fips,4013, 6037, 6059, 6073, 12025, 17031, 26163, 36061, 42003, 42101, 48113, 48201, 36005, 36047, 36081, 36085);

drop if abs(t)  >10; 

gen lnrecips = ln(recipients);
gen lnrecips_2 = ln(recipients + 1); 

egen syid = group(opeid sanct_year); 

* DROP SCHOOLS THAT DO NOT HAVE ANY PELL RECIPIENTS OVER WINDOW AROUND SANCTION YEAR ;
bysort syid : egen max = max(recipients ) ; drop if max == 0; drop max; 

recode nbr (. = 0) if year >=1992; recode nbd (.  = 0) if year>=1992; 

* ALIGN BORROWER AND DEFAULTER MEASURES WITH YEAR OF ENTERING REPAYMENT (RATHER THAN YEAR CDR WAS REPORTED); 
bysort syid (t): gen nbr_2 = nbr[_n+2] if syid == syid[_n+2] & t == t[_n+2]-2; 
bysort syid (t): gen nbd_2 = nbd[_n+2] if syid == syid[_n+2] & t == t[_n+2]-2; 

gen lnnbr = ln(nbr_2+1);
gen lnnbd = ln(nbd_2+1); 

** OPTION TO LIMIT TO FIRST EVENT FOR TREATED OBS ;
forv i = 1/9 {;
	bysort opeid t (sanct_year): gen priorsanc`i'= sanc[_n-`i'] if opeid == opeid[_n-`i'] & t == t[_n-`i'] & sanct_year == sanct_year[_n-`i']+`i';
	recode priorsanc`i' (. = 0);
	
	bysort opeid t (sanct_year): gen priornum`i'= anysanc_num6_fips[_n-`i'] if opeid == opeid[_n-`i'] & t == t[_n-`i'] & sanct_year == sanct_year[_n-`i']+`i';
	recode priornum`i' (. = 0);
};

foreach v of var prior* {; drop if `v'>0; };

gen G24anysanc_rs6_fips = anysanc_rs6_fips if inlist(group,2,4); 
recode G24anysanc_rs6_fips (. = 0); 

foreach v of var anysanc_rs2_fips anysanc_rs4_fips  anysanc_rs6_fips  G24anysanc_rs6_fips {; replace `v' = ln(`v'+1); };

* INTERACT TREATMENTXPOST WITH SECTOR INDICATORS;
foreach v of var sanc anysanc_rs2_fips anysanc_rs4_fips  anysanc_rs6_fips {;
foreach n of num 2(2)6 {;
	gen G`n'`v' = `v' if group == `n'; recode G`n'`v' (. = 0); 
};
};



gen post = t>=0; 

forv i = 2(2)6 {;
	replace number_schools_fips`i' = number_schools_fips`i'+1 if group ==`i';
	gen number_unsanc_fips`i' = number_schools_fips`i' - anysanc_num`i'_fips;
};

* BALANCED PANEL; 
drop if t<-1; 

foreach v of var nbr nbd {;

* IMPACT OF SANCTIONS ON OWN ENROLLMENT AND COMPETITOR BORROWERS/DEFAULTERS;
xi: reghdfe ln`v'  i.post|G2sanc i.post|G4sanc i.post|G6sanc 
	i.post|G2anysanc_rs2_fips i.post|G4anysanc_rs2_fips  i.post|G6anysanc_rs2_fips  
	i.post|G2anysanc_rs4_fips  i.post|G4anysanc_rs4_fips   i.post|G6anysanc_rs4_fips   
	i.post|G2anysanc_rs6_fips   i.post|G4anysanc_rs6_fips   i.post|G6anysanc_rs6_fips  if abs(t)<=8, a(syid t year group##c.t fips##c.t) cl(opeid);

test _IposXG2san_1 =  _IposXG4san_1 =  _IposXG6san_1; loc p_sanc = r(p); 
test  _IposXG2any_1 =  _IposXG4any_1 =  _IposXG6any_1; loc p_comp2 = r(p);
test  _IposXG2anya1 =  _IposXG4anya1 =  _IposXG6anya1; loc p_comp4 = r(p);
test  _IposXG2anyb1 =  _IposXG4anyb1 =  _IposXG6anyb1; loc p_comp6 = r(p);
test  _IposXG2any_1 =  _IposXG2anya1 =  _IposXG2anyb1; loc p_pcomp = r(p); 
test _IposXG4any_1 =  _IposXG4anya1 =  _IposXG4anyb1; loc p_npcomp = r(p); 
test _IposXG6any_1 =  _IposXG6anya1 =  _IposXG6anyb1; loc p_fpcomp = r(p); 

* NUMBER OF BORROWERS/DEFAULTERS | SANCTIONED;
forv i = 2(2)6 {;

	sum `v'_2 if t == -1 & sanc ==1 & group == `i'; loc m_sanc`i' = r(mean); 
	
};

** NUMBER OF BORROWERS/DEFAULTERS, UNSANCTIONED COMPETITOR | SANCTIONED SCHOOL IN SECTOR IN MARKET;	
* SECTOR SANCTIONED;
forv i = 2(2)6 {;

* SECTOR OF COMPETITOR; 
forv j = 2(2)6 {;

	sum `v'_2 if t == -1  & anysanc_num`i'_fips >0 & group == `j'; loc m`j'_`i' = r(mean);
	sum number_unsanc_fips`j' if t == -1 & anysanc_num`i'_fips >0 ; loc n`j'_`i' = r(mean);
	
};

};

nlcom ((exp( _b[_IposXG2san_1] )-1)*`m_sanc2') + ((exp(_b[_IposXG2any_1])-1)*`m2_2'*`n2_2')+  ((exp(_b[_IposXG4any_1])-1)*`m4_2'*`n4_2')+ ((exp(_b[_IposXG6any_1])-1)*`m6_2'*`n6_2');
loc mkt_p_est =  el(r(b),1,1); loc mkt_p_se = (el(r(V),1,1))^.5; 
	
nlcom ((exp( _b[_IposXG4san_1] )-1)*`m_sanc4')+ ((exp(_b[_IposXG2anya1])-1)*`m2_4'*`n2_4')+  ((exp(_b[_IposXG4anya1])-1)*`m4_4'*`n4_4')+ ((exp(_b[_IposXG6anya1])-1)*`m6_4'*`n6_4');
loc mkt_np_est =  el(r(b),1,1); loc mkt_np_se = (el(r(V),1,1))^.5; 

nlcom ((exp( _b[_IposXG6san_1] )-1)*`m_sanc6')+ ((exp(_b[_IposXG2anyb1])-1)*`m2_6'*`n2_6')+  ((exp(_b[_IposXG4anyb1])-1)*`m4_6'*`n4_6')+ ((exp(_b[_IposXG6anyb1])-1)*`m6_6'*`n6_6'); 
loc mkt_fp_est =  el(r(b),1,1); loc mkt_fp_se = (el(r(V),1,1))^.5; 
};

outreg2 using "${output}/T6C16_`v'.txt", keep(_I*) replace dec(3) sym(**,*,+) se aster(se) 
	addstat("pval - sanc", `p_sanc', "pval - comp spub",`p_comp2',"pval - comp snp",`p_comp4',"pval - comp sfp",`p_comp6',
	"pval - public comp", `p_pcomp',"pval - np comp", `p_npcomp', "pval - fp comp", `p_fpcomp',
	"mean - sp", `m_sanc2', "mean - snp", `m_sanc4', "mean - sfp", `m_sanc6', 
	"mean - pc_sp",`m2_2', "mean - npc_sp",`m4_2', "mean - fpc_sp",`m6_2',
	"n - pc_sp",`n2_2', "n - npc_sp",`n4_2', "n - fpc_sp",`n6_2',
	"mean - pc_snp",`m2_4', "mean - npc_snp",`m4_4', "mean - fpc_snp",`m6_4',
	"n - pc_snp",`n2_4', "n - npc_snp",`n4_4', "n - fpc_snp",`n6_4',
	"mean - pc_sfp",`m2_6', "mean - npc_sfp",`m4_6', "mean - fpc_sfp",`m6_6',
	"n - pc_sfp",`n2_6', "n - npc_sfp",`n4_6', "n - fpc_sfp",`n6_6',
	"mkt - sp est",`mkt_p_est', "mkt - sp se",`mkt_p_se', 
	"mkt - snp est",`mkt_np_est', "mkt - snp se",`mkt_np_se', 
	"mkt - sfp est",`mkt_fp_est', "mkt - sfp se",`mkt_fp_se');

	
	
* EVENT STUDY COEFFICIENTS FOR F7;
char t[omit] -1;

foreach v of var lnnbr lnnbd {;

xi: reghdfe `v'  i.t|G2sanc i.t|G4sanc i.t|G6sanc 
	i.t|anysanc_rs2_fips i.t|anysanc_rs4_fips   i.t|G24anysanc_rs6_fips   i.t|G6anysanc_rs6_fips   
	if abs(t)<=8, a(syid t year group##c.t fips##c.t) cl(opeid);

	outreg2 _ItXG* _ItXany* using "${output}/F7_event_study_coeffs_`v'.txt", st(coef) noaster replace; 
	outreg2 _ItXG* _ItXany* using "${output}/F7_event_study_coeffs_`v'.txt", st(ci_low) noaster ap; 
	outreg2 _ItXG* _ItXany* using "${output}/F7_event_study_coeffs_`v'.txt", st(ci_high) noaster ap;

* CLOSE LOOP OVER DEPVARS;
};

foreach v in nbr nbd {;

	insheet using "${output}/F7_event_study_coeffs_ln`v'.txt", clear;
	for any 2 3 4 \ any coef_`v' cil_`v' cih_`v' : rename vX Y;
	drop v1; 
		
	gen own_fp = _n >=30 & _n<=38;
	gen other_comp_fp = _n >=66 & _n<=74;
	gen fp_comp_fp = _n >=78 & _n<=86;
		
	egen keep = rowmax(own_* *comp_* ); 
	drop if keep ==0;	drop keep;
		
	gen t = .; 
	foreach n of num 1 10 19 {; replace t = 0 if _n == `n'; };
	foreach n of num 2 11 20 {; replace t = 1 if _n == `n'; };
	foreach n of num 3 12 21 {; replace t = 2 if _n == `n'; };
	foreach n of num 4 13 22 {; replace t = 3 if _n == `n'; };
	foreach n of num 5 14 23 {; replace t = 4 if _n == `n'; };
	foreach n of num 6 15 24 {; replace t = 5 if _n == `n'; };
	foreach n of num 7 16 25 {; replace t = 6 if _n == `n'; };
	foreach n of num 8 17 26 {; replace t = 7 if _n == `n'; };
	foreach n of num 9 18 27 {; replace t = 8 if _n == `n'; };

	foreach t of var coef cil cih {; destring `t', replace; };	

	set obs 28; 
	replace coef = 0 in 28 ; replace cil_`v' = 0 in 28; replace cih_`v' = 0 in 28; replace t = -1 in 28; 
	foreach t of var own_* *comp_* {; replace `t'= 1 in 28; };	

	save scrap_`v', replace; 
	
};

use scrap_nbr, clear;
merge 1:1 t own_fp other_comp_fp fp_comp_fp using scrap_nbd, update; 

** PANEL A: SANCTIONED FP;
tw (rline cil_nbr cih_nbr t, sort lc(green) lw(thin) lp(shortdash)) (connected coef_nbr t, sort lc(green) mc(green) ms(X) msiz(medlarge) lw(medthick))
	(rline cil_nbd cih_nbd t, sort lc(dknavy) lw(thin) lp(longdash)) (connected coef_nbd t, sort lc(dknavy) mc(dknavy) lw(medthick)) if  own_fp ==1,
			graphr(fc(white)) legend(lab(1 "" ) lab(2 "Borrowers") lab(3 "") lab(4 "Defaulters") size(small) col(4))
			xlab(-1(1)8, labs(small)) xti("Years before/after sanction") 
			ylab(-1.4(.2)0, gmin gmax labs(small)) yti("Coeff, 95% CI") yli(0);
graph export "${output}/F7A_event_study_lnnbr&lnnbd_sanc_fp_balanced.pdf", as(pdf) replace;			

** PANEL B: UNSANCTIONED FP COMPETITORS OF SANCTIONED FP;
tw (rline cil_nbr cih_nbr t, sort lc(green) lw(thin) lp(shortdash)) (connected coef_nbr t, sort lc(green) mc(green) ms(X) msiz(medlarge) lw(medthick))
	(rline cil_nbd cih_nbd t, sort lc(dknavy) lw(thin) lp(longdash)) (connected coef_nbd t, sort lc(dknavy) mc(dknavy) lw(medthick)) if  fp_comp_fp ==1,
			graphr(fc(white)) legend(lab(1 "" ) lab(2 "Borrowers") lab(3 "") lab(4 "Defaulters") size(small) col(4))
			xlab(-1(1)8, labs(small)) xti("Years before/after competitor sanction(s)") 
			ylab(0(.02).12, gmin gmax labs(small)) yti("Coeff, 95% CI") yli(0);
graph export "${output}/F7B_event_study_lnnbr&lnnbd_fpcompsancfp_balanced.pdf", as(pdf) replace;			

** PANEL C: UNSANCTIONED OTHER COMPETITORS OF SANCTIONED FP;
tw (rline cil_nbr cih_nbr t, sort lc(green) lw(thin) lp(shortdash)) (connected coef_nbr t, sort lc(green) mc(green) ms(X) msiz(medlarge) lw(medthick))
	(rline cil_nbd cih_nbd t, sort lc(dknavy) lw(thin) lp(longdash)) (connected coef_nbd t, sort lc(dknavy) mc(dknavy) lw(medthick)) if  other_comp_fp ==1,
			graphr(fc(white)) legend(lab(1 "" ) lab(2 "Borrowers") lab(3 "") lab(4 "Defaulters") size(small) col(4))
			xlab(-1(1)8, labs(small)) xti("Years before/after competitor sanction(s)") 
			ylab(0(.02).12, gmin gmax labs(small)) yti("Coeff, 95% CI") yli(0);
graph export "${output}/F7C_event_study_lnnbr&lnnbd_othercompsancfp_balanced.pdf", as(pdf) replace;			

erase scrap_nbr.dta; erase scrap_nbd.dra; 