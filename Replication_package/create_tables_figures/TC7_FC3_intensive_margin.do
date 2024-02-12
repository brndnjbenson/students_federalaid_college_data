/* CREATES OUTPUT USED IN ONLINE APPENDIX TABLE C.7: THE EFFECT OF SANCTIONS ON PELL GRANT RECIPIENT ENROLLMENT: INTENSIVE MARGIN VARIATION */
/* AND APPENDIX FIGURE C.3:  THE EFFECT OF FOR-PROFIT COLLEGE SANCTIONS ON PELL GRANT RECIPIENT ENROLLMENT: INTENSIVE MARGIN VARIATION*/

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

* DROP COUNTIES WITH MORE THAN 50 SCHOOLS (WITH PELL RECIPIENTS) PER YEAR, ON AVERAGE;
destring fips, replace; 
drop if inlist(fips,4013, 6037, 6059, 6073, 12025, 17031, 26163, 36061, 42003, 42101, 48113, 48201, 36005, 36047, 36081, 36085);

drop if abs(t)  >10; 

gen lnrecips = ln(recipients);
gen lnrecips_2 = ln(recipients + 1); 

egen syid = group(opeid sanct_year); 

* DROP SCHOOLS THAT DO NOT HAVE ANY PELL RECIPIENTS OVER WINDOW AROUND SANCTION YEAR ;
bysort syid : egen max = max(recipients ) ; drop if max == 0; drop max; 

** LIMIT TO FIRST EVENT FOR TREATED OBS;
forv i = 1/9 {;
	bysort opeid t (sanct_year): gen priorsanc`i'= sanc[_n-`i'] if opeid == opeid[_n-`i'] & t == t[_n-`i'] & sanct_year == sanct_year[_n-`i']+`i';
	recode priorsanc`i' (. = 0);
	
	bysort opeid t (sanct_year): gen priornum`i'= anysanc_num6_fips[_n-`i'] if opeid == opeid[_n-`i'] & t == t[_n-`i'] & sanct_year == sanct_year[_n-`i']+`i';
	recode priornum`i' (. = 0);
};

foreach v of var prior* {; drop if `v'>0; };


** INDICATOR FOR WHETHER ANY FP STUDENTS WERE EXPOSED TO SANCTIONS IN MARKET;
forv i = 2(2)6 {; 
	gen any_rs`i'_fips = anysanc_rs`i'_fips >0; 
	bysort fips sanct_year : egen any_`i'_sanc = max(any_rs`i'_fips );
	drop any_rs`i'_fips; 
};

foreach v of var anysanc_rs2_fips anysanc_rs4_fips  anysanc_rs6_fips  {; replace `v' = ln(`v'+1); };

** INTERACT TREATMENT WITH SECTOR INDICATORS;
foreach v of var sanc anysanc_rs2_fips anysanc_rs4_fips  anysanc_rs6_fips {;
foreach n of num 2(2)6 {;
	gen G`n'`v' = `v' if group == `n'; recode G`n'`v' (. = 0); 
};
};

gen G24anysanc_rs6_fips = anysanc_rs6_fips if inlist(group,2,4); recode G24anysanc_rs6_fips (. =0); 

gen post = t>=0; 

forv i = 2(2)6 {;
	replace number_schools_fips`i' = number_schools_fips`i'+1 if group ==`i';
	gen number_unsanc_fips`i' = number_schools_fips`i' - anysanc_num`i'_fips;
};

egen number_unsanc_fips24 = rowtotal(number_unsanc_fips2 number_unsanc_fips4); 

** APPENDIX TABLE C.7: IMPACT OF SANCTIONS ON OWN ENROLLMENT AND COMPETITOR ENROLLMENT USING ONLY INTENSIVE MARGIN VARIATION;
xi: reghdfe lnrecips_2  i.post|G2sanc i.post|G4sanc i.post|G6sanc i.post|G2anysanc_rs2_fips  i.post|G4anysanc_rs2_fips   i.post|G6anysanc_rs2_fips   i.post|G2anysanc_rs4_fips  
	i.post|G4anysanc_rs4_fips   i.post|G6anysanc_rs4_fips   i.post|G2anysanc_rs6_fips   i.post|G4anysanc_rs6_fips    i.post|G6anysanc_rs6_fips  i.post|any_2_sanc  i.post|any_4_sanc   i.post|any_6_sanc   
	if abs(t)<=8, a(syid t year group##c.t fips##c.t) cl(opeid);

test _IposXG2san_1 =  _IposXG4san_1 =  _IposXG6san_1; loc p_sanc = r(p); 
test  _IposXG2any_1 =  _IposXG4any_1 =  _IposXG6any_1; loc p_comp2 = r(p);
test  _IposXG2anya1 =  _IposXG4anya1 =  _IposXG6anya1; loc p_comp4 = r(p);
test  _IposXG2anyb1 =  _IposXG4anyb1 =  _IposXG6anyb1; loc p_comp6 = r(p);
test  _IposXG2any_1 =  _IposXG2anya1 =  _IposXG2anyb1; loc p_pcomp = r(p); 
test _IposXG4any_1 =  _IposXG4anya1 =  _IposXG4anyb1; loc p_npcomp = r(p); 
test _IposXG6any_1 =  _IposXG6anya1 =  _IposXG6anyb1; loc p_fpcomp = r(p); 

* NUMBER OF RECIPIENTS | SANCTIONED;
forv i = 2(2)6 {;

	sum recipients if t == -1 & sanc ==1 & group == `i'; loc m_sanc`i' = r(mean); 
	
};

** NUMBER OF RECIPIENTS, UNSANCTIONED COMPETITOR | SANCTIONED SCHOOL IN SECTOR IN MARKET;	
* SECTOR SANCTIONED;
forv i = 2(2)6 {;

* SECTOR OF COMPETITOR; 
forv j = 2(2)6 {;

	sum recipients  if t == -1  & anysanc_num`i'_fips >0 & group == `j'; loc m`j'_`i' = r(mean);
	sum number_unsanc_fips`j' if t == -1 & anysanc_num`i'_fips >0 ; loc n`j'_`i' = r(mean);
	
};

};

nlcom ((exp( _b[_IposXG2san_1] )-1)*`m_sanc2') + ((exp(_b[_IposXG2any_1])-1)*`m2_2'*`n2_2')+  ((exp(_b[_IposXG4any_1])-1)*`m4_2'*`n4_2')+ ((exp(_b[_IposXG6any_1])-1)*`m6_2'*`n6_2');
loc mkt_p_est =  el(r(b),1,1); loc mkt_p_se = (el(r(V),1,1))^.5; 
	
nlcom ((exp( _b[_IposXG4san_1] )-1)*`m_sanc4')+ ((exp(_b[_IposXG2anya1])-1)*`m2_4'*`n2_4')+  ((exp(_b[_IposXG4anya1])-1)*`m4_4'*`n4_4')+ ((exp(_b[_IposXG6anya1])-1)*`m6_4'*`n6_4');
loc mkt_np_est =  el(r(b),1,1); loc mkt_np_se = (el(r(V),1,1))^.5; 

nlcom ((exp( _b[_IposXG6san_1] )-1)*`m_sanc6')+ ((exp(_b[_IposXG2anyb1])-1)*`m2_6'*`n2_6')+  ((exp(_b[_IposXG4anyb1])-1)*`m4_6'*`n4_6')+ ((exp(_b[_IposXG6anyb1])-1)*`m6_6'*`n6_6'); 
loc mkt_fp_est =  el(r(b),1,1); loc mkt_fp_se = (el(r(V),1,1))^.5; 

outreg2 using "${output}/TC7_rob_intensivemarginonly.txt", keep(_I*) replace dec(3) sym(**,*,+) se aster(se) 
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



** APPENDIX FIGURE C.3: EVENT STUDY GRAPHS FOR IMPACT OF SANCTIONS WITH INTENSIVE MARGIN VARIATION ONLY;	
char t[omit] -1; 

xi: reghdfe lnrecips_2 i.t|G2sanc i.t|G4sanc i.t|G6sanc 
	i.t|anysanc_rs2_fips i.t|anysanc_rs4_fips   
	i.t|G24anysanc_rs6_fips i.t|G6anysanc_rs6_fips i.t|any_2_sanc i.t|any_4_sanc i.t|any_6_sanc, a(syid t year fips##c.t group##c.t ) cl(opeid);

outreg2 _ItXG* _ItXany* using "${output}/FC3_event_study_intensive.txt", st(coef) noaster replace; 
outreg2 _ItXG* _ItXany* using "${output}/FC3_event_study_intensive.txt", st(ci_low) noaster ap; 
outreg2 _ItXG* _ItXany* using "${output}/FC3_event_study_intensive.txt", st(ci_high) noaster ap;


preserve;

	insheet using "${output}/FC3_event_study_intensive.txt", clear;
	for any 2 3 4 \ any coef cil cih : rename vX Y;
	drop v1; 
	
	gen own_pub = _n >=8 & _n<=23; 
	gen own_np = _n >=29 & _n<=44;
	gen own_fp = _n >=50 & _n<=65;
	gen comp_pub = _n >=71 & _n<=86;
	gen comp_np = _n >=92 & _n<=107;
	gen other_comp_fp = _n >=113 & _n<=128;
	gen fp_comp_fp = _n >=133 & _n<=148;
	
	egen keep = rowmax(own_* *comp_* ); 
	drop if keep ==0;	drop keep;
	
	gen t = .; 
	foreach n of num 1 17 33 49 65 81 97 {; replace t = -8 if _n == `n'; };
	foreach n of num 2 18 34 50 66 82 98 {; replace t = -7 if _n == `n'; };
	foreach n of num 3 19 35 51 67 83 99 {; replace t = -6 if _n == `n'; };
	foreach n of num 4 20 36 52 68 84 100 {; replace t = -5 if _n == `n'; };
	foreach n of num 5 21 37 53 69 85 101 {; replace t = -4 if _n == `n'; };
	foreach n of num 6 22 38 54 70 86 102 {; replace t = -3 if _n == `n'; };
	foreach n of num 7 23 39 55 71 87 103 {; replace t = -2 if _n == `n'; };
	foreach n of num 8 24 40 56 72 88 104 {; replace t = 0 if _n == `n'; };
	foreach n of num 9 25 41 57 73 89 105 {; replace t = 1 if _n == `n'; };
	foreach n of num 10 26 42 58 74 90 106 {; replace t = 2 if _n == `n'; };
	foreach n of num 11 27 43 59 75 91 107 {; replace t = 3 if _n == `n'; };
	foreach n of num 12 28 44 60 76 92 108 {; replace t = 4 if _n == `n'; };
	foreach n of num 13 29 45 61 77 93 109 {; replace t = 5 if _n == `n'; };
	foreach n of num 14 30 46 62 78 94 110 {; replace t = 6 if _n == `n'; };
	foreach n of num 15 31 47 63 79 95 111 {; replace t = 7 if _n == `n'; };
	foreach n of num 16 32 48 64 80 96 112 {; replace t = 8 if _n == `n'; };
		
	foreach v of var coef cil cih {; destring `v', replace; };	

	set obs 113; 
	replace coef = 0 in 113; replace cil = 0 in 113; replace cih = 0 in 113; replace t = -1 in 113; 
	foreach v of var own_* *comp_* {; replace `v' = 1 in 113; };	

** SANCTIONED FP;
* F5A: OWN ENROLLMENT; 
	tw (rline cil cih t, sort lp(longdash) lw(thin) lc(dknavy) ) (connected coef t, sort lc(navy) mc(navy)) if  own_fp ==1,
			graphr(fc(white)) legend(off)
			xlab(-8(1)8, labs(small)) xti("Years before/after sanction") 
			ylab(-3(1)1, gmin gmax labs(small)) yti("Point estimate, 95% CI") yli(0);
	graph save "${output}/FC3_event_study_ln_sanctionedfp_intensive ",   replace;			

* F5C: FP COMPETITOR ENROLLMENT; 
	tw (rline cil cih t, sort lp(longdash) lw(thin) lc(dknavy) ) (connected coef t, sort lc(navy) mc(navy)) if  fp_comp_fp==1,
			graphr(fc(white)) legend(off)
			xlab(-8(1)8, labs(small)) xti("Years before/after competitor sanction(s)") 
			ylab(-0.08(0.02)0.08, gmin gmax labs(small)) yti("Point estimate, 95% CI") yli(0);
	graph save "${output}/FC3_event_study_lnln_fpcomp_intensive ",   replace;			
	
* F5D: OTHER COMPETITOR ENROLLMENT; 
	tw (rline cil cih t, sort lp(longdash) lw(thin) lc(dknavy) ) (connected coef t, sort lc(navy) mc(navy)) if  other_comp_fp==1,
			graphr(fc(white)) legend(off)
			xlab(-8(1)8, labs(small)) xti("Years before/after competitor sanction(s)") 
			ylab(-0.08(0.05)0.2, gmin gmax labs(small)) yti("Point estimate, 95% CI") yli(0);	
	graph save "${output}/FC3_event_study_lnln_othercomp_intensive ",   replace;			

restore;