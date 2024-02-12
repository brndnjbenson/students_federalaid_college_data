/* CREATES OUTPUT USED IN ONLINE APPENDIX B FIGURES */

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

use "${intermediate}/unstacked_data_allinsts_rev", clear; 


** FB1: INSTITUTION CLOSURES BY SECTOR AND YEAR;

* CALCULATE YEARS SINCE CLOSURE;
sort opeid year;
bysort opeid : gen sum = sum(closed );

* DROP CLOSED SCHOOLS AFTER THEY CLOSE;
drop if sum>1; drop sum;

drop if year<1986;

collapse (sum) closed, by(group year);

tw (li closed year if group ==2, lc(midblue) lp(longdash))  
	(li closed year if group ==4, lc(green) )  
	(li closed year if group ==6, lc(gold) lp(shortdash)), 
	
	graphr(fc(white)) legend(lab(1 Public) lab(2 Nonprofit) lab(3 For-profit) size(small) col(3))
	xti(Year) xlab(1986(2)2010, labs(small)) 
	ylab(0(50)250, gmin gmax labs(small)) yti("Instiutions Reported as Closed") ;
	
graph export "${output}/FB1_number_closed.pdf", as(pdf) replace; 


** FB2: THE IMPACT OF SANCTIONS ON THE CUMULATIVE HAZARD OF CLOSURE BY SECTORE; 

use "${intermediate}/stacked_data_2yearinsts_rev", clear; 

drop if year<1982; drop if year>2008; 

* DROP COUNTIES WITH MORE THAN 50 SCHOOLS (WITH PELL RECIPIENTS) PER YEAR, ON AVERAGE;
destring fips, replace; 
drop if inlist(fips,4013, 6037, 6059, 6073, 12025, 17031, 26163, 36061, 42003, 42101, 48113, 48201,36005, 36047, 36081, 36085);

* DROP SCHOOLS THAT DO NOT HAVE ANY PELL RECIPIENTS IN ANY YEAR;
bysort opeid: egen max = max(recipients ) ; drop if max == 0; drop max; 

* CALCULATE YEARS SINCE CLOSURE;
sort opeid year;
bysort opeid : gen sum = sum(closed );

* DROP CLOSED SCHOOLS AFTER THEY CLOSE;
drop if sum>1; drop sum;

* INDICATOR FOR ANY SANCTION SO FAR; 
sort opeid year; 
egen sanc = rowmax(sanc_ll sanc_lp); 
bysort opeid: gen any_sanc = sum(sanc); 
replace any_sanc = 1 if any_sanc>1;


* YEARS SINCE LAST SANCTION;
bysort opeid (year): gen sanc_1 = sanc[_n-1] if opeid == opeid[_n-1] & year == year[_n-1]+1 & sanc ==0; recode sanc_1 (. = 0); 
bysort opeid (year): gen sanc_2 = sanc[_n-2] if opeid == opeid[_n-2] & year == year[_n-2]+2 & sanc ==0 & sanc_1 ==0; recode sanc_2 (. = 0); 
bysort opeid (year): gen sanc_3 = sanc[_n-3] if opeid == opeid[_n-3] & year == year[_n-3]+3 & sanc ==0 & sanc_1 ==0 & sanc_2 ==0; recode sanc_3 (. = 0); 
bysort opeid (year): gen sanc_4 = sanc[_n-4] if opeid == opeid[_n-4] & year == year[_n-4]+4 & sanc ==0 & sanc_1 ==0 & sanc_2 ==0 & sanc_3 ==0; recode sanc_4 (. = 0);
bysort opeid (year): gen sanc_5 = sanc[_n-5] if opeid == opeid[_n-5] & year == year[_n-5]+5 & sanc ==0 & sanc_1 ==0 & sanc_2 ==0 & sanc_3 ==0 & sanc_4 ==0; recode sanc_5 (. = 0); 
bysort opeid (year): gen sanc_6 = sanc[_n-6] if opeid == opeid[_n-6] & year == year[_n-6]+6 & sanc ==0 & sanc_1 ==0 & sanc_2 ==0 & sanc_3 ==0 & sanc_4 ==0 & sanc_5 ==0; recode sanc_6 (. = 0); 
bysort opeid (year): gen sanc_7 = sanc[_n-7] if opeid == opeid[_n-7] & year == year[_n-7]+7 & sanc ==0 & sanc_1 ==0 & sanc_2 ==0 & sanc_3 ==0 & sanc_4 ==0 & sanc_5 ==0 & sanc_6 ==0; recode sanc_7 (. = 0); 

foreach v of var sanc sanc_1 - sanc_5 {; 

foreach n in 2 4 6 {;

	gen G`n'`v' = `v' if group == `n'; recode G`n'`v' (. = 0);
	
};


};

xi: areg closed G2* G4* G6* i.group i.year, a(fips);

foreach n in 2 4 6 {;

	lincom G`n'sanc; loc est_`n'_0 = r(estimate); loc ci_l_`n'_0 = r(estimate)-(1.96*r(se)); loc ci_h_`n'_0 = r(estimate)+(1.96*r(se));
	lincom G`n'sanc+ G`n'sanc_1; loc est_`n'_1 = r(estimate); loc ci_l_`n'_1 = r(estimate)-(1.96*r(se)); loc ci_h_`n'_1 = r(estimate)+(1.96*r(se));
	lincom G`n'sanc+ G`n'sanc_1 + G`n'sanc_2; loc est_`n'_2 = r(estimate); loc ci_l_`n'_2 = r(estimate)-(1.96*r(se)); loc ci_h_`n'_2 = r(estimate)+(1.96*r(se)); 
	lincom G`n'sanc+ G`n'sanc_1 + G`n'sanc_2 + G`n'sanc_3; loc est_`n'_3 = r(estimate); loc ci_l_`n'_3 = r(estimate)-(1.96*r(se)); loc ci_h_`n'_3 = r(estimate)+(1.96*r(se)); 
	lincom G`n'sanc+ G`n'sanc_1 + G`n'sanc_2 + G`n'sanc_3 + G`n'sanc_4; loc est_`n'_4 = r(estimate); loc ci_l_`n'_4 = r(estimate)-(1.96*r(se)); loc ci_h_`n'_4 = r(estimate)+(1.96*r(se)); 
	lincom G`n'sanc+ G`n'sanc_1 + G`n'sanc_2 + G`n'sanc_3 + G`n'sanc_4 + G`n'sanc_5; loc est_`n'_5 = r(estimate); loc ci_l_`n'_5 = r(estimate)-(1.96*r(se)); loc ci_h_`n'_5 = r(estimate)+(1.96*r(se)); 
};

outreg2 using "${output}/AppendixB_closed.txt", replace keep(G2* G4* G6*) dec(3) sym(**,*,+) se aster(se) 
	addstat(
	"pub -1", 0, "pub 0",`est_2_0', "pub cum 1",`est_2_1', "pub cum 2",`est_2_2', "pub cum 3",`est_2_3', "pub cum 4",`est_2_4', "pub cum 5",`est_2_5', 
	"np -1",  0, "np 0", `est_4_0',  "np cum 1", `est_4_1', "np cum 2", `est_4_2', "np cum 3", `est_4_3', "np cum 4", `est_4_4', "np cum 5", `est_4_5', 
	"fp -1",  0, "fp 0", `est_6_0',  "fp cum 1", `est_6_1', "fp cum 2", `est_6_2', "fp cum 3", `est_6_3', "fp cum 4", `est_6_4', "fp cum 5", `est_6_5');


outreg2 using "${output}/AppendixB_closed.txt", ap keep(G2* G4* G6*) dec(3) sym(**,*,+) se aster(se) 
	addstat(
	"pub -1", 0, "pub 0",`ci_l_2_0', "pub cum 1",`ci_l_2_1', "pub cum 2",`ci_l_2_2', "pub cum 3",`ci_l_2_3', "pub cum 4",`ci_l_2_4', "pub cum 5",`ci_l_2_5', 
	"np -1",  0, "np 0",`ci_l_4_0',  "np cum 1", `ci_l_4_1', "np cum 2", `ci_l_4_2', "np cum 3", `ci_l_4_3', "np cum 4", `ci_l_4_4', "np cum 5", `ci_l_4_5', 
	"fp -1", 0,  "fp 0",`ci_l_6_0', "fp cum 1", `ci_l_6_1', "fp cum 2", `ci_l_6_2', "fp cum 3", `ci_l_6_3', "fp cum 4", `ci_l_6_4', "fp cum 5", `ci_l_6_5');

outreg2 using "${output}/AppendixB_closed.txt", ap keep(G2* G4* G6*) dec(3) sym(**,*,+) se aster(se) 
	addstat(
	"pub -1", 0, "pub 0",`ci_h_2_0', "pub cum 1",`ci_h_2_1', "pub cum 2",`ci_h_2_2', "pub cum 3",`ci_h_2_3', "pub cum 4",`ci_h_2_4', "pub cum 5",`ci_h_2_5', 
	"np -1",  0, "np 0",`ci_h_4_0',  "np cum 1", `ci_h_4_1', "np cum 2", `ci_h_4_2', "np cum 3", `ci_h_4_3', "np cum 4", `ci_h_4_4', "np cum 5", `ci_h_4_5', 
	"fp -1", 0,  "fp 0",`ci_h_6_0', "fp cum 1", `ci_h_6_1', "fp cum 2", `ci_h_6_2', "fp cum 3", `ci_h_6_3', "fp cum 4", `ci_h_6_4', "fp cum 5", `ci_h_6_5');

	
preserve;

	insheet using "${output}/AppendixB_closed.txt", clear; keep in 45/65;
	gen group = .; 
	replace group = 2 if substr(v1,1,3) == "pub"; 
	replace group = 4 if substr(v1,1,2) == "np"; 
	replace group = 6 if substr(v1,1,2) == "fp"; 
	drop v1; 
	for any v2 v3 v4 \ any coeff ci_l ci_h : rename X Y; 
	bysort group: gen t = _n; replace t= t-2; 
	foreach v of var coeff - ci_h {; destring `v', replace; };

	tw (rarea ci_l ci_h t if group ==2, lw(none) lc(white) fc(midblue) fi(30)) 
	(connected coeff t if group == 2, ms(Oh) mc(midblue) lp(longdash) lw(medthick) lc(midblue)) 
	(rarea ci_l ci_h t if group ==4, lw(none)  lc(white) fc(green) fi(30)) 
	(connected coeff t if group == 4, ms(triangle) mc(green) lw(medthick) lc(green))  
	(rarea ci_l ci_h t if group ==6, lw(none)  lc(white) fc(gold) fi(30)) 
	(connected coeff t if group == 6, ms(X) mc(gold) lw(medthick) lc(gold) lp(shortdash)), 
	graphr(fc(white)) legend(order(2 4 6) lab(2 Public) lab(4 Nonprofit) lab(6 For-profit) size(small) col(3)) 
	xlab(-1(1)5, labs(small)) xti(Years since sanction) ylab(-.1(.1).5, labs(small) gmin gmax) yti(Cumulative hazard of closure);

	graph export "${output}/FB2_hazard_of_closure_sanctioned.pdf", as(pdf) replace; 

restore;

