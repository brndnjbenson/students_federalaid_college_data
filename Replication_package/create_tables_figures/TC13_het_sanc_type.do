/* CREATES OUTPUT USED IN ONLINE APPENDIX TABLE C13: ROBUSTNESS OF THE IMPACT OF SANCTIONS ON PELL GRANT RECIPIENT ENROLLMENT: HETEROGENEITY BY TYPE OF SANCTION  */


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
	
	bysort opeid t (sanct_year): gen priornum`i'= anysanc_num6_fips[_n-`i'] if opeid == opeid[_n-`i'] & t == t[_n-`i'] & sanct_year == sanct_year[_n-`i']+`i';
	recode priornum`i' (. = 0);
};

foreach v of var prior* {; drop if `v'>0; };

foreach v of var anysanc_rsl*2_fips anysanc_rsl*4_fips  anysanc_rsl*6_fips  {; replace `v' = ln(`v'+1); };

* INTERACT TREATMENTXPOST WITH SECTOR INDICATORS;
foreach v of var sanc_ll sanc_lp anysanc_rsl*2_fips anysanc_rsl*4_fips  anysanc_rsl*6_fips {;
foreach n of num 2(2)6 {;
	gen G`n'`v' = `v' if group == `n'; recode G`n'`v' (. = 0); 
};
};

gen post = t>=0; 

forv i = 2(2)6 {;
	replace number_schools_fips`i' = number_schools_fips`i'+1 if group ==`i';
	gen number_unsancll_fips`i' = number_schools_fips`i' - sanc_ll_num`i'_fips;
	gen number_unsanclp_fips`i' = number_schools_fips`i' - sanc_lp_num`i'_fips;
};

xi: reghdfe lnrecips_2  i.post|G2sanc_ll i.post|G4sanc_ll i.post|G6sanc_ll i.post|G2sanc_lp i.post|G4sanc_lp i.post|G6sanc_lp 
	i.post|G2anysanc_rsll2_fips i.post|G4anysanc_rsll2_fips  i.post|G6anysanc_rsll2_fips  
	i.post|G2anysanc_rsll4_fips  i.post|G4anysanc_rsll4_fips   i.post|G6anysanc_rsll4_fips   
	i.post|G2anysanc_rsll6_fips   i.post|G4anysanc_rsll6_fips   i.post|G6anysanc_rsll6_fips  
	i.post|G2anysanc_rslp2_fips i.post|G4anysanc_rslp2_fips  i.post|G6anysanc_rslp2_fips  
	i.post|G2anysanc_rslp4_fips  i.post|G4anysanc_rslp4_fips   i.post|G6anysanc_rslp4_fips   
	i.post|G2anysanc_rslp6_fips   i.post|G4anysanc_rslp6_fips   i.post|G6anysanc_rslp6_fips  if abs(t)<=8	
	, a(syid t year group##c.t  fips##c.t) cl(opeid );


* TEST EQ OF MAIN EFFECTS - SEPARATE BY SANCTION TYPE;
test  _IposXG2san_1  =  _IposXG4san_1 =  _IposXG6san_1; loc p_sanc_ll = r(p); 
test  _IposXG2sana1  =  _IposXG4sana1 =  _IposXG6sana1; loc p_sanc_lp = r(p); 

* TEST EQ OF SPILLOVERS - COMPETITORS OF SANCTIONED SCHOOLS, LOSS LOANS ONLY;
test _IposXG2any_1  = _IposXG4any_1 = _IposXG6any_1; loc p_pcomp_ll = r(p); 
test _IposXG2anya1  = _IposXG4anya1 = _IposXG6anya1; loc p_npcomp_ll = r(p);
test _IposXG2anyb1  = _IposXG4anyb1 = _IposXG6anyb1; loc p_fpcomp_ll = r(p);

* TEST EQ OF SPILLOVERS - COMPETITORS OF SANCTIONED SCHOOLS, LOSS LOANS ONLY;
test _IposXG2anyc1  = _IposXG4anyc1 = _IposXG6anyc1; loc p_pcomp_lp  = r(p);
test _IposXG2anyd1  = _IposXG4anyd1 = _IposXG6anyd1; loc p_npcomp_lp = r(p); 
test _IposXG2anye1  = _IposXG4anye1 = _IposXG6anye1; loc p_fpcomp_lp = r(p); 

* TEST EQ OF SPILLOVERS - PUBLIC COMPETITORS OF SANCTIONED SCHOOLS, LOSS LOANS ONLY;
test _IposXG2any_1  = _IposXG2anya1 = _IposXG2anyb1; loc p_comp2_ll = r(p); 
* TEST EQ OF SPILLOVERS - NP COMPETITORS OF SANCTIONED SCHOOLS, LOSS LOANS ONLY;
test _IposXG4any_1  = _IposXG4anya1 = _IposXG4anyb1; loc p_comp4_ll = r(p); 
* TEST EQ OF SPILLOVERS - FP COMPETITORS OF SANCTIONED SCHOOLS, LOSS LOANS ONLY;
test _IposXG6any_1  = _IposXG6anya1 = _IposXG6anyb1; loc p_comp6_ll = r(p); 
* TEST EQ OF SPILLOVERS - PUBLIC COMPETITORS OF SANCTIONED SCHOOLS, LOSS T4 ;
test _IposXG2anyc1  = _IposXG2anyd1 = _IposXG2anye1; loc p_comp2_lp = r(p); 
* TEST EQ OF SPILLOVERS - NP COMPETITORS OF SANCTIONED SCHOOLS, LOSS T4;
test _IposXG4anyc1  = _IposXG4anyd1 = _IposXG4anye1; loc p_comp4_lp = r(p); 
* TEST EQ OF SPILLOVERS - FP COMPETITORS OF SANCTIONED SCHOOLS, LOSS T4;
test _IposXG6anyc1  = _IposXG6anyd1 = _IposXG6anye1; loc p_comp6_lp = r(p); 


* TEST EQ OF MAIN EFFECTS BY SANCTION TYPE; 
test  _IposXG2sana1  = _IposXG2san_1; 
test  _IposXG4sana1  = _IposXG4san_1; 
test  _IposXG6sana1  = _IposXG6san_1; 

* TEST EQ OF SPILLOVERS BY SANCTION TYPE; 
test _IposXG2any_1  = _IposXG2anyc1;
test _IposXG4any_1  = _IposXG4anyc1;
test _IposXG6any_1  = _IposXG6anyc1;
test _IposXG2anya1 = _IposXG2anyd1;
test _IposXG4anya1 = _IposXG4anyd1;
test _IposXG6anya1 = _IposXG6anyd1;
test _IposXG2anyb1 = _IposXG2anye1;
test _IposXG4anyb1 = _IposXG4anye1;
test _IposXG6anyb1 = _IposXG6anye1;
	

* NUMBER OF RECIPIENTS | SANCTIONED;
forv i = 2(2)6 {;

* TYPE OF SANCTION;
foreach t in ll lp {;

	sum recipients if t == -1 & sanc_`t' ==1 & group == `i'; loc m_sanc`i'_`t' = r(mean); 
	
};

};

** NUMBER OF RECIPIENTS, UNSANCTIONED COMPETITOR | SANCTIONED SCHOOL IN SECTOR IN MARKET;	
* SECTOR SANCTIONED;
forv i = 2(2)6 {;

* SECTOR OF COMPETITOR; 
forv j = 2(2)6 {;

* TYPE OF SANCTION;
foreach t in ll lp {;

	sum recipients  if t == -1  & sanc_`t'_num`i'_fips >0 & group == `j'; loc m`j'_`i'_`t' = r(mean);
	sum number_unsanc`t'_fips`j' if t == -1 & sanc_`t'_num`i'_fips >0 ; loc n`j'_`i'_`t' = r(mean);
	
};

};

};

** MARKET-WIDE EFFECTS BY SANCTION TYPE; 
* SANCTION TYPE = LOSS LOANS ONLY;
nlcom ((exp( _b[_IposXG2san_1] )-1)*`m_sanc2_ll') + ((exp(_b[_IposXG2any_1])-1)*`m2_2_ll'*`n2_2_ll')+  ((exp(_b[_IposXG4any_1])-1)*`m4_2_ll'*`n4_2_ll')+ ((exp(_b[_IposXG6any_1])-1)*`m6_2_ll'*`n6_2_ll');
loc mkt_p_ll_est =  el(r(b),1,1); loc mkt_p_ll_se = (el(r(V),1,1))^.5; 
	
nlcom ((exp( _b[_IposXG4san_1] )-1)*`m_sanc4_ll')+ ((exp(_b[_IposXG2anya1])-1)*`m2_4_ll'*`n2_4_ll')+  ((exp(_b[_IposXG4anya1])-1)*`m4_4_ll'*`n4_4_ll')+ ((exp(_b[_IposXG6anya1])-1)*`m6_4_ll'*`n6_4_ll');
loc mkt_np_ll_est =  el(r(b),1,1); loc mkt_np_ll_se = (el(r(V),1,1))^.5; 

nlcom ((exp( _b[_IposXG6san_1] )-1)*`m_sanc6_ll')+ ((exp(_b[_IposXG2anyb1])-1)*`m2_6_ll'*`n2_6_ll')+  ((exp(_b[_IposXG4anyb1])-1)*`m4_6_ll'*`n4_6_ll')+ ((exp(_b[_IposXG6anyb1])-1)*`m6_6_ll'*`n6_6_ll'); 
loc mkt_fp_ll_est =  el(r(b),1,1); loc mkt_fp_ll_se = (el(r(V),1,1))^.5; 

* SANCTION TYPE = LOSS T4;
nlcom ((exp( _b[_IposXG2san_1] )-1)*`m_sanc2_lp') + ((exp(_b[_IposXG2any_1])-1)*`m2_2_lp'*`n2_2_lp')+  ((exp(_b[_IposXG4any_1])-1)*`m4_2_lp'*`n4_2_lp')+ ((exp(_b[_IposXG6any_1])-1)*`m6_2_lp'*`n6_2_lp');
loc mkt_p_lp_est =  el(r(b),1,1); loc mkt_p_lp_se = (el(r(V),1,1))^.5; 
	
nlcom ((exp( _b[_IposXG4san_1] )-1)*`m_sanc4_lp')+ ((exp(_b[_IposXG2anya1])-1)*`m2_4_lp'*`n2_4_lp')+  ((exp(_b[_IposXG4anya1])-1)*`m4_4_lp'*`n4_4_lp')+ ((exp(_b[_IposXG6anya1])-1)*`m6_4_lp'*`n6_4_lp');
loc mkt_np_lp_est =  el(r(b),1,1); loc mkt_np_lp_se = (el(r(V),1,1))^.5; 

nlcom ((exp( _b[_IposXG6san_1] )-1)*`m_sanc6_lp')+ ((exp(_b[_IposXG2anyb1])-1)*`m2_6_lp'*`n2_6_lp')+  ((exp(_b[_IposXG4anyb1])-1)*`m4_6_lp'*`n4_6_lp')+ ((exp(_b[_IposXG6anyb1])-1)*`m6_6_lp'*`n6_6_lp'); 
loc mkt_fp_lp_est =  el(r(b),1,1); loc mkt_fp_lp_se = (el(r(V),1,1))^.5; 


outreg2 using "${output}/TC13_het_sanc_type.txt", keep(_I*) replace dec(3) sym(**,*,+) se aster(se) 
	addstat("pval - sanc", `p_sanc_ll', "pval - comp spub",`p_comp2_ll',"pval - comp snp",`p_comp4_ll',"pval - comp sfp",`p_comp6_ll',
	"pval - public comp", `p_pcomp_ll',"pval - np comp", `p_npcomp_ll', "pval - fp comp", `p_fpcomp_ll',
	"mkt - sp est",`mkt_p_ll_est', "mkt - sp se",`mkt_p_ll_se',
	"mkt - snp est",`mkt_np_ll_est', "mkt - snp se",`mkt_np_ll_se',
	"mkt - sfp est",`mkt_fp_ll_est', "mkt - sfp se",`mkt_fp_ll_se',
	"loss loans only",1);

outreg2 using "${output}/TC13_het_sanc_type", keep(_I*) ap dec(3) sym(**,*,+) se aster(se) 
	addstat("pval - sanc", `p_sanc_lp', "pval - comp spub",`p_comp2_lp',"pval - comp snp",`p_comp4_lp',"pval - comp sfp",`p_comp6_lp',
	"pval - public comp", `p_pcomp_lp',"pval - np comp", `p_npcomp_lp', "pval - fp comp", `p_fpcomp_lp',
	"mkt - sp est",`mkt_p_lp_est', "mkt - sp se",`mkt_p_lp_se', 
	"mkt - snp est",`mkt_np_lp_est', "mkt - snp se",`mkt_np_lp_se', 
	"mkt - sfp est",`mkt_fp_lp_est', "mkt - sfp se",`mkt_fp_lp_se', 
	"loss loans only",0);

