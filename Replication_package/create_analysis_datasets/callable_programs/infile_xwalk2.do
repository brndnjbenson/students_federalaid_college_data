/* THIS PROGRAM CREATES zip.dta USING ORIGINAL zip_code_database.csv  (downloaded from http://www.unitedstateszipcodes.org/zip-code-database/).
From the website: "The data comes from authoritative sources such as the United States Postal Service (2011), US Census Bureau (2010), the Internal Revenue 
Service (2008), and Yahoo". */
/*national_county.txt was downloaded from the United States Census bureau website*/

#d;


/** COUNTY FIPS CODE DATA  **/
**********************************************************************************;

insheet using "${zip}/national_county.txt", names clear; 

tostring stateansi , replace;
tostring countyansi, replace;

gen length1=length(stateansi);
replace stateansi= "0"+stateansi if length1 ==1 ;

gen length2=length(countyansi);
replace countyansi= "00"+countyansi if length2 ==1 ;
replace countyansi= "0"+countyansi if length2 ==2;

drop length*;

gen fips=stateansi + countyansi;

rename countyname county;

keep state county fips;

replace county = subinstr(lower(county),".","",.); 

drop if state=="PR" | state=="AP" | state=="AA" | state=="AE" | state=="GU" | state=="MP" | state=="VI" | state=="UM" | state=="FM" | state=="MH" 
	 | state=="PW" | state=="CM" | state=="CZ" | state=="NB"  | state=="PI" | state=="TT" | state == "AS" ;

save "${intermediate}/county_fips",replace ; 


/** ZIP CODE DATA  **/
**********************************************************************************;

insheet using "${zip}/zip_code_database.csv", names clear; 
tostring zip, replace;
gen length_zip=length(zip);
replace zip= "00"+zip if length_zip ==3;
replace zip= "0"+zip if length_zip ==4;
drop length_zip;
keep zip county primary_city acceptable state;
rename state state_zip;

* DROP TERRITORIES;
foreach t in AA AE AP AS CM CZ FM GU MH MP NB PI PR PW TT VI UM {;
	drop if state_zip == "`t'";
};

replace county= subinstr(lower(county),".","",.);
replace county= "anchorage municipality" if county=="anchorage borough" | county=="municipality of anchorage";
replace county= "juneau city and borough" if county=="city and borough of juneau" | county=="juneau borough";
replace county= "dekalb county" if county=="de kalb county";
replace county= "dewitt county" if county=="de witt county";
replace county= "hoonah-angoon census area" if county=="hoonah-angoon borough";
replace county= "laporte county" if county=="la porte county";
replace county= "lasalle county" if county=="la salle county";
replace county= "o'brien county" if county=="obrien county";
replace county= "petersburg census area" if county=="petersburg borough";
replace county= "prince of wales-hyder census area" if county=="prince of wales-outer ketchikan borough";
replace county= "sitka city and borough" if county=="sitka borough";
replace county= "skagway municipality" if county=="skagway borough";
replace county= "wrangell city and borough" if county=="wrangell borough";
replace county= "yakutat city and borough" if county=="yakutat borough";

rename state_zip state;

merge m:1 state county using "${intermediate}/county_fips"; /*59 (1), 9 (2), 41,498 (3)*/ 
keep if _mer!=2;
drop _merge;

rename state state_zip;
rename county county_zip;
/*rename fips fips_zip*/;

count; /*41656*/

drop if fips == "";

drop primary_city acceptable_cities;
ren state_zip state; ren county_zip county;

save zip_temp, replace;

erase "${intermediate}/county_fips.dta"; 
