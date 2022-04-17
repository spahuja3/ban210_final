*------------------------------------------------------------*;
* MBR: Create decision matrix;
*------------------------------------------------------------*;
data WORK.class;
  length   class                            $  32
           COUNT                                8
           DATAPRIOR                            8
           TRAINPRIOR                           8
           DECPRIOR                             8
           DECISION1                            8
           DECISION2                            8
           ;

  label    COUNT="Level Counts"
           DATAPRIOR="Data Proportions"
           TRAINPRIOR="Training Proportions"
           DECPRIOR="Decision Priors"
           DECISION1="RECURRENCE-EVENTS"
           DECISION2="NO-RECURRENCE-EVENTS"
           ;
  format   COUNT 10.
           ;
class="RECURRENCE-EVENTS"; COUNT=85; DATAPRIOR=0.2972027972; TRAINPRIOR=0.2972027972; DECPRIOR=0.2972; DECISION1=1; DECISION2=0;
output;
class="NO-RECURRENCE-EVENTS"; COUNT=201; DATAPRIOR=0.7027972028; TRAINPRIOR=0.7027972028; DECPRIOR=0.7028; DECISION1=0; DECISION2=1;
output;
;
run;
proc datasets lib=work nolist;
modify class(type=PROFIT label=class);
label DECISION1= 'RECURRENCE-EVENTS';
label DECISION2= 'NO-RECURRENCE-EVENTS';
run;
quit;
%macro EM_MBR;
%let _MBRTRAIN = EMSCORE.EM_TRAIN_MBR;
%if %symexist(em_train) %then %do;
%let _MBRTRAIN = EMWS1.Impt_TRAIN;
%end;
*------------------------------------------------------------* ;
* MBR: DMDBClass Macro ;
*------------------------------------------------------------* ;
%macro DMDBClass;
    class(DESC)
%mend DMDBClass;
*------------------------------------------------------------* ;
* MBR: DMDBVar Macro ;
*------------------------------------------------------------* ;
%macro DMDBVar;
    AvgAge AvgTumorSize Avginv_node_group deg_malig
%mend DMDBVar;
*------------------------------------------------------------*;
* MBR: Create DMDB;
*------------------------------------------------------------*;
proc dmdb batch data=&_MBRTRAIN
dmdbcat=WORK.MBR_DMDB
maxlevel = 513
;
class %DMDBClass;
var %DMDBVar;
target
class
;
run;
quit;
*------------------------------------------------------------* ;
* MBR: Interval Variables Macro ;
*------------------------------------------------------------* ;
%macro pmbrvar;
    AvgAge AvgTumorSize Avginv_node_group deg_malig
%mend pmbrvar;
%let _vvnoption = %sysfunc(getoption(VALIDVARNAME));
%if &_vvnoption = ANY and ^%symexist(em_train) %then %do;
data em_MBR;
set &em_score_output;
run;
data &em_score_output;
set &em_score_output;
keep %pmbrvar;
run;
%end;
options validvarname=V7;
%if ^%symexist(em_train) %then %do;
proc pmbr data=&_MBRTRAIN dmdbcat=WORK.MBR_DMDB %end;
%else %do;
proc pmbr data=EMWS1.Impt_TRAIN dmdbcat=WORK.MBR_DMDB %end;
k = 16
epsilon = 0
buckets = 8
method = SCAN
neighbors
;
var %pmbrvar;
target class;
decision decdata=WORK.class
decvars=
DECISION1
DECISION2
;
score data=&em_score_output out=&em_score_output role=score;
;
run;
quit;
options validvarname=&_vvnoption;
%if &_vvnoption = ANY and ^%symexist(em_train) %then %do;
data &em_score_output;
merge em_MBR &em_score_output;
run;
proc delete data=em_MBR;
run;
%end;
%mend EM_MBR;
%EM_MBR;
