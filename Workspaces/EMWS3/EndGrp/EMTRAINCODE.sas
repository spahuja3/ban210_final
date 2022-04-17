%macro main;
   %if %upcase(&EM_ACTION) = TRAIN %then %do;

       filename temp catalog 'sashelp.emutil.endgp_train.source';
       %include temp;
       filename temp;

       %train;

   %end;
   %else
      %if %upcase(&EM_ACTION) = SCORE %then %do;

       filename temp catalog 'sashelp.emutil.endgp_score.source';
       %include temp;
       filename temp;

       %score;
   %end;
   %else
   %if %upcase(&EM_ACTION) = POSTLOOP %then %do;

       filename temp catalog 'sashelp.emutil.endgp_postloop.source';
       %include temp;
       filename temp;

       %postloop;

   %end;

   %doendm:
%mend main;

%main;

