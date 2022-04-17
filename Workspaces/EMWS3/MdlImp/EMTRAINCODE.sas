%macro main;

   %if %upcase(&EM_ACTION) = CREATE %then %do;

       filename temp catalog 'sashelp.emmodl.modelimport_create.source';
       %include temp;
       filename temp;
       %create;
   %end;
   %else
   %if %upcase(&EM_ACTION) = TRAIN %then %do;

       filename temp catalog 'sashelp.emmodl.modelimport_train.source';
       %include temp;
       filename temp;
       %train;
   %end;
   %else
   %if %upcase(&EM_ACTION) = SCORE %then %do;

       filename temp catalog 'sashelp.emmodl.modelimport_score.source';
       %include temp;
       filename temp;
       %score;
   %end;
   %else
   %if %upcase(&EM_ACTION) = OPENMAPPINGTABLE %then %do;

       filename temp catalog 'sashelp.emmodl.modelimport_actions.source';
       %include temp;
       filename temp;
       %openMappingTable;
   %end;
   %else
   %if %upcase(&EM_ACTION) = CLOSEMAPPINGTABLE %then %do;

       filename temp catalog 'sashelp.emmodl.modelimport_actions.source';
       %include temp;
       filename temp;
       %closeMappingTable;
   %end;
%mend main;

%main;

