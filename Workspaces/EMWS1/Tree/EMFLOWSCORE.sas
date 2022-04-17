****************************************************************;
******             DECISION TREE SCORING CODE             ******;
****************************************************************;
 
******         LENGTHS OF NEW CHARACTER VARIABLES         ******;
LENGTH F_class  $   20;
LENGTH I_class  $   20;
LENGTH U_class  $   20;
LENGTH _WARN_  $    4;
 
******              LABELS FOR NEW VARIABLES              ******;
label _NODE_ = 'Node' ;
label _LEAF_ = 'Leaf' ;
label P_classrecurrence_events = 'Predicted: class=recurrence-events' ;
label P_classno_recurrence_events = 'Predicted: class=no-recurrence-events' ;
label Q_classrecurrence_events = 'Unadjusted P: class=recurrence-events' ;
label Q_classno_recurrence_events =
'Unadjusted P: class=no-recurrence-events' ;
label V_classrecurrence_events = 'Validated: class=recurrence-events' ;
label V_classno_recurrence_events = 'Validated: class=no-recurrence-events' ;
label R_classrecurrence_events = 'Residual: class=recurrence-events' ;
label R_classno_recurrence_events = 'Residual: class=no-recurrence-events' ;
label F_class = 'From: class' ;
label I_class = 'Into: class' ;
label U_class = 'Unnormalized Into: class' ;
label _WARN_ = 'Warnings' ;
 
 
******      TEMPORARY VARIABLES FOR FORMATTED VALUES      ******;
LENGTH _ARBFMT_20 $     20; DROP _ARBFMT_20;
_ARBFMT_20 = ' '; /* Initialize to avoid warning. */
 
 
_ARBFMT_20 = PUT( class , $20.);
 %DMNORMCP( _ARBFMT_20, F_class );
 
******             ASSIGN OBSERVATION TO NODE             ******;
IF  NOT MISSING(deg_malig ) AND
                   2.5 <= deg_malig  THEN DO;
  IF  NOT MISSING(Avginv_node_group ) AND
                     1.5 <= Avginv_node_group  THEN DO;
    _NODE_  =                    7;
    _LEAF_  =                    3;
    P_classrecurrence_events  =      0.7037037037037;
    P_classno_recurrence_events  =     0.29629629629629;
    Q_classrecurrence_events  =      0.7037037037037;
    Q_classno_recurrence_events  =     0.29629629629629;
    V_classrecurrence_events  =                  0.8;
    V_classno_recurrence_events  =                  0.2;
    I_class  = 'RECURRENCE-EVENTS' ;
    U_class  = 'recurrence-events' ;
    END;
  ELSE DO;
    _NODE_  =                    6;
    _LEAF_  =                    2;
    P_classrecurrence_events  =      0.4047619047619;
    P_classno_recurrence_events  =     0.59523809523809;
    Q_classrecurrence_events  =      0.4047619047619;
    Q_classno_recurrence_events  =     0.59523809523809;
    V_classrecurrence_events  =     0.16666666666666;
    V_classno_recurrence_events  =     0.83333333333333;
    I_class  = 'NO-RECURRENCE-EVENTS' ;
    U_class  = 'no-recurrence-events' ;
    END;
  END;
ELSE DO;
  _NODE_  =                    2;
  _LEAF_  =                    1;
  P_classrecurrence_events  =     0.19620253164556;
  P_classno_recurrence_events  =     0.80379746835443;
  Q_classrecurrence_events  =     0.19620253164556;
  Q_classno_recurrence_events  =     0.80379746835443;
  V_classrecurrence_events  =     0.20930232558139;
  V_classno_recurrence_events  =      0.7906976744186;
  I_class  = 'NO-RECURRENCE-EVENTS' ;
  U_class  = 'no-recurrence-events' ;
  END;
 
*****  RESIDUALS R_ *************;
IF  F_class  NE 'RECURRENCE-EVENTS'
AND F_class  NE 'NO-RECURRENCE-EVENTS'  THEN DO;
        R_classrecurrence_events  = .;
        R_classno_recurrence_events  = .;
 END;
 ELSE DO;
       R_classrecurrence_events  =  -P_classrecurrence_events ;
       R_classno_recurrence_events  =  -P_classno_recurrence_events ;
       SELECT( F_class  );
          WHEN( 'RECURRENCE-EVENTS'  ) R_classrecurrence_events  =
        R_classrecurrence_events  +1;
          WHEN( 'NO-RECURRENCE-EVENTS'  ) R_classno_recurrence_events  =
        R_classno_recurrence_events  +1;
       END;
 END;
 
*****  DECISION VARIABLES *******;
 
*** Decision Processing;
label D_CLASS = 'Decision: class' ;
label EP_CLASS = 'Expected Profit: class' ;
label BP_CLASS = 'Best Profit: class' ;
label CP_CLASS = 'Computed Profit: class' ;
 
length D_CLASS $ 20;
 
D_CLASS = ' ';
EP_CLASS = .;
BP_CLASS = .;
CP_CLASS = .;
 
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
 
*** Decision Matrix;
array TREEdema [2,2] _temporary_ (
/* row 1 */  1 0
/* row 2 */  0 1
);
 
*** Find Index of Target Category;
drop _tarnum; select( F_class );
   when('RECURRENCE-EVENTS' ) _tarnum = 1;
   when('NO-RECURRENCE-EVENTS' ) _tarnum = 2;
   otherwise _tarnum = 0;
end;
if _tarnum <= 0 then goto TREEdeex;
 
*** Computed Consequence of Chosen Decision;
CP_CLASS = TREEdema [_tarnum,_decnum];
 
*** Best Possible Consequence of Any Decision without Cost;
array TREEdebe [2] _temporary_ ( 1 1);
BP_CLASS = TREEdebe [_tarnum];
 
 
TREEdeex:;
 
*** End Decision Processing ;
 
****************************************************************;
******          END OF DECISION TREE SCORING CODE         ******;
****************************************************************;
 
drop _LEAF_;
