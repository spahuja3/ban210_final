%macro main;

   filename temp catalog 'sashelp.emutil.gp_macros.source';
   %include temp;
   filename temp;

   %SetProperties;

   %if %upcase(&EM_ACTION) = CREATE %then %do;

       filename temp catalog 'sashelp.emutil.gp_create.source';
       %include temp;
       filename temp;

       %create;
   %end;
   %else
   %if %upcase(&EM_ACTION) = TRAIN %then %do;

       filename temp catalog 'sashelp.emutil.gp_train.source';
       %include temp;
       filename temp;

       %train;
   %end;
   %else
   %if %upcase(&EM_ACTION) = SCORE %then %do;

       filename temp catalog 'sashelp.emutil.gp_score.source';
       %include temp;
       filename temp;

       %score;
   %end;
   %else
   %if %upcase(&EM_ACTION) = REPORT %then %do;

       filename temp catalog 'sashelp.emutil.gp_report.source';
       %include temp;
       filename temp;

       %report;

   %end;
   %else
   %if %upcase(&EM_ACTION) = POSTLOOP %then %do;

       filename temp catalog 'sashelp.emutil.gp_postloop.source';
       %include temp;
       filename temp;

       %postloop;

   %end;

   %doendm:
%mend main;

%main;

