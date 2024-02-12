/* CREATES OUTPUT USED IN TABLES 2 & 3 AND ONLINE APPENDIX TABLES C5, C6, C8, C9, C14, C15 */

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

* OPTION TO USE 2 & 4-YEAR SCHOOL SAMPLE (TC9); 
*use "${intermediate}/stacked_data_allinsts_rev", clear; 

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
stop;
* OPTION TO EXCLUDE BEAUTY SCHOOLS (UNCOMMENT TO CREATE TC15); 
/*drop if beauty == 1; replace anysanc_rs6_fips = anysanc_rs6_fips - anysanc_rsbeauty_fips; */

gen post = t>=0; 

forv i = 2(2)6 {;
	replace number_schools_fips`i' = number_schools_fips`i'+1 if group ==`i';
	gen number_unsanc_fips`i' = number_schools_fips`i' - anysanc_num`i'_fips;
};


** T2, PANEL A: IMPACT OF SANCTIONS ON OWN ENROLLMENT AND COMPETITOR ENROLLMENT - LNLN;

foreach v of var anysanc_rs2_fips anysanc_rs4_fips  anysanc_rs6_fips  {; replace `v' = ln(`v'+1); };

* INTERACT TREATMENTXPOST WITH SECTOR INDICATORS;
foreach v of var sanc anysanc_rs2_fips anysanc_rs4_fips  anysanc_rs6_fips {;
foreach n of num 2(2)6 {;
	gen G`n'`v' = `v' if group == `n'; recode G`n'`v' (. = 0); 
};
};

* FULLY INTERACTED MODEL;
xi: reghdfe lnrecips_2  i.post|G2sanc i.post|G4sanc i.post|G6sanc 
	i.post|anysanc_rs2_fips i.post|anysanc_rs4_fips  i.post|anysanc_rs6_fips   if abs(t)<=8, a(syid t year group##c.t fips##c.t) cl(opeid );
	
* COLLECT P-VALS FROM EQ TESTS;
test _IposXG2san_1 =  _IposXG4san_1 =  _IposXG6san_1; loc p_sanc = r(p); 
test  _IposXanysa_1  =   _IposXanysaa1 =   _IposXanysab1; loc p_comp = r(p);

outreg2 using "${output}/T2_T3_main_results.txt", keep(_I*) replace dec(3) sym(**,*,+) se aster(se) 
	addstat("pval - sanc", `p_sanc', "pval - comp",`p_comp');


** T2, PANEL B: IMPACT OF SANCTIONS ON OWN ENROLLMENT AND COMPETITOR ENROLLMENT, FULLY INTERACTED;
xi: reghdfe lnrecips_2  i.post|G2sanc i.post|G4sanc i.post|G6sanc 
	i.post|G2anysanc_rs2_fips i.post|G4anysanc_rs2_fips  i.post|G6anysanc_rs2_fips  
	i.post|G2anysanc_rs4_fips  i.post|G4anysanc_rs4_fips   i.post|G6anysanc_rs4_fips   
	i.post|G2anysanc_rs6_fips   i.post|G4anysanc_rs6_fips   i.post|G6anysanc_rs6_fips  if abs(t)<=8, a(syid t year group##c.t fips##c.t) cl(opeid );
	
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

** OUTPUT FOR T3; 

** NUMBER OF RECIPIENTS, UNSANCTIONED COMPETITOR | SANCTIONED SCHOOL IN SECTOR IN MARKET;	
* SECTOR SANCTIONED;
forv i = 2(2)6 {;

* SECTOR OF COMPETITOR; 
forv j = 2(2)6 {;

	sum recipients  if t == -1  & anysanc_num`i'_fips >0 & group == `j'; loc m`j'_`i' = r(mean);
	sum number_unsanc_fips`j' if t == -1 & anysanc_num`i'_fips >0 ; loc n`j'_`i' = r(mean);
	
};

};

* EFFECTS ON MARKET-WIDE ENROLLMENT;
nlcom ((exp( _b[_IposXG2san_1] )-1)*`m_sanc2') + ((exp(_b[_IposXG2any_1])-1)*`m2_2'*`n2_2')+  ((exp(_b[_IposXG4any_1])-1)*`m4_2'*`n4_2')+ ((exp(_b[_IposXG6any_1])-1)*`m6_2'*`n6_2');
loc mkt_p_est =  el(r(b),1,1); loc mkt_p_se = (el(r(V),1,1))^.5; 
	
nlcom ((exp( _b[_IposXG4san_1] )-1)*`m_sanc4')+ ((exp(_b[_IposXG2anya1])-1)*`m2_4'*`n2_4')+  ((exp(_b[_IposXG4anya1])-1)*`m4_4'*`n4_4')+ ((exp(_b[_IposXG6anya1])-1)*`m6_4'*`n6_4');
loc mkt_np_est =  el(r(b),1,1); loc mkt_np_se = (el(r(V),1,1))^.5; 

nlcom ((exp( _b[_IposXG6san_1] )-1)*`m_sanc6')+ ((exp(_b[_IposXG2anyb1])-1)*`m2_6'*`n2_6')+  ((exp(_b[_IposXG4anyb1])-1)*`m4_6'*`n4_6')+ ((exp(_b[_IposXG6anyb1])-1)*`m6_6'*`n6_6'); 
loc mkt_fp_est =  el(r(b),1,1); loc mkt_fp_se = (el(r(V),1,1))^.5; 

outreg2 using "${output}/T2_T3_main_results.txt", keep(_I*) ap dec(3) sym(**,*,+) se aster(se) 
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

	/*
*** UNCOMMENT BELOW TO PRODUCE OUTPUT FOR TABLE C6: IMPACT OF SANCTIONS ON OWN ENROLLMENT AND COMPETITOR ENROLLMENT - LEVEL LEVEL;

* INTERACT TREATMENTXPOST WITH SECTOR INDICATORS;
foreach v of var anysanc_num2_fips anysanc_num4_fips  anysanc_num6_fips {;
foreach n of num 2(2)6 {;
	gen G`n'`v' = `v' if group == `n'; recode G`n'`v' (. = 0); 
};
};

** FULLY INTERACTED MODEL;
xi: reghdfe recipients  i.post|G2sanc i.post|G4sanc i.post|G6sanc 
	i.post|G2anysanc_num2_fips i.post|G4anysanc_num2_fips  i.post|G6anysanc_num2_fips  
	i.post|G2anysanc_num4_fips  i.post|G4anysanc_num4_fips   i.post|G6anysanc_num4_fips   
	i.post|G2anysanc_num6_fips   i.post|G4anysanc_num6_fips   i.post|G6anysanc_num6_fips  if abs(t)<=8, a(syid t year group##c.t fips##c.t) cl(opeid );

* COLLECT P-VALS FROM EQ TESTS;
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

	sum number_unsanc_fips`j' if t == -1 & anysanc_num`i'_fips >0 ; loc n`j'_`i' = r(mean);
	
};

};

* EFFECTS ON MARKET ENROLLMENT;
lincom _b[_IposXG2san_1] + (_b[_IposXG2any_1]*`n2_2')+  (_b[_IposXG4any_1]*`n4_2')+ (_b[_IposXG6any_1]*`n6_2');
loc mkt_p_est =  r(estimate);  loc mkt_p_se = r(se); 
	
lincom _b[_IposXG4san_1] + (_b[_IposXG2anya1]*`n2_4')+  (_b[_IposXG4anya1]*`n4_4')+ (_b[_IposXG6anya1]*`n6_4');
loc mkt_np_est =  r(estimate);  loc mkt_np_se = r(se); 

lincom _b[_IposXG6san_1] + (_b[_IposXG2anyb1]*`n2_6')+  (_b[_IposXG4anyb1]*`n4_6')+ (_b[_IposXG6anyb1]*`n6_6');
loc mkt_fp_est =  r(estimate);  loc mkt_fp_se = r(se); 

outreg2 using "${output}/TC6main_results.txt", keep(_I*) replace dec(0) sym(**,*,+) se aster(se) 
	addstat("pval - sanc", `p_sanc', "pval - comp spub",`p_comp2',"pval - comp snp",`p_comp4',"pval - comp sfp",`p_comp6',
	"pval - public comp", `p_pcomp',"pval - np comp", `p_npcomp', "pval - fp comp", `p_fpcomp',
	"mkt - sp est",`mkt_p_est', "mkt - sp se",`mkt_p_se', 
	"mkt - snp est",`mkt_np_est', "mkt - snp se",`mkt_np_se', 
	"mkt - sfp est",`mkt_fp_est', "mkt - sfp se",`mkt_fp_se');
*/
/*
*** UNCOMMENT BELOW TO PRODUCE OUTPUT FOR TABLE C14: HETEROGENEITY BY SANCTION YEAR;

* GROUP TOGETHER 1995-2000 (VERY FEW FIRST SANCTIONS IN THIS PERIOD); 
gen year_grouped = sanct_year; 
recode year_grouped (1996 1997 1998 1999 2000 = 1995); 


loc k = 0;

forv y = 1991/1995{;

loc k = `k'+1; 

preserve;

keep if year_grouped == `y'; 

* (1) IMPACT OF SANCTIONS ON OWN ENROLLMENT AND COMPETITOR ENROLLMENT;
xi: reghdfe lnrecips_2  i.post|G2sanc i.post|G4sanc i.post|G6sanc 
	i.post|G2anysanc_rs2_fips i.post|G4anysanc_rs2_fips  i.post|G6anysanc_rs2_fips  
	i.post|G2anysanc_rs4_fips  i.post|G4anysanc_rs4_fips   i.post|G6anysanc_rs4_fips   
	i.post|G2anysanc_rs6_fips   i.post|G4anysanc_rs6_fips   i.post|G6anysanc_rs6_fips  if abs(t)<=8 , a(syid t year group##c.t fips##c.t) cl(opeid );

* COLLECT P-VALS FROM EQ TESTS;
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

* EFFECTS ON MARKET ENROLLMENT;
nlcom ((exp( _b[_IposXG2san_1] )-1)*`m_sanc2') + ((exp(_b[_IposXG2any_1])-1)*`m2_2'*`n2_2')+  ((exp(_b[_IposXG4any_1])-1)*`m4_2'*`n4_2')+ ((exp(_b[_IposXG6any_1])-1)*`m6_2'*`n6_2');
loc mkt_p_est =  el(r(b),1,1); loc mkt_p_se = (el(r(V),1,1))^.5; 
	
nlcom ((exp( _b[_IposXG4san_1] )-1)*`m_sanc4')+ ((exp(_b[_IposXG2anya1])-1)*`m2_4'*`n2_4')+  ((exp(_b[_IposXG4anya1])-1)*`m4_4'*`n4_4')+ ((exp(_b[_IposXG6anya1])-1)*`m6_4'*`n6_4');
loc mkt_np_est =  el(r(b),1,1); loc mkt_np_se = (el(r(V),1,1))^.5; 

nlcom ((exp( _b[_IposXG6san_1] )-1)*`m_sanc6')+ ((exp(_b[_IposXG2anyb1])-1)*`m2_6'*`n2_6')+  ((exp(_b[_IposXG4anyb1])-1)*`m4_6'*`n4_6')+ ((exp(_b[_IposXG6anyb1])-1)*`m6_6'*`n6_6'); 
loc mkt_fp_est =  el(r(b),1,1); loc mkt_fp_se = (el(r(V),1,1))^.5; 


loc ap = "ap"; 
if `k' ==1 {; loc ap = "replace"; };

outreg2 using "${output}/TC14_het_sy.txt", keep(_I*) `ap' dec(3) sym(**,*,+) se aster(se) 
		addstat("SY",`y', "pval - sanc", `p_sanc', "pval - comp spub",`p_comp2',"pval - comp snp",`p_comp4',"pval - comp sfp",`p_comp6',
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

restore; 
* CLOSE LOOP OVER SANCTION YEARS;
};
*/