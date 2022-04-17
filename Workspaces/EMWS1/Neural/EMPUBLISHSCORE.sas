***********************************;
*** Begin Scoring Code for Neural;
***********************************;
DROP _DM_BAD _EPS _NOCL_ _MAX_ _MAXP_ _SUM_ _NTRIALS;
 _DM_BAD = 0;
 _NOCL_ = .;
 _MAX_ = .;
 _MAXP_ = .;
 _SUM_ = .;
 _NTRIALS = .;
 _EPS =                1E-10;
LENGTH _WARN_ $4
      I_class  $ 20
      U_class  $ 20
;
      label S_AvgAge = 'Standard: AvgAge' ;

      label S_AvgTumorSize = 'Standard: AvgTumorSize' ;

      label S_Avginv_node_group = 'Standard: Avginv_node_group' ;

      label S_deg_malig = 'Standard: deg_malig' ;

      label IMP_node_capsno = 'Dummy: IMP_node_caps=no' ;

      label breastleft = 'Dummy: breast=left' ;

      label irradiatno = 'Dummy: irradiat=no' ;

      label age20_29 = 'Dummy: age=20-29' ;

      label age30_39 = 'Dummy: age=30-39' ;

      label age40_49 = 'Dummy: age=40-49' ;

      label age50_59 = 'Dummy: age=50-59' ;

      label age60_69 = 'Dummy: age=60-69' ;

      label breast_quadcentral = 'Dummy: breast_quad=central' ;

      label breast_quadleft_low = 'Dummy: breast_quad=left_low' ;

      label breast_quadleft_up = 'Dummy: breast_quad=left_up' ;

      label breast_quadright_low = 'Dummy: breast_quad=right_low' ;

      label inv_nodes0_2 = 'Dummy: inv_nodes=0-2' ;

      label inv_nodes12_14 = 'Dummy: inv_nodes=12-14' ;

      label inv_nodes15_17 = 'Dummy: inv_nodes=15-17' ;

      label inv_nodes24_26 = 'Dummy: inv_nodes=24-26' ;

      label inv_nodes3_5 = 'Dummy: inv_nodes=3-5' ;

      label inv_nodes6_8 = 'Dummy: inv_nodes=6-8' ;

      label menopausege40 = 'Dummy: menopause=ge40' ;

      label menopauselt40 = 'Dummy: menopause=lt40' ;

      label tumor_size0_4 = 'Dummy: tumor_size=0-4' ;

      label tumor_size10_14 = 'Dummy: tumor_size=10-14' ;

      label tumor_size15_19 = 'Dummy: tumor_size=15-19' ;

      label tumor_size20_24 = 'Dummy: tumor_size=20-24' ;

      label tumor_size25_29 = 'Dummy: tumor_size=25-29' ;

      label tumor_size30_34 = 'Dummy: tumor_size=30-34' ;

      label tumor_size35_39 = 'Dummy: tumor_size=35-39' ;

      label tumor_size40_44 = 'Dummy: tumor_size=40-44' ;

      label tumor_size45_49 = 'Dummy: tumor_size=45-49' ;

      label tumor_size5_9 = 'Dummy: tumor_size=5-9' ;

      label H11 = 'Hidden: H1=1' ;

      label H12 = 'Hidden: H1=2' ;

      label H13 = 'Hidden: H1=3' ;

      label I_class = 'Into: class' ;

      label U_class = 'Unnormalized Into: class' ;

      label P_classrecurrence_events = 'Predicted: class=recurrence-events' ;

      label P_classno_recurrence_events =
'Predicted: class=no-recurrence-events' ;

      label  _WARN_ = "Warnings";

*** Generate dummy variables for IMP_node_caps ;
drop IMP_node_capsno ;
if missing( IMP_node_caps ) then do;
   IMP_node_capsno = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm3 $ 3; drop _dm3 ;
   _dm3 = put( IMP_node_caps , $3. );
   %DMNORMIP( _dm3 )
   if _dm3 = 'NO'  then do;
      IMP_node_capsno = 1;
   end;
   else if _dm3 = 'YES'  then do;
      IMP_node_capsno = -1;
   end;
   else do;
      IMP_node_capsno = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;

*** Generate dummy variables for breast ;
drop breastleft ;
if missing( breast ) then do;
   breastleft = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm5 $ 5; drop _dm5 ;
   _dm5 = put( breast , $5. );
   %DMNORMIP( _dm5 )
   if _dm5 = 'LEFT'  then do;
      breastleft = 1;
   end;
   else if _dm5 = 'RIGHT'  then do;
      breastleft = -1;
   end;
   else do;
      breastleft = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;

*** Generate dummy variables for irradiat ;
drop irradiatno ;
if missing( irradiat ) then do;
   irradiatno = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm3 $ 3; drop _dm3 ;
   _dm3 = put( irradiat , $3. );
   %DMNORMIP( _dm3 )
   if _dm3 = 'NO'  then do;
      irradiatno = 1;
   end;
   else if _dm3 = 'YES'  then do;
      irradiatno = -1;
   end;
   else do;
      irradiatno = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;

*** Generate dummy variables for age ;
drop age20_29 age30_39 age40_49 age50_59 age60_69 ;
*** encoding is sparse, initialize to zero;
age20_29 = 0;
age30_39 = 0;
age40_49 = 0;
age50_59 = 0;
age60_69 = 0;
if missing( age ) then do;
   age20_29 = .;
   age30_39 = .;
   age40_49 = .;
   age50_59 = .;
   age60_69 = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm5 $ 5; drop _dm5 ;
   _dm5 = put( age , $5. );
   %DMNORMIP( _dm5 )
   _dm_find = 0; drop _dm_find;
   if _dm5 <= '40-49'  then do;
      if _dm5 <= '30-39'  then do;
         if _dm5 = '20-29'  then do;
            age20_29 = 1;
            _dm_find = 1;
         end;
         else do;
            if _dm5 = '30-39'  then do;
               age30_39 = 1;
               _dm_find = 1;
            end;
         end;
      end;
      else do;
         if _dm5 = '40-49'  then do;
            age40_49 = 1;
            _dm_find = 1;
         end;
      end;
   end;
   else do;
      if _dm5 <= '60-69'  then do;
         if _dm5 = '50-59'  then do;
            age50_59 = 1;
            _dm_find = 1;
         end;
         else do;
            if _dm5 = '60-69'  then do;
               age60_69 = 1;
               _dm_find = 1;
            end;
         end;
      end;
      else do;
         if _dm5 = '70-79'  then do;
            age20_29 = -1;
            age30_39 = -1;
            age40_49 = -1;
            age50_59 = -1;
            age60_69 = -1;
            _dm_find = 1;
         end;
      end;
   end;
   if not _dm_find then do;
      age20_29 = .;
      age30_39 = .;
      age40_49 = .;
      age50_59 = .;
      age60_69 = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;

*** Generate dummy variables for breast_quad ;
drop breast_quadcentral breast_quadleft_low breast_quadleft_up
        breast_quadright_low ;
*** encoding is sparse, initialize to zero;
breast_quadcentral = 0;
breast_quadleft_low = 0;
breast_quadleft_up = 0;
breast_quadright_low = 0;
if missing( breast_quad ) then do;
   breast_quadcentral = .;
   breast_quadleft_low = .;
   breast_quadleft_up = .;
   breast_quadright_low = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm9 $ 9; drop _dm9 ;
   _dm9 = put( breast_quad , $9. );
   %DMNORMIP( _dm9 )
   if _dm9 = 'LEFT_UP'  then do;
      breast_quadleft_up = 1;
   end;
   else if _dm9 = 'LEFT_LOW'  then do;
      breast_quadleft_low = 1;
   end;
   else if _dm9 = 'RIGHT_UP'  then do;
      breast_quadcentral = -1;
      breast_quadleft_low = -1;
      breast_quadleft_up = -1;
      breast_quadright_low = -1;
   end;
   else if _dm9 = 'CENTRAL'  then do;
      breast_quadcentral = 1;
   end;
   else if _dm9 = 'RIGHT_LOW'  then do;
      breast_quadright_low = 1;
   end;
   else do;
      breast_quadcentral = .;
      breast_quadleft_low = .;
      breast_quadleft_up = .;
      breast_quadright_low = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;

*** Generate dummy variables for inv_nodes ;
drop inv_nodes0_2 inv_nodes12_14 inv_nodes15_17 inv_nodes24_26 inv_nodes3_5
        inv_nodes6_8 ;
*** encoding is sparse, initialize to zero;
inv_nodes0_2 = 0;
inv_nodes12_14 = 0;
inv_nodes15_17 = 0;
inv_nodes24_26 = 0;
inv_nodes3_5 = 0;
inv_nodes6_8 = 0;
if missing( inv_nodes ) then do;
   inv_nodes0_2 = .;
   inv_nodes12_14 = .;
   inv_nodes15_17 = .;
   inv_nodes24_26 = .;
   inv_nodes3_5 = .;
   inv_nodes6_8 = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm5 $ 5; drop _dm5 ;
   _dm5 = put( inv_nodes , $5. );
   %DMNORMIP( _dm5 )
   if _dm5 = '0-2'  then do;
      inv_nodes0_2 = 1;
   end;
   else if _dm5 = '3-5'  then do;
      inv_nodes3_5 = 1;
   end;
   else if _dm5 = '6-8'  then do;
      inv_nodes6_8 = 1;
   end;
   else if _dm5 = '9-11'  then do;
      inv_nodes0_2 = -1;
      inv_nodes12_14 = -1;
      inv_nodes15_17 = -1;
      inv_nodes24_26 = -1;
      inv_nodes3_5 = -1;
      inv_nodes6_8 = -1;
   end;
   else if _dm5 = '15-17'  then do;
      inv_nodes15_17 = 1;
   end;
   else if _dm5 = '12-14'  then do;
      inv_nodes12_14 = 1;
   end;
   else if _dm5 = '24-26'  then do;
      inv_nodes24_26 = 1;
   end;
   else do;
      inv_nodes0_2 = .;
      inv_nodes12_14 = .;
      inv_nodes15_17 = .;
      inv_nodes24_26 = .;
      inv_nodes3_5 = .;
      inv_nodes6_8 = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;

*** Generate dummy variables for menopause ;
drop menopausege40 menopauselt40 ;
if missing( menopause ) then do;
   menopausege40 = .;
   menopauselt40 = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm7 $ 7; drop _dm7 ;
   _dm7 = put( menopause , $7. );
   %DMNORMIP( _dm7 )
   if _dm7 = 'PREMENO'  then do;
      menopausege40 = -1;
      menopauselt40 = -1;
   end;
   else if _dm7 = 'GE40'  then do;
      menopausege40 = 1;
      menopauselt40 = 0;
   end;
   else if _dm7 = 'LT40'  then do;
      menopausege40 = 0;
      menopauselt40 = 1;
   end;
   else do;
      menopausege40 = .;
      menopauselt40 = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;

*** Generate dummy variables for tumor_size ;
drop tumor_size0_4 tumor_size10_14 tumor_size15_19 tumor_size20_24
        tumor_size25_29 tumor_size30_34 tumor_size35_39 tumor_size40_44
        tumor_size45_49 tumor_size5_9 ;
*** encoding is sparse, initialize to zero;
tumor_size0_4 = 0;
tumor_size10_14 = 0;
tumor_size15_19 = 0;
tumor_size20_24 = 0;
tumor_size25_29 = 0;
tumor_size30_34 = 0;
tumor_size35_39 = 0;
tumor_size40_44 = 0;
tumor_size45_49 = 0;
tumor_size5_9 = 0;
if missing( tumor_size ) then do;
   tumor_size0_4 = .;
   tumor_size10_14 = .;
   tumor_size15_19 = .;
   tumor_size20_24 = .;
   tumor_size25_29 = .;
   tumor_size30_34 = .;
   tumor_size35_39 = .;
   tumor_size40_44 = .;
   tumor_size45_49 = .;
   tumor_size5_9 = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm5 $ 5; drop _dm5 ;
   _dm5 = put( tumor_size , $5. );
   %DMNORMIP( _dm5 )
   _dm_find = 0; drop _dm_find;
   if _dm5 <= '30-34'  then do;
      if _dm5 <= '15-19'  then do;
         if _dm5 <= '10-14'  then do;
            if _dm5 = '0-4'  then do;
               tumor_size0_4 = 1;
               _dm_find = 1;
            end;
            else do;
               if _dm5 = '10-14'  then do;
                  tumor_size10_14 = 1;
                  _dm_find = 1;
               end;
            end;
         end;
         else do;
            if _dm5 = '15-19'  then do;
               tumor_size15_19 = 1;
               _dm_find = 1;
            end;
         end;
      end;
      else do;
         if _dm5 <= '25-29'  then do;
            if _dm5 = '20-24'  then do;
               tumor_size20_24 = 1;
               _dm_find = 1;
            end;
            else do;
               if _dm5 = '25-29'  then do;
                  tumor_size25_29 = 1;
                  _dm_find = 1;
               end;
            end;
         end;
         else do;
            if _dm5 = '30-34'  then do;
               tumor_size30_34 = 1;
               _dm_find = 1;
            end;
         end;
      end;
   end;
   else do;
      if _dm5 <= '45-49'  then do;
         if _dm5 <= '40-44'  then do;
            if _dm5 = '35-39'  then do;
               tumor_size35_39 = 1;
               _dm_find = 1;
            end;
            else do;
               if _dm5 = '40-44'  then do;
                  tumor_size40_44 = 1;
                  _dm_find = 1;
               end;
            end;
         end;
         else do;
            if _dm5 = '45-49'  then do;
               tumor_size45_49 = 1;
               _dm_find = 1;
            end;
         end;
      end;
      else do;
         if _dm5 = '5-9'  then do;
            tumor_size5_9 = 1;
            _dm_find = 1;
         end;
         else do;
            if _dm5 = '50-54'  then do;
               tumor_size0_4 = -1;
               tumor_size10_14 = -1;
               tumor_size15_19 = -1;
               tumor_size20_24 = -1;
               tumor_size25_29 = -1;
               tumor_size30_34 = -1;
               tumor_size35_39 = -1;
               tumor_size40_44 = -1;
               tumor_size45_49 = -1;
               tumor_size5_9 = -1;
               _dm_find = 1;
            end;
         end;
      end;
   end;
   if not _dm_find then do;
      tumor_size0_4 = .;
      tumor_size10_14 = .;
      tumor_size15_19 = .;
      tumor_size20_24 = .;
      tumor_size25_29 = .;
      tumor_size30_34 = .;
      tumor_size35_39 = .;
      tumor_size40_44 = .;
      tumor_size45_49 = .;
      tumor_size5_9 = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;

*** *************************;
*** Checking missing input Interval
*** *************************;

IF NMISS(
   AvgAge ,
   AvgTumorSize ,
   Avginv_node_group ,
   deg_malig   ) THEN DO;
   SUBSTR(_WARN_, 1, 1) = 'M';

   _DM_BAD = 1;
END;
*** *************************;
*** Writing the Node intvl ;
*** *************************;
IF _DM_BAD EQ 0 THEN DO;
   S_AvgAge  =    -5.17542134396122 +     0.10002730056017 * AvgAge ;
   S_AvgTumorSize  =    -2.52494540353916 +     0.09506760766352 *
        AvgTumorSize ;
   S_Avginv_node_group  =    -0.69351787747727 +     0.31173971918285 *
        Avginv_node_group ;
   S_deg_malig  =    -2.75629070254781 +     1.34265662978187 * deg_malig ;
END;
ELSE DO;
   IF MISSING( AvgAge ) THEN S_AvgAge  = . ;
   ELSE S_AvgAge  =    -5.17542134396122 +     0.10002730056017 * AvgAge ;
   IF MISSING( AvgTumorSize ) THEN S_AvgTumorSize  = . ;
   ELSE S_AvgTumorSize  =    -2.52494540353916 +     0.09506760766352 *
        AvgTumorSize ;
   IF MISSING( Avginv_node_group ) THEN S_Avginv_node_group  = . ;
   ELSE S_Avginv_node_group  =    -0.69351787747727 +     0.31173971918285 *
        Avginv_node_group ;
   IF MISSING( deg_malig ) THEN S_deg_malig  = . ;
   ELSE S_deg_malig  =    -2.75629070254781 +     1.34265662978187 * deg_malig
         ;
END;
*** *************************;
*** Writing the Node bin ;
*** *************************;
*** *************************;
*** Writing the Node nom ;
*** *************************;
*** *************************;
*** Writing the Node H1 ;
*** *************************;
IF _DM_BAD EQ 0 THEN DO;
   H11  =    -0.61497493528093 * S_AvgAge  +     0.95387181547091 *
        S_AvgTumorSize  +    -0.07696387186429 * S_Avginv_node_group
          +    -0.37968136001267 * S_deg_malig ;
   H12  =    -0.10284288284194 * S_AvgAge  +     0.37352136247344 *
        S_AvgTumorSize  +     0.68676513170483 * S_Avginv_node_group
          +     0.47005499648247 * S_deg_malig ;
   H13  =      0.9145919034759 * S_AvgAge  +     0.05826862125007 *
        S_AvgTumorSize  +    -0.00110862274069 * S_Avginv_node_group
          +     1.75176090163572 * S_deg_malig ;
   H11  = H11  +     0.36327134003845 * IMP_node_capsno
          +    -0.61958170054396 * breastleft  +    -0.76320688913225 *
        irradiatno ;
   H12  = H12  +     0.79264758501102 * IMP_node_capsno
          +     0.38736672542142 * breastleft  +    -0.41943897063306 *
        irradiatno ;
   H13  = H13  +    -0.57775127561597 * IMP_node_capsno
          +     0.72019942479724 * breastleft  +    -0.27388143245069 *
        irradiatno ;
   H11  = H11  +     0.03389920437167 * age20_29  +     0.72089986894102 *
        age30_39  +     0.28798904753624 * age40_49  +     0.44335242159532 *
        age50_59  +     0.52451229055658 * age60_69  +     0.26756102661582 *
        breast_quadcentral  +    -0.27707826700111 * breast_quadleft_low
          +    -0.50619587378469 * breast_quadleft_up
          +     0.32385655977639 * breast_quadright_low
          +    -0.34095159639954 * inv_nodes0_2  +      0.4491951931604 *
        inv_nodes12_14  +    -0.18585971024084 * inv_nodes15_17
          +     0.46197576963823 * inv_nodes24_26  +     1.13872977786161 *
        inv_nodes3_5  +    -0.24695704463614 * inv_nodes6_8
          +     -1.6254898573616 * menopausege40  +    -0.92858614182967 *
        menopauselt40  +    -0.38889900414931 * tumor_size0_4
          +    -1.07107947032064 * tumor_size10_14  +     0.03210466953987 *
        tumor_size15_19  +     2.09618876020959 * tumor_size20_24
          +     -0.2438896271209 * tumor_size25_29  +    -0.22402647329776 *
        tumor_size30_34  +     0.34369986972179 * tumor_size35_39
          +     0.10609442400314 * tumor_size40_44  +    -0.33854013913445 *
        tumor_size45_49  +    -0.02593198988185 * tumor_size5_9 ;
   H12  = H12  +     0.01685296927978 * age20_29  +     0.35307919317833 *
        age30_39  +    -0.69893461072245 * age40_49  +    -0.24523441741186 *
        age50_59  +     0.07558333902437 * age60_69  +     0.37289958336996 *
        breast_quadcentral  +     0.36773572083573 * breast_quadleft_low
          +     1.18722346758725 * breast_quadleft_up
          +     0.06349587968543 * breast_quadright_low
          +      -0.059174362514 * inv_nodes0_2  +     0.15010019016924 *
        inv_nodes12_14  +     0.21292950214496 * inv_nodes15_17
          +    -0.38120373140886 * inv_nodes24_26  +    -0.78617065785688 *
        inv_nodes3_5  +    -0.53988580512066 * inv_nodes6_8
          +     0.37876358329232 * menopausege40  +     0.98534893153269 *
        menopauselt40  +     0.26937806074223 * tumor_size0_4
          +    -0.42069656657828 * tumor_size10_14  +    -0.06792429022016 *
        tumor_size15_19  +     0.58136904760064 * tumor_size20_24
          +    -0.08769804820483 * tumor_size25_29  +     0.03374092030048 *
        tumor_size30_34  +      0.1829108052925 * tumor_size35_39
          +     0.01690568296329 * tumor_size40_44  +     0.13224531669088 *
        tumor_size45_49  +    -0.22204959796125 * tumor_size5_9 ;
   H13  = H13  +     0.18753630570782 * age20_29  +    -0.03350421785345 *
        age30_39  +     0.14623047416945 * age40_49  +    -0.41701616903549 *
        age50_59  +     0.89967320394619 * age60_69  +    -0.20761226509696 *
        breast_quadcentral  +    -1.04013447085256 * breast_quadleft_low
          +     -1.7692938970504 * breast_quadleft_up
          +     0.20743849640219 * breast_quadright_low
          +    -0.29974021420975 * inv_nodes0_2  +     0.85993563103741 *
        inv_nodes12_14  +     0.50250813126704 * inv_nodes15_17
          +     0.35668817181134 * inv_nodes24_26  +     1.00306353211516 *
        inv_nodes3_5  +      0.3582805661238 * inv_nodes6_8
          +     0.31231492228923 * menopausege40  +     0.61342571580869 *
        menopauselt40  +     0.20376513631778 * tumor_size0_4
          +      -0.185934474148 * tumor_size10_14  +    -0.10040191113771 *
        tumor_size15_19  +      0.1860239709766 * tumor_size20_24
          +     0.72634109614906 * tumor_size25_29  +     0.08646236423332 *
        tumor_size30_34  +     0.36660157691503 * tumor_size35_39
          +    -0.82183765104013 * tumor_size40_44  +     0.38021345065478 *
        tumor_size45_49  +    -0.06805996233089 * tumor_size5_9 ;
   H11  =     1.87635201395074 + H11 ;
   H12  =     0.04770355881681 + H12 ;
   H13  =      -1.760700478131 + H13 ;
   H11  = TANH(H11 );
   H12  = TANH(H12 );
   H13  = TANH(H13 );
END;
ELSE DO;
   H11  = .;
   H12  = .;
   H13  = .;
END;
*** *************************;
*** Writing the Node class ;
*** *************************;
IF _DM_BAD EQ 0 THEN DO;
   P_classrecurrence_events  =     2.49224982498149 * H11
          +     1.14059984464365 * H12  +     2.20917444320522 * H13 ;
   P_classrecurrence_events  =    -1.04524170486537 + P_classrecurrence_events
         ;
   P_classno_recurrence_events  = 0;
   _MAX_ = MAX (P_classrecurrence_events , P_classno_recurrence_events );
   _SUM_ = 0.;
   P_classrecurrence_events  = EXP(P_classrecurrence_events  - _MAX_);
   _SUM_ = _SUM_ + P_classrecurrence_events ;
   P_classno_recurrence_events  = EXP(P_classno_recurrence_events  - _MAX_);
   _SUM_ = _SUM_ + P_classno_recurrence_events ;
   P_classrecurrence_events  = P_classrecurrence_events  / _SUM_;
   P_classno_recurrence_events  = P_classno_recurrence_events  / _SUM_;
END;
ELSE DO;
   P_classrecurrence_events  = .;
   P_classno_recurrence_events  = .;
END;
IF _DM_BAD EQ 1 THEN DO;
   P_classrecurrence_events  =     0.29203539823008;
   P_classno_recurrence_events  =     0.70796460176991;
END;


*** Decision Processing;
label D_CLASS = 'Decision: class' ;
label EP_CLASS = 'Expected Profit: class' ;

length D_CLASS $ 20;

D_CLASS = ' ';
EP_CLASS = .;

*** Compute Expected Consequences and Choose Decision;
_decnum = 1; drop _decnum;

D_CLASS = 'RECURRENCE-EVENTS' ;
EP_CLASS = P_classrecurrence_events * 1 + P_classno_recurrence_events * 0;
drop _sum;
_sum = P_classrecurrence_events * 0 + P_classno_recurrence_events * 1;
if _sum > EP_CLASS + 4.547474E-13 then do;
   EP_CLASS = _sum; _decnum = 2;
   D_CLASS = 'NO-RECURRENCE-EVENTS' ;
end;


*** End Decision Processing ;
*** *************************;
*** Writing the I_class  AND U_class ;
*** *************************;
_MAXP_ = P_classrecurrence_events ;
I_class  = "RECURRENCE-EVENTS   " ;
U_class  = "recurrence-events   " ;
IF( _MAXP_ LT P_classno_recurrence_events  ) THEN DO;
   _MAXP_ = P_classno_recurrence_events ;
   I_class  = "NO-RECURRENCE-EVENTS" ;
   U_class  = "no-recurrence-events" ;
END;
********************************;
*** End Scoring Code for Neural;
********************************;
drop
H11
H12
H13
;
drop S_:;
