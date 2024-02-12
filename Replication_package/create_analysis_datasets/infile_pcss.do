/** INFILES AND CLEANS DATA FROM POSTSECONDARY CAREER SCHOOL SURVEY OF SCHOOLS WITH VOC ED PROGRAMS **/
/** DATA ARE AVAILABLE FROM ICPSR: https://www.icpsr.umich.edu/icpsrweb/ICPSR/studies/2382 **/

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
gl pcss= "${data}/Survey_of_Noncollegiate_PSI";
gl output = "${dir}/output";
gl programs = "${dir}/programs/callable_programs";

cd "${dir}/programs";


/************************************************************************************************/

*** 1975-76 FILE (20380-0001-Data.txt);
** INFILE DATA;
infix 

   edscode 1-2              sernumb 3-6              vennumb 7-12             
   str name 13-58           fips 59-61               str county 62-77           
   str street 78-112        str city 113-127         zip 128-132            
   distno 133-134       	founded 135-138      	 str phone 139-151          
   str chanc 152-152        str affil 153-153        str name2 154-203          
   str street2 204-238      str city2 239-253        str edstc 254-255          
   zip2 256-260             str schlc 261-261        str otherid 262-274        
   str filler1 275-275      fttot 276-280            pttot 281-285          
   ftptt 286-291            ftmale 292-296           ptmale 297-301         
   maletot  302-307         ftfema 308-313           ptfema 314-319         
   fematot 320-325          str filler2 326-327      str corres 328-328         
   str control 329-329      str relig1 330-339       disadvan 340-340       
   handi 341-341            coordw 342-342           workst 343-343         
   placem   344-344         guidan   345-345         none   346-346           
   str accstat   347-347    mlt   348-348            aics   349-349           
   anes   350-350           dh1   351-351            da1   352-352            
   dt1   353-353            mltama   354-354         mrt   355-355            
   mt   356-356             pas   357-357            hist   358-358           
   filler4   359-359        cla   360-360            nmt   361-361            
   rtt   362-362            rt   363-363             ct   364-364             
   it   365-365             ma   366-366             fse   367-367            
   cac   368-368            ecpd   369-369           napnes   370-370         
   natts   371-371          nhsc   372-372           adn   373-373            
   nur   374-374            pn   375-375             str othid   376-389          
   str nonaccr   390-390    str accred   391-391     str asso   392-392           
   str fedprog   393-393    fisl   394-394       	 va   395-395             
   pell 396-396             faa   397-397            ins   398-398            
   bia   399-399            str others   400-400     total1   401-402         
   agprod   403-403         agsupp   404-404         agmech   405-405         
   agripr   406-406         orna   407-407           agres   408-408          
   forest1   409-409        agrmisc   410-410        vetasst   411-411        
   total   412-413          advert   414-414         apparel   415-415        
   auto   416-416           fincred   417-417        florist   418-418        
   foodist   419-419        foodser   420-420        genmerc   421-421        
   hardwar   422-422        homefur   423-423        hotelmg   424-424        
   indmark   425-425        insuran   426-426        intl   427-427           
   pers   428-428           petro   429-429          realst   430-430         
   recr   431-431           transpo   432-432        retail   433-433         
   whsl   434-434           disted   435-435         total2   436-437         
   da2   438-438            dh2   439-439            dlt2   440-440           
   dm2   441-441            cytol   442-442          histo   443-443          
   medlab   444-444         hemat   445-445          medbio   446-446         
   assnur   447-447         pracnu   448-448         asstnu   449-449         
   psych   450-450          surg   451-451           nurso   452-452          
   occth   453-453          phyth   454-454          rehmi   455-455          
   xrayt   456-456          radth   457-457          nucle   458-458          
   xraym   459-459          optic   460-460          envir   461-461          
   mental   462-462         eectec   463-463         ekgtec   464-464         
   respth   465-465         medast1   466-466        healaid   467-467        
   meder   468-468          mortua   469-469         medrec1   470-470        
   physasst   471-471       healmisc   472-472       fille7   473-477         
   total3   478-479         childc   480-480         cloth   481-481          
   foodmg   482-482         homefur2   483-483       instmg1   484-484        
   homeech   485-485        total4   486-487         account1   488-488       
   comput   489-489         keypun   490-490         comprog   491-491        
   systan   492-492         busdata   493-493        genoff   494-494         
   infocom   495-495        matsupp   496-496        person   497-497         
   secret1   498-498        supadm   499-499         typin   500-500          
   offmisc   501-501        fille8   502-506         total5   507-508         
   aerotec   509-509        agritec   510-510        achtec   511-511         
   autotec   512-512        chemtec   513-513        civiltec   514-514       
   electtec   515-515       electron   516-516       elemech1   517-517       
   envircnt   518-518       indtech2   519-519       instrtec   520-520       
   mechtec   521-521        metalgy   522-522        nucletec   523-523       
   petrotec   524-524       scidata   525-525        legasst   526-526        
   compilot   527-527       firetech   528-528       forestec   529-529       
   oceantec   530-530       police1   531-531        teachast   532-532       
   libasst   533-533        bdcstech   534-534       arts   535-535           
   tecedmis   536-536       airpolt   537-537        watertec   538-538       
   fille88   539-543        total6   544-545         acrepair   546-546       
   applirep   547-547       autorep   548-548        automech   549-549       
   autospec   550-550       autoserv   551-551       aircrm   552-552         
   aircro   553-553         ground   554-554         bluepr   555-555         
   busmech   556-556        commart   557-557        comfish   558-558        
   comphot   559-559        carpent   560-560        eleccon   561-561        
   constr1   562-562        mason   563-563          paint   564-564          
   plast   565-565          plumb   566-566          drywa   567-567          
   glaze   568-568          roof   569-569           const   570-570          
   custo   571-571          diese   572-572          draft   573-573          
   eleocc   574-574         radio   575-575          electrn   576-576        
   fabric   577-577         forema   578-578         graph   579-579          
   atomic   580-580         instr   581-581          mariti   582-582         
   machsh   583-583         machto   584-584         weld   585-585           
   tool   586-586           metwork   587-587        metalg   588-588         
   barb   589-589           cosme   590-590          pers2   591-591          
   plasti   592-592         fireman   593-593        lawenf   594-594         
   pubserv   595-595        quantfo   596-596        refrig   597-597         
   engine   598-598         staener   599-599        textile   600-600        
   leather   601-601        upholst   602-602        woodwor   603-603        
   truck   604-604          doggroo   605-605        trademi   606-606        
   fille9   607-611         total8   612-613         dptech   614-614         
   keypunch   615-615       program   616-616        periphe   617-617        
   equipma   618-618        other1   619-619         fille10   620-621        
   total9   622-623         healgen   624-624        da3   625-625            
   dh3   626-626            dl3   627-627            medbio3   628-628        
   animal   629-629         xray2   630-630          nursrn   631-631         
   nurspr   632-632         occthr   633-633         surgica   634-634        
   optic2   635-635         medrec2   636-636        medast2   637-637        
   inhalth   638-638        psychia   639-639        elecdia   640-640        
   instmg2   641-641        phythe   642-642         other2   643-643         
   fille11   644-646        total10   647-648        megen   649-649          
   aero2   650-650          enggra   651-651         archit   652-652         
   chemic   653-653         automo   654-654         diesel2   655-655        
   weld2   656-656          civil   657-657          electro   658-658        
   elemech2   659-659       indust   660-660         textil   661-661         
   instru   662-662         mechan   663-663         nuclea   664-664         
   constr2   665-665        other3   666-666         fille12   667-669        
   total11   670-671        natsch   672-672         agri   673-673           
   forest2   674-674        foodse   675-675         homeec   676-676         
   marine   677-677         labtech   678-678        sanitat   679-679        
   other4   680-680         fille13   681-682        total12   683-684        
   buscom   685-685         account2   686-686       bankfin   687-687        
   manage   688-688         secret2   689-689        persona   690-690        
   photogr   691-691        commbrd   692-692        print   693-693          
   hotel   694-694          trans   695-695          art   696-696            
   other5   697-697         fille14   698-699        total13   700-701        
   pubseg   702-702         relig    703-703         educa   704-704          
   librar   705-705         police2   706-706        social   707-707         
   fire   708-708           admin   709-709          other6   710-710         
   fille15   711-713        printc   714-714         errorf   715-715        

   using "${pcss}/02380-0001-Data.txt", clear;


gen year = 1976;

drop fille*; 

save scrap, replace;

*** 1977-78 FILE (20381-0001-Data.txt);
** INFILE DATA;
infix 
   edscode 1-2              sernumb 3-6              vennumb 7-12          
   str name   13-58         fips   59-61         	 str county   62-77        
   str street   78-112      str city   113-127       zip   128-132         
   distno   133-134         founded   135-138        str phone   139-151       
   str chanc   152-152      str affil   153-153      str name2   154-183       
   str city2   184-198      str edstc   199-200      respc 201-202         
   hegis 203-203            
   sample 206-206           addstat 207-207          totprog 208-209       
   size   210-214           
   filler1   235-260        str schlc   261-261      str otherid   262-274     
   fttot 276-280		    pttot 281-285         
   ftptt 286-291            ftmale 292-296           ptmale 297-301        
   maletot 302-307          ftfema 308-313           ptfema   314-319      
   fematot 320-325          filler2   326-326        str areavoc   327-327     
   str corres   328-328     str control   329-329    
   str accstat   347-347    mlt   348-348            aics   349-349        
   anes   350-350           dh1   351-351            da1   352-352         
   dt1   353-353            mltama   354-354         mrt   355-355         
   mt   356-356             pas   357-357            hist   358-358        
   filler4   359-359        cla   360-360            nmt   361-361         
   rtt   362-362            rt   363-363             ct   364-364          
   it   365-365             ma   366-366             fse   367-367         
   cac   368-368            ecpd   369-369           napnes   370-370      
   natts   371-371          nhsc   372-372           adn   373-373         
   nur   374-374            pn   375-375             id   376-376          
   antech   377-377         filler5   378-390        str accred   391-391      
   str asso   392-392       str fedprog   393-393    fisl   394-394        
   va   395-395         	pell 396-396         	 faa   397-397         
   fille6   398-400         total1   401-402         agprod   403-403      
   agsupp   404-404         agmech   405-405         agripr   406-406      
   orna   407-407           agres   408-408          forest1   409-409     
   agrmisc   410-410        vetasst   411-411        total   412-413       
   advert   414-414         apparel   415-415        auto   416-416        
   fincred   417-417        florist   418-418        foodist   419-419     
   foodser   420-420        genmerc   421-421        hardwar   422-422     
   homefur   423-423        hotelmg   424-424        indmark   425-425     
   insuran   426-426        intl   427-427           pers   428-428        
   petro   429-429          realst   430-430         recr   431-431        
   transpo   432-432        retail   433-433         whsl   434-434        
   disted   435-435         total2   436-437         da2   438-438         
   dh2   439-439            dlt2   440-440           dm2   441-441         
   cytol   442-442          histo   443-443          medlab   444-444      
   hemat   445-445          medbio   446-446         assnur   447-447      
   pracnu   448-448         asstnu   449-449         psych   450-450       
   surg   451-451           nurso   452-452          occth   453-453       
   phyth   454-454          rehmi   455-455          xrayt   456-456       
   radth   457-457          nucle   458-458          xraym   459-459       
   optic   460-460          envir   461-461          mental   462-462      
   eectec   463-463         ekgtec   464-464         respth   465-465      
   medast1   466-466        healaid   467-467        meder   468-468       
   mortua   469-469         medrec1   470-470        physasst   471-471    
   healmisc   472-472       fille7   473-477         total3   478-479      
   childc   480-480         cloth   481-481          foodmg   482-482      
   homefur2   483-483       instmg1   484-484        homeech   485-485     
   total4   486-487         account1   488-488       comput   489-489      
   keypun   490-490         comprog   491-491        systan   492-492      
   busdata   493-493        genoff   494-494         infocom   495-495     
   matsupp   496-496        person   497-497         secret1   498-498     
   supadm   499-499         typin   500-500          offmisc   501-501     
   fille8   502-506         total5   507-508         aerotec   509-509     
   agritec   510-510        achtec   511-511         autotec   512-512     
   chemtec   513-513        civiltec   514-514       electtec   515-515    
   electron   516-516       elemech1   517-517       envircnt   518-518    
   indtech2   519-519       instrtec   520-520       mechtec   521-521     
   metalgy   522-522        nucletec   523-523       petrotec   524-524    
   scidata   525-525        legasst   526-526        compilot   527-527    
   firetech   528-528       forestec   529-529       oceantec   530-530    
   police1   531-531        teachast   532-532       libasst   533-533     
   bdcstech   534-534       arts   535-535           tecedmis   536-536    
   airpolt   537-537        watertec   538-538       fille88   539-543     
   total6   544-545         acrepair   546-546       applirep   547-547    
   autorep   548-548        automech   549-549       autospec   550-550    
   autoserv   551-551       aircrm   552-552         aircro   553-553      
   ground   554-554         bluepr   555-555         busmech   556-556     
   commart   557-557        comfish   558-558        comphot   559-559     
   carpent   560-560        eleccon   561-561        constr1   562-562     
   mason   563-563          paint   564-564          plast   565-565       
   plumb   566-566          drywa   567-567          glaze   568-568       
   roof   569-569           const   570-570          custo   571-571       
   diese   572-572          draft   573-573          eleocc   574-574      
   radio   575-575          electrn   576-576        fabric   577-577      
   forema   578-578         graph   579-579          atomic   580-580      
   instr   581-581          mariti   582-582         machsh   583-583      
   machto   584-584         weld   585-585           tool   586-586        
   metwork   587-587        metalg   588-588         barb   589-589        
   cosme   590-590          pers2   591-591          plasti   592-592      
   fireman   593-593        lawenf   594-594         pubserv   595-595     
   quantfo   596-596        refrig   597-597         engine   598-598      
   staener   599-599        textile   600-600        leather   601-601     
   upholst   602-602        woodwor   603-603        truck   604-604       
   doggroo   605-605        trademi   606-606        fille9   607-611      
   total8   612-613         dptech   614-614         keypunch   615-615    
   program   616-616        periphe   617-617        equipma   618-618     
   other1   619-619         fille10   620-621        total9   622-623      
   healgen   624-624        da3   625-625            dh3   626-626         
   dl3   627-627            medbio3   628-628        animal   629-629      
   xray2   630-630          nursrn   631-631         nurspr   632-632      
   occthr   633-633         surgica   634-634        optic2   635-635      
   medrec2   636-636        medast2   637-637        inhalth   638-638     
   psychia   639-639        elecdia   640-640        instmg2   641-641     
   phythe   642-642         other2   643-643         fille11   644-646     
   total10   647-648        megen   649-649          aero2   650-650       
   enggra   651-651         archit   652-652         chemic   653-653      
   automo   654-654         diesel2   655-655        weld2   656-656       
   civil   657-657          electro   658-658        elemech2   659-659    
   indust   660-660         textil   661-661         instru   662-662      
   mechan   663-663         nuclea   664-664         constr2   665-665     
   other3   666-666         fille12   667-669        total11   670-671     
   natsch   672-672         agri   673-673           forest2   674-674     
   foodse   675-675         homeec   676-676         marine   677-677      
   labtech   678-678        sanitat   679-679        other4   680-680      
   fille13   681-682        total12   683-684        buscom   685-685      
   account2   686-686       bankfin   687-687        manage   688-688      
   secret2   689-689        persona   690-690        photogr   691-691     
   commbrd   692-692        print   693-693          hotel   694-694       
   trans   695-695          art   696-696            other5   697-697      
   fille14   698-699        total13   700-701        pubseg   702-702      
   relig   703-703          educa   704-704          librar   705-705      
   police2   706-706        social   707-707         fire   708-708        
   admin   709-709          other6   710-710         fille15   711-713     
   printc   714-714         errorf   715-715
   
using "${pcss}/02381-0001-Data.txt", clear;
           
drop fille*; 
              
gen year = 1978;

append using scrap; save scrap, replace;


*** 1979-80 FILE (20382-0001-Data.txt);
** INFILE DATA;
infix 
   edscode  1-2             sernumb 3-6              vennumb 7-12          
   str name   13-58         fips   59-61         	 str county   62-77        
   str street   78-112      str city   113-127       zip   128-132         
   founded   135-138    	str phone   139-151       
   str chanc   152-152      str affil   153-153      str name2   154-183       
   str city2   184-198      str edstc   199-200      respc 201-202         
   hegis 203-203            
   sample 206-206           addstat 207-207          totprog 208-209       
   size   210-214           
   str filler1   235-260    str schlc   261-261      str otherid   262-274     
   fttot 276-280            pttot 281-285         
   ftptt 286-291            ftmale 292-296           ptmale 297-301        
   maletot 302-307          ftfema 308-313           ptfema   314-319      
   fematot 320-325          filler2   326-326        str areavoc   327-327     
   str corres   328-328     str control   329-329    
   str accstat   347-347    mlt   348-348        	 aics   349-349        
   anes   350-350           dh1   351-351            da1   352-352         
   dt1   353-353            mltama   354-354         mrt   355-355         
   mt   356-356             pas   357-357            hist   358-358        
   filler4   359-359        cla   360-360            nmt   361-361         
   rtt   362-362            rt   363-363             ct   364-364          
   it   365-365             ma   366-366             fse   367-367         
   cac   368-368            ecpd   369-369           napnes   370-370      
   natts   371-371          nhsc   372-372           adn   373-373         
   nur   374-374            pn   375-375             id   376-376          
   antech   377-377         filler5   378-390        str accred   391-391      
   str asso   392-392       str fedprog   393-393    fisl   394-394        
   va   395-395         	pell   396-396       faa   397-397         
   fille6   398-400         total1   401-402         agprod   403-403      
   agsupp   404-404         agmech   405-405         agripr   406-406      
   orna   407-407           agres   408-408          forest1   409-409     
   agrmisc   410-410        vetasst   411-411        total   412-413       
   advert   414-414         apparel   415-415        auto   416-416        
   fincred   417-417        florist   418-418        foodist   419-419     
   foodser   420-420        genmerc   421-421        hardwar   422-422     
   homefur   423-423        hotelmg   424-424        indmark   425-425     
   insuran   426-426        intl   427-427           pers   428-428        
   petro   429-429          realst   430-430         recr   431-431        
   transpo   432-432        retail   433-433         whsl   434-434        
   disted   435-435         total2   436-437         da2   438-438         
   dh2   439-439            dlt2   440-440           dm2   441-441         
   cytol   442-442          histo   443-443          medlab   444-444      
   hemat   445-445          medbio   446-446         assnur   447-447      
   pracnu   448-448         asstnu   449-449         psych   450-450       
   surg   451-451           nurso   452-452          occth   453-453       
   phyth   454-454          rehmi   455-455          xrayt   456-456       
   radth   457-457          nucle   458-458          xraym   459-459       
   optic   460-460          envir   461-461          mental   462-462      
   eectec   463-463         ekgtec   464-464         respth   465-465      
   medast1   466-466        healaid   467-467        meder   468-468       
   mortua   469-469         medrec1   470-470        physasst   471-471    
   healmisc   472-472       fille7   473-477         total3   478-479      
   childc   480-480         cloth   481-481          foodmg   482-482      
   homefur2   483-483       instmg1   484-484        homeech   485-485     
   total4   486-487         account1   488-488       comput   489-489      
   keypun   490-490         comprog   491-491        systan   492-492      
   busdata   493-493        genoff   494-494         infocom   495-495     
   matsupp   496-496        person   497-497         secret1   498-498     
   supadm   499-499         typin   500-500          offmisc   501-501     
   fille8   502-506         total5   507-508         aerotec   509-509     
   agritec   510-510        achtec   511-511         autotec   512-512     
   chemtec   513-513        civiltec   514-514       electtec   515-515    
   electron   516-516       elemech1   517-517       envircnt   518-518    
   indtech2   519-519       instrtec   520-520       mechtec   521-521     
   metalgy   522-522        nucletec   523-523       petrotec   524-524    
   scidata   525-525        legasst   526-526        compilot   527-527    
   firetech   528-528       forestec   529-529       oceantec   530-530    
   police1   531-531        teachast   532-532       libasst   533-533     
   bdcstech   534-534       arts   535-535           tecedmis   536-536    
   airpolt   537-537        watertec   538-538       fille88   539-543     
   total6   544-545         acrepair   546-546       applirep   547-547    
   autorep   548-548        automech   549-549       autospec   550-550    
   autoserv   551-551       aircrm   552-552         aircro   553-553      
   ground   554-554         bluepr   555-555         busmech   556-556     
   commart   557-557        comfish   558-558        comphot   559-559     
   carpent   560-560        eleccon   561-561        constr1   562-562     
   mason   563-563          paint   564-564          plast   565-565       
   plumb   566-566          drywa   567-567          glaze   568-568       
   roof   569-569           const   570-570          custo   571-571       
   diese   572-572          draft   573-573          eleocc   574-574      
   radio   575-575          electrn   576-576        fabric   577-577      
   forema   578-578         graph   579-579          atomic   580-580      
   instr   581-581          mariti   582-582         machsh   583-583      
   machto   584-584         weld   585-585           tool   586-586        
   metwork   587-587        metalg   588-588         barb   589-589        
   cosme   590-590          pers2   591-591          plasti   592-592      
   fireman   593-593        lawenf   594-594         pubserv   595-595     
   quantfo   596-596        refrig   597-597         engine   598-598      
   staener   599-599        textile   600-600        leather   601-601     
   upholst   602-602        woodwor   603-603        truck   604-604       
   doggroo   605-605        trademi   606-606        fille9   607-611      
   total8   612-613         dptech   614-614         keypunch   615-615    
   program   616-616        periphe   617-617        equipma   618-618     
   other1   619-619         fille10   620-621        total9   622-623      
   healgen   624-624        da3   625-625            dh3   626-626         
   dl3   627-627            medbio3   628-628        animal   629-629      
   xray2   630-630          nursrn   631-631         nurspr   632-632      
   occthr   633-633         surgica   634-634        optic2   635-635      
   medrec2   636-636        medast2   637-637        inhalth   638-638     
   psychia   639-639        elecdia   640-640        instmg2   641-641     
   phythe   642-642         other2   643-643         fille11   644-646     
   total10   647-648        megen   649-649          aero2   650-650       
   enggra   651-651         archit   652-652         chemic   653-653      
   automo   654-654         diesel2   655-655        weld2   656-656       
   civil   657-657          electro   658-658        elemech2   659-659    
   indust   660-660         textil   661-661         instru   662-662      
   mechan   663-663         nuclea   664-664         constr2   665-665     
   other3   666-666         fille12   667-669        total11   670-671     
   natsch   672-672         agri   673-673           forest2   674-674     
   foodse   675-675         homeec   676-676         marine   677-677      
   labtech   678-678        sanitat   679-679        other4   680-680      
   fille13   681-682        total12   683-684        buscom   685-685      
   account2   686-686       bankfin   687-687        manage   688-688      
   secret2   689-689        persona   690-690        photogr   691-691     
   commbrd   692-692        print   693-693          hotel   694-694       
   trans   695-695          art   696-696            other5   697-697      
   fille14   698-699        total13   700-701        pubseg   702-702      
   relig   703-703          educa   704-704          librar   705-705      
   police2   706-706        social   707-707         fire   708-708        
   admin   709-709          other6   710-710         fille15   711-713     
   printc   714-714         errorf   715-715
         
using "${pcss}/02382-0001-Data.txt", clear;
         
drop fille*; 
              
gen year = 1980;

append using scrap; save scrap, replace; 

*** 1980-81 FILE (20383-0001-Data.txt);
** INFILE DATA;
      
infix 
   edscode 1-2              sernumb 3-6              vennumb 7-12          
   str name   13-58         fips   59-61         	 str county   62-77        
   str street   78-112      str city   113-127       zip 128-132           
   str phone   135-147      str affil 148-148         
   str name2   149-178      str city2   179-198      str edstc 199-200         
   respc 201-202            hegis 203-203            
   totprog 207-208       
   size 209-213             
   str schlc   234-234      fttot 235-239            pttot 240-244         
   ftptt 245-250            ftmale 251-255           ptmale 256-260        
   maletot 261-266          ftfema 267-272           ptfema 273-278        
   fematot 279-284          ftflag 285-285           ptflag 286-286        
   totfla 287-287           ftmalf 288-288           ptmalf 289-289        
   maltotf 290-290          ftfemfl 291-291          ptfemfl 292-292       
   femtotf 293-293          str corres   294-294     str control 295-295       
   str accstat   296-296    mlt   297-297        	 aics   298-298        
   anes   299-299           dh1   300-300            da1   301-301         
   dt1   302-302            mltama   303-303         mrt   304-304         
   mt   305-305             pas   306-306            hist   307-307        
   dte   308-308            mae   309-309            nmt   310-310         
   rtt   311-311            rt   312-312             ct   313-313          
   it   314-314             ma   315-315             fse   316-316         
   cac   317-317            ecpd   318-318           napnes   319-319      
   natts   320-320          nhsc   321-321           adn   322-322         
   nur   323-323            pn   324-324             id   325-325          
   antech   326-326         str accred   327-327     str asso   328-328        
   fille1   329-329         fisl   330-330       	 va   331-331          
   pell   332-332       	faa   333-333            fille2   334-350      
   total1 351-352           agprod   353-353         agsupp   354-354      
   agmech   355-355         agripr   356-356         orna   357-357        
   agres   358-358          forest1   359-359        agrmisc   360-360     
   fille3   361-365         total 366-367            advert   368-368      
   apparel   369-369        auto   370-370           fincred   371-371     
   florist   372-372        foodist   373-373        foodser   374-374     
   genmerc   375-375        hardwar   376-376        homefur   377-377     
   hotelmg   378-378        indmark   379-379        insuran   380-380     
   intl   381-381           pers   382-382           petro   383-383       
   realst   384-384         recr   385-385           transpo   386-386      
   retail   387-387         whsl   388-388           disted   389-389      
   entert   390-390         fille4   391-395         total2   396-397      
   da2   398-398            dh2   399-399            dlt2   400-400        
   dm2   401-401            cytol   402-402          histo   403-403       
   medlab   404-404         hemat   405-405          medbio   406-406      
   assnur   407-407         pracnu   408-408         asstnu   409-409      
   psych   410-410          surg   411-411           nurso   412-412       
   occth   413-413          phyth   414-414          rehmi   415-415       
   xrayt   416-416          radth   417-417          nucle   418-418       
   xraym   419-419          optic   420-420          envir   421-421       
   mental   422-422         eectec   423-423         ekgtec   424-424      
   respth   425-425         medast1   426-426        healaid   427-427     
   meder   428-428          mortua   429-429         medrec1   430-430     
   physasst   431-431       healmisc   432-432       vetasst   433-433     
   fille5   434-438         total3 439-440           childc   441-441      
   cloth   442-442          foodmg   443-443         homefur2   444-444    
   instmg1   445-445        homeech   446-446        tailor   447-447      
   fille6   448-453         total4 454-455           account1   456-456     
   comput   457-457         keypun   458-458         comprog   459-459     
   systan   460-460         busdata   461-461        genoff   462-462      
   infocom   463-463        matsupp   464-464        person   465-465      
   secret1   466-466        supadm   467-467         typin   468-468       
   offmisc   469-469        fille7   470-474         total5 475-476        
   aerotec   477-477        agritec   478-478        achtec   479-479      
   autotec   480-480        chemtec   481-481        civiltec   482-482    
   electtec   483-483       electron   484-484       elemech1   485-485    
   envircnt   486-486       indtech2   487-487       instrtec   488-488    
   mechtec   489-489        metalgy   490-490        nucletec   491-491    
   petrotec   492-492       scidata   493-493        legasst   494-494     
   compilot   495-495       firetech   496-496       forestec   497-497    
   oceantec   498-498       police1   499-499        teachast   500-500    
   libasst   501-501        bdcstech   502-502       arts   503-503        
   tecedmis   504-504       fille8   505-509         total6 510-511        
   acrepair   512-512       applirep   513-513       autorep   514-514     
   automech   515-515       autospec   516-516       autoserv   517-517    
   aircrm   518-518         aircro   519-519         ground   520-520      
   bluepr   521-521         busmech   522-522        commart   523-523     
   comfish   524-524        comphot   525-525        carpent   526-526     
   eleccon   527-527        constr1   528-528        mason   529-529       
   paint   530-530          plast   531-531          plumb   532-532       
   drywa   533-533          glaze   534-534          roof   535-535        
   const   536-536          custo   537-537          diese   538-538       
   draft   539-539          eleocc   540-540         radio   541-541       
   electrn   542-542        fabric   543-543         forema   544-544      
   graph   545-545          atomic   546-546         instr   547-547       
   mariti   548-548         machsh   549-549         machto   550-550      
   weld   551-551           tool   552-552           metwork   553-553     
   metalg   554-554         barb   555-555           cosme   556-556       
   pers2   557-557          plasti   558-558         fireman   559-559     
   lawenf   560-560         pubserv   561-561        quantfo   562-562     
   refrig   563-563         engine   564-564         staener   565-565     
   textile   566-566        leather   567-567        upholst   568-568     
   woodwor   569-569        truck   570-570          doggroo   571-571     
   trademi   572-572        unknown   573-574        fille9   575-611      
   total8 612-613           dptech   614-614         keypunch   615-615    
   program   616-616        periphe   617-617        equipma   618-618     
   other1   619-619         fille10   620-621        total9 622-623        
   healgen   624-624        da3   625-625            dh3   626-626         
   dl3   627-627            medbio3   628-628        animal   629-629      
   xray2   630-630          nursrn   631-631         nurspr   632-632      
   occthr   633-633         surgica   634-634        optic2   635-635      
   medrec2   636-636        medast2   637-637        inhalth   638-638     
   psychia   639-639        elecdia   640-640        instmg2   641-641     
   phythe   642-642         other2   643-643         fille11   644-646     
   total10 647-648          megen   649-649          aero2   650-650       
   enggra   651-651         archit   652-652         chemic   653-653      
   automo   654-654         diesel2   655-655        weld2   656-656       
   civil   657-657          electro   658-658        elemech2   659-659    
   indust   660-660         textil   661-661         instru   662-662      
   mechan   663-663         nuclea   664-664         constr2   665-665     
   other3   666-666         fille12   667-669        total11 670-671       
   natsch   672-672         agri   673-673           forest2   674-674     
   foodse   675-675         homeec   676-676         marine   677-677      
   labtech   678-678        sanitat   679-679        other4   680-680      
   fille13   681-682        total12 683-684          buscom   685-685      
   acount2   686-686        bankfin   687-687        manage   688-688      
   secret2   689-689        persona   690-690        photogr   691-691     
   commbrd   692-692        print   693-693          hotel   694-694       
   trans   695-695          art   696-696            other5   697-697      
   fille14   698-699        total13 700-701          pubseg   702-702      
   relig   703-703          educa   704-704          librar   705-705      
   police2   706-706        social   707-707         fire   708-708        
   admin   709-709          other6   710-710         fille15   711-715  


using "${pcss}/02383-0001-Data.txt", clear;

drop fille*; 
gen year = 1981;

append using scrap; 

** CLEAN AND FORMAT DATA;
* VARIABLE LABELS;
label var   edscode   "state codes (10-64) assigned by office"                         ;
label var   sernumb   "unique number assigned to each record"                          ;
label var   vennumb   "for internal use only"                                          ;
label var   name      "name of institution"                                            ;
label var   fips      "identifies county by ftps code"                                 ;
label var   county    "name of county institution is located"                          ;
label var   street    "street address"                                                 ;
label var   city      "city institution is located"                                    ;
label var   zip       "postal zip code"                                                ;
label var   distno    "numeric ident  congr district"                                  ;
label var   founded   "year reporting institute was founded"                           ;
label var   phone     "telphone num of instit - (xxx)xxx-xxxx"                         ;
label var   chanc     "indicate change in ownership since 7/1/7"                       ;
label var   affil     "type of affiliation"                                            ;
label var   name2     "name of parent institution"                                     ;
label var   street2   "street2"                                                        ;
label var   city2     "city parent institution is located"                             ;
label var   edstc     "state code (10-64) assigned by nces"                            ;
label var   zip2      "postal zip code"                                                ;
label var   schlc     "school type"                                                    ;
label var   otherid   "if record pos 261 k write in schl type"                         ;
label var   fttot     "total full-time enrollment"                                     ;
label var   pttot     "total part-time enrollment"                                     ;
label var   ftptt     "total full-time and pt enroll"                                  ;
label var   ftmale    "total full-time male enrollment"                                ;
label var   ptmale    "total part-time male enrollment"                                ;
label var   maletot   "total full-time and pt male enroll"                             ;
label var   ftfema    "total full-time female enrollment"                              ;
label var   ptfema    "total part-time female enrollment"                              ;
label var   fematot   "total full-time and pt female enroll"                           ;
label var   corres    "whether schl offers corres courses"                             ;
label var   control   "type of control"                                                ;
label var   relig1    "if rec position 329 equal d write relig"                        ;
label var   disadvan  "special prog for disadvantaged"                                ;
label var   handi     "special prog for handicapped"                                   ;
label var   coordw    "special prog in cooperate work"                                 ;
label var   workst    "special prog in work study"                                     ;
label var   placem    "special prog in placement"                                      ;
label var   guidan    "special prog in guidance counsel"                               ;
label var   none      "special prog not offered"                                       ;
label var   accstat   "whether schl is nationally accredited"                          ;
label var   mlt       "medical lab technicin prog"                                     ;
label var   aics      "assoc indep colleges schls bus prog"                            ;
label var   anes      "amer assoc of nurse anesthetists"                               ;
label var   dh1       "(ada/cda): dental hygienist prog"                               ;
label var   da1       "ada/cad: dental assistant prog"                                 ;
label var   dt1       "ada/cda: dental lab tech prog"                                  ;
label var   mltama    "(ama/cahea): medical lab tech prog"                             ;
label var   mrt       "ama/cahea: med records tech prog"                               ;
label var   mt        "ama/cahea: med tech prog certif only"                           ;
label var   pas       "ama/cahea: prog for physician's assist"                         ;
label var   hist      "ama/cahea: histologic tech prog"                                ;
label var   cla       "ama/cme: certified lab assist prog"                             ;
label var   nmt       "ama/cahea: nuclear medicine tech prog"                          ;
label var   rtt       "ama/cahea: radiation therapy tech prog"                         ;
label var   rt        "ama/cahea: radiolographer prog"                                 ;
label var   ct        "ama/cahea: cytotechnologist prog"                               ;
label var   it        "ama/cahea: inhalation ther tech prog"                           ;
label var   ma        "ama/cahea: med assist prog"                                     ;
label var   fse       "funeral service prog"                                           ;
label var   cac       "cosmetology prog"                                               ;
label var   ecpd      "engineering tech prog"                                          ;
label var   napnes    "nat assoc prac nurse edu serv"                                  ;
label var   natts     "nat assoc trade and tech schls"                                 ;
label var   nhsc      "nat home study councit:all prog"                                ;
label var   adn       "nat league for nursing (nln)"                                   ;
label var   nur       "nln: diploma nursing prog"                                      ;
label var   pn        "nln: diploma prac nursing prog"                                 ;
label var   id        "foundation for interior design research: technician programs"   ;
label var   antech	  " american vet medical assoc: animal technician programs"		   ;
label var   othid     "if accred not described above write accr"                       ;
label var   nonaccr   "write in asso not accredite"                                    ;
label var   accred    "institution has regional accred"                                ;
label var   asso      "the region the schl is award accred"                            ;
label var   fedprog   "whether schl offer fed sponsored prog"                          ;
label var   fisl      "fed insured student loan eligible"                              ;
label var   va        "veteran's administration"                                       ;
label var   pell      "Pell (basic education opport) grant prog"                              ;
label var   faa       "fed aviation administmtion"                                     ;
label var   ins       "immigration naturalization"                                     ;
label var   bia       "bureau of indian affairs"                                       ;
label var   others    "elig for prog than in list 394-399"                             ;
label var   total1    "total number of offer in agri"                                  ;
label var   agprod    "agri product prog (01.01)"                                      ;
label var   agsupp    "agri supply and serv prog (01.02)"                              ;
label var   agmech    "agri mechanics prog (01.03)"                                    ;
label var   agripr    "agri products prog (01.04)"                                     ;
label var   orna      "horticulture prog (01.05)"                                      ;
label var   agres     "agri resources prog (01.06)"                                    ;
label var   forest1   "forestry prog (01.07)"                                          ;
label var   agrmisc   "agri, misc prog (01.08)"                                        ;
label var   vetasst   "veterinarian asst prog(01.0299)"                                ;
label var   total     "number of offer in distr educ"                                  ;
label var   advert    "advertising serv prog(04.01)"                                   ;
label var   apparel   "apparel and access prog(04.02)"                                 ;
label var   auto      "automotive sales prog(04.03)"                                   ;
label var   fincred   "finance and credit prog(04.04)"                                 ;
label var   florist   "floristry prog(04.05)"                                          ;
label var   foodist   "food distr prog(04.06)"                                         ;
label var   foodser   "food serv tech prog(04.07)"                                     ;
label var   genmerc   "general merchand prog(04.08)"                                   ;
label var   hardwar   "hardware,build,prog(04.09)"                                     ;
label var   homefur   "home furnish sales prog(04.10)"                                 ;
label var   hotelmg   "motel, lodging manage prog(04.11)"                              ;
label var   indmark   "industrial market prog(04.12)"                                  ;
label var   insuran   "insurance manage and sell prog(04.13)"                          ;
label var   intl      "international trade prog(04.15)"                                ;
label var   pers      "personal serv prog(04.15)"                                      ;
label var   petro     "petroleum products prog(04.16)"                                 ;
label var   realst    "real estate and selling prog(04.17)"                            ;
label var   recr      "recreation and tourism prog(04.18)"                             ;
label var   transpo   "transportation serv prog(04.19)"                                ;
label var   retail    "retail trade prog(04.20)"                                       ;
label var   whsl      "wholesale trade prog(04.31)"                                    ;
label var   disted    "distributive educ,prog(04.99)"                                  ;
label var   total2    "number of offer in health prog"                                 ;
label var   da2       "dental assistant prog(07.0101)"                                 ;
label var   dh2       "dental hygiene prog(07.0102)"                                   ;
label var   dlt2      "dental lab tech prog(07.0103)"                                  ;
label var   dm2       "dental tech, misc prog(07.019)"                                 ;
label var   cytol     "cytology prog(07.0201)"                                         ;
label var   histo     "histology prog(07.0202)"                                        ;
label var   medlab    "med,biol lab assist prog(07.0203)"                              ;
label var   hemat     "hematology prog(07.0204)"                                       ;
label var   medbio    "med, biol lab, misc prog(07.0299)"                              ;
label var   assnur    "nursing(assoc deg) prog(07.0301)"                               ;
label var   pracnu    "nursing,(vocational)prog(07.0302)"                              ;
label var   asstnu    "nursing assist(aide) prog(07.0303)"                             ;
label var   psych     "psychiatric aide prog(07.0304)"                                 ;
label var   surg      "surgical tech prog(07.0305)"                                    ;
label var   nurso     "nursing, other prog(07.0399)"                                   ;
label var   occth     "occupational therapy prog(07.0401)"                             ;
label var   phyth     "physical therapy prog(07.0402)"                                 ;
label var   rehmi     "rehab services, misc prog(07.0499)"                             ;
label var   xrayt     "radiologic tech prog(07.0501)"                                  ;
label var   radth     "radiation therapy prog(07.0502)"                                ;
label var   nucle     "nuclear med tech prog(07.0503)"                                 ;
label var   xraym     "radiol occup, misc prog(07.0599)"                               ;
label var   optic     "optical tech prog(07.06)"                                       ;
label var   envir     "envir health tech prog(07.07)"                                  ;
label var   mental    "mental health tech prog(07.08)"                                 ;
label var   eectec    "electroencep tech prog(07.0901)"                                ;
label var   ekgtec    "electrocardiog tech prog(07.0902)"                              ;
label var   respth    "respiratory therapy prog(07.0903)"                              ;
label var   medast1   "med assistant prog(07.0904)"                                    ;
label var   healaid   "community health aide prog(07.0906)"                            ;
label var   meder     "med emergency tech prog(07.0907)"                               ;
label var   mortua    "mortuary sci prog(07.0909)"                                     ;
label var   medrec1   "med records tech prog(07.0915)"                                 ;
label var   physasst   "physicians assist prog(07.0920)"                               ;
label var   healmisc   "health occup, misc prog(07.99)"                                ;
label var   total3     "number of offer in home economics"                             ;
label var   childc     "care, guidance of child prog(09.0201)"                         ;
label var   cloth      "clothing, product and serv prog(09.0202)"                      ;
label var   foodmg     "food manage, product prog(09.0203)"                            ;
label var   homefur2   "home furnish, equip, serv prog(09.0204)"                       ;
label var   instmg1    "institut, home manage serv prog(09.0205)"                      ;
label var   homeech    "home economics, misc prog(09.0299)"                            ;
label var   total4     "number of office occup offering"                               ;
label var   account1   "accounting/bookkeeping(14.01)"                                 ;
label var   comput     "comput,equip oper tech prog(14.0201)"                          ;
label var   keypun     "keypunch operator prog(14.0202)"                               ;
label var   comprog    "comput programmer tech(14.0299)"                               ;
label var   systan     "systems analyst prog(14.0204)"                                 ;
label var   busdata    "bus data process sys prog(14.0299)"                            ;
label var   genoff     "filling,gen office occup prog(14.03)"                          ;
label var   infocom    "information comm prog(14.04)"                                  ;
label var   matsupp    "materials occup prog(14.05)"                                   ;
label var   person     "personnel, training occup prog(14.06)"                         ;
label var   secret1    "stenographic, secret occup prog(14.07)"                        ;
label var   supadm     "supervise, administr manage prog(14.08)"                       ;
label var   typin      "typing and clerical occup prog(14.09)"                         ;
label var   offmisc    "office occupation, misc prog(14.99)"                           ;
label var   total5     "total number of offer in tech educ"                            ;
label var   aerotec    "aeronautical tech prog(16.0101)"                               ;
label var   agritec    "agricultural tech prog(16.0102)"                               ;
label var   achtec     "architectural tech prog(16.0103)"                              ;
label var   autotec    "automotive tech prog(16.0104)"                                 ;
label var   chemtec    "chemical tech prog(16.0105)"                                   ;
label var   civiltec   "civil tech prog(16.0106)"                                      ;
label var   electtec   "electrical tech prog(16.0107)"                                 ;
label var   electron   "electron, mach tech prog(16.0108)"                             ;
label var   elemech1   "electomech tech prog(16.0109)"                                 ;
label var   envircnt   "envir control tech prog(16.0110)"                              ;
label var   indtech2   "industrial tech prog(16.0111)"                                 ;
label var   instrtec   "instrumentation tech prog(16.0112)"                            ;
label var   mechtec    "mech and engin tech prog(16.0113)"                             ;
label var   metalgy    "metallurgical tech prog(16.0114)"                              ;
label var   nucletec   "nuclear tech prog(16.0115)"                                    ;
label var   petrotec   "petroleum tech prog(16.0116)"                                  ;
label var   scidata    "sci data process tech prog(16.0117)"                           ;
label var   legasst    "food processing tech"                                          ;
label var   compilot   "commercial pilot train prog(16.0601)"                          ;
label var   firetech   "fire, fire safety tech prog(16.060)"                           ;
label var   forestec   "forestry, wildlife tech prog(16.06)"                           ;
label var   oceantec   "oceanographic tech prog(16.0604)"                              ;
label var   police1    "police science tech prog(16.0605)"                             ;
label var   teachast   "education tech"                                                ;
label var   libasst    "library assist tech prog(16.0607)"                             ;
label var   bdcstech   "comm, broadcast tech prog(16.0609)"                            ;
label var   arts       "performing artists prog(16.0695)"                              ;
label var   tecedmis   "tech education, misc prog(16.001)"                             ;
label var   airpolt    "air pollution tech prog (16.0695)"                             ;
label var   watertec   "water, waste water tech prog"                                  ;
label var   total6     "number of offer for trade,ind occup"                           ;
label var   acrepair   "air cond install, repair prog(17.01)"                          ;
label var   applirep   "appliance repair prog(17.02)"                                  ;
label var   autorep    "automotive body repair prog(17.0301)"                          ;
label var   automech   "automotive mechanics prog(17.0302)"                            ;
label var   autospec   "auto specialize repair prog(17.0303)"                          ;
label var   autoserv   "automotive serv prog(17.0399)"                                 ;
label var   aircrm     "aircraft maintenance prog(17.0401)"                            ;
label var   aircro     "aircraft operations prog(17.0402)"                             ;
label var   ground     "aircraft grounds oper prog(17.0403)"                           ;
label var   bluepr     "blueprint reading prog(17.05)"                                 ;
label var   busmech    "business mach maint occup prog(17.06)"                         ;
label var   commart    "commercial art prog(17.07)"                                    ;
label var   comfish    "commercial fishery occup prog(17.08)"                          ;
label var   comphot    "commercial photography prog(17.09)"                            ;
label var   carpent    "carpentry-construct prog(17.1001)"                             ;
label var   eleccon    "electricity-construct prog(17.1002)"                           ;
label var   constr1    "constr equip,operation prog(17.1003)"                          ;
label var   mason      "masonry-construct prog(17.1004)"                               ;
label var   paint      "painting, decor-construct prog(17.1005)"                       ;
label var   plast      "plaster-construct prog(17.1006)"                               ;
label var   plumb      "plumb and pipefit-constr prog(17.1007)"                        ;
label var   drywa      "drywall install-constr prog(17.1008)"                          ;
label var   glaze      "glazing-construct prog(17.1009)"                               ;
label var   roof       "roofing-construct prog(17.1010)"                               ;
label var   const      "construct, build tech prog(17.1099)"                           ;
label var   custo      "custodial serv prog(17.11)"                                    ;
label var   diese      "diesel mechanic prog(17.12)"                                   ;
label var   draft      "drafting occup prog(17.13)"                                    ;
label var   eleocc     "electrical occup prog(17.14)"                                  ;
label var   radio      "radio,tv repair occup prog(17.1503)"                           ;
label var   electrn    "electronics occup prog(17.1599)"                               ;
label var   fabric     "fabric maint serv prog(17.16)"                                 ;
label var   forema     "foreman,manage dev prog(17.17)"                                ;
label var   graph      "graphic arts occup prog(17.19)"                                ;
label var   atomic     "indust atomic energy occup prog(17.20)"                        ;
label var   instr      "instr maint, repairs occup prog(17.21)"                        ;
label var   mariti     "maritime occup prog(17.22)"                                    ;
label var   machsh     "machine shop occup prog(17.2302)"                              ;
label var   machto     "machine tool oper prog(17.2303)"                               ;
label var   weld       "weld and cutting occup prog(17.2306)"                          ;
label var   tool       "tool, die making occup prog(17.2307)"                          ;
label var   metwork    "metalwork occup, misc prog(17.2399)"                           ;
label var   metalg     "metallurgy occup prog(17.24)"                                  ;
label var   barb       "barbering occup prog(17.2601)"                                 ;
label var   cosme      "cosmetology prog(17.2602)"                                     ;
label var   pers2      "personal serv,trade,ind prog(17.2699)"                         ;
label var   plasti     "plastics occup prog(17.27)"                                    ;
label var   fireman    "fireman training prog(17.2801)"                                ;
label var   lawenf     "law enforce training prog(17.2802)"                            ;
label var   pubserv    "public service ocup prog(17.2899)"                             ;
label var   quantfo    "quality food occup prog(17.29)"                                ;
label var   refrig     "refrigeration engin prog(17.30)"                               ;
label var   engine     "small engine repair prog(17.31)"                               ;
label var   staener    "stationary energy occup prog(17.32)"                           ;
label var   textile    "textile product,fabric prog(17.33)"                            ;
label var   leather    "leatherwork prog(17.34)"                                       ;
label var   upholst    "upholster prog(17.35)"                                         ;
label var   woodwor    "woodwork prog(17.36)"                                          ;
label var   truck      "truck driving prog(17.4000)"                                   ;
label var   doggroo    "dog grooming prog(17.50)"                                      ;
label var   trademi    "trade,indust occup, misc prog(17.99)"                          ;
label var   total8     "number of data process tech offer"                             ;
label var   dptech     "data process tech, general prog(5101)"                         ;
label var   keypunch   "keypunch operator,input tech prog(5102)"                       ;
label var   program    "computer program tech prog(5103)"                              ;
label var   periphe    "comput operator,equip tech prog(5104)"                         ;
label var   equipma    "data process equip maint tech prog(5105)"                      ;
label var   other1     "related prog not in the above subject(51"                      ;
label var   total9     "number of offer health serv paramed prog"                      ;
label var   healgen    "health serv assist tech,gen prog(5201)"                        ;
label var   da3        "dental assistant tech prog(5202)"                              ;
label var   dh3        "dental hygiene tech prog(5203)"                                ;
label var   dl3        "dental lab tech prog(5204)"                                    ;
label var   medbio3    "med, biol lab assist tech prog(5205)"                          ;
label var   animal     "animal lab assist tech prog(5206)"                             ;
label var   xray2      "radiologic(x-ray, etc)tech prog(5207)"                         ;
label var   nursrn     "nursing,(less than 4 year)prog(5208)"                          ;
label var   nurspr     "nursing, practical prog(5209)"                                 ;
label var   occthr     "occup therapy tech prog(5210)"                                 ;
label var   surgica    "surgical tech prog(5211)"                                      ;
label var   optic2     "optical tech prog(5212)"                                       ;
label var   medrec2    "med record tech prog(5213)"                                    ;
label var   medast2    "med assist tech prog(5214)"                                    ;
label var   inhalth    "inhalation therapy tech prog(5215)"                            ;
label var   psychia    "psychiatric tech prog(5216)"                                   ;
label var   elecdia    "electro diagnostic tech prog(5217)"                            ;
label var   instmg2    "institute management tech prog(5218)"                          ;
label var   phythe     "physical therapy tech(5219)"                                   ;
label var   other2     "prog not in above subject(5299)"                               ;
label var   total10    "number offer from mech, eng tech area"                         ;
label var   megen      "mech and engin tech, gen prog(5301)"                           ;
label var   aero2      "aeronaut and aviation tech prog(5302)"                         ;
label var   enggra     "engin and aviation tech prog(5302)"                            ;
label var   archit     "architecture draft tech prog(5304)"                            ;
label var   chemic     "chemical tech prog(5305)"                                      ;
label var   automo     "automotive tech prog(5306)"                                    ;
label var   diesel2    "diesel tech prog(5307)"                                        ;
label var   weld2      "welding tech prog(5308)"                                       ;
label var   civil      "civil tech prog(5309)"                                         ;
label var   electro    "elec and machine tech prog(5310)"                              ;
label var   elemech2   "electromech tech prog(5311)"                                   ;
label var   indust     "industrial tech prog(5312)"                                    ;
label var   textil     "textle tech prog(5313)"                                        ;
label var   instru     "instrumentation tech prog(5315)"                               ;
label var   mechan     "mechanical tech prog(5315)"                                    ;
label var   nuclea     "nuclear tech prog(5316)"                                       ;
label var   constr2    "constr and build tech prog(5317)"                              ;
label var   other3     "prog not in the above subject(5399)"                           ;
label var   total11    "number offer from nat sci tech areas"                          ;
label var   natsch     "nat sciences tech, gen prog(5401)"                             ;
label var   agri       "agriculture tech prog(5402)"                                   ;
label var   forest2    "forestry, wildlife tech prog(5403)"                            ;
label var   foodse     "food serv tech  prog(5404)"                                    ;
label var   homeec     "home economics tech prog(5405)"                                ;
label var   marine     "marine,oceanographic tech prog(5406)"                          ;
label var   labtech    "lab tech, general prog(5407)"                                  ;
label var   sanitat    "sanitat, pub health inspect prog(5408)"                        ;
label var   other4     "prog not in the above areas (5499)"                            ;
label var   total12    "number offer from bus and commerce tech"                       ;
label var   buscom     "bus and commerce tech, gen prog(5001)"                         ;
label var   account2   "accounting tech prog(5002)"                                    ;
label var   bankfin    "banking and finance tech prog(5003)"                           ;
label var   manage     "market distr, bus,indust tech prog(5004)"                      ;
label var   secret2    "secretarial tech prog(5006)"                                   ;
label var   persona    "personal service tech prog(5006)"                              ;
label var   photogr    "photography tech prog(5007)"                                   ;
label var   commbrd    "commun and broadcast tech prog(5008)"                          ;
label var   print      "print and lithography tech prog(5009)"                         ;
label var   hotel      "hotel,restaurant manage tech prog(5010)"                       ;
label var   trans      "transport and pub util tech prog(5011)"                        ;
label var   art        "appl arts, graphic, fine arts prog(5012)"                      ;
label var   other5     "prog not in the above subject (5099)"                          ;
label var   total13    "offer from public serv tech subject area"                      ;
label var   pubseg     "public service tech, general prog(5501)"                       ;
label var   relig      "bible, religion related occup prog(5502)"                      ;
label var   educa      "educ(2 year teach train prog) prog(5503)"                      ;
label var   librar     "library assist tech prog(5504)"                                ;
label var   police2    "police, law enforcement tech prog(5505)"                       ;
label var   social     "recreation and soc work tech prog(5506)"                       ;
label var   fire       "fire control tech prog(5507)"                                  ;
label var   admin      "pub administr and manage tech prog(5508)"                      ;
label var   other6     "prog not in the above areas(5599)"                             ;
label var   printc     "indicate schl is listed in postsec voc d"                      ;
label var   errorf     "for internal use only";          
label var respc "response code of school";                      
label var hegis "whether schl covered by HEGIS control fi";         
label var sample "indicates whether school was sampled"; 
label var addstat "status of school's address"; 
label var totprog "total number of programs offered by school"; 
label var size "total enrollment size of school"; 
label var areavoc "area vocational school?"; 
label var dte "Jt Comm Dance & Theater Accred: dance & theater education programs" ;
label var mae "Accred Bureau of Health Ed Schls: med assistant programs" ; 
label var entert "Entertainment Services (dealer, bartenders)(04.08)";
label var tailor "Tailoring (09.0202)"; 

** DEAL WITH CATEGORICAL VARS;
* AFFILIATION;
for   any A B C D E F N O 9
	\ any None Branch Chain Parent Other Other None Other None
	: replace affil = "Y" if affil == "X"; 

for   any 1 2 3 4 5 6 
	\ any None Branch Chain Parent Other Missing
	: replace affil = "Y" if affil == "X"; 

replace affil = "Missing" if affil == "" | affil == "0" | affil == "Y"; 	
	
for   any A B C D E F G H I J K L 
	\ any "Vocational and technical" "Technical only" "Business and commercial" "Cosmetology and barber" "Flight" Trade "Arts and design"                                                    
			Hospital "Junior, community college"  College Other "Allied health"
	: replace schlc = "Y" if schlc == "X";                                                      

for   any A B C D 
	\ any Public FP NP "Religious NP"
	: replace control = "Y" if control == "X";  	

for   any 1 2 3 
	\ any Public FP NP
	: replace control = "Y" if control == "X"; 
	
for   any A B C D E F 
	\ any Northeast "Middle States"  "North Central" Northwest Southern Western
	: replace asso = "Y" if asso == "X"; 

replace corres = "" if corres == "0"; 
replace corres = "1" if corres == "1" | corres == "2" | corres == "Y"; 
replace corres = "0" if corres == "3" | corres == "N";
destring corres, replace force; 
	
foreach v of var accred accstat {;
	replace `v' = "0" if `v' == "N"; 
	replace `v' = "1" if `v' == "Y"; 
	destring `v' , replace force; 
};

gen stabbr = ""; 
for   any 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 28 29 30 31 32 33 
	\ any AL AK AZ AR CA CO CT DE DC FL GA HI ID IL IN IA KS LA ME MD MA MI MN 
	: replace stabbr = "Y" if edscode == X; 

for   any 34 35 36 37 38 39 40 41 43 44 45 46 47 48 49 50 51 52 54 55 56 57 58 59 
	\ any MS MO MT NE NV NH NJ NM NC ND OH OK OR PA RI SC SD TN UT VT VA WA WV WI 
	: replace stabbr = "Y" if edscode == X; 
	
replace stabbr = "KY" if edscode == 27; 
replace stabbr = "NY" if edscode == 42; 
replace stabbr = "TX" if edscode == 53; 
replace stabbr = "WY" if edscode == 60; 
	
drop if inlist(edscode,61,62,63,64,65,66); 
drop edscode; 

/* respc values 
   3 = "Closed"                                                            
   4 = "Out of scope"                                                      
   5 = "Merged"                                                            
   6 = "Affiliated with jr.sr. college"                                    
   10 = "Nonresponse"                                                      
   11 = "Postmaster return"                                                
   12 = "Refusal"                                                          
   18 = "Incomplete Data"                                                  
   19 = "Complete response"
                           
corres values for 1978
   "1" = "Only correspondence offered"                                     
   "2" = "Some correspondence offered"                                     
   "3" = "No correspondence offered"                                       
   "9" = "Not reported"                                                   
*/	
	                     
* DROP VARIABLES WE DON'T NEED;
drop phone distno errorf respc sample;

* FORMATTING;
foreach v of var name name2 street street2 city city2 {; replace `v' = ltrim(rtrim(itrim(proper(`v')))); };

tostring vennumb, replace; gen opeid = vennumb+"00"; 
destring vennumb, replace; destring opeid, replace; replace opeid = . if vennumb == . | vennumb == 0	; drop vennumb; 
move opeid sernumb; move year sernumb; move stabbr sernumb;

replace founded = . if founded<1740 | founded> 1985;

* FILL IN BLANK OPEIDS IN LATER YEARS;
bysort stabbr sernumb (year): replace opeid = opeid[_n-1] if opeid == . & opeid[_n-1] ~=. & stabbr == stabbr[_n-1] & sernumb == sernumb[_n-1];

* FIX OBS WITH INCORRECT OPEIDS;
replace opeid = . if name == "O'Bryans Styling Academy" & stabbr== "IN"; 
replace opeid = . if name == "Nancy Bounds Model-Charm School And Agency" & stabbr== "NE"; 
replace opeid = . if name == "R E T S Electronic Schools" & stabbr == "PA"; 

* FOR NOW, KEEP INFO ON LOCATION, OVERALL ENROLLMENT, SECTOR, ACCREDITATIONS, AND BROAD OFFERINGS CATEGORIES;
keep opeid year street stabbr sernumb name fips zip affil schlc ftpt corres control accstat mlt - accred fisl va pell total* founded ;

rename street address; 

* HEALTH PROGRAMS ACCREDITITED?;
gen acc_health = mlt==1 | anes == 1 | dh1 ==1 | da1 ==1 | dt1 == 1 | mltama == 1 | mrt == 1 | mt == 1 | pas == 1 | hist == 1 | mae ==1 | 
	nmt == 1 | rtt == 1 | rt == 1 | ct == 1 | it == 1 | ma == 1 | napnes == 1 | adn == 1 | nur == 1 | pn == 1 | antech == 1 | fse == 1 ; 

* BUSINESS PROGRAMS ACCREDITITED?;
gen acc_bus = aics == 1 ;

* ARTS PROGRAMS ACCREDITITED?;
gen acc_arts = dte == 1 | id == 1; 

* COSMETOLOGY PROGRAMS ACCREDITITED?;
gen acc_cos = cac == 1;

* TECH PROGRAMS ACCREDITITED?;
gen acc_tech = ecpd == 1 | natts == 1 ;

drop mlt - antech;

* RECODE OFFERING VARIABLES TO BE BINARY (RATHER THAN NUMBER OF PROGS OFFERED);
foreach v of var total* {; recode `v' (. = 0); replace `v' = 1 if `v'>1; }; 

gen offers_agri = total1==1; drop total1; 
egen offers_health = rowmax(total2 total9) ; drop total2 total9; 
egen offers_homeec_dist = rowmax(total total3 ) ; drop total total3 ; 
gen offers_tradeindust = total6; drop total6; 
egen offers_office_bus = rowmax(total4 total12) ; drop total4 total12;
egen offers_tech = rowmax(total5 total10 total11); drop total5 total10 total11;
gen offers_data = total8==1; drop total8; 
gen offers_pubsvc = total13 ==1; drop total13; 

tostring zip, replace; 

for   any FP NP "Religious NP" Public
	\ any 3 2 2 1 
	: replace control = "Y" if control == "X"; 
	
destring control, replace; 

foreach v of var corres ftptt accstat accred fisl va pell {; recode `v' (. = 0); };


compress;


* FIRST KEEP RECORDS WITH OPEIDS;
preserve;

	keep if opeid ~=.; drop sernumb; 
	
* FIX SOME INCORRECT OPEIDS;
	recode opeid (300 = 165000 ) (6000 =  267800) (49100 = 849100) (103900 = 2270400) (106400 = 2154800) (122200 = 2226000) (126400 = 1014900)
		(425800 = 614800) (998000 = 569900) (1161200 = 2319500) (1031100 = 109700) (997700 = 2075300) (1317600 = 2074600)  (807000 = 792100)
		(764600 = 3007100)	(2914200 = 2200000) (955200 = 123200) (830600 = 672000) (863100 = 2299600) (1304700 = 2205700) (566600 = 1046300)
		(1027400 = 1324000) (1295500 = 2153900) (1304500 = 2121200) (1304900 = 2122400) (1124600 = 2065500) (705100  = 1306400)
		(725700 = 2288500) (809200 = 2298300) (1171200 = 2231900) (725400 = 2147600) (721600 =  2150200) (720200 = 2185800) (725200 = 2051200)
		(725000 = 2051100) (1256300 = 1250200) (825400 = 2079100) (2909000 = 2136200) (2916600 = 2116300) (1095700 = 2141100) 
		(2901300 = 141700) (2917000 = 2110100) (2910000 = 701500) (1138700 = 2144900) (980400 = 2080600) (149200 = 2057900) (774200 = 2112400)
		(2902800 = 2055000) (1039000 = 1122000) (2902000 = 161100) (831600 = 458900) (1035900 = 186400) (873500 = 458900) (874000 = 460300)
		(2090300 = 771600) (873600 = 840300) (422500 = 1141200) (1195500 = 1280900) (167200 = 1072700) (933200 = 1006200) (765000 = 760900)
		(2905000 = 164700) (621800 = 1354100) (2908500 = 2074400) (1100200 = 2124400) (163000 = 2147000) (893700 = 2168800) (2915300 = 2055200)
		(956300 = 180700) (181200 = 182800) (2912400 = 945700) (2903400 = 794400) (548500 = 547100) (462200 = 768600) (1120700 = 2055500)
		(963600 = 202500) (1203300 = 2055400) (2909900 = 222500) (1029700 = 926900) (208200  = 691100) (734500 = 209100) (2911600 = 2155100)
		(2905300 = 2073900) (577800 = 915300) (909200 = 232500) (396800 = 1239900) (876000 = 230300) (817700 = 1383500) (2909100 = 2088200)
		(1046800 = 1408700) (436900 = 2508000) (797800 = 2122100) (930200 = 1384900) (965500 = 2137400) (1197400 = 2165900) (710200 = 246800)
		(2902900 = 2056000) (2914400 = 2266400) (1042900 = 1040500) (242000 = 241700) (469100 = 1190400) (808400 = 531600) (921500 = 2056700)
		(926500 = 299700) (2900700 = 472000) (759100 = 2508300) (696400 = 262900) (613900 = 2232500) (994900 = 766400) (1288600 = 2067700)
		(1164800 = 2192200) (745000 = 1300500) (1031300 = 26630) (528600 = 2083900) (1118500 = 2511000) (2908700 = 2083900)
		(1103000 = 479900) (278000 = 2066200) (751700 = 1378600) (741400 = 2056400) (1263300 = 1256100) (895000 = 1441000) (904200  = 1300200)
		(986100 = 1277800) (751700 = 1378600) (2918000 = 2106800) (2904000 = 268600) (942900 = 2105900) (2911800 = 2118700) (710300 405300 1028800 879700 = 304000)
		(688300 = 309000) (879500 = 301000) (710400 = 307700) (1274800 = 994200) (1227000 = 1275000) (305200 305600 306100 305400 306400 306200 = 305100)
		(710400 = 307700) (1274800  = 994200) (742300 = 2137500) (317100 = 964700) (782100 = 2076500) (941300 = 1299800) (958500 = 1114300)
		(923500 = 331800) (718400   405100  405200 = 323100) (1166000  = 653900) (591600 = 708900) (1247700 = 2506300) (594100 = 656300)
		(594800 = 656600) (1030400 = 337100) (589800 = 690800) (595000 = 656600) (594700 = 1017700) (941300 = 1299800) (589800 = 690800)
		(1154100 591500 = 962500) (889200 = 2063400) (889000 = 2127100) (881000 = 327700) (1158600  = 1411900) (921600 = 1372400)
		(696500 = 332900) (491700 905600 = 341000) (492100 2911100 = 2256800) (881800 = 492000) (2911200 = 2143700) (868500 = 2137100)
		(2904700 = 694000) (785700 = 728700) (495800 = 681700) (666200 = 497200) (890000 889900 1096400 889800 = 362600) (604700 = 363200) (696700 = 354500)
		(2906500 = 356100) (2906600 = 2077400) (2915000 = 2100200) (1212900 = 1082200) (970500  = 378700) (2901900 = 2106700) (728800 = 538900)
		(529700 = 919400) (925800 = 529400) (664100 = 1323800) (925700 = 530100) (537000 = 1182400) (938800 = 2070100) (757700 = 2112600)
		(738200 = 2076600) (1229400 = 904400) (2256800 = 1012900) (690900 = 2244800) (2902700 = 2063500) (927300 =  729600) (868000 = 1291200)
		(2912800 = 2119100) (2910600 = 2242700) (1125400 = 617500) (2916300 = 450700) (434200 = 618100)  (1172800 1215500 452900 = 153400) 
		(712200 = 459800) (187200 = 460300) (414800 = 621600) (621500 = 414600) (579600 = 632300) (583800 = 797700) (584400 = 636000) ( 584300 = 635900 )
		(584500  = 636100 ) (875900  = 407200) (230400  = 230300) (543500 = 249100) (1179800 = 648300) (508700 = 300300) ( 508900  =  648400 )
		(1300400 = 2532000) (26630  = 266300 ) (751900 = 1201200) (506300 = 646100) (1314300 = 737800) (1171600  = 283400) (512100 =  1289400)
		(512900  =  650900 ) (514300 = 651900 ) (2910100  = 323100) (593000  592900 = 655400) (895300 = 1258300) ( 1061400  = 2314400) (689900  = 1304000 )
		(1282600  = 361200) ( 1161800  = 495100 ) (1148300 = 664300 )   ; 	

* DEAL WITH DUPLICATE OBS; 
* DROP SOME DUPLICATE OBS WITH ALL MISSING DATA;
	foreach o in 404900 611300 809000 1111200  {;
		drop if opeid == `o' & year == 1981 & control ==.; 
	};

* SUM ENROLLMENT AND ANY ACCREDITATION, OFFERINGS, ETC;
	bysort opeid year: gen count = _N; 
	bysort opeid year: egen	sum = total(ftptt); replace ftptt = sum if count>1; drop sum; 
	
	foreach v of var corres accstat accred fisl va pell acc_* offers_* {; 
		bysort opeid year: egen max = max(`v'); replace `v' = max if count>1; drop max; 
	};
	
	bysort opeid: egen min = min(founded); replace founded = min; drop min; 
	
* DROP "PARENT" DUPLICATE OBS;
	drop if count>1 & affil == "Parent"; drop count;
	
	bysort opeid year: gen count = _N; 
	
* DROP DUPLICATE OBS WITH MISSING CONTROL;
	drop if count>1 & control ==.; drop count; 
	
	bysort opeid year: gen count = _N; 

* DROP DUPLICATE OBS WITH MISSING FIPS;
	drop if count>1 & fips == .; drop count;
	
	bysort opeid year: gen count = _N; 

* DROP DUPLICATE OBS WITH MISSING AFFILIATION;
	drop if count>1 & affil == "Missing"; drop count; 
	
	bysort opeid year: gen count = _N; 
	 				 			
* KEEP ONE OB FROM EACH REMAINING DUPLICATE PAIR;
	bysort opeid year: gen num = _n; drop if count >1 & num > 1; 
	drop count num; 
	
* DROP OBS WITH CLEARLY INCORRECT OPEIDS THAT I CANNOT CORRECT;
	drop if opeid == 800; 

* DROP OBS WITH MISSING CONTROL AND ZERO ENROLLMENT; 
	drop if ftptt == 0 & control == .; 
	
	save "${intermediate}/pcss_has_opeid", replace;
	
restore;

* RECORDS WITHOUT OPEIDS;
preserve;

	keep if opeid ==.; drop opeid; 
	
* DROP ZERO ENROLLMENT OBS;
	drop if ftptt ==0; 
	
* DROP DUPLICATE NAME-ZIP-YEAR OBS;
* SUM ENROLLMENT AND ANY ACCREDITATION, OFFERINGS, ETC;
	bysort zip name year: gen count = _N; 
	bysort zip name year: egen	sum = total(ftptt); replace ftptt = sum if count>1; drop sum; 
	
	foreach v of var corres accstat accred fisl va pell acc_* offers_* {; 
		bysort zip name  year: egen max = max(`v'); replace `v' = max if count>1; drop max; 
	};
	
	bysort zip name year : egen min = min(founded); replace founded = min; drop min; 

* KEEP ONE OB FROM EACH REMAINING DUPLICATE PAIR;
	bysort zip name year (fips): gen num = _n; drop if count >1 & num > 1; 
	drop count num; 
		
	gen len = length(zip); replace zip = "0"+zip if len == 4; drop len; 
	 
	save "${intermediate}/pcss_no_opeid", replace;

restore;

erase scrap.dta; 
