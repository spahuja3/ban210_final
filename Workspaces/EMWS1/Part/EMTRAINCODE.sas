*------------------------------------------------------------*;
* Part: Retrieving stratification variable(s) levels;
*------------------------------------------------------------*;
proc freq data=EMWS1.Ids_DATA noprint;
format
class $20.
;
table
class
/out=WORK.Part_FREQ(drop=percent);
run;
proc sort data=WORK.Part_FREQ;
by descending count;
run;
* Part: Retrieving levels that meet minimum requirement;
data WORK.Part_FREQ2(keep = count);
set WORK.Part_FREQ;
where (.01 * 80 * count) >= 3;
run;
*------------------------------------------------------------*;
* Part: Create stratified partitioning;
*------------------------------------------------------------*;
data
EMWS1.Part_TRAIN(label="")
EMWS1.Part_VALIDATE(label="")
;
retain _seed_ 12345;
drop _seed_ _genvalue_;
call ranuni(_seed_, _genvalue_);
label _dataobs_ = "%sysfunc(sasmsg(sashelp.dmine, sample_dataobs_vlabel, NOQUOTE))";
_dataobs_ = _N_;
drop _c00:;
set EMWS1.Ids_DATA;
length _Pformat1 $70;
drop _Pformat1;
_Pformat1 = strip(put(class, $20.));
if
_Pformat1 = 'no-recurrence-events'
then do;
if (201+1-_C000003)*_genvalue_ <= (161 - _C000001) then do;
_C000001 + 1;
output EMWS1.Part_TRAIN;
end;
else do;
_C000002 + 1;
output EMWS1.Part_VALIDATE;
end;
_C000003+1;
end;
else if
_Pformat1 = 'recurrence-events'
then do;
if (85+1-_C000006)*_genvalue_ <= (68 - _C000004) then do;
_C000004 + 1;
output EMWS1.Part_TRAIN;
end;
else do;
_C000005 + 1;
output EMWS1.Part_VALIDATE;
end;
_C000006+1;
end;
run;
