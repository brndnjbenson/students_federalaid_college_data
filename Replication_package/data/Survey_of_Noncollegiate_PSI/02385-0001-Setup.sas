/*           SAS DATA DEFINITION STATEMENTS FOR ICPSR 2385                    
                     Program and Enrollments File:                            
               Postsecondary Career School Survey, 1981                       
                          [United States]                                     
                         1ST ICPSR VERSION                                    
                            June, 2004                                        
                                                                              
 DATA: begins a SAS data step and names an output SAS data set.               
                                                                              
 INFILE: identifies the input file to be read with the input                  
 statement. Users must replace the "physical-filename" with host              
 computer specific input file specifications.                                 
                                                                              
 INPUT: assigns the name, type, decimal specification (if any), and           
 specifies the beginning and ending column locations for each variable        
 in the data file.                                                            
                                                                              
 LABEL: assigns descriptive labels to all variables. Variable labels          
 and variable names may be identical for some variables.                      
                                                                              
 FORMAT: associates the formats created by the PROC FORMAT step with          
 the variables named in the INPUT statement.                                  
                                                                              
 These data definition statements have been tested for compatability          
 with SAS Release 8.2 for UNIX and/or SAS Release 8.02 for                    
 Windows. */                                                                  
                                                                              
PROC FORMAT;                                                                  
                                                                              
 Value SEGNU                                                                  
        1  ="Segment 1 var on card image"                                     
        2  ="Segment 2 var on card image"                                     
        ;                                                                     
                                                                              
 Value V3F                                                                    
        1  ="Short Form"                                                      
        2  ="Long Form"                                                       
        3  ="Correspondence Form"                                             
        ;                                                                     
                                                                              
 Value V10F                                                                   
        1  ="Short Form"                                                      
        2  ="Long Form"                                                       
        3  ="Correspondence Form"                                             
        ;                                                                     
                                                                              
 Value V13F                                                                   
        1  ="Eligible"                                                        
        2  ="Ineligible"                                                      
        ;                                                                     
                                                                              
 Value V14F                                                                   
        1  ="Correspondence only"                                             
        2  ="Mixture"                                                         
        3  ="Noncorrespondence only"                                          
        ;                                                                     
                                                                              
 Value V15F                                                                   
        1  ="Public"                                                          
        2  ="Private/for profit"                                              
        3  ="Private/nonprofit"                                               
        ;                                                                     
                                                                              
 Value V17F                                                                   
        1  ="Not affiliated"                                                  
        2  ="Branch"                                                          
        3  ="Part of Chain"                                                   
        4  ="Parent/home office chain"                                        
        5  ="Hospital School"                                                 
        6  ="Other"                                                           
        ;                                                                     
                                                                              
 Value V25F                                                                   
        1   ="Short Form"                                                     
        2   ="Long Form"                                                      
        3   ="Correspondence Form"                                            
        ;                                                                     
                                                                              
 Value V28F                                                                   
        1  ="Eligible"                                                        
        2  ="Ineligible"                                                      
        ;                                                                     
                                                                              
 Value  V29F                                                                  
        1   ="Correspondence only"                                            
        2   ="Mixture"                                                        
        3   ="Noncorrespondence only"                                         
        ;                                                                     
                                                                              
 Value V30F                                                                   
        1   ="Public"                                                         
        2   ="Private/for profit"                                             
        3   ="Private/nonprofit"                                              
        ;                                                                     
                                                                              
 Value V32F                                                                   
        1  ="Not affiliated"                                                  
        2  ="Branch"                                                          
        3  ="Part of Chain"                                                   
        4  ="Parent/home office of chain"                                     
        5  ="Hospital School"                                                 
        6  ="Other"                                                           
        ;                                                                     
                                                                              
 Value V40F                                                                   
        1   ="Short Form"                                                     
        2   ="Long Form"                                                      
        3   ="Correspondence Form"                                            
        ;                                                                     
                                                                              
 Value V44F                                                                   
        101  ="Agricultural Production"                                       
        102  ="Agricultural supplies and serv"                                
        103  ="Agricultural mechanics"                                        
        104  ="Agri products"                                                 
        105  ="Horticulture"                                                  
        106  ="Agricultural Resources"                                        
        107  ="Forestry"                                                      
        108  ="Animal Caretaker"                                              
        201  ="Advertising Services"                                          
        202  ="Apparel and Accessories"                                       
        203  ="Automotive Sales"                                              
        204  ="Banking"                                                       
        205  ="Floristry"                                                     
        206  ="Food Distribution"                                             
        207  ="Food Services Technologies"                                    
        208  ="Merchandising, General "                                       
        209  ="Hardware, Building Materials"                                  
        210  ="Home Furnish Manage and Sales"                                 
        211  ="Hotel and Lodging Management"                                  
        212  ="Industrial Marketing"                                          
        213  ="Insurance Managing and Selling"                                
        214  ="International Trade"                                           
        215  ="Personal Services"                                             
        216  ="Petroleum Products"                                            
        217  ="Real Estate Managing and Selling"                              
        218  ="Recreation and Tourism"                                        
        219  ="Transportation Services"                                       
        220  ="Retail Trade"                                                  
        221  ="Wholesale Trade"                                               
        222  ="Distribut Education, misce"                                    
        223  ="Entertainment Services"                                        
        301  ="Dental Assistant"                                              
        302  ="Dental Hygiene (associate degree)"                             
        303  ="Dental Laboratory Technology"                                  
        304  ="Dental Technologies, misce"                                    
        305  ="Cytology (Cyiotechnology)"                                     
        306  ="Histology program"                                             
        307  ="Medical Lab Assistant"                                         
        308  ="Hematology"                                                    
        309  ="Medical Lab Technology, NEC"                                   
        310  ="Nursing (Associate degree)"                                    
        311  ="Nursing, practical (vocational)"                               
        312  ="Nursing Assistant (Aide)"                                      
        313  ="Psychiatric Aid"                                               
        314  ="Operating Room Technician"                                     
        315  ="Nursing Diploma (3-yrs)"                                       
        316  ="Occupational Therapy"                                          
        318  ="Rehabilitation Services"                                       
        319  ="Radiologic Technology (X-Ray)"                                 
        320  ="Radiation Therapy"                                             
        321  ="Nuclear Medical Technology"                                    
        322  ="Radiologic Occupations"                                        
        323  ="Ophthalmic Occupations"                                        
        324  ="Environmental Health Technologies"                             
        325  ="Counselor Mental Health"                                       
        326  ="Electroencephalograph Technology"                              
        327  ="Electrocardiograph Technology"                                 
        328  ="Respiratory Therapy"                                           
        329  ="Medical Assistant Physician Office"                            
        330  ="Community Health Aide"                                         
        331  ="Medical Emergency Technician"                                  
        332  ="Funeral Service Education"                                     
        333  ="Medical Record Technician"                                     
        334  ="Physician's Assistant"                                         
        335  ="Health Occupations, NEC"                                       
        336  ="Veterinary Assistant"                                          
        401  ="Care and Guidance of Children prog"                            
        402  ="Clothing Manage Production and Serv"                           
        403  ="Dietician"                                                     
        404  ="Home Furnishing"                                               
        405  ="Institutional and Home Manage Serv"                            
        406  ="Home Economics, misce programs"                                
        409  ="Tailoring"                                                     
        501  ="Accounting/Bookkeeping"                                        
        502  ="Computer Operator"                                             
        503  ="Peripheral Equipment Operator"                                 
        504  ="Computer Programmer"                                           
        505  ="System Analyst"                                                
        506  ="Data Processing, NEC"                                          
        507  ="Clerk"                                                         
        508  ="Information Communication"                                     
        509  ="Materials Support Occupations"                                 
        510  ="Personnel, Training"                                           
        511  ="Secretarial Occupation"                                        
        512  ="Administrative Management"                                     
        513  ="Typing"                                                        
        514  ="Office Occupation"                                             
        601  ="Aeronautical Technologies"                                     
        602  ="Agricultural Technologies"                                     
        603  ="Architectural Technologies"                                    
        604  ="Automotive Technologies"                                       
        605  ="Chemical Technologies"                                         
        606  ="Civil Technologies"                                            
        607  ="Electrical Technologies"                                       
        608  ="Electronics and Machine Techn"                                 
        609  ="Electromechanical Technologies"                                
        610  ="Environmental Control Technologies"                            
        611  ="Industrial Technologies"                                       
        612  ="Instrumentation Technologies"                                  
        613  ="Mechanical and Engineering Techn"                              
        614  ="Metallurgical Technologies"                                    
        615  ="Nuclear Technologies"                                          
        616  ="Petroleum Technologies"                                        
        617  ="Scientific Data Processing Techn"                              
        618  ="Food Processing Technology"                                    
        619  ="Pilot Training"                                                
        620  ="Fire and Fire Safety Technologies"                             
        621  ="Forestry and Wildlife Technologies"                            
        622  ="Oceanographic Technologies"                                    
        623  ="Police Science Technologies"                                   
        624  ="Education Technologies"                                        
        625  ="Library Assistant"                                             
        626  ="Communication Technologies"                                    
        627  ="Performing Artists"                                            
        628  ="Technical Ed. Misc"                                            
        701  ="Air Condition Installation and Repair"                         
        702  ="Appliance Repair"                                              
        703  ="Automotive Body and Fender Repair"                             
        704  ="Automotive Mechanics"                                          
        705  ="Automotive Specialization Repair"                              
        706  ="Automotive Services Other"                                     
        707  ="Aircraft Maintenance"                                          
        708  ="Aircraft Operations"                                           
        709  ="Airt Traffic Control"                                          
        710  ="Blueprint Reading"                                             
        711  ="Business Machines Mainten Occup"                               
        712  ="Commercial Art"                                                
        713  ="Fishing, commercial"                                           
        714  ="Photography"                                                   
        715  ="Carpentry-Construction"                                        
        716  ="Electricity-Construction"                                      
        717  ="Construction Equipment Maint & Operat"                         
        718  ="Masonry-Construction"                                          
        719  ="Painting and Decorating-Construction"                          
        720  ="Plastering-Construction"                                       
        721  ="Plumbing and Pipefitting-Construction"                         
        722  ="Drywall Installation-Construction"                             
        723  ="Glazing-Construction"                                          
        724  ="Roofing-Construction"                                          
        725  ="Construction and Building Techn Other"                         
        726  ="Custodial Services"                                            
        727  ="Diesel Mechanic"                                               
        728  ="Drafting Occupations"                                          
        729  ="Electrical Occupations"                                        
        730  ="Radio/TV Repair"                                               
        731  ="Electronic Occup Excl. Radio/TV repair"                        
        732  ="Fabric Maintenance Services"                                   
        733  ="Foreman Supervisor and Manage Develop"                         
        734  ="Graphic Arts Occupations"                                      
        735  ="Industrial Atomic Energy Occupations"                          
        736  ="Instrument Mainten and Repairs Occup"                          
        737  ="Maritime Occupations program"                                  
        738  ="Machine Shop Occupation"                                       
        739  ="Machine Tool Operator"                                         
        740  ="Welding and Cutting"                                           
        741  ="Tool and Diemaking"                                            
        742  ="Metalworking Occupations, NEC"                                 
        743  ="Metallurgical Occupation"                                      
        744  ="Barbering"                                                     
        745  ="Cosmetology"                                                   
        746  ="Personal Services Other"                                       
        747  ="Plastics Occupations"                                          
        748  ="Fireman Training"                                              
        749  ="Law Enforcement Training"                                      
        750  ="Public Service Occupations"                                    
        751  ="Quantity Food Occupations"                                     
        752  ="Refrigeration"                                                 
        753  ="Small Engine Repair (Internal Combust"                         
        754  ="Boiler Room Technology"                                        
        755  ="Textile Production and Fabrication"                            
        756  ="Shoe Manufacture and Repair"                                   
        757  ="Upholstering"                                                  
        758  ="Woodworking"                                                   
        759  ="Truck/Trailer Driving"                                         
        760  ="Dog Grooming"                                                  
        761  ="Miscellaneous"                                                 
        999  ="Unknown"                                                       
        ;                                                                     
                                                                              
 Value V53F                                                                   
        0  ="No Imputation"                                                   
        1  ="Zero based on 0 total"                                           
        2  ="Amount computed by subtraction"                                  
        3  ="Imput based on 1979 data for same schl"                          
        4  ="Imput based 1981 data from compar schl"                          
        5  ="Imput based 1981 data form compar schl"                          
        6  ="Imput based  ranking procedure"                                  
        7  ="Imput based ranking procedure"                                   
        ;                                                                     
                                                                              
 Value V54F                                                                   
        0  ="No Imputation"                                                   
        1  ="Zero based on 0 total"                                           
        2  ="Amount computed by subtraction"                                  
        3  ="Imput based on 1979 data for same schl"                          
        4  ="Imput based 1981 data from compar schl"                          
        5  ="Imput based 1981 data form compar schl"                          
        6  ="Imput based ranking procedure"                                   
        7  ="Imput based ranking procedure"                                   
        ;                                                                     
                                                                              
 Value V55F                                                                   
        0  ="No Imputation"                                                   
        1  ="Zero based on 0 total"                                           
        2  ="Amount computed by subtraction"                                  
        3  ="Imput based on 1979 data for same schl"                          
        4  ="Imput based 1981 data from compar schl"                          
        5  ="Imput based 1981 data form compar schl"                          
        6  ="Imput based ranking procedure"                                   
        7  ="Imput based ranking procedure"                                   
        ;                                                                     
                                                                              
 Value V56F                                                                   
        0  ="No Imputation"                                                   
        1  ="Zero based on 0 total"                                           
        2  ="Amount computed by subtraction"                                  
        3  ="Imput based on 1979 data for same schl"                          
        4  ="Imput based 1981 data from compar schl"                          
        5  ="Imput based 1981 data form compar schl"                          
        6  ="Imput based ranking procedure"                                   
        7  ="Imput based ranking procedure"                                   
        ;                                                                     
                                                                              
 Value V57F                                                                   
        0  ="No Imputation"                                                   
        1  ="Zero based on 0 total"                                           
        2  ="Amount computed by subtraction"                                  
        3  ="Imput based on 1979 data for same schl"                          
        4  ="Imput based 1981 data from compar schl"                          
        5  ="Imput based 1981 data from compar schl"                          
        6  ="Imput based ranking procedure"                                   
        7  ="Imput based ranking procedure"                                   
        ;                                                                     
                                                                              
 Value V58F                                                                   
        0 ="No Imputation"                                                    
        1 ="Zero based on 0 total"                                            
        2 ="Amount computed by subtraction"                                   
        3 ="Imput based on 1979 data for same schl"                           
        4 ="Imput based 1981 data from compar schl"                           
        5 ="Imput based 1981 data from compar schl"                           
        6 ="Imput based ranking procedure"                                    
        7 ="Imput based ranking procedure"                                    
        ;                                                                     
                                                                              
 Value V59F                                                                   
        0  ="No Imputation"                                                   
        1  ="Zero based on 0 total"                                           
        2  ="Amount computed by subtraction"                                  
        3  ="Imput based on 1979 data for same schl"                          
        4  ="Imput based 1981 data from compar schl"                          
        5  ="Imput based 1981 data from compar schl"                          
        6  ="Imput based ranking procedure"                                   
        7  ="Imput based ranking procedure"                                   
        ;                                                                     
                                                                              
 Value V60F                                                                   
        0  ="No Imputation"                                                   
        1  ="Zero based on 0 total"                                           
        2  ="Amount computed by subtraction"                                  
        3  ="Imput based on 1979 data for same schl"                          
        4  ="Imput based 1981 data from compar schl"                          
        5  ="Imput based 1981 data from compar schl"                          
        6  ="Imput based ranking procedure"                                   
        7  ="Imput based ranking procedure"                                   
        ;                                                                     
                                                                              
  Value V67F                                                                  
        101  ="Agricultural Production"                                       
        102  ="Agricultural supplies and serv"                                
        103  ="Agricultural mechanics"                                        
        104  ="Agri products"                                                 
        105  ="Horticulture"                                                  
        106  ="Agricultural Resources"                                        
        107  ="Forestry"                                                      
        108  ="Animal Caretaker"                                              
        201  ="Advertising Services"                                          
        202  ="Apparel and Accessories"                                       
        203  ="Automotive Sales"                                              
        204  ="Banking"                                                       
        205  ="Floristry"                                                     
        206  ="Food Distribution"                                             
        207  ="Food Services Technologies"                                    
        208  ="Merchandising, General "                                       
        209  ="Hardware, Building Materials"                                  
        210  ="Home Furnish Manage and Sales"                                 
        211  ="Hotel and Lodging Management"                                  
        212  ="Industrial Marketing"                                          
        213  ="Insurance Managing and Selling"                                
        214  ="International Trade"                                           
        215  ="Personal Services"                                             
        216  ="Petroleum Products"                                            
        217  ="Real Estate Managing and Selling"                              
        218  ="Recreation and Tourism"                                        
        219  ="Transportation Services"                                       
        220  ="Retail Trade"                                                  
        221  ="Wholesale Trade"                                               
        222  ="Distribut Education, misce"                                    
        223  ="Entertainment Services"                                        
        301  ="Dental Assistant"                                              
        302  ="Dental Hygiene (associate degree)"                             
        303  ="Dental Laboratory Technology"                                  
        304  ="Dental Technologies, misce"                                    
        305  ="Cytology (Cyiotechnology)"                                     
        306  ="Histology program"                                             
        307  ="Medical Lab Assistant"                                         
        308  ="Hematology"                                                    
        309  ="Medical Lab Technology, NEC"                                   
        310  ="Nursing (Associate degree)"                                    
        311  ="Nursing, practical (vocational)"                               
        312  ="Nursing Assistant (Aide)"                                      
        313  ="Psychiatric Aide"                                              
        314  ="Operating Room Technician"                                     
        315  ="Nursing Diploma (3-yrs)"                                       
        316  ="Occupational Therapy"                                          
        318  ="Rehabilitation Services"                                       
        319  ="Radiologic Technology (X-Ray)"                                 
        320  ="Radiation Therapy"                                             
        321  ="Nuclear Medical Technology"                                    
        322  ="Radiologic Occupations"                                        
        323  ="Ophthalmic Occupations"                                        
        324  ="Environmental Health Technologies"                             
        325  ="Counselor Mental Health"                                       
        326  ="Electroencephalograph Technology"                              
        327  ="Electrocardiograph Technology"                                 
        328  ="Respiratory Therapy"                                           
        329  ="Medical Assistant Physician Office"                            
        330  ="Community Health Aide"                                         
        331  ="Medical Emergency Technician"                                  
        332  ="Funeral Service Education"                                     
        333  ="Medical Record Technician"                                     
        334  ="Physician's Assistant"                                         
        335  ="Health Occupations, NEC"                                       
        336  ="Veterinary Assistant"                                          
        401  ="Care and Guidance of Children prog"                            
        402  ="Clothing Manage Production and Serv"                           
        403  ="Dietician"                                                     
        404  ="Home Furnishing"                                               
        405  ="Institutional and Home Manage Serv"                            
        406  ="Home Economics, misce programs"                                
        409  ="Tailoring"                                                     
        501  ="Accounting/Bookkeeping"                                        
        502  ="Computer Operator"                                             
        503  ="Peripheral Equipment Operator"                                 
        504  ="Computer Programmer"                                           
        505  ="System Analyst"                                                
        506  ="Data Processing, NEC"                                          
        507  ="Clerk"                                                         
        508  ="Information Communication"                                     
        509  ="Materials Support Occupations"                                 
        510  ="Personnel, Training"                                           
        511  ="Secretarial Occupation"                                        
        512  ="Administrative Management"                                     
        513  ="Typing"                                                        
        514  ="Office Occupation"                                             
        601  ="Aeronautical Technologies"                                     
        602  ="Agricultural Technologies"                                     
        603  ="Architectural Technologies"                                    
        604  ="Automotive Technologies"                                       
        605  ="Chemical Technologies"                                         
        606  ="Civil Technologies"                                            
        607  ="Electrical Technologies"                                       
        608  ="Electronics and Machine Techn"                                 
        609  ="Electromechanical Technologies"                                
        610  ="Environmental Control Technologies"                            
        611  ="Industrial Technologies"                                       
        612  ="Instrumentation Technologies"                                  
        613  ="Mechanical and Engineering Techn"                              
        614  ="Metallurgical Technologies"                                    
        615  ="Nuclear Technologies"                                          
        616  ="Petroleum Technologies"                                        
        617  ="Scientific Data Processing Techn"                              
        618  ="Food Processing Technology"                                    
        619  ="Pilot Training"                                                
        620  ="Fire and Fire Safety Technologies"                             
        621  ="Forestry and Wildlife Technologies"                            
        622  ="Oceanographic Technologies"                                    
        623  ="Police Science Technologies"                                   
        624  ="Education Technologies"                                        
        625  ="Library Assistant"                                             
        626  ="Communication Technologies"                                    
        627  ="Performing Artists"                                            
        628  ="Technical Ed. Misc"                                            
        701  ="Air Condition Installation and Repair"                         
        702  ="Appliance Repair"                                              
        703  ="Automotive Body and Fender Repair"                             
        704  ="Automotive Mechanics"                                          
        705  ="Automotive Specialization Repair"                              
        706  ="Automotive Services Other"                                     
        707  ="Aircraft Maintenance"                                          
        708  ="Aircraft Operations"                                           
        709  ="Airt Traffic Control"                                          
        710  ="Blueprint Reading"                                             
        711  ="Business Machines Mainten Occup"                               
        712  ="Commercial Art"                                                
        713  ="Fishing, commercial"                                           
        714  ="Photography"                                                   
        715  ="Carpentry-Construction"                                        
        716  ="Electricity-Construction"                                      
        717  ="Construction Equipment Maint & Operat"                         
        718  ="Masonry-Construction"                                          
        719  ="Painting and Decorating-Construction"                          
        720  ="Plastering-Construction"                                       
        721  ="Plumbing and Pipefitting-Construction"                         
        722  ="Drywall Installation-Construction"                             
        723  ="Glazing-Construction"                                          
        724  ="Roofing-Construction"                                          
        725  ="Construction and Building Techn Other"                         
        726  ="Custodial Services"                                            
        727  ="Diesel Mechanic"                                               
        728  ="Drafting Occupations"                                          
        729  ="Electrical Occupations"                                        
        730  ="Radio/TV Repair"                                               
        731  ="Electronic Occup Excl. Radio/TV repair"                        
        732  ="Fabric Maintenance Services"                                   
        733  ="Foreman Supervisor and Manage Develop"                         
        734  ="Graphic Arts Occupations"                                      
        735  ="Industrial Atomic Energy Occupations"                          
        736  ="Instrument Mainten and Repairs Occup"                          
        737  ="Maritime Occupations program"                                  
        738  ="Machine Shop Occupation"                                       
        739  ="Machine Tool Operator"                                         
        740  ="Welding and Cutting"                                           
        741  ="Tool and Diemaking"                                            
        742  ="Metalworking Occupations, NEC"                                 
        743  ="Metallurgical Occupation"                                      
        744  ="Barbering"                                                     
        745  ="Cosmetology"                                                   
        746  ="Personal Services Other"                                       
        747  ="Plastics Occupations"                                          
        748  ="Fireman Training"                                              
        749  ="Law Enforcement Training"                                      
        750  ="Public Service Occupations"                                    
        751  ="Quantity Food Occupations"                                     
        752  ="Refrigeration"                                                 
        753  ="Small Engine Repair (Internal Combust"                         
        754  ="Boiler Room Technology"                                        
        755  ="Textile Production and Fabrication"                            
        756  ="Shoe Manufacture and Repair"                                   
        757  ="Upholstering"                                                  
        758  ="Woodworking"                                                   
        759  ="Truck/Trailer Driving"                                         
        760  ="Dog Grooming"                                                  
        761  ="Miscellaneous"                                                 
        999  ="Unknown"                                                       
         ;                                                                    
                                                                              
 Value V80F                                                                   
        0  ="No Imputation"                                                   
        1  ="Zero based on 0 total"                                           
        2  ="Amount computed by subtraction"                                  
        3  ="Imput based on 1979 data for same schl"                          
        4  ="Imput based 1981 data from compar schl"                          
        5  ="Imput based 1981 data form compar schl"                          
        6  ="Imput based ranking procedure"                                   
        7  ="Imput based ranking procedure"                                   
        ;                                                                     
                                                                              
 Value V81F                                                                   
        0  ="No Imputation"                                                   
        1  ="Zero based on 0 total"                                           
        2  ="Amount computed by subtraction"                                  
        3  ="Imput based on 1979 data for same schl"                          
        4  ="Imput based 1981 data from compar schl"                          
        5  ="Imput based 1981 data form compar schl"                          
        6  ="Imput based ranking procedure"                                   
        7  ="Imput based ranking procedure"                                   
        ;                                                                     
                                                                              
 Value V82F                                                                   
        0  ="No Imputation"                                                   
        1  ="Zero based on 0 total"                                           
        2  ="Amount computed by subtraction"                                  
        3  ="Imput based on 1979 data for same schl"                          
        4  ="Imput based 1981 data from compar schl"                          
        5  ="Imput based 1981 data form compar schl"                          
        6  ="Imput based ranking procedure"                                   
        7  ="Imput based ranking procedure"                                   
        ;                                                                     
                                                                              
 Value V83F                                                                   
        0  ="No Imputation"                                                   
        1  ="Zero based on 0 total"                                           
        2  ="Amount computed by subtraction"                                  
        3  ="Imput based on 1979 data for same schl"                          
        4  ="Imput based 1981 data from compar schl"                          
        5  ="Imput based 1981 data form compar schl"                          
        6  ="Imput based ranking procedure"                                   
        7  ="Imput based ranking procedure"                                   
        ;                                                                     
                                                                              
 Value V84F                                                                   
        0  ="No Imputation"                                                   
        1  ="Zero based on 0 total"                                           
        2  ="Amount computed by subtraction"                                  
        3  ="Imput based on 1979 data for same schl"                          
        4  ="Imput based 1981 data from compar schl"                          
        5  ="Imput based 1981 data form compar schl"                          
        6  ="Imput based ranking procedure"                                   
        7  ="Imput based ranking procedure"                                   
        ;                                                                     
                                                                              
 Value V85F                                                                   
        0  ="No Imputation"                                                   
        1  ="Zero based on 0 total"                                           
        2  ="Amount computed by subtraction"                                  
        3  ="Imput based on 1979 data for same schl"                          
        4  ="Imput based 1981 data from compar schl"                          
        5  ="Imput based 1981 data form compar schl"                          
        6  ="Imput based ranking procedure"                                   
        7  ="Imput based ranking procedure"                                   
        ;                                                                     
                                                                              
 Value V86F                                                                   
        0  ="No Imputation"                                                   
        1  ="Zero based on 0 total"                                           
        2  ="Amount computed by subtraction"                                  
        3  ="Imput based on 1979 data for same schl"                          
        4  ="Imput based 1981 data from compar schl"                          
        5  ="Imput based 1981 data form compar schl"                          
        6  ="Imput based ranking procedure"                                   
        7  ="Imput based ranking procedure"                                   
        ;                                                                     
                                                                              
 Value V87F                                                                   
        0  ="No Imputation"                                                   
        1  ="Zero based on 0 total"                                           
        2  ="Amount computed by subtraction"                                  
        3  ="Imput based on 1979 data for same schl"                          
        4  ="Imput based 1981 data from compar schl"                          
        5  ="Imput based 1981 data form compar schl"                          
        6  ="Imput based ranking procedure"                                   
        7  ="Imput based ranking procedure"                                   
        ;                                                                     
                                                                              
 Value V88F                                                                   
        0  ="No Imputation"                                                   
        1  ="Zero based on 0 total"                                           
        2  ="Amount computed by subtraction"                                  
        3  ="Imput based on 1979 data for same schl"                          
        4  ="Imput based 1981 data from compar schl"                          
        5  ="Imput based 1981 data form compar schl"                          
        6  ="Imput based ranking procedure"                                   
        7  ="Imput based ranking procedure"                                   
        ;                                                                     
                                                                              
 Value V91F                                                                   
        1  ="Short Form"                                                      
        2  ="Long Form"                                                       
        3  ="Correspondence Form"                                             
        ;                                                                     
                                                                              
 Value V94F                                                                   
        1  ="Segment 1"                                                       
        2  ="Segment 2"                                                       
        ;                                                                     
                                                                              
 Value V107F                                                                  
        0  ="No Imputation"                                                   
        1  ="Zero based on 0 total"                                           
        2  ="Amount computed by subtraction"                                  
        3  ="Imput based on 1979 data for same schl"                          
        4  ="Imput based 1981 data from compar schl"                          
        5  ="Imput based 1981 data form compar schl"                          
        6  ="Imput based ranking procedure"                                   
        7  ="Imput based ranking procedure"                                   
        ;                                                                     
                                                                              
 Value V108F                                                                  
        0  ="No Imputation"                                                   
        1  ="Zero based on 0 total"                                           
        2  ="Amount computed by subtraction"                                  
        3  ="Imput based on 1979 data for same schl"                          
        4  ="Imput based 1981 data from compar schl"                          
        5  ="Imput based 1981 data form compar schl"                          
        6  ="Imput based ranking procedure"                                   
        7  ="Imput based ranking procedure"                                   
        ;                                                                     
                                                                              
 Value V109F                                                                  
        0  ="No Imputation"                                                   
        1  ="Zero based on 0 total"                                           
        2  ="Amount computed by subtraction"                                  
        3  ="Imput based on 1979 data for same schl"                          
        4  ="Imput based 1981 data from compar schl"                          
        5  ="Imput based 1981 data form compar schl"                          
        6  ="Imput based ranking procedure"                                   
        7  ="Imput based ranking procedure"                                   
        ;                                                                     
                                                                              
 Value V110F                                                                  
        0  ="No Imputation"                                                   
        1  ="Zero based on 0 total"                                           
        2  ="Amount computed by subtraction"                                  
        3  ="Imput based on 1979 data for same schl"                          
        4  ="Imput based 1981 data from compar schl"                          
        5  ="Imput based 1981 data form compar schl"                          
        6  ="Imput based ranking procedure"                                   
        7  ="Imput based ranking procedure"                                   
        ;                                                                     
                                                                              
 Value V111F                                                                  
        0  ="No Imputation"                                                   
        1  ="Zero based on 0 total"                                           
        2  ="Amount computed by subtraction"                                  
        3  ="Imput based on 1979 data for same schl"                          
        4  ="Imput based 1981 data from compar schl"                          
        5  ="Imput based 1981 data form compar schl"                          
        6  ="Imput based ranking procedure"                                   
        7  ="Imput based ranking procedure"                                   
        ;                                                                     
                                                                              
 Value V112F                                                                  
        0  ="No Imputation"                                                   
        1  ="Zero based on 0 total"                                           
        2  ="Amount computed by subtraction"                                  
        3  ="Imput based on 1979 data for same schl"                          
        4  ="Imput based 1981 data from compar schl"                          
        5  ="Imput based 1981 data form compar schl"                          
        6  ="Imput based ranking procedure"                                   
        7  ="Imput based ranking procedure"                                   
        ;                                                                     
                                                                              
 Value V113F                                                                  
        0  ="No Imputation"                                                   
        1  ="Zero based on 0 total"                                           
        2  ="Amount computed by subtraction"                                  
        3  ="Imput based on 1979 data for same schl"                          
        4  ="Imput based 1981 data from compar schl"                          
        5  ="Imput based 1981 data form compar schl"                          
        6  ="Imput based ranking procedure"                                   
        7  ="Imput based ranking procedure"                                   
        ;                                                                     
                                                                              
 Value V114F                                                                  
        0  ="No Imputation"                                                   
        1  ="Zero based on 0 total"                                           
        2  ="Amount computed by subtraction"                                  
        3  ="Imput based on 1979 data for same schl"                          
        4  ="Imput based 1981 data from compar schl"                          
        5  ="Imput based 1981 data form compar schl"                          
        6  ="Imput based ranking procedure"                                   
        7  ="Imput based ranking procedure"                                   
        ;                                                                     
                                                                              
 Value V115F                                                                  
        0  ="No Imputation"                                                   
        1  ="Zero based on 0 total"                                           
        2  ="Amount computed by subtraction"                                  
        3  ="Imput based on 1979 data for same schl"                          
        4  ="Imput based 1981 data from compar schl"                          
        5  ="Imput based 1981 data form compar schl"                          
        6  ="Imput based ranking procedure"                                   
        7  ="Imput based ranking procedure"                                   
        ;                                                                     
                                                                              
 Value V116F                                                                  
        0  ="No Imputation"                                                   
        1  ="Zero based on 0 total"                                           
        2  ="Amount computed by subtraction"                                  
        3  ="Imput based on 1979 data for same schl"                          
        4  ="Imput based 1981 data from compar schl"                          
        5  ="Imput based 1981 data form compar schl"                          
        6  ="Imput based ranking procedure"                                   
        7  ="Imput based ranking procedure"                                   
        ;                                                                     
                                                                              
 Value V117F                                                                  
        0  ="No Imputation"                                                   
        1  ="Zero based on 0 total"                                           
        2  ="Amount computed by subtraction"                                  
        3  ="Imput based on 1979 data for same schl"                          
        4  ="Imput based 1981 data from compar schl"                          
        5  ="Imput based 1981 data form compar schl"                          
        6  ="Imput based ranking procedure"                                   
        7  ="Imput based ranking procedure"                                   
        ;                                                                     
                                                                              
 Value V118F                                                                  
        0  ="No Imputation"                                                   
        1  ="Zero based on 0 total"                                           
        2  ="Amount computed by subtraction"                                  
        3  ="Imput based on 1979 data for same schl"                          
        4  ="Imput based 1981 data from compar schl"                          
        5  ="Imput based 1981 data form compar schl"                          
        6  ="Imput based ranking procedure"                                   
        7  ="Imput based ranking procedure"                                   
        ;                                                                     
                                                                              
 Value V121F                                                                  
        1  ="Short Form"                                                      
        2  ="Long Form"                                                       
        3  ="Correspondence Form"                                             
        ;                                                                     
                                                                              
 Value V138F                                                                  
        1  ="Short Form"                                                      
        2  ="Long Form"                                                       
        3  ="Correspondence Form"                                             
        ;                                                                     
                                                                              
 Value V156F                                                                  
        1  ="Short Form"                                                      
        2  ="Long Form"                                                       
        3  ="Correspondence Form"                                             
        ;                                                                     
                                                                              
 Value V160F                                                                  
        101  ="Agricultural Production"                                       
        102  ="Agricultural supplies and serv"                                
        103  ="Agricultural mechanics"                                        
        104  ="Agri products"                                                 
        105  ="Horticulture"                                                  
        106  ="Agricultural Resources"                                        
        107  ="Forestry"                                                      
        108  ="Animal Caretaker"                                              
        201  ="Advertising Services"                                          
        202  ="Apparel and Accessories"                                       
        203  ="Automotive Sales"                                              
        204  ="Banking"                                                       
        205  ="Floristry"                                                     
        206  ="Food Distribution"                                             
        207  ="Food Services Technologies"                                    
        208  ="Merchandising, General "                                       
        209  ="Hardware, Building Materials"                                  
        210  ="Home Furnish Manage and Sales"                                 
        211  ="Hotel and Lodging Management"                                  
        212  ="Industrial Marketing"                                          
        213  ="Insurance Managing and Selling"                                
        214  ="International Trade"                                           
        215  ="Personal Services"                                             
        216  ="Petroleum Products"                                            
        217  ="Real Estate Managing and Selling"                              
        218  ="Recreation and Tourism"                                        
        219  ="Transportation Services"                                       
        220  ="Retail Trade"                                                  
        221  ="Wholesale Trade"                                               
        222  ="Distribut Education, misce"                                    
        223  ="Entertainment Services"                                        
        301  ="Dental Assistant"                                              
        302  ="Dental Hygiene (associate degree)"                             
        303  ="Dental Laboratory Technology"                                  
        304  ="Dental Technologies, misce"                                    
        305  ="Cytology (Cyiotechnology)"                                     
        306  ="Histology program"                                             
        307  ="Medical Lab Assistant"                                         
        308  ="Hematology"                                                    
        309  ="Medical Lab Technology, NEC"                                   
        310  ="Nursing (Associate degree)"                                    
        311  ="Nursing, practical (vocational)"                               
        312  ="Nursing Assistant (Aide)"                                      
        313  ="Psychiatric Aide"                                              
        314  ="Operating Room Technician"                                     
        315  ="Nursing Diploma (3-yrs)"                                       
        316  ="Occupational Therapy"                                          
        318  ="Rehabilitation Services"                                       
        319  ="Radiologic Technology (X-Ray)"                                 
        320  ="Radiation Therapy"                                             
        321  ="Nuclear Medical Technology"                                    
        322  ="Radiologic Occupations"                                        
        323  ="Ophthalmic Occupations"                                        
        324  ="Environmental Health Technologies"                             
        325  ="Counselor Mental Health"                                       
        326  ="Electroencephalograph Technology"                              
        327  ="Electrocardiograph Technology"                                 
        328  ="Respiratory Therapy"                                           
        329  ="Medical Assistant Physician Office"                            
        330  ="Community Health Aide"                                         
        331  ="Medical Emergency Technician"                                  
        332  ="Funeral Service Education"                                     
        333  ="Medical Record Technician"                                     
        334  ="Physician's Assistant"                                         
        335  ="Health Occupations, NEC"                                       
        336  ="Veterinary Assistant"                                          
        401  ="Care and Guidance of Children prog"                            
        402  ="Clothing Manage Production and Serv"                           
        403  ="Dietician"                                                     
        404  ="Home Furnishing"                                               
        405  ="Institutional and Home Manage Serv"                            
        406  ="Home Economics, misce programs"                                
        409  ="Tailoring"                                                     
        501  ="Accounting/Bookkeeping"                                        
        502  ="Computer Operator"                                             
        503  ="Peripheral Equipment Operator"                                 
        504  ="Computer Programmer"                                           
        505  ="System Analyst"                                                
        506  ="Data Processing, NEC"                                          
        507  ="Clerk"                                                         
        508  ="Information Communication"                                     
        509  ="Materials Support Occupations"                                 
        510  ="Personnel, Training"                                           
        511  ="Secretarial Occupation"                                        
        512  ="Administrative Management"                                     
        513  ="Typing"                                                        
        514  ="Office Occupation"                                             
        601  ="Aeronautical Technologies"                                     
        602  ="Agricultural Technologies"                                     
        603  ="Architectural Technologies"                                    
        604  ="Automotive Technologies"                                       
        605  ="Chemical Technologies"                                         
        606  ="Civil Technologies"                                            
        607  ="Electrical Technologies"                                       
        608  ="Electronics and Machine Techn"                                 
        609  ="Electromechanical Technologies"                                
        610  ="Environmental Control Technologies"                            
        611  ="Industrial Technologies"                                       
        612  ="Instrumentation Technologies"                                  
        613  ="Mechanical and Engineering Techn"                              
        614  ="Metallurgical Technologies"                                    
        615  ="Nuclear Technologies"                                          
        616  ="Petroleum Technologies"                                        
        617  ="Scientific Data Processing Techn"                              
        618  ="Food Processing Technology"                                    
        619  ="Pilot Training"                                                
        620  ="Fire and Fire Safety Technologies"                             
        621  ="Forestry and Wildlife Technologies"                            
        622  ="Oceanographic Technologies"                                    
        623  ="Police Science Technologies"                                   
        624  ="Education Technologies"                                        
        625  ="Library Assistant"                                             
        626  ="Communication Technologies"                                    
        627  ="Performing Artists"                                            
        628  ="Technical Ed. Misc"                                            
        701  ="Air Condition Installation and Repair"                         
        702  ="Appliance Repair"                                              
        703  ="Automotive Body and Fender Repair"                             
        704  ="Automotive Mechanics"                                          
        705  ="Automotive Specialization Repair"                              
        706  ="Automotive Services Other"                                     
        707  ="Aircraft Maintenance"                                          
        708  ="Aircraft Operations"                                           
        709  ="Airt Traffic Control"                                          
        710  ="Blueprint Reading"                                             
        711  ="Business Machines Mainten Occup"                               
        712  ="Commercial Art"                                                
        713  ="Fishing, commercial"                                           
        714  ="Photography"                                                   
        715  ="Carpentry-Construction"                                        
        716  ="Electricity-Construction"                                      
        717  ="Construction Equipment Maint & Operat"                         
        718  ="Masonry-Construction"                                          
        719  ="Painting and Decorating-Construction"                          
        720  ="Plastering-Construction"                                       
        721  ="Plumbing and Pipefitting-Construction"                         
        722  ="Drywall Installation-Construction"                             
        723  ="Glazing-Construction"                                          
        724  ="Roofing-Construction"                                          
        725  ="Construction and Building Techn Other"                         
        726  ="Custodial Services"                                            
        727  ="Diesel Mechanic"                                               
        728  ="Drafting Occupations"                                          
        729  ="Electrical Occupations"                                        
        730  ="Radio/TV Repair"                                               
        731  ="Electronic Occup Excl. Radio/TV repair"                        
        732  ="Fabric Maintenance Services"                                   
        733  ="Foreman Supervisor and Manage Develop"                         
        734  ="Graphic Arts Occupations"                                      
        735  ="Industrial Atomic Energy Occupations"                          
        736  ="Instrument Mainten and Repairs Occup"                          
        737  ="Maritime Occupations program"                                  
        738  ="Machine Shop Occupation"                                       
        739  ="Machine Tool Operator"                                         
        740  ="Welding and Cutting"                                           
        741  ="Tool and Diemaking"                                            
        742  ="Metalworking Occupations, NEC"                                 
        743  ="Metallurgical Occupation"                                      
        744  ="Barbering"                                                     
        745  ="Cosmetology"                                                   
        746  ="Personal Services Other"                                       
        747  ="Plastics Occupations"                                          
        748  ="Fireman Training"                                              
        749  ="Law Enforcement Training"                                      
        750  ="Public Service Occupations"                                    
        751  ="Quantity Food Occupations"                                     
        752  ="Refrigeration"                                                 
        753  ="Small Engine Repair (Internal Combust"                         
        754  ="Boiler Room Technology"                                        
        755  ="Textile Production and Fabrication"                            
        756  ="Shoe Manufacture and Repair"                                   
        757  ="Upholstering"                                                  
        758  ="Woodworking"                                                   
        759  ="Truck/Trailer Driving"                                         
        760  ="Dog Grooming"                                                  
        761  ="Miscellaneous"                                                 
        999  ="Unknown" ;                                                     
data;                                                                         
infile 'physical-filename' lrecl=80 missover pad;                             
input CARDTYP 7-8  FORM 7 @;                                                  
if CARDTYP=10 then do;                                                        
input                                                                         
  V1    1-2                                                                   
  V2    3-6                                                                   
  V3A   7-8                                                                   
  V3    7                                                                     
  V4    8                                                                     
  V5 $  9-54                                                                  
  V6 $  55-69                                                                 
  V7    70-74;                                                                
                                                                              
LABEL                                                                         
  V1    ="State Number"                                                       
  V2    ="Serial Number"                                                      
  V3A   ="Card Type 10, 20, 30"                                               
  V3    ="Form Type"                                                          
  V4    ="Card Number"                                                        
  V5    ="School Name"                                                        
  V6    ="School City"                                                        
  V7    ="School Zip";                                                        
                                                                              
return;                                                                       
end;                                                                          
                                                                              
else if CARDTYP=20 then do;                                                   
input                                                                         
  V1    1-2                                                                   
  V2    3-6                                                                   
  V3A   7-8                                                                   
  V3    7                                                                     
  V4    8                                                                     
  V5 $  9-54                                                                  
  V6 $  55-69                                                                 
  V7    70-74;                                                                
                                                                              
LABEL                                                                         
  V1    ="State Number"                                                       
  V2    ="Serial Number"                                                      
  V3A   ="Card Type 10, 20, 30"                                               
  V3    ="Form Type"                                                          
  V4    ="Card Number"                                                        
  V5    ="School Name"                                                        
  V6    ="School City"                                                        
  V7    ="School Zip";                                                        
                                                                              
return;                                                                       
end;                                                                          
                                                                              
else if CARDTYP=30 then do;                                                   
input                                                                         
  V1    1-2                                                                   
  V2    3-6                                                                   
  V3A   7-8                                                                   
  V3    7                                                                     
  V4    8                                                                     
  V5 $  9-54                                                                  
  V6 $  55-69                                                                 
  V7    70-74;                                                                
                                                                              
LABEL                                                                         
  V1    ="State Number"                                                       
  V2    ="Serial Number"                                                      
  V3A   ="Card Type 10, 20, 30"                                               
  V3    ="Form Type"                                                          
  V4    ="Card Number"                                                        
  V5    ="School Name"                                                        
  V6    ="School City"                                                        
  V7    ="School Zip";                                                        
return;                                                                       
end;                                                                          
                                                                              
else if CARDTYP= 11 then do;                                                  
input                                                                         
  V8    1-2                                                                   
  V9    3-6                                                                   
  V9A   7-8                                                                   
  V10   7                                                                     
  V11   8                                                                     
  V12   9-11                                                                  
  V13   12                                                                    
  V14   13                                                                    
  V15   14                                                                    
  V16   15-16                                                                 
  V17   17                                                                    
  V18 $ 18-47                                                                 
  V19 $ 48-67                                                                 
  V20   68-69                                                                 
  V21   70-74                                                                 
  V22   75-76;                                                                
                                                                              
LABEL                                                                         
  V8    ="State Number"                                                       
  V9    ="Serial Number"                                                      
  V9A   ="Card Type 11, 31"                                                   
  V10   ="Form Type"                                                          
  V11   ="Card Number"                                                        
  V12   ="Blank"                                                              
  V13   ="Eligibility"                                                        
  V14   ="Correspondence"                                                     
  V15   ="Control"                                                            
  V16   ="Congress District"                                                  
  V17   ="Affiliation Code"                                                   
  V18   ="Affiliate Name"                                                     
  V19   ="Affiliate City"                                                     
  V20   ="Affiliate State"                                                    
  V21   ="Affiliate Zip"                                                      
  V22   ="Numb of Programs";                                                  
return;                                                                       
end;                                                                          
                                                                              
else if CARDTYP= 31 then do;                                                  
input                                                                         
  V8    1-2                                                                   
  V9    3-6                                                                   
  V9A   7-8                                                                   
  V10   7                                                                     
  V11   8                                                                     
  V12   9-11                                                                  
  V13   12                                                                    
  V14   13                                                                    
  V15   14                                                                    
  V16   15-16                                                                 
  V17   17                                                                    
  V18 $ 18-47                                                                 
  V19 $ 48-67                                                                 
  V20   68-69                                                                 
  V21   70-74                                                                 
  V22   75-76;                                                                
                                                                              
LABEL                                                                         
  V8    ="State Number"                                                       
  V9    ="Serial Number"                                                      
  V9A   ="Card Type 11, 31"                                                   
  V10   ="Form Type"                                                          
  V11   ="Card Number"                                                        
  V12   ="Blank"                                                              
  V13   ="Eligibility"                                                        
  V14   ="Correspondence"                                                     
  V15   ="Control"                                                            
  V16   ="Congress District"                                                  
  V17   ="Affiliation Code"                                                   
  V18   ="Affiliate Name"                                                     
  V19   ="Affiliate City"                                                     
  V20   ="Affiliate State"                                                    
  V21   ="Affiliate Zip"                                                      
  V22   ="Numb of Programs";                                                  
return;                                                                       
end;                                                                          
                                                                              
else if CARDTYP= 21 then do;                                                  
input                                                                         
  V23   1-2                                                                   
  V24   3-6                                                                   
  V24A  7-8                                                                   
  V25   7                                                                     
  V26   8                                                                     
  V27   9-11                                                                  
  V28   12                                                                    
  V29   13                                                                    
  V30   14                                                                    
  V31   15-16                                                                 
  V32   17                                                                    
  V33 $ 18-47                                                                 
  V34 $ 48-67                                                                 
  V35   68-69                                                                 
  V36   70-74                                                                 
  V37   75-80;                                                                
                                                                              
LABEL                                                                         
  V23   ="State Number"                                                       
  V24   ="Serial Number"                                                      
  V24A  ="Card Type 21"                                                       
  V25   ="Form Type"                                                          
  V26   ="Card Number"                                                        
  V27   ="Blank"                                                              
  V28   ="Eligibility"                                                        
  V29   ="Correspondence"                                                     
  V30   ="Control"                                                            
  V31   ="Congress District"                                                  
  V32   ="Affiliation Code"                                                   
  V33   ="Affiliate Name"                                                     
  V34   ="Affiliate City"                                                     
  V35   ="Affiliate State"                                                    
  V36   ="Affiliate Zip"                                                      
  V37   ="Weight";                                                            
return;                                                                       
end;                                                                          
                                                                              
else if CARDTYP= 12 then do;                                                  
input                                                                         
  V38   1-2                                                                   
  V39   3-6                                                                   
  V39A  7-8                                                                   
  V40   7                                                                     
  V41   8                                                                     
  V42   9-10                                                                  
  V43   11-11                                                                 
  V44   12-14                                                                 
  V45   15-19                                                                 
  V46   20-23                                                                 
  V47   24-27                                                                 
  V48   28-31                                                                 
  V49   32-35                                                                 
  V50   36-39                                                                 
  V51   40-43                                                                 
  V52   44-47                                                                 
  V53   48                                                                    
  V54   49                                                                    
  V55   50                                                                    
  V56   51                                                                    
  V57   52                                                                    
  V58   53                                                                    
  V59   54                                                                    
  V60   55;                                                                   
                                                                              
LABEL                                                                         
  V38   ="State Number"                                                       
  V39   ="Serial Number"                                                      
  V39A  ="Card type 12"                                                       
  V40   ="Form Type"                                                          
  V41   ="Card Number"                                                        
  V42   ="Ordinal line numb used in Survey"                                   
  V43   ="Blank"                                                              
  V44   ="Program codes,see Appdix A & note 1"                                
  V45   ="Total Enroll, Short Form Q5, Col 2"                                 
  V46   ="Male Enroll, Short Form Q5, Col 3"                                  
  V47   ="Female Enroll, Short Form Q5, Col 4"                                
  V48   ="F-time Enroll, Short Form Q5, Col 5"                                
  V49   ="P-time Enroll,Short Form Q5, Col 6"                                 
  V50   ="Completions"                                                        
  V51   ="Male complet, Short Form Q5, Col 7"                                 
  V52   ="Female complet, Short Form Q5, Col 8"                               
  V53   ="Tot Enroll Imput Flags"                                             
  V54   ="Male Enroll Imput Flags"                                            
  V55   ="Female Enroll Imput Flags"                                          
  V56   ="F-time Enroll Imput Flags"                                          
  V57   ="P-time Enroll Imput Flags"                                          
  V58   ="Computed"                                                           
  V59   ="Tot Male complet Imput Flags"                                       
  V60   ="Tot Female complet Imput Flags";                                    
return;                                                                       
end;                                                                          
                                                                              
else if CARDTYP=24 then do;                                                   
input SEGNU 11 @;                                                             
end;                                                                          
                                                                              
if SEGNU= 1  then do;                                                         
input                                                                         
  V61     1-2                                                                 
  V62     3-6                                                                 
  V62A    7-8                                                                 
  V63     7                                                                   
  V64     8                                                                   
  V65     9-10                                                                
  V66     11-11                                                               
  V67     12-14                                                               
  V68     15-18                                                               
  V69  $  19-20                                                               
  V70     21-24                                                               
  V71     25-29                                                               
  V72     30-33                                                               
  V73     34-37                                                               
  V74     38-41                                                               
  V75     42-45                                                               
  V76     46-49                                                               
  V77     50-53                                                               
  V78     54-57                                                               
  V79     58-61                                                               
  V80     62                                                                  
  V81     63                                                                  
  V82     64                                                                  
  V83     65                                                                  
  V84     66                                                                  
  V85     67                                                                  
  V86     68                                                                  
  V87     69                                                                  
  V88     70;                                                                 
                                                                              
LABEL                                                                         
  V61    ="State Number"                                                      
  V62    ="Serial Number"                                                     
  V62A   ="Card type 24, segment 1"                                           
  V63    ="Form Type"                                                         
  V64    ="Card Number"                                                       
  V65    ="Ordinal Line Numb used in Survey"                                  
  V66    ="Segment Number"                                                    
  V67    ="Program Code, see note 1"                                          
  V68    ="Total Clock Hours,Long Form Q6, Col 2"                             
  V69    ="Clock Hrs per Week, Long Form Q6, Col 3"                           
  V70    ="Total Charges, Long Form Q6, Col 4"                                
  V71    ="Total Enroll, Long Form Q6, Col 5"                                 
  V72    ="Male Enroll, Long Form Q6, Col 6"                                  
  V73    ="Female Enroll, Long Form Q6, Col 7"                                
  V74    ="F-time Enroll, Long Form Q6, Col 8"                                
  V75    ="F-time Male Enroll, Long Form Q6, Col 9"                           
  V76    ="F-time Female Enroll, Long Form Q6, Col 10"                        
  V77    ="P-time Enroll,Long Form Q6, Col 11"                                
  V78    ="P-time Male Enrollment,Long Form Q6, Col 12"                       
  V79    ="P-time Female Enroll, Long Form Q6, Col 13"                        
  V80    ="Total Enroll Imputation Flags"                                     
  V81    ="Male Enroll Imputation Flags"                                      
  V82    ="Female Enroll Imputation Flags"                                    
  V83    ="F-time Enroll Imputation Flags"                                    
  V84    ="F-time Male Enroll Imput Flags"                                    
  V85    ="F-time Female Enroll Imput Flags"                                  
  V86    ="P-time Enrollment Imput Flags"                                     
  V87    ="P-time Male Enroll Imput Flags"                                    
  V88    ="P-time Female Enroll Imput Flags";                                 
return;                                                                       
end;                                                                          
                                                                              
if SEGNU= 2 then do;                                                          
input                                                                         
  V89    1-2                                                                  
  V90    3-6                                                                  
  V90A   7-8                                                                  
  V91    7                                                                    
  V92    8                                                                    
  V93    9-10                                                                 
  V94    11-11                                                                
  V95    12-15                                                                
  V96    16-19                                                                
  V97    20-23                                                                
  V98    24-27                                                                
  V99    28-31                                                                
  V100   32-35                                                                
  V101   36-39                                                                
  V102   40-43                                                                
  V103   44-47                                                                
  V104   48-51                                                                
  V105   52-55                                                                
  V106   56-59                                                                
  V107   60-60                                                                
  V108   61-61                                                                
  V109   62-62                                                                
  V110   63-63                                                                
  V111   64-64                                                                
  V112   65-65                                                                
  V113   66-66                                                                
  V114   67-67                                                                
  V115   68-68                                                                
  V116   69-69                                                                
  V117   70-70                                                                
  V118   71-71;                                                               
                                                                              
LABEL                                                                         
  V89   ="State Number"                                                       
  V90   ="Serial Number"                                                      
  V90A  ="Card Type 24, segment 2"                                            
  V91   ="Form Type"                                                          
  V92   ="Card Number"                                                        
  V93   ="Line Number"                                                        
  V94   ="Segment Number"                                                     
  V95   ="Total Complet, Long Form Q6, Col 14"                                
  V96   ="Male Complet, Long Form Q6, Col 15"                                 
  V97   ="Female Complet, Long Form Q6, Col 16"                               
  V98   ="Tot Left with Skill, Long Form Q6, Col 17"                          
  V99   ="Male Left with Skill,Long Form Q6, Col 18"                          
  V100  ="Female Left w Skill, Long Form Q6, Col 19"                          
  V101  ="Tot Left without Skill,Long Form Q6, Col 20"                        
  V102  ="Male Left without Skil,Long Form Q6, Col 21"                        
  V103  ="Female without Skill,Long Form Q6, Col 22"                          
  V104  ="Total Continue in School, Long Form Q6, Col 23"                     
  V105  ="Males Continue in School, Long Form Q6, Col 24"                     
  V106  ="Females Continue School, Long Form Q6, Col 25"                      
  V107  ="Total Completions"                                                  
  V108  ="Male Completions"                                                   
  V109  ="Female Completions"                                                 
  V110  ="Total left with Skill"                                              
  V111  ="Male left with Skill"                                               
  V112  ="Female left with Skill"                                             
  V113  ="Total left without Skill"                                           
  V114  ="Male left Without Skill"                                            
  V115  ="Female left Without Skill"                                          
  V116  ="Total Continue in School"                                           
  V117  ="Male Continue in School"                                            
  V118  ="Female Continue in School";                                         
return;                                                                       
end;                                                                          
                                                                              
else if CARDTYP= 22 then do;                                                  
input                                                                         
  V119   1-2                                                                  
  V120   3-6                                                                  
  V120A  7-8                                                                  
  V121   7                                                                    
  V122   8                                                                    
  V123   9-11                                                                 
  V124   12-15                                                                
  V125   16-19                                                                
  V126   20-23                                                                
  V127   24-27                                                                
  V128   28-31                                                                
  V129   32-35                                                                
  V130   36-39                                                                
  V131   40-43                                                                
  V132   44-47                                                                
  V133   48-51                                                                
  V134   52-55                                                                
  V135   56-59;                                                               
                                                                              
LABEL                                                                         
  V119  ="State Number"                                                       
  V120  ="Serial Number"                                                      
  V120A ="Card Type 22, 32"                                                   
  V121  ="Form Type"                                                          
  V122  ="Card Number"                                                        
  V123  ="Blank"                                                              
  V124  ="F-time, Total,Instruct Staff"                                       
  V125  ="F-time, Male, Instruct Staff"                                       
  V126  ="F-time, Female,Instruct Staff"                                      
  V127  ="P-time, Total, Instruct Staff"                                      
  V128  ="P-time, Male, Instruct Staff"                                       
  V129  ="P-time, Female,Instruc Staff"                                       
  V130  ="F-time, Total,Profess Staff"                                        
  V131  ="F-time, Male, Profess Staff"                                        
  V132  ="F-time, Female,Profess Staff"                                       
  V133  ="P-time, Total,Profess Staff"                                        
  V134  ="P-time, Male, Profess Staff"                                        
  V135  ="P-time, Female, Profess Staff";                                     
return;                                                                       
end;                                                                          
                                                                              
else if CARDTYP= 32 then do;                                                  
input                                                                         
  V119   1-2                                                                  
  V120   3-6                                                                  
  V120A  7-8                                                                  
  V121   7                                                                    
  V122   8                                                                    
  V123   9-11                                                                 
  V124   12-15                                                                
  V125   16-19                                                                
  V126   20-23                                                                
  V127   24-27                                                                
  V128   28-31                                                                
  V129   32-35                                                                
  V130   36-39                                                                
  V131   40-43                                                                
  V132   44-47                                                                
  V133   48-51                                                                
  V134   52-55                                                                
  V135   56-59;                                                               
                                                                              
LABEL                                                                         
  V119  ="State Number"                                                       
  V120  ="Serial Number"                                                      
  V120A ="Card Type 22, 32"                                                   
  V121  ="Form Type"                                                          
  V122  ="Card Number"                                                        
  V123  ="Blank"                                                              
  V124  ="F-time, Total,Instruct Staff"                                       
  V125  ="F-time, Male, Instruct Staff"                                       
  V126  ="F-time, Female,Instruct Staff"                                      
  V127  ="P-time, Total, Instruct Staff"                                      
  V128  ="P-time, Male, Instruct Staff"                                       
  V129  ="P-time, Female,Instruc Staff"                                       
  V130  ="F-time, Total,Profess Staff"                                        
  V131  ="F-time, Male, Profess Staff"                                        
  V132  ="F-time, Female,Profess Staff"                                       
  V133  ="P-time, Total,Profess Staff"                                        
  V134  ="P-time, Male, Profess Staff"                                        
  V135  ="P-time, Female, Profess Staff";                                     
return;                                                                       
end;                                                                          
                                                                              
else if CARDTYP= 23 then do;                                                  
input                                                                         
  V136    1-2                                                                 
  V137    3-6                                                                 
  V137A   7-8                                                                 
  V138    7                                                                   
  V139    8                                                                   
  V140    9-11                                                                
  V141    12-15                                                               
  V142    16-19                                                               
  V143    20-23                                                               
  V144    24-27                                                               
  V145    28-31                                                               
  V146    32-35                                                               
  V147    36-39                                                               
  V148    40-43                                                               
  V149    44-47                                                               
  V150    48-51                                                               
  V151    52-55                                                               
  V152    56-59                                                               
  V153    60-61;                                                              
                                                                              
LABEL                                                                         
  V136  ="State Number"                                                       
  V137  ="Serial Number"                                                      
  V137A ="Card Type 23, 33"                                                   
  V138  ="Form Type"                                                          
  V139  ="Card Number"                                                        
  V140  ="Blank"                                                              
  V141  ="F-time, Total, Nonprofess Staff"                                    
  V142  ="F-time, Male, Nonprofess Staff"                                     
  V143  ="F-time, Female,Nonprofess Staff"                                    
  V144  ="P-time, Total, Nonprofess Staff"                                    
  V145  ="P-time, Male, Nonprofess Staff"                                     
  V146  ="P-time, Female, Profess Staff"                                      
  V147  ="F-time, Total, Total Staff"                                         
  V148  ="F-time, Male, Total Staff"                                          
  V149  ="F-time, Female,Total Staff"                                         
  V150  ="P-time, Total, Total Staff"                                         
  V151  ="P-time, Male, Total Staff"                                          
  V152  ="P-time, Female, Total Staff"                                        
  V153  ="Total Programs";                                                    
return;                                                                       
end;                                                                          
                                                                              
else if CARDTYP= 33 then do;                                                  
input                                                                         
  V136    1-2                                                                 
  V137    3-6                                                                 
  V137A   7-8                                                                 
  V138    7                                                                   
  V139    8                                                                   
  V140    9-11                                                                
  V141    12-15                                                               
  V142    16-19                                                               
  V143    20-23                                                               
  V144    24-27                                                               
  V145    28-31                                                               
  V146    32-35                                                               
  V147    36-39                                                               
  V148    40-43                                                               
  V149    44-47                                                               
  V150    48-51                                                               
  V151    52-55                                                               
  V152    56-59                                                               
  V153    60-61;                                                              
                                                                              
LABEL                                                                         
  V136  ="State Number"                                                       
  V137  ="Serial Number"                                                      
  V137A ="Card Type 23, 33"                                                   
  V138  ="Form Type"                                                          
  V139  ="Card Number"                                                        
  V140  ="Blank"                                                              
  V141  ="F-time, Total, Nonprofess Staff"                                    
  V142  ="F-time, Male, Nonprofess Staff"                                     
  V143  ="F-time, Female,Nonprofess Staff"                                    
  V144  ="P-time, Total, Nonprofess Staff"                                    
  V145  ="P-time, Male, Nonprofess Staff"                                     
  V146  ="P-time, Female, Profess Staff"                                      
  V147  ="F-time, Total, Total Staff"                                         
  V148  ="F-time, Male, Total Staff"                                          
  V149  ="F-time, Female,Total Staff"                                         
  V150  ="P-time, Total, Total Staff"                                         
  V151  ="P-time, Male, Total Staff"                                          
  V152  ="P-time, Female, Total Staff"                                        
  V153  ="Total Programs";                                                    
return;                                                                       
end;                                                                          
                                                                              
else if CARDTYP= 34 then do;                                                  
input                                                                         
  V154    1-2                                                                 
  V155    3-6                                                                 
  V155A   7-8                                                                 
  V156    7                                                                   
  V157    8                                                                   
  V158    9-10                                                                
  V159    11-11                                                               
  V160    12-14                                                               
  V161    15-18                                                               
  V162    19-20                                                               
  V163    21-24                                                               
  V164    25-28                                                               
  V165    29-32                                                               
  V166    33-37                                                               
  V167    38-43;                                                              
                                                                              
LABEL                                                                         
  V154  ="State Number"                                                       
  V155  ="Serial Number"                                                      
  V155A ="Card Type 34"                                                       
  V156  ="Form Type"                                                          
  V157  ="Card Number"                                                        
  V158  ="Line Number"                                                        
  V159  ="Blank"                                                              
  V160  ="Program Code, Note 1 & Append A"                                    
  V161  ="No of Req Response, Corr Form Q6, Col 2"                            
  V162  ="Months to Complete, Corr Form Q6, Col 3"                            
  V163  ="Hours to Complete, Corr Form Q6, Col 4"                             
  V164  ="Res Hours, Corr Form Q6, Col 5"                                     
  V165  ="Total Tuition, Corr Form Q6, Col 6"                                 
  V166  ="Total Enrollment, Corr Form Q6, Col 7"                              
  V167  ="Total Completion, Corr Form Q6, Col 8";                             
return;                                                                       
end;                                                                          
                                                                              
                                                                              
FORMAT                                                                        
  SEGNU SEGNU.                                                                
  V3    V3F.                                                                  
  V10   V10F.                                                                 
  V13   V13F.                                                                 
  V14   V14F.                                                                 
  V15   V15F.                                                                 
  V17   V17F.                                                                 
  V25   V25F.                                                                 
  V28   V28F.                                                                 
  V29   V29F.                                                                 
  V30   V30F.                                                                 
  V32   V32F.                                                                 
  V40   V40F.                                                                 
  V44   V44F.                                                                 
  V53   V53F.                                                                 
  V54   V54F.                                                                 
  V55   V55F.                                                                 
  V56   V56F.                                                                 
  V57   V57F.                                                                 
  V58   V58F.                                                                 
  V59   V59F.                                                                 
  V60   V60F.                                                                 
  V67   V67F.                                                                 
  V80   V80F.                                                                 
  V81   V81F.                                                                 
  V82   V82F.                                                                 
  V83   V83F.                                                                 
  V84   V84F.                                                                 
  V85   V85F.                                                                 
  V86   V86F.                                                                 
  V87   V87F.                                                                 
  V88   V88F.                                                                 
  V91   V91F.                                                                 
  V94   V94F.                                                                 
  V107  V107F.                                                                
  V108  V108F.                                                                
  V109  V109F.                                                                
  V110  V110F.                                                                
  V111  V111F.                                                                
  V112  V112F.                                                                
  V113  V113F.                                                                
  V114  V114F.                                                                
  V115  V115F.                                                                
  V116  V116F.                                                                
  V117  V117F.                                                                
  V118  V118F.                                                                
  V121  V121F.                                                                
  V138  V138F.                                                                
  V156  V156F.                                                                
  V160  V160F.;                                                               
                                                                              
