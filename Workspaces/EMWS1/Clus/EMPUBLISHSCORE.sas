*****************************************;
*** Begin Scoring Code from PROC DMVQ ***;
*****************************************;


*** Begin Class Look-up, Standardization, Replacement ;
drop _dm_bad; _dm_bad = 0;

*** Standardize AvgTumorSize ;
drop T_AvgTumorSize ;
if missing( AvgTumorSize ) then T_AvgTumorSize = .;
else T_AvgTumorSize = (AvgTumorSize - 26.5594713656387) * 0.09506760766352;

*** Standardize Avginv_node_group ;
drop T_Avginv_node_group ;
if missing( Avginv_node_group ) then T_Avginv_node_group = .;
else T_Avginv_node_group = (Avginv_node_group
         - 2.22466960352422) * 0.31173971918285;

*** Standardize deg_malig ;
drop T_deg_malig ;
if missing( deg_malig ) then T_deg_malig = .;
else T_deg_malig = (deg_malig - 2.05286343612334) * 1.34265662978187;

*** Generate dummy variables for IMP_node_caps ;
drop IMP_node_capsno IMP_node_capsyes ;
if missing( IMP_node_caps ) then do;
   IMP_node_capsno = .;
   IMP_node_capsyes = .;
end;
else do;
   length _dm3 $ 3; drop _dm3 ;
   _dm3 = put( IMP_node_caps , $3. );
   %DMNORMIP( _dm3 )
   if _dm3 = 'NO'  then do;
      IMP_node_capsno = 0.34107635208911;
      IMP_node_capsyes = -0.34107635208911;
   end;
   else if _dm3 = 'YES'  then do;
      IMP_node_capsno = -1.45948950661386;
      IMP_node_capsyes = 1.45948950661386;
   end;
   else do;
      IMP_node_capsno = .;
      IMP_node_capsyes = .;
      _DM_BAD = 1;
   end;
end;

*** Generate dummy variables for irradiat ;
drop irradiatno irradiatyes ;
if missing( irradiat ) then do;
   irradiatno = .;
   irradiatyes = .;
end;
else do;
   length _dm3 $ 3; drop _dm3 ;
   _dm3 = put( irradiat , $3. );
   %DMNORMIP( _dm3 )
   if _dm3 = 'NO'  then do;
      irradiatno = 0.38459969953978;
      irradiatyes = -0.38459969953978;
   end;
   else if _dm3 = 'YES'  then do;
      irradiatno = -1.29432591191273;
      irradiatyes = 1.29432591191273;
   end;
   else do;
      irradiatno = .;
      irradiatyes = .;
      _DM_BAD = 1;
   end;
end;

*** End Class Look-up, Standardization, Replacement ;


*** Omitted Cases;
if _dm_bad then do;
   _SEGMENT_ = .; Distance = .;
   goto CLUSvlex ;
end; *** omitted;

*** Compute Distances and Cluster Membership;
label _SEGMENT_ = 'Segment Id' ;
label Distance = 'Distance' ;
array CLUSvads [7] _temporary_;
drop _vqclus _vqmvar _vqnvar;
_vqmvar = 0;
do _vqclus = 1 to 7; CLUSvads [_vqclus] = 0; end;
if not missing( T_AvgTumorSize ) then do;
   CLUSvads [1] + ( T_AvgTumorSize - 0.92465064596587 )**2;
   CLUSvads [2] + ( T_AvgTumorSize - 0.45780078690392 )**2;
   CLUSvads [3] + ( T_AvgTumorSize - 0.37461663019833 )**2;
   CLUSvads [4] + ( T_AvgTumorSize - 0.52940619652228 )**2;
   CLUSvads [5] + ( T_AvgTumorSize - -0.98485015939006 )**2;
   CLUSvads [6] + ( T_AvgTumorSize - -0.15384742416654 )**2;
   CLUSvads [7] + ( T_AvgTumorSize - 1.46789411832887 )**2;
end;
else _vqmvar + 1;
if not missing( T_Avginv_node_group ) then do;
   CLUSvads [1] + ( T_Avginv_node_group - 1.17692043761985 )**2;
   CLUSvads [2] + ( T_Avginv_node_group - 4.06051284006127 )**2;
   CLUSvads [3] + ( T_Avginv_node_group - 0.09622274445262 )**2;
   CLUSvads [4] + ( T_Avginv_node_group - -0.34181152762995 )**2;
   CLUSvads [5] + ( T_Avginv_node_group - -0.365152039938 )**2;
   CLUSvads [6] + ( T_Avginv_node_group - 0.11333786629011 )**2;
   CLUSvads [7] + ( T_Avginv_node_group - 0.05465744856157 )**2;
end;
else _vqmvar + 1;
if not missing( T_deg_malig ) then do;
   CLUSvads [1] + ( T_deg_malig - 0.50444682692245 )**2;
   CLUSvads [2] + ( T_deg_malig - 1.10384710807507 )**2;
   CLUSvads [3] + ( T_deg_malig - 0.37657476694322 )**2;
   CLUSvads [4] + ( T_deg_malig - 0.22165284812224 )**2;
   CLUSvads [5] + ( T_deg_malig - -0.73335471367645 )**2;
   CLUSvads [6] + ( T_deg_malig - 0.32392156577531 )**2;
   CLUSvads [7] + ( T_deg_malig - 1.00314786084143 )**2;
end;
else _vqmvar + 1;
if not missing( IMP_node_capsno ) then do;
   CLUSvads [1] + ( IMP_node_capsno - -1.45948950661386 )**2;
   CLUSvads [2] + ( IMP_node_capsno - -1.23441877427599 )**2;
   CLUSvads [3] + ( IMP_node_capsno - 0.34107635208911 )**2;
   CLUSvads [4] + ( IMP_node_capsno - 0.34107635208911 )**2;
   CLUSvads [5] + ( IMP_node_capsno - 0.34107635208911 )**2;
   CLUSvads [6] + ( IMP_node_capsno - -1.45948950661386 )**2;
   CLUSvads [7] + ( IMP_node_capsno - -1.45948950661386 )**2;
end;
else _vqmvar + 0.49999999999999;
if not missing( IMP_node_capsyes ) then do;
   CLUSvads [1] + ( IMP_node_capsyes - 1.45948950661386 )**2;
   CLUSvads [2] + ( IMP_node_capsyes - 1.23441877427599 )**2;
   CLUSvads [3] + ( IMP_node_capsyes - -0.34107635208911 )**2;
   CLUSvads [4] + ( IMP_node_capsyes - -0.34107635208911 )**2;
   CLUSvads [5] + ( IMP_node_capsyes - -0.34107635208911 )**2;
   CLUSvads [6] + ( IMP_node_capsyes - 1.45948950661386 )**2;
   CLUSvads [7] + ( IMP_node_capsyes - 1.45948950661386 )**2;
end;
else _vqmvar + 0.49999999999999;
if not missing( irradiatno ) then do;
   CLUSvads [1] + ( irradiatno - 0.14475318361799 )**2;
   CLUSvads [2] + ( irradiatno - -0.24499740475491 )**2;
   CLUSvads [3] + ( irradiatno - -1.29432591191273 )**2;
   CLUSvads [4] + ( irradiatno - 0.38459969953978 )**2;
   CLUSvads [5] + ( irradiatno - 0.36221402472041 )**2;
   CLUSvads [6] + ( irradiatno - -0.70176393140008 )**2;
   CLUSvads [7] + ( irradiatno - -1.29432591191273 )**2;
end;
else _vqmvar + 0.5;
if not missing( irradiatyes ) then do;
   CLUSvads [1] + ( irradiatyes - -0.14475318361799 )**2;
   CLUSvads [2] + ( irradiatyes - 0.24499740475491 )**2;
   CLUSvads [3] + ( irradiatyes - 1.29432591191273 )**2;
   CLUSvads [4] + ( irradiatyes - -0.38459969953978 )**2;
   CLUSvads [5] + ( irradiatyes - -0.36221402472041 )**2;
   CLUSvads [6] + ( irradiatyes - 0.70176393140008 )**2;
   CLUSvads [7] + ( irradiatyes - 1.29432591191273 )**2;
end;
else _vqmvar + 0.5;
_vqnvar = 5 - _vqmvar;
if _vqnvar <= 3.9790393202565E-12 then do;
   _SEGMENT_ = .; Distance = .;
end;
else do;
   _SEGMENT_ = 1; Distance = CLUSvads [1];
   _vqfzdst = Distance * 0.99999999999988; drop _vqfzdst;
   do _vqclus = 2 to 7;
      if CLUSvads [_vqclus] < _vqfzdst then do;
         _SEGMENT_ = _vqclus; Distance = CLUSvads [_vqclus];
         _vqfzdst = Distance * 0.99999999999988;
      end;
   end;
   Distance = sqrt(Distance * (5 / _vqnvar));
end;
CLUSvlex :;

***************************************;
*** End Scoring Code from PROC DMVQ ***;
***************************************;
*------------------------------------------------------------*;
* Clus: Creating Segment Label;
*------------------------------------------------------------*;
length _SEGMENT_LABEL_ $80;
label _SEGMENT_LABEL_='Segment Description';
if _SEGMENT_ = 1 then _SEGMENT_LABEL_="Cluster1";
else
if _SEGMENT_ = 2 then _SEGMENT_LABEL_="Cluster2";
else
if _SEGMENT_ = 3 then _SEGMENT_LABEL_="Cluster3";
else
if _SEGMENT_ = 4 then _SEGMENT_LABEL_="Cluster4";
else
if _SEGMENT_ = 5 then _SEGMENT_LABEL_="Cluster5";
else
if _SEGMENT_ = 6 then _SEGMENT_LABEL_="Cluster6";
else
if _SEGMENT_ = 7 then _SEGMENT_LABEL_="Cluster7";
