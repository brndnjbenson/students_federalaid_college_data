*-------------------------------------------------------------------------*
|              SAS DATA DEFINITION STATEMENTS FOR ICPSR 2383              |
|        POSTSECONDARY CAREER SCHOOL SURVEY, 1981: [UNITED STATES]        |
|                         1ST ICPSR VERSION                               |
|                           December, 2001                                |
|                                                                         |
|                                                                         |
| This SAS setup file contains the following statements:                  |
|                                                                         |
| PROC FORMAT:  Creates user-defined formats. Formats replace original    |
| value codes with value code descriptions. Formats may not be present    |
| for all variables in the data file.                                     |
|                                                                         |
| DATA:  Begins a SAS data step and names an output SAS data set.         |
|                                                                         |
| INFILE:  Specifies the input data file to be read with the input        |
| statement. Users must replace "file-specification" with a complete      |
| statement of the location of the data file.                             |
|                                                                         |
| INPUT:  Assigns the name, type, decimal specification (if any), and     |
| identifies variable beginning and ending column locations.              |
|                                                                         |
| LABEL:  Assigns descriptive labels to variables. Variable labels and    |
| variable names may be identical for certain variables.                  |
|                                                                         |
| FORMAT:  Associates the formats created by the PROC FORMAT step with    |
| the variables named in the INPUT statement. Format statements may not   |
| be present for all variables in the data file.                          |
|                                                                         |
| NOTE:  Users should modify this SAS setup file to suit their specific   |
| needs. PROC FORMAT, FORMAT, and MISSING VALUE RECODES sections have     |
| been marked by SAS comment statements. To include these sections in a   |
| final SAS setup, users should remove the SAS comment statements from    |
| the desired section(s).                                                 |
*-------------------------------------------------------------------------;
* SAS PROC FORMAT;                                                         
/*                                                                         
PROC FORMAT;                                                               
   VALUE V12FT (MAX=40)                                                    
   1 = "Not affiliated"                                                    
   2 = "Branch another organization"                                       
   3 = "Part  chain of schools"                                            
   4 = "Parent of a chain of schools"                                      
   5 = "Hospit schl stud register"                                         
   6 = "Dont know, Refused";                                               
   VALUE V16FT (MAX=40)                                                    
   1 = "Postmaster Return"                                                 
   3 = "Closed Out of business"                                            
   4 = "Out of scope"                                                      
   5 = "Merged School"                                                     
   6 = "Affiliated a NEGIS school"                                         
   7 = "Duplication"                                                       
   10 = "Nonresponse"                                                      
   12 = "Refusal"                                                          
   18 = "Incomplete Data"                                                  
   19 = "Complete response";                                               
   VALUE V17FT (MAX=40)                                                    
   0 = "Non-NEGIS school"                                                  
   1 = "NEGIS school";                                                     
   VALUE V18FT (MAX=40)                                                    
   1 = "Northeast"                                                         
   2 = "North Central"                                                     
   3 = "South"                                                             
   4 = "West";                                                             
   VALUE $V19FT                                                            
   "1" = "Short form 2358-2"                                               
   "2" = "Long form 2358"                                                  
   "3" = "Correspondence 2358-1x"                                          
   "4" = "Short form new school";                                          
   VALUE V20FT (MAX=40)                                                    
   1 = "Unique program-certainty"                                          
   2 = "size-certainty"                                                    
   3 = "Random selection"                                                  
   4 = "Correspondence-certainty"                                          
   5 = "New school-not selected"                                           
   6 = "Part of frame of sample-not selected";                             
   VALUE V26FT (MAX=40)                                                    
   0 = "Otherwise"                                                         
   1 = "Published";                                                        
   VALUE $V28FT                                                            
   "A" = "Vocational and technical"                                        
   "B" = "Technical only"                                                  
   "C" = "Business and commercial"                                         
   "D" = "Cosmetology and barber"                                          
   "E" = "Flight"                                                          
   "F" = "Trade"                                                           
   "G" = "Arts and design"                                                 
   "H" = "Hospital"                                                        
   "I" = "Junior, community college"                                       
   "J" = "College"                                                         
   "K" = "Other"                                                           
   "L" = "Allied health";                                                  
   VALUE V38FT (MAX=40)                                                    
   0 = "No imputation"                                                     
   1 = "0 imputed based on 0 total"                                        
   2 = "amount computed by subtraction"                                    
   3 = "imput based on 1979 data"                                          
   4 = "5 imput based on 1981 data"                                        
   6 = "7 imput based on ranking procedure";                               
   VALUE V39FT (MAX=40)                                                    
   0 = "No imputation"                                                     
   1 = "0 imputed based on 0 total"                                        
   2 = "amount computed by subtraction"                                    
   3 = "imput based on 1979 data"                                          
   4 = "5 imput based on 1981 data"                                        
   6 = "7 imput based on ranking procedure";                               
   VALUE V40FT (MAX=40)                                                    
   0 = "No imputation"                                                     
   1 = "0 imputed based on 0 total"                                        
   2 = "amount computed by subtraction"                                    
   3 = "imput based on 1979 data"                                          
   4 = "5 imput based on 1981 data"                                        
   6 = "7 imput based on ranking procedure";                               
   VALUE V41FT (MAX=40)                                                    
   0 = "No imputation"                                                     
   1 = "0 imputed based on 0 total"                                        
   2 = "amount computed by subtraction"                                    
   3 = "imput based on 1979 data"                                          
   4 = "5 imput based on 1981 data"                                        
   6 = "7 imput based on ranking procedure";                               
   VALUE V42FT (MAX=40)                                                    
   0 = "No imputation"                                                     
   1 = "0 imputed based on 0 total"                                        
   2 = "amount computed by subtraction"                                    
   3 = "imput based on 1979 data"                                          
   4 = "5 imput based on 1981 data"                                        
   6 = "7 imput based on ranking procedure";                               
   VALUE V43FT (MAX=40)                                                    
   0 = "No imputation"                                                     
   1 = "0 imputed based on 0 total"                                        
   2 = "amount computed by subtraction"                                    
   3 = "imput based on 1979 data"                                          
   4 = "5 imput based on 1981 data"                                        
   6 = "7 imput based on ranking procedure";                               
   VALUE V44FT (MAX=40)                                                    
   0 = "No imputation"                                                     
   1 = "0 imputed based on 0 total"                                        
   2 = "amount computed by subtraction"                                    
   3 = "imput based on 1979 data"                                          
   4 = "5 imput based on 1981 data"                                        
   6 = "7 imput based on ranking procedure";                               
   VALUE V45FT (MAX=40)                                                    
   0 = "No imputation"                                                     
   1 = "0 imputed based on 0 total"                                        
   2 = "amount computed by subtraction"                                    
   3 = "imput based on 1979 data"                                          
   4 = "5 imput based on 1981 data"                                        
   6 = "7 imput based on ranking procedure";                               
   VALUE V46FT (MAX=40)                                                    
   0 = "No imputation"                                                     
   1 = "0 imputed based on 0 total"                                        
   2 = "amount computed by subtraction"                                    
   3 = "imput based on 1979 data"                                          
   4 = "5 imput based on 1981 data"                                        
   6 = "7 imput based on ranking procedure";                               
   VALUE $V47FT                                                            
   "1" = "Only correspondence offered"                                     
   "2" = "Some correspondence offered"                                     
   "3" = "No correspondence offered"                                       
   "9" = "Not reported";                                                   
   VALUE V48FT (MAX=40)                                                    
   1 = "Public"                                                            
   2 = "Private proprietary"                                               
   3 = "Independent nonprofit";                                            
   VALUE $V49FT                                                            
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V50FT                                                            
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V51FT                                                            
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V52FT                                                            
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V53FT                                                            
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V54FT                                                            
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V55FT                                                            
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V56FT                                                            
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V57FT                                                            
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V58FT                                                            
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V59FT                                                            
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V60FT                                                            
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V61FT                                                            
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V62FT                                                            
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V63FT                                                            
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V64FT                                                            
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V65FT                                                            
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V66FT                                                            
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V67FT                                                            
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V68FT                                                            
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V69FT                                                            
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V70FT                                                            
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V71FT                                                            
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V72FT                                                            
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V73FT                                                            
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V74FT                                                            
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V75FT                                                            
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V76FT                                                            
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V77FT                                                            
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V78FT                                                            
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V79FT                                                            
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V80FT                                                            
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V81FT                                                            
   "0" = "No accreditation"                                                
   "A" = "Northeast"                                                       
   "B" = "Middle States"                                                   
   "C" = "North Central"                                                   
   "D" = "Northwest"                                                       
   "E" = "Southern"                                                        
   "F" = "Western";                                                        
   VALUE $V83FT                                                            
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V84FT                                                            
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V85FT                                                            
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V86FT                                                            
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V89FT                                                            
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V90FT                                                            
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V91FT                                                            
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V92FT                                                            
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V93FT                                                            
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V94FT                                                            
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V95FT                                                            
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V96FT                                                            
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V99FT                                                            
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V100FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V101FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V102FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V103FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V104FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V105FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V106FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V107FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V108FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V109FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V110FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V111FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V112FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V113FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V114FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V115FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V116FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V117FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V118FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V119FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V120FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V121FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V124FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V125FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V126FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V127FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V128FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V129FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V130FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V131FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V132FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V133FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V134FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V135FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V136FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V137FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V138FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V139FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V140FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V141FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V142FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V143FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V144FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V145FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V146FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V147FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V148FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V149FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V150FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V151FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V152FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V153FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V154FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V155FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V156FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V157FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V158FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V159FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V162FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V163FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V164FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V165FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V166FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V167FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V168FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V171FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V172FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V173FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V174FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V175FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V176FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V177FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V178FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V179FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V180FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V181FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V182FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V183FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V184FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V187FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V188FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V189FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V190FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V191FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V192FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V193FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V194FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V195FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V196FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V197FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V198FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V199FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V200FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V201FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V202FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V203FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V204FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V205FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V206FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V207FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V208FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V209FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V210FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V211FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V212FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V213FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V214FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V217FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V218FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V219FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V220FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V221FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V222FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V223FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V224FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V225FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V226FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V227FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V228FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V229FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V230FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V231FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V232FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V233FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V234FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V235FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V236FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V237FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V238FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V239FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V240FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V241FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V242FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V243FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V244FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V245FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V246FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V247FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V248FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V249FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V250FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V251FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V252FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V253FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V254FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V255FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V256FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V257FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V258FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V259FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V260FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V261FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V262FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V263FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V264FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V265FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V266FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V267FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V268FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V269FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V270FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V271FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V272FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V273FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V274FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V275FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V276FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V277FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V281FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V282FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V283FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V284FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V285FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V289FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V290FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V291FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V292FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V293FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V294FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V295FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V296FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V297FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V298FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V299FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V300FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V301FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V302FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V303FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V304FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V305FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V306FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V307FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V311FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V312FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V313FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V314FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V315FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V316FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V317FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V318FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V319FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V320FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V321FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V322FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V323FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V324FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V325FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V326FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V327FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V331FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V332FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V333FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V334FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V335FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V336FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V337FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V338FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V342FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V343FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V344FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V345FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V346FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V347FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V348FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V349FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V350FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V351FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V352FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V353FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V357FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V358FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V359FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V360FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V361FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V362FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V363FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V364FT                                                           
   "0" = "No"                                                              
   "1" = "Yes";                                                            
*/                                                                         
* SAS DATA, INFILE, INPUT STATEMENTS;                                      
                                                                           
DATA;                                                                      
INFILE "file-specification" LRECL=715  missover pad;                       
INPUT                                                                      
   EDSCODE 1-2              SERNUMB 3-6              VENNUMB 7-12          
   NAME $ 13-58             FIPS $ 59-61             COUNTY $ 62-77        
   STREET $ 78-112          CITY $ 113-127           ZIP 128-132           
   DISTNO 133-134           PHONE $ 135-147          AFFIL 148-148         
   NAME2 $ 149-178          CITY2 $ 179-198          EDSTC 199-200         
   RESPC 201-202            HEGIS 203-203            REGION 204-204        
   FORMT $ 205-205          SAMPLE 206-206           TOTPROG 207-208       
   SIZE 209-213             PROBS 214-218            STRNO 219-222         
   SEQNO 223-226            PUBL 227-227             IDAFF 228-233         
   SCHLC $ 234-234          FTTOT 235-239            PTTOT 240-244         
   FTPTT 245-250            FTMALE 251-255           PTMALE 256-260        
   MALETOT 261-266          FTFEMA 267-272           PTFEMA 273-278        
   FEMATOT 279-284          FTFLAG 285-285           PTFLAG 286-286        
   TOTFLA 287-287           FTMALF 288-288           PTMALF 289-289        
   MALTOTF 290-290          FTFEMFL 291-291          PTFEMFL 292-292       
   FEMTOTF 293-293          CORRES $ 294-294         CONTROL 295-295       
   ACCSTAT $ 296-296        MLT $ 297-297            AICS $ 298-298        
   ANES $ 299-299           DH1 $ 300-300            DA1 $ 301-301         
   DT1 $ 302-302            MLTAMA $ 303-303         MRT $ 304-304         
   MT $ 305-305             PAS $ 306-306            HIST $ 307-307        
   DTE $ 308-308            MAE $ 309-309            NMT $ 310-310         
   RTT $ 311-311            RT $ 312-312             CT $ 313-313          
   IT $ 314-314             MA $ 315-315             FSE $ 316-316         
   CAC $ 317-317            ECPD $ 318-318           NAPNES $ 319-319      
   NATTS $ 320-320          NHSC $ 321-321           ADN $ 322-322         
   NUR $ 323-323            PN $ 324-324             ID $ 325-325          
   ANTECH $ 326-326         ACCRED $ 327-327         ASSO $ 328-328        
   FILLE1 $ 329-329         FISL $ 330-330           VA $ 331-331          
   PELL $ 332-332           FAA $ 333-333            FILLE2 $ 334-350      
   TOTAL1 351-352           AGPROD $ 353-353         AGSUPP $ 354-354      
   AGMECH $ 355-355         AGRIPR $ 356-356         ORNA $ 357-357        
   AGRES $ 358-358          FOREST1 $ 359-359        AGRMISC $ 360-360     
   FILLE3 $ 361-365         TOTAL2 366-367           ADVERT $ 368-368      
   APPAREL $ 369-369        AUTO $ 370-370           FINCRED $ 371-371     
   FLORIST $ 372-372        FOODIST $ 373-373        FOODSER $ 374-374     
   GENMERC $ 375-375        HARDWAR $ 376-376        HOMEFUR $ 377-377     
   HOTELMG $ 378-378        INDMARK $ 379-379        INSURAN $ 380-380     
   INTL $ 381-381           PERS $ 382-382           PETRO $ 383-383       
   REALST $ 384-384         RECR $ 385-385           TRANSP $ 386-386      
   RETAIL $ 387-387         WHSL $ 388-388           DISTED $ 389-389      
   ENTERT $ 390-390         FILLE4 $ 391-395         TOTAL3 $ 396-397      
   DA2 $ 398-398            DH2 $ 399-399            DLT2 $ 400-400        
   DM2 $ 401-401            CYTOL $ 402-402          HISTO $ 403-403       
   MEDLAB $ 404-404         HEMAT $ 405-405          MEDBIO $ 406-406      
   ASSNUR $ 407-407         PRACNU $ 408-408         ASSTNU $ 409-409      
   PSYCH $ 410-410          SURG $ 411-411           NURSO $ 412-412       
   OCCTH $ 413-413          PHYTH $ 414-414          REHMI $ 415-415       
   XRAYT $ 416-416          RADTH $ 417-417          NUCLE $ 418-418       
   XRAYM $ 419-419          OPTIC $ 420-420          ENVIR $ 421-421       
   MENTAL $ 422-422         EECTEC $ 423-423         EKGTEC $ 424-424      
   RESPTH $ 425-425         MEDAST1 $ 426-426        HEALAID $ 427-427     
   MEDER $ 428-428          MORTUA $ 429-429         MEDREC1 $ 430-430     
   PHYSASST $ 431-431       HEALMISC $ 432-432       VETASST $ 433-433     
   FILLE5 $ 434-438         TOTAL4 439-440           CHILDC $ 441-441      
   CLOTH $ 442-442          FOODMG $ 443-443         HOMEFUR2 $ 444-444    
   INSTMG1 $ 445-445        HOMEECH $ 446-446        TAILOR $ 447-447      
   FILLE6 $ 448-453         TOTAL5 454-455           ACOUNT1 $ 456-456     
   COMPUT $ 457-457         KEYPUN $ 458-458         COMPROG $ 459-459     
   SYSTAN $ 460-460         BUSDATA $ 461-461        GENOFF $ 462-462      
   INFOCOM $ 463-463        MATSUPP $ 464-464        PERSON $ 465-465      
   SECRET1 $ 466-466        SUPADM $ 467-467         TYPIN $ 468-468       
   OFFMISC $ 469-469        FILLE7 $ 470-474         TOTAL6 475-476        
   AEROTEC $ 477-477        AGRITEC $ 478-478        ACHTEC $ 479-479      
   AUTOTEC $ 480-480        CHEMTEC $ 481-481        CIVILTEC $ 482-482    
   ELECTTEC $ 483-483       ELECTRON $ 484-484       ELEMECH1 $ 485-485    
   ENVIRCNT $ 486-486       INDTECH2 $ 487-487       INSTRTEC $ 488-488    
   MECHTEC $ 489-489        METALGY $ 490-490        NUCLETEC $ 491-491    
   PETROTEC $ 492-492       SCIDATA $ 493-493        LEGASST $ 494-494     
   COMPILOT $ 495-495       FIRETECH $ 496-496       FORESTEC $ 497-497    
   OCEANTEC $ 498-498       POLICE1 $ 499-499        TEACHAST $ 500-500    
   LIBASST $ 501-501        BDCSTECH $ 502-502       ARTS $ 503-503        
   TECEDMIS $ 504-504       FILLE8 $ 505-509         TOTAL7 510-511        
   ACREPAIR $ 512-512       APPLIREP $ 513-513       AUTOREP $ 514-514     
   AUTOMECH $ 515-515       AUTOSPEC $ 516-516       AUTOSERV $ 517-517    
   AIRCRM $ 518-518         AIRCRO $ 519-519         GROUND $ 520-520      
   BLUEPR $ 521-521         BUSMECH $ 522-522        COMMART $ 523-523     
   COMFISH $ 524-524        COMPHOT $ 525-525        CARPENT $ 526-526     
   ELECCON $ 527-527        CONSTR1 $ 528-528        MASON $ 529-529       
   PAINT $ 530-530          PLAST $ 531-531          PLUMB $ 532-532       
   DRYWA $ 533-533          GLAZE $ 534-534          ROOF $ 535-535        
   CONST $ 536-536          CUSTO $ 537-537          DIESE $ 538-538       
   DRAFT $ 539-539          ELEOCC $ 540-540         RADIO $ 541-541       
   ELECTRN $ 542-542        FABRIC $ 543-543         FOREMA $ 544-544      
   GRAPH $ 545-545          ATOMIC $ 546-546         INSTR $ 547-547       
   MARITI $ 548-548         MACHSH $ 549-549         MACHTO $ 550-550      
   WELD $ 551-551           TOOL $ 552-552           METWORK $ 553-553     
   METALG $ 554-554         BARB $ 555-555           COSME $ 556-556       
   PERST $ 557-557          PLASTI $ 558-558         FIREMAN $ 559-559     
   LAWENF $ 560-560         PUBSERV $ 561-561        QUANTFO $ 562-562     
   REFRIG $ 563-563         ENGINE $ 564-564         STAENER $ 565-565     
   TEXTILE $ 566-566        LEATHER $ 567-567        UPHOLST $ 568-568     
   WOODWOR $ 569-569        TRUCK $ 570-570          DOGGROO $ 571-571     
   TRADEMI $ 572-572        UNKNOWN $ 573-574        FILLE9 $ 575-611      
   TOTAL8 612-613           DPTECH $ 614-614         KEYPUNCH $ 615-615    
   PROGRAM $ 616-616        PERIPHE $ 617-617        EQUIPMA $ 618-618     
   OTHER1 $ 619-619         FILLE10 $ 620-621        TOTAL9 622-623        
   HEALGEN $ 624-624        DA3 $ 625-625            DH3 $ 626-626         
   DL3 $ 627-627            MEDBIO3 $ 628-628        ANIMAL $ 629-629      
   XRAY2 $ 630-630          NURSRN $ 631-631         NURSPR $ 632-632      
   OCCTHR $ 633-633         SURGICA $ 634-634        OPTIC2 $ 635-635      
   MEDREC2 $ 636-636        MEDAST2 $ 637-637        INHALTH $ 638-638     
   PSYCHIA $ 639-639        ELECDIA $ 640-640        INSTMG2 $ 641-641     
   PHYTHE $ 642-642         OTHER2 $ 643-643         FILLE11 $ 644-646     
   TOTAL10 647-648          MEGEN $ 649-649          AERO2 $ 650-650       
   ENGGRA $ 651-651         ARCHIT $ 652-652         CHEMIC $ 653-653      
   AUTOMO $ 654-654         DIESEL2 $ 655-655        WELD2 $ 656-656       
   CIVIL $ 657-657          ELECTRO $ 658-658        ELEMECH2 $ 659-659    
   INDUST $ 660-660         TEXTIL $ 661-661         INSTRU $ 662-662      
   MECHAN $ 663-663         NUCLEA $ 664-664         CONSTR2 $ 665-665     
   OTHER3 $ 666-666         FILLE12 $ 667-669        TOTAL11 670-671       
   NATSCH $ 672-672         AGRI $ 673-673           FOREST2 $ 674-674     
   FOODSE $ 675-675         HOMEEC $ 676-676         MARINE $ 677-677      
   LABTECH $ 678-678        SANITAT $ 679-679        OTHER4 $ 680-680      
   FILLE13 $ 681-682        TOTAL12 683-684          BUSCOM $ 685-685      
   ACOUNT2 $ 686-686        BANKFIN $ 687-687        MANAGE $ 688-688      
   SECRET2 $ 689-689        PERSONA $ 690-690        PHOTOGR $ 691-691     
   COMMBRD $ 692-692        PRINT $ 693-693          HOTEL $ 694-694       
   TRANSPO $ 695-695        ART $ 696-696            OTHER5 $ 697-697      
   FILLE14 $ 698-699        TOTAL13 700-701          PUBSEG $ 702-702      
   RELIG $ 703-703          EDUCA $ 704-704          LIBRAR $ 705-705      
   POLICE2 $ 706-706        SOCIAL $ 707-707         FIRE $ 708-708        
   ADMIN $ 709-709          OTHER6 $ 710-710         FILLE15 $ 711-715;    
                                                                           
* SAS LABEL STATEMENT;                                                     
                                                                           
LABEL                                                                      
   EDSCODE = "STATE CODES (10-66) ASSIGNED BY NCES"                        
   SERNUMB = "UNIQUE NUMBER ASSIGNED TO EACH RECORD"                       
   VENNUMB = "NEGIS SCHLS, BLANK FOR NON-NEGIS SCHLS"                      
   NAME = "NAME OF INSTITUTION"                                            
   FIPS = "IDENTIFIES COUNTY BY FTPS CODE"                                 
   COUNTY = "NAME OF COUNTY INSTITUTION IS LOCATED"                        
   STREET = "STREET ADDRESS"                                               
   CITY = "CITY INSTITUTION IS LOCATED"                                    
   ZIP = "POSTAL ZIP CODE"                                                 
   DISTNO = "NUMERIC IDENT  CONGR DISTRICT"                                
   PHONE = "BOTTOM-PAGE 1 PHONE OF INSTIT AABBCCDD"                        
   AFFIL = "TYPE OF AFFILIATION"                                           
   NAME2 = "NAME OF PARENT INSTITUTION"                                    
   CITY2 = "CITY PARENT INSTITUTION IS LOCATED"                            
   EDSTC = "STATE CODE (10-66) ASSIGNED BY NCES"                           
   RESPC = "SURVEY CONTROL RESPONSE CODE OF SCHL FIL"                      
   HEGIS = "WHETHER SCHL COVERED BY NEGIS CONTROL FI"                      
   REGION = "REGION WHERE SCHOOL IS LOCATED"                               
   FORMT = "TYPE OF FORM SENT TO SCHOOL"                                   
   SAMPLE = "WHETHER SCHOOL WAS SAMPLED"                                   
   TOTPROG = "TOTAL PROG OFFERED BY THE SCHL"                              
   SIZE = "MEASURE OF SIZE-NCES USE"                                       
   PROBS = "THE PROB OF SELECT FOR THE SCHL-NCES USE"                      
   STRNO = "THE STRATUM NUMBER FOR THE SCHL-NCES USE"                      
   SEQNO = "NUMBER OF SCHL IN THE STRATUM-NCES USE"                        
   PUBL = "WHETHER SCHL IS IN DIRECTORY-NCES USE"                          
   IDAFF = "ID OF THE SCHL'S AFFILI SCHL,IF KNOWN"                         
   SCHLC = "SCHOOL TYPE"                                                   
   FTTOT = "TOTAL FULL-TIME ENROLLMENT"                                    
   PTTOT = "TOTAL PART-TIME ENROLLMENT"                                    
   FTPTT = "TOTAL FULL-TIME AND PT ENROLL"                                 
   FTMALE = "TOTAL FULL-TIME MALE ENROLLMENT"                              
   PTMALE = "TOTAL PART-TIME MALE ENROLLMENT"                              
   MALETOT = "TOTAL FULL-TIME AND PT MALE ENROLL"                          
   FTFEMA = "TOTAL FULL-TIME FEMALE ENROLLMENT"                            
   PTFEMA = "TOTAL PART-TIME FEMALE ENROLLMENT"                            
   FEMATOT = "TOTAL FULL-TIME AND PT FEMALE ENROLL"                        
   FTFLAG = "TOTAL FULL-TIME ENROLLMENT FLAG"                              
   PTFLAG = "TOTAL PART-TIME ENROLLMENT FLAG"                              
   TOTFLA = "TOTAL FULL-TIME AND PT ENROLL FLAG"                           
   FTMALF = "TOTAL FULL-TIME MALE ENROLLMENT FLAG"                         
   PTMALF = "TOTAL PART-TIME MALE ENROLLMENT FLAG"                         
   MALTOTF = "TOTAL MALE ENROLLMENT FLAG"                                  
   FTFEMFL = "TOTAL FULL-TIME FEMALE ENROLL FLAG"                          
   PTFEMFL = "TOTAL FULL-TIME FEMALE ENROLL FLAG"                          
   FEMTOTF = "TOTAL FEMALE ENROLLMENT FLAG"                                
   CORRES = "WHETHER SCHL OFFERS CORRES COURSES"                           
   CONTROL = "TYPE OF CONTROL"                                             
   ACCSTAT = "WHETHER SCHL IS NATIONALLY ACCREDITED"                       
   MLT = "MEDICAL LAB TECHNICIN PROG"                                      
   AICS = "ASSOC INDEP COLLEGES, SCHLS:BUS PROG"                           
   ANES = "AMER ASSOC OF NURSE ANESTHETISTS"                               
   DH1 = "(ADA/CDA): DENTAL HYGIENIST PROG"                                
   DA1 = "ADA/CAD: DENTAL ASSISTANT PROG"                                  
   DT1 = "ADA/CDA: DENTAL LAB TECH PROG"                                   
   MLTAMA = "(AMA/CAHEA): MEDICAL LAB TECH PROG"                           
   MRT = "AMA/CAHEA: MED RECORDS TECH PROG"                                
   MT = "AMA/CAHEA: MED TECH PROG CERTIF ONLY"                             
   PAS = "AMA/CAHEA: PROG FOR PHYSICIAN'S ASSIST"                          
   HIST = "AMA/CAHEA: HISTOLOGIC TECH PROG"                                
   DTE = "DANCE AND THEATER EDUCATION PROG"                                
   MAE = "MEDICAL ASSIST PROG"                                             
   NMT = "AMA/CAHEA: NUCLEAR MEDICINE TECH PROG"                           
   RTT = "AMA/CAHEA: RADIATION THERAPY TECH PROG"                          
   RT = "AMA/CAHEA: RADIOLOGRAPHER PROG"                                   
   CT = "AMA/CAHEA: CYTOTECHNOLOGIST PROG"                                 
   IT = "AMA/CAHEA: INHALATION THER TECH PROG"                             
   MA = "AMA/CAHEA: MED ASSIST PROG"                                       
   FSE = "FUNERAL SERVICE PROG"                                            
   CAC = "COSMETOLOGY PROG"                                                
   ECPD = "ENGINEERING TECH PROG"                                          
   NAPNES = "NAT ASSOC PRAC NURSE EDU SERV"                                
   NATTS = "NAT ASSOC TRADE AND TECH SCHLS"                                
   NHSC = "NAT HOME STUDY COUNCIT:ALL PROG"                                
   ADN = "NAT LEAGUE FOR NURSING (NLN)"                                    
   NUR = "NLN: DIPLOMA NURSING PROG"                                       
   PN = "NLN: DIPLOMA PRAC NURSING PROG"                                   
   ID = "FOUNDATION FOR INTERIOR DESIGN RES"                               
   ANTECH = "ANIMAL TECHNICIAN PROGRAMS"                                   
   ACCRED = "INSTITUTION HAS REGIONAL ACCRED"                              
   ASSO = "THE REGION THE SCHL IS AWARD ACCRED"                            
   FILLE1 = "BLANK"                                                        
   FISL = "FED INSURED STUDENT LOAN ELIGIBLE"                              
   VA = "VETERAN'S ADMINISTRATION"                                         
   PELL = "PELL GRANT"                                                     
   FAA = "FED AVIATION ADMINISTMTION"                                      
   FILLE2 = "BLANK"                                                        
   TOTAL1 = "TOTAL NUMBER OF OFFER IN AGRI"                                
   AGPROD = "AGRI PRODUCT PROG (01.01)"                                    
   AGSUPP = "AGRI SUPPLY AND SERV PROG (01.02)"                            
   AGMECH = "AGRI MECHANICS PROG (01.03)"                                  
   AGRIPR = "AGRI PRODUCTS PROG (01.04)"                                   
   ORNA = "HORTICULTURE PROG (01.05)"                                      
   AGRES = "AGRI RESOURCES PROG (01.06)"                                   
   FOREST1 = "FORESTRY PROG (01.07)"                                       
   AGRMISC = "AGRI, MISC PROG (01.08)"                                     
   FILLE3 = "ZERO-FILLED"                                                  
   TOTAL2 = "NUMBER OF OFFER IN DISTR EDUC"                                
   ADVERT = "ADVERTISING SERV PROG(04.01)"                                 
   APPAREL = "APPAREL AND ACCESS PROG(04.02)"                              
   AUTO = "AUTOMOTIVE SALES PROG(04.03)"                                   
   FINCRED = "FINANCE AND CREDIT PROG(04.04)"                              
   FLORIST = "FLORISTRY PROG(04.05)"                                       
   FOODIST = "FOOD DISTR PROG(04.06)"                                      
   FOODSER = "FOOD SERV TECH PROG(04.07)"                                  
   GENMERC = "GENERAL MERCHAND PROG(04.08)"                                
   HARDWAR = "HARDWARE,BUILD,PROG(04.09)"                                  
   HOMEFUR = "HOME FURNISH SALES PROG(04.10)"                              
   HOTELMG = "MOTEL, LODGING MANAGE PROG(04.11)"                           
   INDMARK = "INDUSTRIAL MARKET PROG(04.12)"                               
   INSURAN = "INSURANCE MANAGE AND SELL PROG(04.13)"                       
   INTL = "INTERNATIONAL TRADE PROG(04.15)"                                
   PERS = "PERSONAL SERV PROG(04.15)"                                      
   PETRO = "PETROLEUM PRODUCTS PROG(04.16)"                                
   REALST = "REAL ESTATE AND SELLING PROG(04.17)"                          
   RECR = "RECREATION AND TOURISM PROG(04.18)"                             
   TRANSP = "TRANSPORTATION SERV PROG(04.19)"                              
   RETAIL = "RETAIL TRADE PROG(04.20)"                                     
   WHSL = "WHOLESALE TRADE PROG(04.31)"                                    
   DISTED = "DISTRIBUTIVE EDUC,PROG(04.99)"                                
   ENTERT = "ENTERTAINMENT SERVICES(04.08)"                                
   FILLE4 = "ZERO-FILLED"                                                  
   TOTAL3 = "NUMBER OF OFFER IN HEALTH PROG"                               
   DA2 = "DENTAL ASSISTANT PROG(07.0101)"                                  
   DH2 = "DENTAL HYGIENE PROG(07.0102)"                                    
   DLT2 = "DENTAL LAB TECH PROG(07.0103)"                                  
   DM2 = "DENTAL TECH, MISC PROG(07.019)"                                  
   CYTOL = "CYTOLOGY PROG(07.0201)"                                        
   HISTO = "HISTOLOGY PROG(07.0202)"                                       
   MEDLAB = "MED,BIOL LAB ASSIST PROG(07.0203)"                            
   HEMAT = "HEMATOLOGY PROG(07.0204)"                                      
   MEDBIO = "MED, BIOL LAB, MISC PROG(07.0299)"                            
   ASSNUR = "NURSING(ASSOC DEG) PROG(07.0301)"                             
   PRACNU = "NURSING,(VOCATIONAL)PROG(07.0302)"                            
   ASSTNU = "NURSING ASSIST(AIDE) PROG(07.0303)"                           
   PSYCH = "PSYCHIATRIC AIDE PROG(07.0304)"                                
   SURG = "SURGICAL TECH PROG(07.0305)"                                    
   NURSO = "NURSING, OTHER PROG(07.0399)"                                  
   OCCTH = "OCCUPATIONAL THERAPY PROG(07.0401)"                            
   PHYTH = "PHYSICAL THERAPY PROG(07.0402)"                                
   REHMI = "REHAB SERVICES, MISC PROG(07.0499)"                            
   XRAYT = "RADIOLOGIC TECH PROG(07.0501)"                                 
   RADTH = "RADIATION THERAPY PROG(07.0502)"                               
   NUCLE = "NUCLEAR MED TECH PROG(07.0503)"                                
   XRAYM = "RADIOL OCCUP, MISC PROG(07.0599)"                              
   OPTIC = "OPTICAL TECH PROG(07.06)"                                      
   ENVIR = "ENVIR HEALTH TECH PROG(07.07)"                                 
   MENTAL = "MENTAL HEALTH TECH PROG(07.08)"                               
   EECTEC = "ELECTROENCEP TECH PROG(07.0901)"                              
   EKGTEC = "ELECTROCARDIOG TECH PROG(07.0902)"                            
   RESPTH = "RESPIRATORY THERAPY PROG(07.0903)"                            
   MEDAST1 = "MED ASSISTANT PROG(07.0904)"                                 
   HEALAID = "COMMUNITY HEALTH AIDE PROG(07.0906)"                         
   MEDER = "MED EMERGENCY TECH PROG(07.0907)"                              
   MORTUA = "MORTUARY SCI PROG(07.0909)"                                   
   MEDREC1 = "MED RECORDS TECH PROG(07.0915)"                              
   PHYSASST = "PHYSICIANS ASSIST PROG(07.0920)"                            
   HEALMISC = "HEALTH OCCUP, MISC PROG(07.99)"                             
   VETASST = "VETERINARY ASSISTANT (07.09)"                                
   FILLE5 = "ZERO FILLED"                                                  
   TOTAL4 = "NUMBER OF OFFER IN HOME ECONOMICS"                            
   CHILDC = "CARE, GUIDANCE OF CHILD PROG(09.0201)"                        
   CLOTH = "CLOTHING, PRODUCT AND SERV PROG(09.0202)"                      
   FOODMG = "FOOD MANAGE, PRODUCT PROG(09.0203)"                           
   HOMEFUR2 = "HOME FURNISH, EQUIP, SERV PROG(09.0204)"                    
   INSTMG1 = "INSTITUT, HOME MANAGE SERV PROG(09.0205)"                    
   HOMEECH = "HOME ECONOMICS, MISC PROG(09.0299)"                          
   TAILOR = "TAILORING (09.02.02)"                                         
   FILLE6 = "ZERO-FILLED"                                                  
   TOTAL5 = "NUMBER OF OFFICE OCCUP OFFERING"                              
   ACOUNT1 = "ACCOUNTING BOOKKEEPING(14.01)"                               
   COMPUT = "COMPUT,EQUIP OPER TECH PROG(14.0201)"                         
   KEYPUN = "KEYPUNCH OPERATOR PROG(14.0202)"                              
   COMPROG = "COMPUT PROGRAMMER TECH(14.0299)"                             
   SYSTAN = "SYSTEMS ANALYST PROG(14.0204)"                                
   BUSDATA = "BUS DATA PROCESS SYS PROG(14.0299)"                          
   GENOFF = "FILLING,GEN OFFICE OCCUP PROG(14.03)"                         
   INFOCOM = "INFORMATION COMM PROG(14.04)"                                
   MATSUPP = "MATERIALS OCCUP PROG(14.05)"                                 
   PERSON = "PERSONNEL, TRAINING OCCUP PROG(14.06)"                        
   SECRET1 = "STENOGRAPHIC, SECRET OCCUP PROG(14.07)"                      
   SUPADM = "SUPERVISE, ADMINISTR MANAGE PROG(14.08)"                      
   TYPIN = "TYPING AND CLERICAL OCCUP PROG(14.09)"                         
   OFFMISC = "OFFICE OCCUPATION, MISC PROG(14.99)"                         
   FILLE7 = "ZERO-FILLED"                                                  
   TOTAL6 = "TOTAL NUMBER OF OFFER IN TECH EDUC"                           
   AEROTEC = "AERONAUTICAL TECH PROG(16.0101)"                             
   AGRITEC = "AGRICULTURAL TECH PROG(16.0102)"                             
   ACHTEC = "ARCHITECTURAL TECH PROG(16.0103)"                             
   AUTOTEC = "AUTOMOTIVE TECH PROG(16.0104)"                               
   CHEMTEC = "CHEMICAL TECH PROG(16.0105)"                                 
   CIVILTEC = "CIVIL TECH PROG(16.0106)"                                   
   ELECTTEC = "ELECTRICAL TECH PROG(16.0107)"                              
   ELECTRON = "ELECTRON, MACH TECH PROG(16.0108)"                          
   ELEMECH1 = "ELECTOMECH TECH PROG(16.0109)"                              
   ENVIRCNT = "ENVIR CONTROL TECH PROG(16.0110)"                           
   INDTECH2 = "INDUSTRIAL TECH PROG(16.0111)"                              
   INSTRTEC = "INSTRUMENTATION TECH PROG(16.0112)"                         
   MECHTEC = "MECH AND ENGIN TECH PROG(16.0113)"                           
   METALGY = "METALLURGICAL TECH PROG(16.0114)"                            
   NUCLETEC = "NUCLEAR TECH PROG(16.0115)"                                 
   PETROTEC = "PETROLEUM TECH PROG(16.0116)"                               
   SCIDATA = "SCI DATA PROCESS TECH PROG(16.0117)"                         
   LEGASST = "FOOD PROCESSING TECH"                                        
   COMPILOT = "COMMERCIAL PILOT TRAIN PROG(16.0601)"                       
   FIRETECH = "FIRE, FIRE SAFETY TECH PROG(16.060)"                        
   FORESTEC = "FORESTRY, WILDLIFE TECH PROG(16.06)"                        
   OCEANTEC = "OCEANOGRAPHIC TECH PROG(16.0604)"                           
   POLICE1 = "POLICE SCIENCE TECH PROG(16.0605)"                           
   TEACHAST = "EDUCATION TECH"                                             
   LIBASST = "LIBRARY ASSIST TECH PROG(16.0607)"                           
   BDCSTECH = "COMM, BROADCAST TECH PROG(16.0609)"                         
   ARTS = "PERFORMING ARTISTS PROG(16.0695)"                               
   TECEDMIS = "TECH EDUCATION, MISC PROG(16.001)"                          
   FILLE8 = "ZERO FILLED"                                                  
   TOTAL7 = "TOTAL7"                                                       
   ACREPAIR = "AIR COND INSTALL, REPAIR PROG(17.01)"                       
   APPLIREP = "APPLIANCE REPAIR PROG(17.02)"                               
   AUTOREP = "AUTOMOTIVE BODY REPAIR PROG(17.0301)"                        
   AUTOMECH = "AUTOMOTIVE MECHANICS PROG(17.0302)"                         
   AUTOSPEC = "AUTO SPECIALIZE REPAIR PROG(17.0303)"                       
   AUTOSERV = "AUTOMOTIVE SERV PROG(17.0399)"                              
   AIRCRM = "AIRCRAFT MAINTENANCE PROG(17.0401)"                           
   AIRCRO = "AIRCRAFT OPERATIONS PROG(17.0402)"                            
   GROUND = "AIRCRAFT GROUNDS OPER PROG(17.0403)"                          
   BLUEPR = "BLUEPRINT READING PROG(17.05)"                                
   BUSMECH = "BUSINESS MACH MAINT OCCUP PROG(17.06)"                       
   COMMART = "COMMERCIAL ART PROG(17.07)"                                  
   COMFISH = "COMMERCIAL FISHERY OCCUP PROG(17.08)"                        
   COMPHOT = "COMMERCIAL PHOTOGRAPHY PROG(17.09)"                          
   CARPENT = "CARPENTRY-CONSTRUCT PROG(17.1001)"                           
   ELECCON = "ELECTRICITY-CONSTRUCT PROG(17.1002)"                         
   CONSTR1 = "CONSTR EQUIP,OPERATION PROG(17.1003)"                        
   MASON = "MASONRY-CONSTRUCT PROG(17.1004)"                               
   PAINT = "PAINTING, DECOR-CONSTRUCT PROG(17.1005)"                       
   PLAST = "PLASTER-CONSTRUCT PROG(17.1006)"                               
   PLUMB = "PLUMB AND PIPEFIT-CONSTR PROG(17.1007)"                        
   DRYWA = "DRYWALL INSTALL-CONSTR PROG(17.1008)"                          
   GLAZE = "GLAZING-CONSTRUCT PROG(17.1009)"                               
   ROOF = "ROOFING-CONSTRUCT PROG(17.1010)"                                
   CONST = "CONSTRUCT, BUILD TECH PROG(17.1099)"                           
   CUSTO = "CUSTODIAL SERV PROG(17.11)"                                    
   DIESE = "DIESEL MECHANIC PROG(17.12)"                                   
   DRAFT = "DRAFTING OCCUP PROG(17.13)"                                    
   ELEOCC = "ELECTRICAL OCCUP PROG(17.14)"                                 
   RADIO = "RADIO,TV REPAIR OCCUP PROG(17.1503)"                           
   ELECTRN = "ELECTRONICS OCCUP PROG(17.1599)"                             
   FABRIC = "FABRIC MAINT SERV PROG(17.16)"                                
   FOREMA = "FOREMAN,MANAGE DEV PROG(17.17)"                               
   GRAPH = "GRAPHIC ARTS OCCUP PROG(17.19)"                                
   ATOMIC = "INDUST ATOMIC ENERGY OCCUP PROG(17.20)"                       
   INSTR = "INSTR MAINT, REPAIRS OCCUP PROG(17.21)"                        
   MARITI = "MARITIME OCCUP PROG(17.22)"                                   
   MACHSH = "MACHINE SHOP OCCUP PROG(17.2302)"                             
   MACHTO = "MACHINE TOOL OPER PROG(17.2303)"                              
   WELD = "WELD AND CUTTING OCCUP PROG(17.2306)"                           
   TOOL = "TOOL, DIE MAKING OCCUP PROG(17.2307)"                           
   METWORK = "METALWORK OCCUP, MISC PROG(17.2399)"                         
   METALG = "METALLURGY OCCUP PROG(17.24)"                                 
   BARB = "BARBERING OCCUP PROG(17.2601)"                                  
   COSME = "COSMETOLOGY PROG(17.2602)"                                     
   PERST = "PERSONAL SERV,TRADE,IND PROG(17.2699)"                         
   PLASTI = "PLASTICS OCCUP PROG(17.27)"                                   
   FIREMAN = "FIREMAN TRAINING PROG(17.2801)"                              
   LAWENF = "LAW ENFORCE TRAINING PROG(17.2802)"                           
   PUBSERV = "PUBLIC SERVICE OCUP PROG(17.2899)"                           
   QUANTFO = "QUALITY FOOD OCCUP PROG(17.29)"                              
   REFRIG = "REFRIGERATION ENGIN PROG(17.30)"                              
   ENGINE = "SMALL ENGINE REPAIR PROG(17.31)"                              
   STAENER = "STATIONARY ENERGY OCCUP PROG(17.32)"                         
   TEXTILE = "TEXTILE PRODUCT,FABRIC PROG(17.33)"                          
   LEATHER = "LEATHERWORK PROG(17.34)"                                     
   UPHOLST = "UPHOLSTER PROG(17.35)"                                       
   WOODWOR = "WOODWORK PROG(17.36)"                                        
   TRUCK = "TRUCK DRIVING PROG(17.4000)"                                   
   DOGGROO = "DOG GROOMING PROG(17.50)"                                    
   TRADEMI = "TRADE,INDUST OCCUP ,MISC PROG(17.99)"                        
   UNKNOWN = "SCHOOL REFUSED, NO PROG REPORTED"                            
   FILLE9 = "BLANK"                                                        
   TOTAL8 = "NUMBER OF DATA PROCESS TECH OFFER"                            
   DPTECH = "DATA PROCESS TECH, GENERAL PROG(5101)"                        
   KEYPUNCH = "KEYPUNCH OPERATOR,INPUT TECH PROG(5102)"                    
   PROGRAM = "COMPUTER PROGRAM TECH PROG(5103)"                            
   PERIPHE = "COMPUT OPERATOR,EQUIP TECH PROG(5104)"                       
   EQUIPMA = "DATA PROCESS EQUIP MAINT TECH PROG(5105)"                    
   OTHER1 = "RELATED PROG NOT IN THE ABOVE SUBJECT(51"                     
   FILLE10 = "ZERO FILLE"                                                  
   TOTAL9 = "NUMBER OF OFFER HEALTH SERV PARAMED PROG"                     
   HEALGEN = "HEALTH SERV ASSIST TECH,GEN PROG(5201)"                      
   DA3 = "DENTAL ASSISTANT TECH PROG(5202)"                                
   DH3 = "DENTAL HYGIENE TECH PROG(5203)"                                  
   DL3 = "DENTAL LAB TECH PROG(5204)"                                      
   MEDBIO3 = "MED, BIOL LAB ASSIST TECH PROG(5205)"                        
   ANIMAL = "ANIMAL LAB ASSIST TECH PROG(5206)"                            
   XRAY2 = "RADIOLOGIC(X-RAY, ETC)TECH PROG(5207)"                         
   NURSRN = "NURSING,(LESS THAN 4 YEAR)PROG(5208)"                         
   NURSPR = "NURSING, PRACTICAL PROG(5209)"                                
   OCCTHR = "OCCUP THERAPY TECH PROG(5210)"                                
   SURGICA = "SURGICAL TECH PROG(5211)"                                    
   OPTIC2 = "OPTICAL TECH PROG(5212)"                                      
   MEDREC2 = "MED RECORD TECH PROG(5213)"                                  
   MEDAST2 = "MED ASSIST TECH PROG(5214)"                                  
   INHALTH = "INHALATION THERAPY TECH PROG(5215)"                          
   PSYCHIA = "PSYCHIATRIC TECH PROG(5216)"                                 
   ELECDIA = "ELECTRO DIAGNOSTIC TECH PROG(5217)"                          
   INSTMG2 = "INSTITUTE MANAGEMENT TECH PROG(5218)"                        
   PHYTHE = "PHYSICAL THERAPY TECH(5219)"                                  
   OTHER2 = "PROG NOT IN ABOVE SUBJECT(5299)"                              
   FILLE11 = "ZERO FILLED"                                                 
   TOTAL10 = "NUMBER OFFER FROM MECH, ENG TECH AREA"                       
   MEGEN = "MECH AND ENGIN TECH, GEN PROG(5301)"                           
   AERO2 = "AERONAUT AND AVIATION TECH PROG(5302)"                         
   ENGGRA = "ENGIN AND AVIATION TECH PROG(5302)"                           
   ARCHIT = "ARCHITECTURE DRAFT TECH PROG(5304)"                           
   CHEMIC = "CHEMICAL TECH PROG(5305)"                                     
   AUTOMO = "AUTOMOTIVE TECH PROG(5306)"                                   
   DIESEL2 = "DIESEL TECH PROG(5307)"                                      
   WELD2 = "WELDING TECH PROG(5308)"                                       
   CIVIL = "CIVIL TECH PROG(5309)"                                         
   ELECTRO = "ELEC AND MACHINE TECH PROG(5310)"                            
   ELEMECH2 = "ELECTROMECH TECH PROG(5311)"                                
   INDUST = "INDUSTRIAL TECH PROG(5312)"                                   
   TEXTIL = "TEXTLE TECH PROG(5313)"                                       
   INSTRU = "INSTRUMENTATION TECH PROG(5315)"                              
   MECHAN = "MECHANICAL TECH PROG(5315)"                                   
   NUCLEA = "NUCLEAR TECH PROG(5316)"                                      
   CONSTR2 = "CONSTR AND BUILD TECH PROG(5317)"                            
   OTHER3 = "PROG NOT IN THE ABOVE SUBJECT(5399)"                          
   FILLE12 = "ZERO FILLED"                                                 
   TOTAL11 = "NUMBER OFFER FROM NAT SCI TECH AREAS"                        
   NATSCH = "NAT SCIENCES TECH, GEN PROG(5401)"                            
   AGRI = "AGRICULTURE TECH PROG(5402)"                                    
   FOREST2 = "FORESTRY, WILDLIFE TECH PROG(5403)"                          
   FOODSE = "FOOD SERV TECH  PROG(5404)"                                   
   HOMEEC = "HOME ECONOMICS TECH PROG(5405)"                               
   MARINE = "MARINE,OCEANOGRAPHIC TECH PROG(5406)"                         
   LABTECH = "LAB TECH, GENERAL PROG(5407)"                                
   SANITAT = "SANITAT, PUB HEALTH INSPECT PROG(5408)"                      
   OTHER4 = "PROG NOT IN THE ABOVE AREAS (5499)"                           
   FILLE13 = "ZERO FILLED"                                                 
   TOTAL12 = "NUMBER OFFER FROM BUS AND COMMERCE TECH"                     
   BUSCOM = "BUS AND COMMERCE TECH, GEN PROG(5001)"                        
   ACOUNT2 = "ACCOUNTING TECH PROG(5002)"                                  
   BANKFIN = "BANKING AND FINANCE TECH PROG(5003)"                         
   MANAGE = "MARKET DISTR, BUS,INDUST TECH PROG(5004)"                     
   SECRET2 = "SECRETARIAL TECH PROG(5006)"                                 
   PERSONA = "PERSONAL SERVICE TECH PROG(5006)"                            
   PHOTOGR = "PHOTOGRAPHY TECH PROG(5007)"                                 
   COMMBRD = "COMMUN AND BROADCAST TECH PROG(5008)"                        
   PRINT = "PRINT AND LITHOGRAPHY TECH PROG(5009)"                         
   HOTEL = "HOTEL,RESTAURANT MANAGE TECH PROG(5010)"                       
   TRANSPO = "TRANSPORT AND PUB UTIL TECH PROG(5011)"                      
   ART = "APPL ARTS, GRAPHIC, FINE ARTS PROG(5012)"                        
   OTHER5 = "PROG NOT IN THE ABOVE SUBJECT (5099)"                         
   FILLE14 = "ZERO FILLED"                                                 
   TOTAL13 = "OFFER FROM PUBLIC SERV TECH SUBJECT AREA"                    
   PUBSEG = "PUBLIC SERVICE TECH, GENERAL PROG(5501)"                      
   RELIG = "BIBLE, RELIGION RELATED OCCUP PROG(5502)"                      
   EDUCA = "EDUC(2 YEAR TEACH TRAIN PROG) PROG(5503)"                      
   LIBRAR = "LIBRARY ASSIST TECH PROG(5504)"                               
   POLICE2 = "POLICE, LAW ENFORCEMENT TECH PROG(5505)"                     
   SOCIAL = "RECREATION AND SOC WORK TECH PROG(5506)"                      
   FIRE = "FIRE CONTROL TECH PROG(5507)"                                   
   ADMIN = "PUB ADMINISTR AND MANAGE TECH PROG(5508)"                      
   OTHER6 = "PROG NOT IN THE ABOVE AREAS(5599)"                            
   FILLE15 = "BLANK";                                                      
                                                                           
* SAS FORMAT STATEMENT;                                                    
/*                                                                         
FORMAT                                                                     
   AFFIL V12FT.           RESPC V16FT.           HEGIS V17FT.              
   REGION V18FT.          FORMT $V19FT.          SAMPLE V20FT.             
   PUBL V26FT.            SCHLC $V28FT.          FTFLAG V38FT.             
   PTFLAG V39FT.          TOTFLA V40FT.          FTMALF V41FT.             
   PTMALF V42FT.          MALTOTF V43FT.         FTFEMFL V44FT.            
   PTFEMFL V45FT.         FEMTOTF V46FT.         CORRES $V47FT.            
   CONTROL V48FT.         ACCSTAT $V49FT.        MLT $V50FT.               
   AICS $V51FT.           ANES $V52FT.           DH1 $V53FT.               
   DA1 $V54FT.            DT1 $V55FT.            MLTAMA $V56FT.            
   MRT $V57FT.            MT $V58FT.             PAS $V59FT.               
   HIST $V60FT.           DTE $V61FT.            MAE $V62FT.               
   NMT $V63FT.            RTT $V64FT.            RT $V65FT.                
   CT $V66FT.             IT $V67FT.             MA $V68FT.                
   FSE $V69FT.            CAC $V70FT.            ECPD $V71FT.              
   NAPNES $V72FT.         NATTS $V73FT.          NHSC $V74FT.              
   ADN $V75FT.            NUR $V76FT.            PN $V77FT.                
   ID $V78FT.             ANTECH $V79FT.         ACCRED $V80FT.            
   ASSO $V81FT.           FISL $V83FT.           VA $V84FT.                
   PELL $V85FT.           FAA $V86FT.            AGPROD $V89FT.            
   AGSUPP $V90FT.         AGMECH $V91FT.         AGRIPR $V92FT.            
   ORNA $V93FT.           AGRES $V94FT.          FOREST1 $V95FT.           
   AGRMISC $V96FT.        ADVERT $V99FT.         APPAREL $V100FT.          
   AUTO $V101FT.          FINCRED $V102FT.       FLORIST $V103FT.          
   FOODIST $V104FT.       FOODSER $V105FT.       GENMERC $V106FT.          
   HARDWAR $V107FT.       HOMEFUR $V108FT.       HOTELMG $V109FT.          
   INDMARK $V110FT.       INSURAN $V111FT.       INTL $V112FT.             
   PERS $V113FT.          PETRO $V114FT.         REALST $V115FT.           
   RECR $V116FT.          TRANSP $V117FT.        RETAIL $V118FT.           
   WHSL $V119FT.          DISTED $V120FT.        ENTERT $V121FT.           
   DA2 $V124FT.           DH2 $V125FT.           DLT2 $V126FT.             
   DM2 $V127FT.           CYTOL $V128FT.         HISTO $V129FT.            
   MEDLAB $V130FT.        HEMAT $V131FT.         MEDBIO $V132FT.           
   ASSNUR $V133FT.        PRACNU $V134FT.        ASSTNU $V135FT.           
   PSYCH $V136FT.         SURG $V137FT.          NURSO $V138FT.            
   OCCTH $V139FT.         PHYTH $V140FT.         REHMI $V141FT.            
   XRAYT $V142FT.         RADTH $V143FT.         NUCLE $V144FT.            
   XRAYM $V145FT.         OPTIC $V146FT.         ENVIR $V147FT.            
   MENTAL $V148FT.        EECTEC $V149FT.        EKGTEC $V150FT.           
   RESPTH $V151FT.        MEDAST1 $V152FT.       HEALAID $V153FT.          
   MEDER $V154FT.         MORTUA $V155FT.        MEDREC1 $V156FT.          
   PHYSASST $V157FT.      HEALMISC $V158FT.      VETASST $V159FT.          
   CHILDC $V162FT.        CLOTH $V163FT.         FOODMG $V164FT.           
   HOMEFUR2 $V165FT.      INSTMG1 $V166FT.       HOMEECH $V167FT.          
   TAILOR $V168FT.        ACOUNT1 $V171FT.       COMPUT $V172FT.           
   KEYPUN $V173FT.        COMPROG $V174FT.       SYSTAN $V175FT.           
   BUSDATA $V176FT.       GENOFF $V177FT.        INFOCOM $V178FT.          
   MATSUPP $V179FT.       PERSON $V180FT.        SECRET1 $V181FT.          
   SUPADM $V182FT.        TYPIN $V183FT.         OFFMISC $V184FT.          
   AEROTEC $V187FT.       AGRITEC $V188FT.       ACHTEC $V189FT.           
   AUTOTEC $V190FT.       CHEMTEC $V191FT.       CIVILTEC $V192FT.         
   ELECTTEC $V193FT.      ELECTRON $V194FT.      ELEMECH1 $V195FT.         
   ENVIRCNT $V196FT.      INDTECH2 $V197FT.      INSTRTEC $V198FT.         
   MECHTEC $V199FT.       METALGY $V200FT.       NUCLETEC $V201FT.         
   PETROTEC $V202FT.      SCIDATA $V203FT.       LEGASST $V204FT.          
   COMPILOT $V205FT.      FIRETECH $V206FT.      FORESTEC $V207FT.         
   OCEANTEC $V208FT.      POLICE1 $V209FT.       TEACHAST $V210FT.         
   LIBASST $V211FT.       BDCSTECH $V212FT.      ARTS $V213FT.             
   TECEDMIS $V214FT.      ACREPAIR $V217FT.      APPLIREP $V218FT.         
   AUTOREP $V219FT.       AUTOMECH $V220FT.      AUTOSPEC $V221FT.         
   AUTOSERV $V222FT.      AIRCRM $V223FT.        AIRCRO $V224FT.           
   GROUND $V225FT.        BLUEPR $V226FT.        BUSMECH $V227FT.          
   COMMART $V228FT.       COMFISH $V229FT.       COMPHOT $V230FT.          
   CARPENT $V231FT.       ELECCON $V232FT.       CONSTR1 $V233FT.          
   MASON $V234FT.         PAINT $V235FT.         PLAST $V236FT.            
   PLUMB $V237FT.         DRYWA $V238FT.         GLAZE $V239FT.            
   ROOF $V240FT.          CONST $V241FT.         CUSTO $V242FT.            
   DIESE $V243FT.         DRAFT $V244FT.         ELEOCC $V245FT.           
   RADIO $V246FT.         ELECTRN $V247FT.       FABRIC $V248FT.           
   FOREMA $V249FT.        GRAPH $V250FT.         ATOMIC $V251FT.           
   INSTR $V252FT.         MARITI $V253FT.        MACHSH $V254FT.           
   MACHTO $V255FT.        WELD $V256FT.          TOOL $V257FT.             
   METWORK $V258FT.       METALG $V259FT.        BARB $V260FT.             
   COSME $V261FT.         PERST $V262FT.         PLASTI $V263FT.           
   FIREMAN $V264FT.       LAWENF $V265FT.        PUBSERV $V266FT.          
   QUANTFO $V267FT.       REFRIG $V268FT.        ENGINE $V269FT.           
   STAENER $V270FT.       TEXTILE $V271FT.       LEATHER $V272FT.          
   UPHOLST $V273FT.       WOODWOR $V274FT.       TRUCK $V275FT.            
   DOGGROO $V276FT.       TRADEMI $V277FT.       DPTECH $V281FT.           
   KEYPUNCH $V282FT.      PROGRAM $V283FT.       PERIPHE $V284FT.          
   EQUIPMA $V285FT.       HEALGEN $V289FT.       DA3 $V290FT.              
   DH3 $V291FT.           DL3 $V292FT.           MEDBIO3 $V293FT.          
   ANIMAL $V294FT.        XRAY2 $V295FT.         NURSRN $V296FT.           
   NURSPR $V297FT.        OCCTHR $V298FT.        SURGICA $V299FT.          
   OPTIC2 $V300FT.        MEDREC2 $V301FT.       MEDAST2 $V302FT.          
   INHALTH $V303FT.       PSYCHIA $V304FT.       ELECDIA $V305FT.          
   INSTMG2 $V306FT.       PHYTHE $V307FT.        MEGEN $V311FT.            
   AERO2 $V312FT.         ENGGRA $V313FT.        ARCHIT $V314FT.           
   CHEMIC $V315FT.        AUTOMO $V316FT.        DIESEL2 $V317FT.          
   WELD2 $V318FT.         CIVIL $V319FT.         ELECTRO $V320FT.          
   ELEMECH2 $V321FT.      INDUST $V322FT.        TEXTIL $V323FT.           
   INSTRU $V324FT.        MECHAN $V325FT.        NUCLEA $V326FT.           
   CONSTR2 $V327FT.       NATSCH $V331FT.        AGRI $V332FT.             
   FOREST2 $V333FT.       FOODSE $V334FT.        HOMEEC $V335FT.           
   MARINE $V336FT.        LABTECH $V337FT.       SANITAT $V338FT.          
   BUSCOM $V342FT.        ACOUNT2 $V343FT.       BANKFIN $V344FT.          
   MANAGE $V345FT.        SECRET2 $V346FT.       PERSONA $V347FT.          
   PHOTOGR $V348FT.       COMMBRD $V349FT.       PRINT $V350FT.            
   HOTEL $V351FT.         TRANSPO $V352FT.       ART $V353FT.              
   PUBSEG $V357FT.        RELIG $V358FT.         EDUCA $V359FT.            
   LIBRAR $V360FT.        POLICE2 $V361FT.       SOCIAL $V362FT.           
   FIRE $V363FT.          ADMIN $V364FT.;                                  
                                                                           
                                                                           
