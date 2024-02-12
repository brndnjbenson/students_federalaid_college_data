/* CREATES OUTPUT USED IN TABLE 4: THE EFFECT OF SANCTIONS ON PELL GRANT RECIPIENT ENROLLMENT: HETEROGENEITY BY CHAIN STATUS */
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

* DROP SCHOOLS THAT DO NOT HAVE ANY PELL RECIPIENTS OVER WINDOW AROUND SANCTION YEAR;
bysort syid : egen max = max(recipients ) ; drop if max == 0; drop max; 

** LIMIT TO FIRST EVENT FOR TREATED OBS;
forv i = 1/9 {;
	bysort opeid t (sanct_year): gen priorsanc`i'= sanc[_n-`i'] if opeid == opeid[_n-`i'] & t == t[_n-`i'] & sanct_year == sanct_year[_n-`i']+`i';
	recode priorsanc`i' (. = 0);
	
	bysort opeid t (sanct_year): gen priornum`i'= anysanc_num_fips[_n-`i'] if opeid == opeid[_n-`i'] & t == t[_n-`i'] & sanct_year == sanct_year[_n-`i']+`i';
	recode priornum`i' (. = 0);
};

foreach v of var prior* {; drop if `v'>0; };

* NUMBER OF UNSANCTIONED SAME CHAIN LOCATIONS IN COUNTY;
gen count = 1; replace count = 0 if sanc ==1;
qui sum chain_id;

forv i = 1/`r(max)' {;
	gen dum = count if chain_id == `i';
	recode dum (. = 0);

	bysort fips sanct_year t: egen dum2 = sum(dum) if chain_id == `i';

if `i' == 1 {; gen num_schain = dum2 if chain_id == `i'; };
if `i' >1 {; replace num_schain = dum2 if chain_id == `i';};
	drop dum dum2;
};


gen post = t>=0; 


forv i = 2(2)6 {;
	replace number_schools_fips`i' = number_schools_fips`i'+1 if group ==`i';
	gen number_unsanc_fips`i' = number_schools_fips`i' - anysanc_num`i'_fips;
};

replace number_unsanc_fips6 = number_unsanc_fips6 - anysanc_num_schain ;
gen number_unsanc_fips6_schain = num_schain - anysanc_num_schain ;  recode number_unsanc_fips6_schain (. = 0); 

replace anysanc_rs6_fips = anysanc_rs6_fips - anysanc_rs_schain if group ==6; 

foreach v of var anysanc_rs2_fips anysanc_rs4_fips  anysanc_rs6_fips anysanc_rs_schain  {; replace `v' = ln(`v'+1); };

* INTERACT TREATMENTXPOST WITH SECTOR INDICATORS;
foreach v of var sanc anysanc_rs2_fips anysanc_rs4_fips  anysanc_rs6_fips anysanc_rsinchain6_fips  {;
foreach n of num 2(2)6 {;
	gen G`n'`v' = `v' if group == `n'; recode G`n'`v' (. = 0); 
};
};

* FULLY INTERACTED MODEL;
xi: reghdfe lnrecips_2  i.post|G2sanc i.post|G4sanc i.post|G6sanc 
	i.post|G2anysanc_rs2_fips i.post|G4anysanc_rs2_fips  i.post|G6anysanc_rs2_fips  
	i.post|G2anysanc_rs4_fips  i.post|G4anysanc_rs4_fips   i.post|G6anysanc_rs4_fips   
	i.post|G2anysanc_rs6_fips    i.post|G4anysanc_rs6_fips    i.post|G6anysanc_rs6_fips   i.post|anysanc_rs_schain  if abs(t)<=8, a(syid t year group##c.t fips##c.t) cl(opeid );

* COLLECT P-VALS FROM EQ TESTS;
test _IposXG2san_1 =  _IposXG4san_1 =  _IposXG6san_1 ; loc p_sanc = r(p); 
test  _IposXG2any_1 =  _IposXG4any_1 =  _IposXG6any_1 ; loc p_comp2 = r(p);
test  _IposXG2anya1 =  _IposXG4anya1 =  _IposXG6anya1 ; loc p_comp4 = r(p);
test  _IposXG2anyb1 =  _IposXG4anyb1 =   _IposXG6anyb1  =  _IposXanysa_1 ; loc p_comp6 = r(p);

test  _IposXG2any_1 =  _IposXG2anya1 =  _IposXG2anyb1 ; loc p_pcomp = r(p); 
test _IposXG4any_1 =  _IposXG4anya1 =  _IposXG4anyb1 ; loc p_npcomp = r(p); 
test _IposXG6any_1 =  _IposXG6anya1 =  _IposXG6anyb1 = _IposXanysa_1; loc p_fpcomp = r(p); 
test _IposXG6anyb1 = _IposXanysa_1; loc p_fpcomp_chain = r(p); 

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

sum recipients if t == -1 & anysanc_num_schain==0 & anysanc_num6_fips >0 & group ==6; loc m6_6_nosame = r(mean); 
sum recipients if t == -1 & anysanc_num_schain>0 & group ==6; loc m6_6_same = r(mean); 
sum number_unsanc_fips6 if t == -1 & anysanc_num_schain==0 & anysanc_num6_fips>0; loc n6_6_nosame = r(mean) ;
sum number_unsanc_fips6 if t == -1 & anysanc_num_schain>0 ; loc n6_6_wsame = r(mean) ;
sum number_unsanc_fips6_schain if t == -1 & anysanc_num_schain>0 ; loc n6_6_same = r(mean) ;

* EFFECTS ON MARKET ENROLLMENT;
nlcom ((exp( _b[_IposXG2san_1] )-1)*`m_sanc2') + ((exp(_b[_IposXG2any_1])-1)*`m2_2'*`n2_2')+  ((exp(_b[_IposXG4any_1])-1)*`m4_2'*`n4_2')+ ((exp(_b[_IposXG6any_1])-1)*`m6_2'*`n6_2');
loc mkt_p_est =  el(r(b),1,1); loc mkt_p_se = (el(r(V),1,1))^.5; 
	
nlcom ((exp( _b[_IposXG4san_1] )-1)*`m_sanc4')+ ((exp(_b[_IposXG2anya1])-1)*`m2_4'*`n2_4')+  ((exp(_b[_IposXG4anya1])-1)*`m4_4'*`n4_4')+ ((exp(_b[_IposXG6anya1])-1)*`m6_4'*`n6_4');
loc mkt_np_est =  el(r(b),1,1); loc mkt_np_se = (el(r(V),1,1))^.5; 

nlcom ((exp( _b[_IposXG6san_1] )-1)*`m_sanc6')+ ((exp(_b[_IposXG2anyb1])-1)*`m2_6'*`n2_6')+  ((exp(_b[_IposXG4anyb1])-1)*`m4_6'*`n4_6')+ 
	((exp(_b[_IposXG6anyb1])-1)*`m6_6_nosame'*`n6_6_nosame') ;
loc mkt_fp_est_nosame =  el(r(b),1,1); loc mkt_fp_se_nosame = (el(r(V),1,1))^.5; 
	
nlcom ((exp( _b[_IposXG6san_1] )-1)*`m_sanc6')+ ((exp(_b[_IposXG2anyb1])-1)*`m2_6'*`n2_6')+  ((exp(_b[_IposXG4anyb1])-1)*`m4_6'*`n4_6')+ ((exp(_b[_IposXG6anyb1])-1)*`m6_6_same'*`n6_6_wsame') + 
	((exp(_b[_IposXanysa_1])-1)*`m6_6_same'*`n6_6_same') ;
loc mkt_fp_est_wsame =  el(r(b),1,1); loc mkt_fp_se_wsame = (el(r(V),1,1))^.5; 

macro list;


outreg2 using "${output}/T4_het_chain.txt", keep(_I*) replace dec(3) sym(**,*,+) se aster(se) 
	addstat("pval - sanc", `p_sanc', "pval - comp spub",`p_comp2',"pval - comp snp",`p_comp4',"pval - comp sfp",`p_comp6',
	"pval - public comp", `p_pcomp',"pval - np comp", `p_npcomp', "pval - fp comp", `p_fpcomp',"pval - fp nochain = fp same chain", `p_fpcomp_chain',
	"mean - sp", `m_sanc2', "mean - snp", `m_sanc4', "mean - sfp", `m_sanc6', 
	"mean - pc_sp",`m2_2', "mean - npc_sp",`m4_2', "mean - fpc_sp",`m6_2',
	"n - pc_sp",`n2_2', "n - npc_sp",`n4_2', "n - fpc_sp",`n6_2',
	"mean - pc_snp",`m2_4', "mean - npc_snp",`m4_4', "mean - fpc_snp",`m6_4',
	"n - pc_snp",`n2_4', "n - npc_snp",`n4_4', "n - fpc_snp",`n6_4',
	"mean - pc_sfp",`m2_6', "mean - npc_sfp",`m4_6', "mean - fpc_sfp",`m6_6', "mean - fpc_sfp same chain",`m6_6_same',
	"n - pc_sfp",`n2_6', "n - npc_sfp",`n4_6', "n - fpc_sfp",`n6_6', "n - fpc_sfp same chain",`n6_6_same',
	"mkt - sp est",`mkt_p_est', "mkt - sp se",`mkt_p_se', 
	"mkt - snp est",`mkt_np_est', "mkt - snp se",`mkt_np_se', 
	"mkt - sfp est - no same chain",`mkt_fp_est_nosame', "mkt - sfp se nosame",`mkt_fp_se_nosame',
	"mkt - sfp est - w same chain",`mkt_fp_est_wsame', "mkt - sfp se w same",`mkt_fp_se_wsame');
