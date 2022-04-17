****************************************************************;
******             DECISION TREE SCORING CODE             ******;
****************************************************************;

******         LENGTHS OF NEW CHARACTER VARIABLES         ******;
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
label I_class = 'Into: class' ;
label U_class = 'Unnormalized Into: class' ;
label _WARN_ = 'Warnings' ;


******      TEMPORARY VARIABLES FOR FORMATTED VALUES      ******;
LENGTH _ARBFMT_20 $     20; DROP _ARBFMT_20; 
_ARBFMT_20 = ' '; /* Initialize to avoid warning. */


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

*****  DECISION VARIABLES *******;

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

****************************************************************;
******          END OF DECISION TREE SCORING CODE         ******;
****************************************************************;

