*-------------------------------------------------------------------------*
|                                                                         |
|              SAS DATA DEFINITION STATEMENTS FOR ICPSR 2382              |
|       POSTSECONDARY CAREER SCHOOL SURVEY, 1979-80: [UNITED STATES]      |
|                           1ST ICPSR VERSION                             |
|                            November, 2001                               |
|                                                                         |
|                                                                         |
| This SAS setup file contain the following statements:                   |
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
   VALUE $V13FT                                                            
   "N" = "No"                                                              
   "Y" = "Yes";                                                            
   VALUE $V14FT                                                            
   "A" = "None"                                                            
   "B" = "Branch"                                                          
   "C" = "Chain"                                                           
   "D" = "Parent"                                                          
   "E" = "Enrollment from other"                                           
   "F" = "Other";                                                          
   VALUE V18FT (MAX=40)                                                    
   3 = "Closed"                                                            
   4 = "Out of scope"                                                      
   5 = "Merged"                                                            
   6 = "Affiliated with jr.sr. college"                                    
   10 = "Nonresponse"                                                      
   11 = "Postmaster return"                                                
   12 = "Refusal"                                                          
   18 = "Incomplete Data"                                                  
   19 = "Complete response";                                               
   VALUE V19FT (MAX=40)                                                    
   0 = "Non-NEGIS school"                                                  
   1 = "NEGIS school";                                                     
   VALUE V20FT (MAX=40)                                                    
   1 = "Northeast"                                                         
   2 = "North Central"                                                     
   3 = "South"                                                             
   4 = "West";                                                             
   VALUE $V21FT                                                            
   "1" = "Short form"                                                      
   "2" = "Long form"                                                       
   "3" = "Correspondence";                                                 
   VALUE V22FT (MAX=40)                                                    
   1 = "Unique program-certainty"                                          
   2 = "size-certainty"                                                    
   3 = "Random selection"                                                  
   4 = "Correspondence-certainty"                                          
   5 = "New school-not selected"                                           
   6 = "Part of frame of sample-not selected";                             
   VALUE V23FT (MAX=40)                                                    
   1 = "No change"                                                         
   2 = "Name Change"                                                       
   3 = "New Schl Added";                                                   
   VALUE V29FT (MAX=40)                                                    
   0 = "Otherwise"                                                         
   1 = "Published";                                                        
   VALUE $V32FT                                                            
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
   VALUE $V45FT                                                            
   " " = "Not Area Voc Edu Schl"                                           
   "N" = "Not Area Voc Edu Schl"                                           
   "Y" = "Area voc Edu Schl";                                              
   VALUE $V46FT                                                            
   "1" = "Only correspondence offered"                                     
   "2" = "Some correspondence offered"                                     
   "3" = "No correspondence offered"                                       
   "9" = "Not reported";                                                   
   VALUE $V47FT                                                            
   "A" = "Public"                                                          
   "B" = "Private proprietary"                                             
   "C" = "Private Other";                                                  
   VALUE $V49FT                                                            
   " " = "Not reported"                                                    
   "N" = "No"                                                              
   "Y" = "Yes";                                                            
   VALUE $V50FT                                                            
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V51FT                                                            
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V52FT                                                            
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V53FT                                                            
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V54FT                                                            
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V55FT                                                            
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V56FT                                                            
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V57FT                                                            
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V58FT                                                            
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V59FT                                                            
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V60FT                                                            
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V62FT                                                            
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V63FT                                                            
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V64FT                                                            
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V65FT                                                            
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V66FT                                                            
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V67FT                                                            
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V68FT                                                            
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V69FT                                                            
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V70FT                                                            
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V71FT                                                            
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V72FT                                                            
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V73FT                                                            
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V74FT                                                            
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V75FT                                                            
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V76FT                                                            
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V77FT                                                            
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V78FT                                                            
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V79FT                                                            
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V81FT                                                            
   "N" = "No"                                                              
   "Y" = "Yes";                                                            
   VALUE $V82FT                                                            
   "A" = "Northeast"                                                       
   "B" = "Middle States"                                                   
   "C" = "North Central"                                                   
   "D" = "Northwest"                                                       
   "E" = "Southern"                                                        
   "F" = "Western";                                                        
   VALUE $V83FT                                                            
   "N" = "No"                                                              
   "Y" = "Yes";                                                            
   VALUE $V84FT                                                            
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V85FT                                                            
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V86FT                                                            
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V87FT                                                            
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V90FT                                                            
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V91FT                                                            
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V92FT                                                            
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V93FT                                                            
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V94FT                                                            
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V95FT                                                            
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V96FT                                                            
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V97FT                                                            
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V98FT                                                            
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V100FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V101FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V102FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V103FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V104FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V105FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V106FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V107FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V108FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V109FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V110FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V111FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V112FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V113FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V114FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V115FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V116FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V117FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V118FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V119FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V120FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V121FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V123FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V124FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V125FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V126FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V127FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V128FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V129FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V130FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V131FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V132FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V133FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V134FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V135FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V136FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V137FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V138FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V139FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V140FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V141FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V142FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V143FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V144FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V145FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V146FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V147FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V148FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V149FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V150FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V151FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V152FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V153FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V154FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V155FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V156FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V157FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V160FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V161FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V162FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V163FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V164FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V165FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V167FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V168FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V169FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V170FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V171FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V172FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V173FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V174FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V175FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V176FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V177FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V178FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V179FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V180FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V183FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V184FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V185FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V186FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V187FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V188FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V189FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V190FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V191FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V192FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V193FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V194FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V195FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V196FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V197FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V198FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V199FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V200FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V201FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V202FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V203FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V204FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V205FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V206FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V207FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V208FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V209FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V210FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V211FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V212FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V215FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V216FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V217FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V218FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V219FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V220FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V221FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V222FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V223FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V224FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V225FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V226FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V227FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V228FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V229FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V230FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V231FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V232FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V233FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V234FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V235FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V236FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V237FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V238FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V239FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V240FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V241FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V242FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V243FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V244FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V245FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V246FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V247FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V248FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V249FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V250FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V251FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V252FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V253FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V254FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V255FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V256FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V257FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V258FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V259FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V260FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V261FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V262FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V263FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V264FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V265FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V266FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V267FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V268FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V269FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V270FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V271FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V272FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V273FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V274FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V275FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V278FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V279FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V280FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V281FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V282FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V286FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V287FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V288FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V289FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V290FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V291FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V292FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V293FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V294FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V295FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V296FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V297FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V298FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V299FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V300FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V301FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V302FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V303FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V304FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V308FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V309FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V310FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V311FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V312FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V313FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V314FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V315FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V316FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V317FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V318FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V319FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V320FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V321FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V322FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V323FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V324FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V328FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V329FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V330FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V331FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V332FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V333FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V334FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V335FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V339FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V340FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V341FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V342FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V343FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V344FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V345FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V346FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V347FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V348FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V349FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V350FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V354FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V355FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V356FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V357FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V358FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V359FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V360FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V361FT                                                           
   " " = "No"                                                              
   "1" = "Yes";                                                            
   VALUE $V364FT                                                           
   " " = "Yes"                                                             
   "1" = "No";                                                             
/*                                                                         
* SAS DATA, INFILE, INPUT STATEMENTS;                                      
                                                                           
DATA;                                                                      
INFILE "file-specification" LRECL=715 missover pad;                        
INPUT                                                                      
   EDSCODE $1-2             SERNUMB 3-6              VENNUMB 7-12          
   NAME $ 13-58             FIPS $ 59-61             COUNTY $ 62-77        
   STREET $ 78-112          CITY $ 113-127           ZIP $ 128-132         
   DISTNO $ 133-134         FOUNDED $ 135-138        PHONE $ 139-151       
   CHANC $ 152-152          AFFIL $ 153-153          NAME2 $ 154-183       
   CITY2 $ 184-198          EDSTC $ 199-200          RESPC 201-202         
   HEGIS 203-203            REGION 204-204           FORMT $ 205-205       
   SAMPLE 206-206           ADDSTAT 207-207          TOTPROG 208-209       
   SIZE $ 210-214           PROBS $ 215-219          STRNO $ 220-223       
   STSIZE 224-227           PUBL 228-228             IDAFF 229-234         
   FILLER1 $ 235-260        SCHLC $ 261-261          OTHERID $ 262-274     
   LFEXCUL $ 275-275        FTTOT 276-280            PTTOT 281-285         
   FTPTT 286-291            FTMALE 292-296           PTMALE 297-301        
   MALETOT 302-307          FTFEMA 308-313           PTFEMA $ 314-319      
   FEMATOT 320-325          FILLER2 $ 326-326        AREAVOC $ 327-327     
   CORRES $ 328-328         CONTROL $ 329-329        FILLER3 $ 330-346     
   ACCSTAT $ 347-347        MLT $ 348-348            AICS $ 349-349        
   ANES $ 350-350           DH1 $ 351-351            DA1 $ 352-352         
   DT1 $ 353-353            MLTAMA $ 354-354         MRT $ 355-355         
   MT $ 356-356             PAS $ 357-357            HIST $ 358-358        
   FILLER4 $ 359-359        CLA $ 360-360            NMT $ 361-361         
   RTT $ 362-362            RT $ 363-363             CT $ 364-364          
   IT $ 365-365             MA $ 366-366             FSE $ 367-367         
   CAC $ 368-368            ECPD $ 369-369           NAPNES $ 370-370      
   NATTS $ 371-371          NHSC $ 372-372           ADN $ 373-373         
   NUR $ 374-374            PN $ 375-375             ID $ 376-376          
   ANTECH $ 377-377         FILLER5 $ 378-390        ACCRED $ 391-391      
   ASSO $ 392-392           FEDPROG $ 393-393        FISL $ 394-394        
   VA $ 395-395             BEOG $ 396-396           FAA $ 397-397         
   FILLE6 $ 398-400         TOTAL1 $ 401-402         AGPROD $ 403-403      
   AGSUPP $ 404-404         AGMECH $ 405-405         AGRIPR $ 406-406      
   ORNA $ 407-407           AGRES $ 408-408          FOREST1 $ 409-409     
   AGRMISC $ 410-410        VETASST $ 411-411        TOTAL $ 412-413       
   ADVERT $ 414-414         APPAREL $ 415-415        AUTO $ 416-416        
   FINCRED $ 417-417        FLORIST $ 418-418        FOODIST $ 419-419     
   FOODSER $ 420-420        GENMERC $ 421-421        HARDWAR $ 422-422     
   HOMEFUR $ 423-423        HOTELMG $ 424-424        INDMARK $ 425-425     
   INSURAN $ 426-426        INTL $ 427-427           PERS $ 428-428        
   PETRO $ 429-429          REALST $ 430-430         RECR $ 431-431        
   TRANSPO $ 432-432        RETAIL $ 433-433         WHSL $ 434-434        
   DISTED $ 435-435         TOTAL2 $ 436-437         DA2 $ 438-438         
   DH2 $ 439-439            DLT2 $ 440-440           DM2 $ 441-441         
   CYTOL $ 442-442          HISTO $ 443-443          MEDLAB $ 444-444      
   HEMAT $ 445-445          MEDBIO $ 446-446         ASSNUR $ 447-447      
   PRACNU $ 448-448         ASSTNU $ 449-449         PSYCH $ 450-450       
   SURG $ 451-451           NURSO $ 452-452          OCCTH $ 453-453       
   PHYTH $ 454-454          REHMI $ 455-455          XRAYT $ 456-456       
   RADTH $ 457-457          NUCLE $ 458-458          XRAYM $ 459-459       
   OPTIC $ 460-460          ENVIR $ 461-461          MENTAL $ 462-462      
   EECTEC $ 463-463         EKGTEC $ 464-464         RESPTH $ 465-465      
   MEDAST1 $ 466-466        HEALAID $ 467-467        MEDER $ 468-468       
   MORTUA $ 469-469         MEDREC1 $ 470-470        PHYSASST $ 471-471    
   HEALMISC $ 472-472       FILLE7 $ 473-477         TOTAL3 $ 478-479      
   CHILDC $ 480-480         CLOTH $ 481-481          FOODMG $ 482-482      
   HOMEFUR2 $ 483-483       INSTMG1 $ 484-484        HOMEECH $ 485-485     
   TOTAL4 $ 486-487         ACCOUNT1 $ 488-488       COMPUT $ 489-489      
   KEYPUN $ 490-490         COMPROG $ 491-491        SYSTAN $ 492-492      
   BUSDATA $ 493-493        GENOFF $ 494-494         INFOCOM $ 495-495     
   MATSUPP $ 496-496        PERSON $ 497-497         SECRET1 $ 498-498     
   SUPADM $ 499-499         TYPIN $ 500-500          OFFMISC $ 501-501     
   FILLE8 $ 502-506         TOTAL5 $ 507-508         AEROTEC $ 509-509     
   AGRITEC $ 510-510        ACHTEC $ 511-511         AUTOTEC $ 512-512     
   CHEMTEC $ 513-513        CIVILTEC $ 514-514       ELECTTEC $ 515-515    
   ELECTRON $ 516-516       ELEMECH1 $ 517-517       ENVIRCNT $ 518-518    
   INDTECH2 $ 519-519       INSTRTEC $ 520-520       MECHTEC $ 521-521     
   METALGY $ 522-522        NUCLETEC $ 523-523       PETROTEC $ 524-524    
   SCIDATA $ 525-525        LEGASST $ 526-526        COMPILOT $ 527-527    
   FIRETECH $ 528-528       FORESTEC $ 529-529       OCEANTEC $ 530-530    
   POLICE1 $ 531-531        TEACHAST $ 532-532       LIBASST $ 533-533     
   BDCSTECH $ 534-534       ARTS $ 535-535           TECEDMIS $ 536-536    
   AIRPOLT $ 537-537        WATERTEC $ 538-538       FILLE88 $ 539-543     
   TOTAL6 $ 544-545         ACREPAIR $ 546-546       APPLIREP $ 547-547    
   AUTOREP $ 548-548        AUTOMECH $ 549-549       AUTOSPEC $ 550-550    
   AUTOSERV $ 551-551       AIRCRM $ 552-552         AIRCRO $ 553-553      
   GROUND $ 554-554         BLUEPR $ 555-555         BUSMECH $ 556-556     
   COMMART $ 557-557        COMFISH $ 558-558        COMPHOT $ 559-559     
   CARPENT $ 560-560        ELECCON $ 561-561        CONSTR1 $ 562-562     
   MASON $ 563-563          PAINT $ 564-564          PLAST $ 565-565       
   PLUMB $ 566-566          DRYWA $ 567-567          GLAZE $ 568-568       
   ROOF $ 569-569           CONST $ 570-570          CUSTO $ 571-571       
   DIESE $ 572-572          DRAFT $ 573-573          ELEOCC $ 574-574      
   RADIO $ 575-575          ELECTRN $ 576-576        FABRIC $ 577-577      
   FOREMA $ 578-578         GRAPH $ 579-579          ATOMIC $ 580-580      
   INSTR $ 581-581          MARITI $ 582-582         MACHSH $ 583-583      
   MACHTO $ 584-584         WELD $ 585-585           TOOL $ 586-586        
   METWORK $ 587-587        METALG $ 588-588         BARB $ 589-589        
   COSME $ 590-590          PERS2 $ 591-591          PLASTI $ 592-592      
   FIREMAN $ 593-593        LAWENF $ 594-594         PUBSERV $ 595-595     
   QUANTFO $ 596-596        REFRIG $ 597-597         ENGINE $ 598-598      
   STAENER $ 599-599        TEXTILE $ 600-600        LEATHER $ 601-601     
   UPHOLST $ 602-602        WOODWOR $ 603-603        TRUCK $ 604-604       
   DOGGROO $ 605-605        TRADEMI $ 606-606        FILLE9 $ 607-611      
   TOTAL8 $ 612-613         DPTECH $ 614-614         KEYPUNCH $ 615-615    
   PROGRAM $ 616-616        PERIPHE $ 617-617        EQUIPMA $ 618-618     
   OTHER1 $ 619-619         FILLE10 $ 620-621        TOTAL9 $ 622-623      
   HEALGEN $ 624-624        DA3 $ 625-625            DH3 $ 626-626         
   DL3 $ 627-627            MEDBIO3 $ 628-628        ANIMAL $ 629-629      
   XRAY2 $ 630-630          NURSRN $ 631-631         NURSPR $ 632-632      
   OCCTHR $ 633-633         SURGICA $ 634-634        OPTIC2 $ 635-635      
   MEDREC2 $ 636-636        MEDAST2 $ 637-637        INHALTH $ 638-638     
   PSYCHIA $ 639-639        ELECDIA $ 640-640        INSTMG2 $ 641-641     
   PHYTHE $ 642-642         OTHER2 $ 643-643         FILLE11 $ 644-646     
   TOTAL10 $ 647-648        MEGEN $ 649-649          AERO2 $ 650-650       
   ENGGRA $ 651-651         ARCHIT $ 652-652         CHEMIC $ 653-653      
   AUTOMO $ 654-654         DIESEL2 $ 655-655        WELD2 $ 656-656       
   CIVIL $ 657-657          ELECTRO $ 658-658        ELEMECH2 $ 659-659    
   INDUST $ 660-660         TEXTIL $ 661-661         INSTRU $ 662-662      
   MECHAN $ 663-663         NUCLEA $ 664-664         CONSTR2 $ 665-665     
   OTHER3 $ 666-666         FILLE12 $ 667-669        TOTAL11 $ 670-671     
   NATSCH $ 672-672         AGRI $ 673-673           FOREST2 $ 674-674     
   FOODSE $ 675-675         HOMEEC $ 676-676         MARINE $ 677-677      
   LABTECH $ 678-678        SANITAT $ 679-679        OTHER4 $ 680-680      
   FILLE13 $ 681-682        TOTAL12 $ 683-684        BUSCOM $ 685-685      
   ACCOUNT2 $ 686-686       BANKFIN $ 687-687        MANAGE $ 688-688      
   SECRET2 $ 689-689        PERSONA $ 690-690        PHOTOGR $ 691-691     
   COMMBRD $ 692-692        PRINT $ 693-693          HOTEL $ 694-694       
   TRANS $ 695-695          ART $ 696-696            OTHER5 $ 697-697      
   FILLE14 $ 698-699        TOTAL13 $ 700-701        PUBSEG $ 702-702      
   RELIG $ 703-703          EDUCA $ 704-704          LIBRAR $ 705-705      
   POLICE2 $ 706-706        SOCIAL $ 707-707         FIRE $ 708-708        
   ADMIN $ 709-709          OTHER6 $ 710-710         FILLE15 $ 711-713     
   PRINTC $ 714-714         ERRORF $ 715-715;                              
                                                                           
* SAS LABEL STATEMENT;                                                     
                                                                           
LABEL                                                                      
   EDSCODE = "STATE CODES (10-64) ASSIGNED BY OFFICE E"                    
   SERNUMB = "UNIQUE NUMBER ASSIGNED TO EACH RECORD"                       
   VENNUMB = "FOR INTERNAL USE ONLY"                                       
   NAME = "NAME OF INSTITUTION"                                            
   FIPS = "IDENTIFIES COUNTY BY FTPS CODE"                                 
   COUNTY = "NAME OF COUNTY INSTITUTION IS LOCATED"                        
   STREET = "STREET ADDRESS"                                               
   CITY = "CITY INSTITUTION IS LOCATED"                                    
   ZIP = "POSTAL ZIP CODE"                                                 
   DISTNO = "NUMERIC IDENT  CONGR DISTRICT"                                
   FOUNDED = "YEAR REPORTING INSTITUTE WAS FOUNDED"                        
   PHONE = "TELPHONE NUM OF INSTIT - (XXX)XXX-XXXX"                        
   CHANC = "INDICATE CHANGE IN OWNERSHIP SINCE 7/1/7"                      
   AFFIL = "TYPE OF AFFILIATION"                                           
   NAME2 = "NAME OF PARENT INSTITUTION"                                    
   CITY2 = "CITY PARENT INSTITUTION IS LOCATED"                            
   EDSTC = "STATE CODE (10-64) ASSIGNED BY NCES"                           
   RESPC = "SURVEY CONTROL RESPONSE CODE OF SCHL FIL"                      
   HEGIS = "WHETHER SCHL COVERED BY NEGIS CONTROL FI"                      
   REGION = "REGION WHERE SCHOOL IS LOCATED"                               
   FORMT = "TYPE OF FORM SENT TO SCHOOL"                                   
   SAMPLE = "WHETHER SCHOOL WAS SAMPLED"                                   
   ADDSTAT = "STATUS OF SCHOOL'S ADDRESS"                                  
   TOTPROG = "TOTAL PROG OFFERED BY THE SCHL"                              
   SIZE = "MEASURE OF SIZE-NCES USE"                                       
   PROBS = "THE PROB OF SELECT FOR THE SCHL-NCES USE"                      
   STRNO = "THE STRATUM NUMBER FOR THE SCHL-NCES USE"                      
   STSIZE = "THE STRATUM SIZE FOR  THE SCHL-NCES USE"                      
   PUBL = "WHETHER SCHL IS IN DIRECTORY-NCES USE"                          
   IDAFF = "ID OF THE SCHL'S AFFILI SCHL,IF KNOWN"                         
   FILLER1 = "BLANK"                                                       
   SCHLC = "SCHOOL TYPE"                                                   
   OTHERID = "IF RECORD POS 261=K, WRITE IN SCHL TYPE"                     
   LFEXCUL = "NCES USE"                                                    
   FTTOT = "TOTAL FULL-TIME ENROLLMENT"                                    
   PTTOT = "TOTAL PART-TIME ENROLLMENT"                                    
   FTPTT = "TOTAL FULL-TIME AND PT ENROLL"                                 
   FTMALE = "TOTAL FULL-TIME MALE ENROLLMENT"                              
   PTMALE = "TOTAL PART-TIME MALE ENROLLMENT"                              
   MALETOT = "TOTAL FULL-TIME AND PT MALE ENROLL"                          
   FTFEMA = "TOTAL FULL-TIME FEMALE ENROLLMENT"                            
   PTFEMA = "TOTAL PART-TIME FEMALE ENROLLMENT"                            
   FEMATOT = "TOTAL FULL-TIME AND PT FEMALE ENROLL"                        
   FILLER2 = "BLANK"                                                       
   AREAVOC = "Y EQUAL AREA VOCATOINAL EDUCATION SCHOOL"                    
   CORRES = "WHETHER SCHL OFFERS CORRES COURSES"                           
   CONTROL = "TYPE OF CONTROL"                                             
   FILLER3 = "BLANK"                                                       
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
   FILLER4 = "BLANK"                                                       
   CLA = "AMA/CME: CERTIFIED LAB ASSIST PROG"                              
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
   FILLER5 = "BLANK"                                                       
   ACCRED = "INSTITUTION HAS REGIONAL ACCRED"                              
   ASSO = "THE REGION THE SCHL IS AWARD ACCRED"                            
   FEDPROG = "WHETHER SCHL OFFER FED SPONSORED PROG"                       
   FISL = "FED INSURED STUDENT LOAN ELIGIBLE"                              
   VA = "VETERAN'S ADMINISTRATION"                                         
   BEOG = "BASIC EDUCATION OPPORT GRANT PROG"                              
   FAA = "FED AVIATION ADMINISTMTION"                                      
   FILLE6 = "BLANK"                                                        
   TOTAL1 = "TOTAL NUMBER OF OFFER IN AGRI"                                
   AGPROD = "AGRI PRODUCT PROG (01.01)"                                    
   AGSUPP = "AGRI SUPPLY AND SERV PROG (01.02)"                            
   AGMECH = "AGRI MECHANICS PROG (01.03)"                                  
   AGRIPR = "AGRI PRODUCTS PROG (01.04)"                                   
   ORNA = "HORTICULTURE PROG (01.05)"                                      
   AGRES = "AGRI RESOURCES PROG (01.06)"                                   
   FOREST1 = "FORESTRY PROG (01.07)"                                       
   AGRMISC = "AGRI, MISC PROG (01.08)"                                     
   VETASST = "VETERINARIAN ASST PROG(01.0299)"                             
   TOTAL = "NUMBER OF OFFER IN DISTR EDUC"                                 
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
   TRANSPO = "TRANSPORTATION SERV PROG(04.19)"                             
   RETAIL = "RETAIL TRADE PROG(04.20)"                                     
   WHSL = "WHOLESALE TRADE PROG(04.31)"                                    
   DISTED = "DISTRIBUTIVE EDUC,PROG(04.99)"                                
   TOTAL2 = "NUMBER OF OFFER IN HEALTH PROG"                               
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
   FILLE7 = "ZERO FILLED"                                                  
   TOTAL3 = "NUMBER OF OFFER IN HOME ECONOMICS"                            
   CHILDC = "CARE, GUIDANCE OF CHILD PROG(09.0201)"                        
   CLOTH = "CLOTHING, PRODUCT AND SERV PROG(09.0202)"                      
   FOODMG = "FOOD MANAGE, PRODUCT PROG(09.0203)"                           
   HOMEFUR2 = "HOME FURNISH, EQUIP, SERV PROG(09.0204)"                    
   INSTMG1 = "INSTITUT, HOME MANAGE SERV PROG(09.0205)"                    
   HOMEECH = "HOME ECONOMICS, MISC PROG(09.0299)"                          
   TOTAL4 = "NUMBER OF OFFICE OCCUP OFFERING"                              
   ACCOUNT1 = "ACCOUNTING/BOOKKEEPING(14.01)"                              
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
   FILLE8 = "ZERO-FILLED"                                                  
   TOTAL5 = "TOTAL NUMBER OF OFFER IN TECH EDUC"                           
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
   AIRPOLT = "AIR POLLUTION TECH PROG (16.0695)"                           
   WATERTEC = "WATER, WASTE WATER TECH PROG"                               
   FILLE88 = "ZERO FILLED"                                                 
   TOTAL6 = "NUMBER OF OFFER FOR TRADE,IND OCCUP"                          
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
   PERS2 = "PERSONAL SERV,TRADE,IND PROG(17.2699)"                         
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
   ACCOUNT2 = "ACCOUNTING TECH PROG(5002)"                                 
   BANKFIN = "BANKING AND FINANCE TECH PROG(5003)"                         
   MANAGE = "MARKET DISTR, BUS,INDUST TECH PROG(5004)"                     
   SECRET2 = "SECRETARIAL TECH PROG(5006)"                                 
   PERSONA = "PERSONAL SERVICE TECH PROG(5006)"                            
   PHOTOGR = "PHOTOGRAPHY TECH PROG(5007)"                                 
   COMMBRD = "COMMUN AND BROADCAST TECH PROG(5008)"                        
   PRINT = "PRINT AND LITHOGRAPHY TECH PROG(5009)"                         
   HOTEL = "HOTEL,RESTAURANT MANAGE TECH PROG(5010)"                       
   TRANS = "TRANSPORT AND PUB UTIL TECH PROG(5011)"                        
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
   FILLE15 = "BLANK"                                                       
   PRINTC = "INDICATE SCHL IS LISTED IN POSTSEC VOC D"                     
   ERRORF = "FOR INTERNAL USE ONLY";                                       
                                                                           
* SAS FORMAT STATEMENT;                                                    
/*                                                                         
FORMAT                                                                     
   CHANC $V13FT.          AFFIL $V14FT.          RESPC V18FT.              
   HEGIS V19FT.           REGION V20FT.          FORMT $V21FT.             
   SAMPLE V22FT.          ADDSTAT V23FT.         PUBL V29FT.               
   SCHLC $V32FT.          AREAVOC $V45FT.        CORRES $V46FT.            
   CONTROL $V47FT.        ACCSTAT $V49FT.        MLT $V50FT.               
   AICS $V51FT.           ANES $V52FT.           DH1 $V53FT.               
   DA1 $V54FT.            DT1 $V55FT.            MLTAMA $V56FT.            
   MRT $V57FT.            MT $V58FT.             PAS $V59FT.               
   HIST $V60FT.           CLA $V62FT.            NMT $V63FT.               
   RTT $V64FT.            RT $V65FT.             CT $V66FT.                
   IT $V67FT.             MA $V68FT.             FSE $V69FT.               
   CAC $V70FT.            ECPD $V71FT.           NAPNES $V72FT.            
   NATTS $V73FT.          NHSC $V74FT.           ADN $V75FT.               
   NUR $V76FT.            PN $V77FT.             ID $V78FT.                
   ANTECH $V79FT.         ACCRED $V81FT.         ASSO $V82FT.              
   FEDPROG $V83FT.        FISL $V84FT.           VA $V85FT.                
   BEOG $V86FT.           FAA $V87FT.            AGPROD $V90FT.            
   AGSUPP $V91FT.         AGMECH $V92FT.         AGRIPR $V93FT.            
   ORNA $V94FT.           AGRES $V95FT.          FOREST1 $V96FT.           
   AGRMISC $V97FT.        VETASST $V98FT.        ADVERT $V100FT.           
   APPAREL $V101FT.       AUTO $V102FT.          FINCRED $V103FT.          
   FLORIST $V104FT.       FOODIST $V105FT.       FOODSER $V106FT.          
   GENMERC $V107FT.       HARDWAR $V108FT.       HOMEFUR $V109FT.          
   HOTELMG $V110FT.       INDMARK $V111FT.       INSURAN $V112FT.          
   INTL $V113FT.          PERS $V114FT.          PETRO $V115FT.            
   REALST $V116FT.        RECR $V117FT.          TRANSPO $V118FT.          
   RETAIL $V119FT.        WHSL $V120FT.          DISTED $V121FT.           
   DA2 $V123FT.           DH2 $V124FT.           DLT2 $V125FT.             
   DM2 $V126FT.           CYTOL $V127FT.         HISTO $V128FT.            
   MEDLAB $V129FT.        HEMAT $V130FT.         MEDBIO $V131FT.           
   ASSNUR $V132FT.        PRACNU $V133FT.        ASSTNU $V134FT.           
   PSYCH $V135FT.         SURG $V136FT.          NURSO $V137FT.            
   OCCTH $V138FT.         PHYTH $V139FT.         REHMI $V140FT.            
   XRAYT $V141FT.         RADTH $V142FT.         NUCLE $V143FT.            
   XRAYM $V144FT.         OPTIC $V145FT.         ENVIR $V146FT.            
   MENTAL $V147FT.        EECTEC $V148FT.        EKGTEC $V149FT.           
   RESPTH $V150FT.        MEDAST1 $V151FT.       HEALAID $V152FT.          
   MEDER $V153FT.         MORTUA $V154FT.        MEDREC1 $V155FT.          
   PHYSASST $V156FT.      HEALMISC $V157FT.      CHILDC $V160FT.           
   CLOTH $V161FT.         FOODMG $V162FT.        HOMEFUR2 $V163FT.         
   INSTMG1 $V164FT.       HOMEECH $V165FT.       ACCOUNT1 $V167FT.         
   COMPUT $V168FT.        KEYPUN $V169FT.        COMPROG $V170FT.          
   SYSTAN $V171FT.        BUSDATA $V172FT.       GENOFF $V173FT.           
   INFOCOM $V174FT.       MATSUPP $V175FT.       PERSON $V176FT.           
   SECRET1 $V177FT.       SUPADM $V178FT.        TYPIN $V179FT.            
   OFFMISC $V180FT.       AEROTEC $V183FT.       AGRITEC $V184FT.          
   ACHTEC $V185FT.        AUTOTEC $V186FT.       CHEMTEC $V187FT.          
   CIVILTEC $V188FT.      ELECTTEC $V189FT.      ELECTRON $V190FT.         
   ELEMECH1 $V191FT.      ENVIRCNT $V192FT.      INDTECH2 $V193FT.         
   INSTRTEC $V194FT.      MECHTEC $V195FT.       METALGY $V196FT.          
   NUCLETEC $V197FT.      PETROTEC $V198FT.      SCIDATA $V199FT.          
   LEGASST $V200FT.       COMPILOT $V201FT.      FIRETECH $V202FT.         
   FORESTEC $V203FT.      OCEANTEC $V204FT.      POLICE1 $V205FT.          
   TEACHAST $V206FT.      LIBASST $V207FT.       BDCSTECH $V208FT.         
   ARTS $V209FT.          TECEDMIS $V210FT.      AIRPOLT $V211FT.          
   WATERTEC $V212FT.      ACREPAIR $V215FT.      APPLIREP $V216FT.         
   AUTOREP $V217FT.       AUTOMECH $V218FT.      AUTOSPEC $V219FT.         
   AUTOSERV $V220FT.      AIRCRM $V221FT.        AIRCRO $V222FT.           
   GROUND $V223FT.        BLUEPR $V224FT.        BUSMECH $V225FT.          
   COMMART $V226FT.       COMFISH $V227FT.       COMPHOT $V228FT.          
   CARPENT $V229FT.       ELECCON $V230FT.       CONSTR1 $V231FT.          
   MASON $V232FT.         PAINT $V233FT.         PLAST $V234FT.            
   PLUMB $V235FT.         DRYWA $V236FT.         GLAZE $V237FT.            
   ROOF $V238FT.          CONST $V239FT.         CUSTO $V240FT.            
   DIESE $V241FT.         DRAFT $V242FT.         ELEOCC $V243FT.           
   RADIO $V244FT.         ELECTRN $V245FT.       FABRIC $V246FT.           
   FOREMA $V247FT.        GRAPH $V248FT.         ATOMIC $V249FT.           
   INSTR $V250FT.         MARITI $V251FT.        MACHSH $V252FT.           
   MACHTO $V253FT.        WELD $V254FT.          TOOL $V255FT.             
   METWORK $V256FT.       METALG $V257FT.        BARB $V258FT.             
   COSME $V259FT.         PERS2 $V260FT.         PLASTI $V261FT.           
   FIREMAN $V262FT.       LAWENF $V263FT.        PUBSERV $V264FT.          
   QUANTFO $V265FT.       REFRIG $V266FT.        ENGINE $V267FT.           
   STAENER $V268FT.       TEXTILE $V269FT.       LEATHER $V270FT.          
   UPHOLST $V271FT.       WOODWOR $V272FT.       TRUCK $V273FT.            
   DOGGROO $V274FT.       TRADEMI $V275FT.       DPTECH $V278FT.           
   KEYPUNCH $V279FT.      PROGRAM $V280FT.       PERIPHE $V281FT.          
   EQUIPMA $V282FT.       HEALGEN $V286FT.       DA3 $V287FT.              
   DH3 $V288FT.           DL3 $V289FT.           MEDBIO3 $V290FT.          
   ANIMAL $V291FT.        XRAY2 $V292FT.         NURSRN $V293FT.           
   NURSPR $V294FT.        OCCTHR $V295FT.        SURGICA $V296FT.          
   OPTIC2 $V297FT.        MEDREC2 $V298FT.       MEDAST2 $V299FT.          
   INHALTH $V300FT.       PSYCHIA $V301FT.       ELECDIA $V302FT.          
   INSTMG2 $V303FT.       PHYTHE $V304FT.        MEGEN $V308FT.            
   AERO2 $V309FT.         ENGGRA $V310FT.        ARCHIT $V311FT.           
   CHEMIC $V312FT.        AUTOMO $V313FT.        DIESEL2 $V314FT.          
   WELD2 $V315FT.         CIVIL $V316FT.         ELECTRO $V317FT.          
   ELEMECH2 $V318FT.      INDUST $V319FT.        TEXTIL $V320FT.           
   INSTRU $V321FT.        MECHAN $V322FT.        NUCLEA $V323FT.           
   CONSTR2 $V324FT.       NATSCH $V328FT.        AGRI $V329FT.             
   FOREST2 $V330FT.       FOODSE $V331FT.        HOMEEC $V332FT.           
   MARINE $V333FT.        LABTECH $V334FT.       SANITAT $V335FT.          
   BUSCOM $V339FT.        ACCOUNT2 $V340FT.      BANKFIN $V341FT.          
   MANAGE $V342FT.        SECRET2 $V343FT.       PERSONA $V344FT.          
   PHOTOGR $V345FT.       COMMBRD $V346FT.       PRINT $V347FT.            
   HOTEL $V348FT.         TRANS $V349FT.         ART $V350FT.              
   PUBSEG $V354FT.        RELIG $V355FT.         EDUCA $V356FT.            
   LIBRAR $V357FT.        POLICE2 $V358FT.       SOCIAL $V359FT.           
   FIRE $V360FT.          ADMIN $V361FT.         PRINTC $V364FT.;          
                                                                           
