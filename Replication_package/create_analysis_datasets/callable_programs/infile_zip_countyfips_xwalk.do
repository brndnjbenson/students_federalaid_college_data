/* Data on zip codes, primary city, county, and state, at the zip code level, downloaded from http://www.unitedstateszipcodes.org/zip-code-database/. 
From the website: "The data comes from authoritative sources such as the United States Postal Service (2011), US Census Bureau (2010), the Internal Revenue Service (2008), and Yahoo". 
These data were matched with data on state, fips, and county downloaded from the US Census Bureau website (https://www.census.gov/geo/reference/docs/codes/national_county.txt).   */

# d cr

/** CREATE A SINGLE DATA FILE CONTAINING zip, county, fips, state. **/
*************************************************************************************************
/*zipcty_xwalk*/
foreach year in 1990 2000 2010 {
	use "${zip}/`year'_zipcty_xwalk",clear
	rename county fips
	replace cntyname= subinstr(cntyname,",","",.)
	gen state =substr(cntyname,-2,2)
	gen length=length(cntyname)
	gen county=substr(cntyname,1,length-3)
	drop length
	
	keep zip fips state county
	
	tostring fips, replace
	gen length=length(fips)
	replace fips="0"+fips if length==4
	drop length
	
	rename fips fips`year'
	rename state state`year'
	rename county county`year'
	
	save zipcty_`year', replace
}

use zipcty_1990, clear
merge 1:1 zip using zipcty_2000
drop _merge
merge 1:1 zip using zipcty_2010
drop _m

count if fips1990!=fips2000 & fips1990!="" & fips2000!="" /*304*/
count if fips2000!=fips2010 & fips2000!="" & fips2010!="" /*50*/
count if fips1990!=fips2010 & fips1990!="" & fips2010!="" /*161*/

replace state2000="AK" if zip=="99689"
replace county2000="Yakutat Borough" if zip=="99689"

count /*34406*/

save zipcty_xwalk, replace

foreach y in 1990 2000 2010 { 
	erase zipcty_`y'.dta
}
