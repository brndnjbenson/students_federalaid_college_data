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

use "${intermediate}/formatted_analysis_data", clear;

* DROP UNNECESSARY VARS;
drop address city affil zip schlc ftptt corres accstat accred acc_* fisl va offers_* founded cohort_year; 

* ONLY KEEP OBS FROM 1982-2009;
drop if year<1981 | year>2010;

* DROP SCHOOLS THAT NEVER HAVE PELL ENROLLMENT OVER SAMPLE PERIOD;
bysort opeid: egen max = max(recipients); drop if max == 0; drop max; 

* SECTOR BY LEVEL VARIABLE (ALL MISSING VALS ARE FPS, RECODE AS 2-YEAR SCHOOLS);
** NOTE: GROUP CATS ARE 1 = PUB 4, 2 = PUB 2, 3 = NP 4, 4 = NP 2, 5 = FP 4, 6 = FP 2; 
egen group = group(control level), lab; 

** "TREATMENTS" OF INTEREST - THREATENED SANCTION (LOSS LOANS), THREATENED SANCTION (LOSS LOANS + PELL); 
rename loss_loans_only sanc_ll; rename loss_loans_pell sanc_lp;

** SANCTION IMPOSED (1995 CY AND LATER) - LOSS LOANS, SANCTION IMPOSTED (1995 CY AND LATER) - LOSS LOANS + PELL; 
foreach v of var sanc_upheld* {; replace `v' = . if year<1997; };
rename sanc_upheld_ll suphld_ll; rename sanc_upheld_lp suphld_lp; 

* YEAR CLOSED;
bysort opeid: egen min = min(year_closed);
replace year_closed = min if year_closed == . & min ~=.; 

* OPTION TO KEEP 4-YEAR SCHOOLS (COMMENT OUT FOR MAIN SAMPLE);
*recode group (1 = 2) (3 = 4) (5 = 6); 

keep if inlist(group,2,4,6); 

* COUNT OF TOTAL NUMBER OF (2-YEAR) SCHOOLS IN COUNTY;
gen dum = 1; replace dum = 0 if year>=year_closed; bysort fips year: egen number_schools_fips = total(dum); drop dum; 

* COMBINE INDUSTRY CLASSES - "tech" IS NOW THE CATCH-ALL FOR UNCLASSIFIED;
egen dum = rowtotal(tech - mech_eng); gen dum2 = 1-dum if group ==6;
recode tech (0 = 1) if dum2 == 1 & group ==6; drop dum dum2;

* UNCATEGORIZED FPS ASSIGNED TO "TECH" CATEGORY (THESE ARE SCHOOLS NOT PRESENT OR W/OUT INFO ON NAME PRE-1990);
recode tech (. = 1) if group ==6; 

* ENROLLMENT IN T-1; 
bysort opeid (year): gen recipients_l1 = recipients[_n-1] if opeid == opeid[_n-1] & year == year[_n-1]+1; 

* INDICATORS FOR ANY SANCTION THREATENED, ANY UPHELD (1997+);
egen anysanc = rowmax ( sanc_ll sanc_lp ); egen anysuphld = rowmax(suphld_ll suphld_lp ); 

* INDICATOR FOR WHETHER A SCHOOL IS CLOSED;
gen closed = year>=year_closed;

* ANY COMPETITOR THREATENED WITH SANCTION/RECEIVED SANCTION (1997+ ONLY);
foreach v of var sanc_ll sanc_lp suphld_ll suphld_lp {;
	bysort fips year: egen `v'_fips = max(`v'); 
	replace `v'_fips = 0 if `v'==1;
}; 

* NUMBER OF COMPETITORS THREATENED WITH SANCTION/RECEIVED SANCTION (1997+ ONLY);
foreach v of var anysanc anysuphld sanc_ll sanc_lp suphld_ll suphld_lp {;
	bysort fips year: egen `v'_num_fips = sum(`v'); 
	replace `v'_num_fips = 0 if `v'==1;
}; 

* ENROLLMENT WEIGHTED NUMBER OF COMPETITORS THREATENED WITH SANCTIONS;	
gen anysanc_rs = anysanc*recipients_l1; 
bysort fips year: egen anysanc_rs_fips = sum(anysanc_rs); 
replace anysanc_rs_fips = 0 if anysanc_rs >0 & anysanc_rs <.;

* SEPARATELY FOR EACH TYPE OF SANCTION; 
foreach t in ll lp {;
	gen anysanc_rs`t' = sanc_`t'*recipients_l1;
	bysort fips year: egen anysanc_rs`t'_fips = sum(anysanc_rs`t'); 
	replace anysanc_rs`t'_fips = 0 if anysanc_rs`t' >0 & anysanc_rs`t' <.;
};

* NUMBER OF COMPETITORS IN EACH SECTOR THREATENED WITH SANCTION/RECEIVED SANCTION (1997+ ONLY);
foreach n of num 2 4 6 {;

foreach v of var anysanc anysuphld sanc_ll sanc_lp suphld_ll suphld_lp {;
	
	gen dum = `v' if group == `n'; recode dum (. = 0); 
	bysort fips year: egen `v'_num`n'_fips = sum(dum); 
	replace `v'_num`n'_fips = 0 if `v' == 1;
	drop dum; 
}; 

};

* ENROLLMENT WEIGHTED NUMBER OF COMPETITORS IN EACH SECTOR THREATENED WITH SANCTIONS; 
foreach n of num 2 4 6 {;

foreach v of var anysanc_rs anysanc_rsll  anysanc_rslp {;

	gen dum = `v' if group == `n'; recode dum (. = 0); 
	bysort fips year: egen `v'`n'_fips = sum(dum); 
	replace `v'`n'_fips = 0 if `v' >0 & `v' <. ;
	drop dum; 
}; 

};

* NUMBER OF FP COMPETITORS THREATENED WITH SANCTION BY INDUSTRY;
foreach t in tech health beauty comp_bus cul_art mech_eng {;

	gen dum = anysanc if `t' == 1 & group ==6; recode dum (. = 0); 
	bysort fips year: egen anysanc_num`t'_fips = sum(dum); 
	replace anysanc_num`t'_fips = 0 if anysanc == 1;
	drop dum; 
	
};

* ENROLLMENT WEIGHTED NUMBER OF FP COMPETITORS THREATENED WITH SANCTIONS BY INDUSTRY; 
foreach t in tech health beauty comp_bus cul_art mech_eng {;

	gen dum = anysanc_rs if `t' == 1 & group == 6; recode dum (. = 0); 
	bysort fips year: egen anysanc_rs`t'_fips = sum(dum); 
	replace anysanc_rs`t'_fips = 0 if anysanc_rs >0 & anysanc_rs <. ;
	drop dum; 

}; 

* ENROLLMENT WEIGHTED NUMBER OF FP COMPETITORS THREATENED BY CHAIN STATUS; 
gen dum = anysanc_rs if group == 6 & chain_id == .; recode dum (. = 0); 
bysort fips year: egen anysanc_rsnochain6_fips = sum(dum); 
replace anysanc_rsnochain6_fips = 0 if anysanc_rs >0 & anysanc_rs <. ;
drop dum; 

gen dum = anysanc_rs if group == 6 & chain_id ~= .; recode dum (. = 0); 
bysort fips year: egen anysanc_rsinchain6_fips = sum(dum); 
replace anysanc_rsinchain6_fips = 0 if anysanc_rs >0 & anysanc_rs <. ;
drop dum; 

* NUMBER OF FP COMPETITORS THREATENED WITH SANCTION IN SAME CHAIN IN SAME COUNTY;
qui sum chain_id; 
forv i = 1/`r(max)' {;
	
	gen dum = anysanc if chain_id == `i'; recode dum (. = 0); 
	bysort fips year: egen dum2 = sum(dum) if chain_id == `i';  
	if `i' == 1 {; gen anysanc_num_schain = dum2 if chain_id == `i'; };
	if `i' >1 {; replace anysanc_num_schain = dum2 if chain_id ==`i' ; };
	replace anysanc_num_schain = 0 if anysanc == 1; 
	drop dum dum2;
	
	gen dum = anysanc_rs if chain_id == `i'; recode dum (. = 0); 
	bysort fips year: egen dum2 = sum(dum) if chain_id == `i';  
	if `i' == 1 {; gen anysanc_rs_schain = dum2 if chain_id == `i'; };
	if `i' >1 {; replace anysanc_rs_schain = dum2 if chain_id ==`i' ; };
	replace anysanc_rs_schain = 0 if anysanc == 1; 
	drop dum dum2;
	
};

recode anysanc_num_schain (. = 0); 
recode anysanc_rs_schain (. = 0); 

* ONLY KEEP VARIABLES OF INTEREST (FOR NOW);
keep year opeid recipients totaldisbursed group closed sanc_* suphld_* anysanc* anysuphld* anysanc_rs* year_closed drate0 fips 
	number_schools chain_id chain_cat* tech - mech_eng anysanc_num_schain anysanc_rs_schain  anysanc_rsinchain6_fips anysanc_rsnochain6_fips nbr nbd;

* SAVE NONSTACKED DATA FOR HAZARD ANALYSIS;
compress;

** OPTION TO KEEP 4-YEAR SCHOOLS (COMMENT OUT FOR MAIN SAMPLE);
*save "${intermediate}/unstacked_data_allinsts_rev", replace; 
save "${intermediate}/unstacked_data_2yearinsts_rev", replace; 

** OPTION TO KEEP 4-YEAR SCHOOLS (COMMENT OUT FOR MAIN SAMPLE);
*use "${intermediate}/unstacked_data_allinsts_rev", replace; 
use "${intermediate}/unstacked_data_2yearinsts_rev", clear; 

* LOOP THROUGH SANCTION YEARS, SAVE EACH PANEL AS SEPARATE FILE;
forv y = 1991/2000 {;

preserve;

	gen sanct_year = `y'; 
	gen t = year-sanct_year;
	drop if abs(t)>12; 
	save scrap`y', replace;
	
restore;

* CLOSE LOOP OVER SANCTION-YEARS;
};

use scrap1991,clear; 

forv y = 1992/2000 {; append using scrap`y'; erase scrap`y'.dta; };

erase scrap1991.dta;

* ANY TREATMENT ASSOCIATED WITH SPECIFIC SANCTION YEAR;
foreach v of var sanc_* suphld_* anysanc* anysuphld* anysanc_rs* {; 
	replace `v' = 0 if t ~=0; 
	bysort opeid sanct_year: egen dum = max(`v'); drop `v'; rename dum `v';
};

* TOTAL NUMBER OF COMPETITORS SCHOOL IN EACH SECTOR IN T-1;
gen num = 1; 

foreach g of num 2(2)6 {;
	bysort fips sanct_year: egen dum = total(num) if t == -1 & group == `g';
	bysort fips sanct_year: egen number_schools_fips`g' = min(dum); 
	drop dum;
	replace number_schools_fips`g' = number_schools_fips`g' - 1 if group == `g'; 
	recode number_schools_fips`g' (. =0); 
};

drop num number_schools_fips;
egen number_schools_fips = rowtotal(number_schools_fips*);  

* COMBINE SANCTION TYPES;
rename anysanc sanc; 
egen sanc_fips = rowmax(sanc_ll_fips sanc_lp_fips); 

foreach v of var sanc_fips anysanc_rs* {; replace `v' = 0 if sanc == 1; };


compress;

save "${intermediate}/stacked_data_2yearinsts_rev", replace; 

** OPTION TO KEEP 4-YEAR SCHOOLS (COMMENT OUT FOR MAIN SAMPLE);
* save "${intermediate}/stacked_data_allinsts_rev", replace;
