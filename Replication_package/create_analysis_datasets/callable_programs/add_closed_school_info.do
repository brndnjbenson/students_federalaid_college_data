/*This program uses the closed_schools data plus the CDR data to supplement the pell grant data with zip codes when these are missing.
	using: closed_schools.dta, FY_append.dta, pell_opeid2000.dta 
	creates: pell_modified.dta*/
/* "infile_pell.do" calls this program */

 
*****************************************************************************
#d;
preserve;

* INFILE AND FORMAT CLOSED SCHOOL DATA, MERGE TO PELL GRANT FILE;
	insheet using "${data}/closed_schools_dataonly.csv", names clear; 
	
	drop if countryforeign ~= ""; drop countryforeign;
	foreach t in GU PR {; drop if state == "`t'"; };
	
	rename zipcode zip;
	gen length = length(zip);
	replace zip = "0"+zip if length == 4; 
	replace zip = substr(zip,1,5) if length == 10;
	drop length;
	   
	rename schoolname name; replace name = proper(name); 

* OPTION TO SAVE DATA SET WITH CLOSED SCHOOLS; 
	save "${intermediate}/closed_schools", replace;

* KEEP THE MAIN BRANCHES ONLY;
	tostring opeid, replace;
	keep if substr(opeid,-2,2) == "00"; 

* DROP 100th BRANCHES;
	gen length=length(opeid);
	tab length,m /*6,7,8*/;
	drop if leng==8; drop length;

* EXTRACT YEAR AND MONTH FROM closeddate; 
	gen year_closed =real(substr(closeddate,-2,2));
	gen month_closed = real(subinstr(substr(closeddate,1,2),"/","",.));
	assert year_c<=99 & year_c>=0;
	generate century= "19" if year_>14 & year_<.;
	replace century="20" if year_clo<=14 & year_closed>=10;
	replace century="200" if year_clo<10 & year_closed>=0;
	tostring year_clo, replace; replace year_closed=century+year;
	destring year_clos, replace;
	drop century closeddate;

* IF CLOSED IN SEPT OR LATER, ALLOCATE CLOSURE TO CORRECT ACADEMIC YEAR (E.G., 9/1973 = 1974 ACADEMIC YEAR);
	replace year_closed = year_closed + 1 if month_closed>=9 & month_closed<=12	;

	destring opeid, replace;
	
* FIX RECORDS THAT ARE IDENTIFIED AS DUPLICATES OBS OF THE SAME SCHOOL (E.G., SAME ADDRESS AND NAME, BUT DIFFERENT OPEIDS);
	qui do "${programs}/fix_duplicates.do"; 
		
	keep opeid name year_closed zip city state address;

* DEAL WITH DUPLICATES; 
	bysort opeid: gen count = _N; 
	gsort opeid -year_closed; bysort opeid: gen first = _n == 1; 
	keep if first == 1; 
	drop count first; 
	assert zip!="";
	
	save scrap, replace;

* ADD SCHOOL INFO FROM MAIN PEPS FILE (DROPPING BRANCH CAMPUSES);
	qui infix 	str recordtype 1-2 	str opeid 3-10 		str name 12-81 	str address 152-186
				str city 222-246 	str state 247-248 	str country 252-276 	str zip 277-290 	
			/*act_cd 319-320 		act_rsn 321-322 		str act_dt 323-330*/  level 355-356	control 357-357	
			str t4op_dt 390-397 	str t4cl_dt 398-405 	
			/*loc_rsn 406-407			str t4re_dt 412-419		*/
	if recordtype =="01" 
	
	using "${data}/SCHFILE2012.TXT", clear;

** CLEAN UP, LABEL VARS;	
	
* DROP FOREIGN INSTITUTIONS AND THOSE IN US TERRITORIES;
	drop recordtype; 
	drop if country ~= ""; drop country; 
	foreach t in VI PW PR MP MH GU FM AS {; drop if state == "`t'"; };

* DROP BRANCH CAMPUSES;
	gen dum = substr(opeid,-2,2); drop if dum ~= "00"; drop dum; destring opeid, replace; 

* FORMAT DATE VARIABLES;
	foreach t in t4op t4cl {; 
		gen `t'_year = real(substr(`t'_dt,1,4)); gen `t'_month = real(substr(`t'_dt,5,2)); 
		replace `t'_month = . if `t'_year == 1500; recode `t'_year (1500 = .); 
		drop `t'_dt;

* IF CLOSED IN SEPT OR LATER, ALLOCATE CLOSURE TO CORRECT ACADEMIC YEAR (E.G., 9/1973 = 1974 ACADEMIC YEAR)
		replace `t'_year = `t'_year+ 1 if `t'_month >=9 & `t'_month <=12; drop `t'_month; 	

* CLOSE LOOP OVER DATES;
	};

* LEVEL = 1 => 4-YEAR+, LEVEL = 2 => 2-YEAR OR LESS; 
	gen dum = .; 
	for any 0 1 2 3 4 5 6 7 8 9 10 11 12 
	  \ any 2 1 2 2 2 2 1 1 1 1 1  2  2 
	  : replace dum = Y if level == X; 
	drop level; rename dum level; 

* CONVERT ZIP INTO 5 DIGIT NUMERIC VAR;
	gen length = length(zip); replace zip = substr(zip,1,5) if length == 9; drop length; 

	gen year = 1974; 
	
* FIX RECORDS THAT ARE IDENTIFIED AS DUPLICATES OBS OF THE SAME SCHOOL (E.G., SAME ADDRESS AND NAME, BUT DIFFERENT OPEIDS);
	qui do "${programs}/fix_duplicates.do"; 

* COLLAPSE TO ONE RECORD PER OPEID; 
	collapse (firstnm) name address city state zip (min) control level t4op_year t4cl_year, by(opeid); 

* DROP NORTHERN MARIANAS COLLEGE (NOT IN US 50+DC));
	drop if opeid == 3033000;

* DROP COLLEGE OF AMERICAN SAMOA (NOT IN US 50+DC);
	drop if opeid == 1001000;

* DROP COMMUNITY COLLEGE OF MICRONESIA (NOT IN US 50+DC);
	drop if opeid == 1034300;

* DROP MICRONESIAN OCCUPATIONAL COLLEGE (NOT IN US 50+DC);
	drop if opeid == 1100900;

* MERGE ON CLOSURE DATA;
	merge 1:1 opeid using scrap, update; drop _m; 
	
	compress;
	
	save scrap, replace; 
	
restore;

* MERGE BACK TO MAIN DATA SET;
merge m:1 opeid using scrap, update; 
replace year = 1974 if year == .; 

* GENERATE INDICATORS FOR WHETHER SCHOOL IS PARTICIPATING IN VARIOUS T4 PROGRAMS;
gen t4 = year>=t4op_year & year<=t4cl_year; drop t4op_year t4cl_year; 

erase scrap.dta; 
 
