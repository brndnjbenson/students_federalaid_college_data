/* CREATES FIGURES 1, 2, & APPENDIX FIGURE C.1*/

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

foreach v of var loss_loans_pell loss_loans_only {; recode `v' (. = 0); };
egen group = group(control level ); drop if group ==.;
egen sanct = rowmax(loss_loans_pell loss_loans_only );

* F1: SANCTIONS BY SECTOR & YEAR;
preserve;

	collapse (sum) sanct , by(year group);
	
	reshape wide sanct , i(year ) j(group );

	replace sanct4 = sanct4 + sanct2;
	replace sanct6 = sanct6 + sanct4;
	
	tw (bar sanct2 year ,bc(dknavy) ) 
	(rbar sanct4 sanct2 year , bc(green) fi(25)) 
	(rbar sanct6 sanct4 year , bc(midblue) fi(75)) if year >1989 & year <2011, 
	
	graphr(fc(white)) legend(order(1 2 3) lab(1 "Public") lab(2 "Nonprofit") lab(3 "For-profit") size(small) col(3)) 
	xti(Year) 
	yti(Number Sanctioned) ylab(0(200)800 , gmin gmax labs(small));
	graph export "${output}/F1A_number_sanctioned_by_year_2yr.pdf", as(pdf) replace;

	replace sanct3 = sanct3 + sanct1;
	replace sanct5 = sanct5 + sanct3;
	
	tw (bar sanct1 year ,bc(dknavy) ) 
	(rbar sanct3 sanct1 year , bc(green) fi(25)) 
	(rbar sanct5 sanct3 year , bc(midblue) fi(75)) if year >1989 & year <2011, 
	
	graphr(fc(white)) legend(order(1 2 3) lab(1 "Public") lab(2 "Nonprofit") lab(3 "For-profit") size(small) col(3)) 
	xti(Year) 
	yti(Number Sanctioned) ylab(0(200)800 , gmin gmax labs(small));
	graph export "${output}/F1B_number_sanctioned_by_year_4yr.pdf", as(pdf) replace;
	
restore;

* F2B: THE DISTRIBUTION OF PELL GRANT RECIPIENTS ACROSS SECTORS BY YEAR AND LEVEL;
preserve;

	xi, noomit: collapse (mean) i.group (rawsum) recipients [aw = recipients ], by(year);

	tw (line _Igroup_1 year , lc(navy) lw(thin) lp(shortdash)) 
	(line _Igroup_2 year , lc(navy) lw(thick) lp(shortdash)) 
	(line _Igroup_6 year , lc(midblue) lw(thick) lp(longdash)) 
	(line _Igroup_5 year ,lc(midblue)  lw(thin) lp(longdash)) , 
	
	legend(order(2 3) lab(2 "Public") lab(3 "For-profit") size(small)) graphr(fc(white)) 
	xlab(1974(2)2012, labs(small)  angle(45)) xti(Year)
	yti(Share of Pell Recipients) ylab(0(.1).5, labs(small) gmin gmax) ;

graph export "${output}/F3_pct_pell_pub_v_fp_2year_schools.pdf", as(pdf) replace;

restore;

* F2A: THE DISTRIBUTION OF PELL GRANT RECIPIENTS ACROSS SECTORS BY YEAR;
preserve;

xi, noomit: collapse (mean) i.control (rawsum) recipients [aw = recipients ], by(year);

	tw (line _Icontrol_1 year , lc(navy) lw(medthick) lp(shortdash)) 
	(line _Icontrol_2 year , lc(green) lw(medthick) ) 
	(line _Icontrol_3 year , lc(midblue) lw(medthick) lp(longdash)) , 
	
	legend(order(1 2 3) lab(1 "Public") lab(2 "Nonprofit") lab(3 "For-profit") col(3) size(small)) graphr(fc(white)) 
	xlab(1974(2)2012, labs(small)  angle(45)) xti(Year)
	yti(Share of Pell Recipients) ylab(0(.1).8, labs(small) gmin gmax);

	graph export "${output}/F2_number_dist_pg_recips_by_year.pdf", as(pdf) replace;

restore;

* FC1: TOTAL PELL GRANT RECIPIENTS BY YEAR;
preserve;

	collapse (sum) recipients , by(year);

	replace recipients = recipients/1000000;

	tw (line recipients year , lc(navy) lw(medthick) ), 
	
	legend(off) graphr(fc(white)) 
	xlab(1974(2)2012, labs(small)  angle(45)) xti(Year) 
	ylab(0(1)9, gmin gmax labs(small) ) yti("Pell Grant Recipients (Millions)" );

	graph export "${output}/FC1_recipients_by_year.pdf", as(pdf) replace;

restore;

* F3: BORROWERS AND DEFAULT RATES BY SECTOR AND YEAR;
use "${intermediate}/formatted_analysis_data", clear;

preserve;

	collapse (sum) nbr nbd , by(year control);
	bysort year: egen totalnbr = total(nbr);
	gen pct = nbr/totalnbr
	gen drate = nbd/nbr;
	replace year = year-2;
	drop if year<1990 | year>2008;
	
	tw (li pct year if control ==1, lp(shortdash) lw(medthick)) 
		(li pct year if control ==2 , lc(green) lw(medthick)) 
		(li pct year if control ==3, lp(longdash) lw(medthick) lc(midblue)) , 
		
		graphr(fc(white)) legend(lab(1 Public) lab(2 Nonprofit) lab(3 For-profit) size(small) col(3)) 
		xlab(1990(2)2008, labs(small)) xti(Cohort Year) 
		yti(Share of borrowers entering repayment) ylab(0(.1).6, labs(small) gmin gmax);
		
	graph export "${output}/F3A_borrowers_entering_repayment_by_sector_1992_2011.pdf", as(pdf) replace;
	
	tw (li drate year if control ==1, lp(shortdash) lw(medthick)) 
		(li drate year if control ==2 , lc(green) lw(medthick)) 
		(li drate year if control ==3, lp(longdash) lw(medthick) lc(midblue)) , 
		
		graphr(fc(white)) legend(lab(1 Public) lab(2 Nonprofit) lab(3 For-profit) size(small) col(3)) 
		xlab(1990(2)2008, labs(small)) xti(Cohort Year) 
		yti(Share of borrowers defaulting within years) ylab(0(.05).3, labs(small) gmin gmax);
		
	graph export "${output}/F4B_cdr_by_sector.pdf", as(pdf) replace;

restore;

* FC2: BORROWERS AND DEFAULT RATES BY SECTOR AND YEAR;
preserve;

	collapse (sum) nbr nbd, by(year);
	replace year = year-2;
	drop if year<1990 | year>2009;
	gen rate = nbd/nbr;
	replace nbr = nbr/1000000;
	 
	tw (li nbr year, lw(medthick)) (li rate year , yaxis(2) lc(midblue) lp(longdash) lw(medthick)) , 
	
	graphr(fc(white)) legend(lab(1 Borrowers) lab(2 Share defaulting) size(small))
	xlab(1990(1)2010, angle(45) labsize(small)) 
	ylab(0(.5)4, labs(small) gmin gmax) xti(Cohort Year) 
	ylab(0(.02).16, labs(small) gmin gmax axis(2)) yti("Federal Borrowers (Millions)") yti("Share Defaulting", axis(2)) ;
	
	graph export "${output}/FC2_borrowers_by_year.pdf", as(pdf) replace;
	
restore;