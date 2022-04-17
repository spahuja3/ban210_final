if NAME = "node_caps" then delete;
else 
if NAME    = "IMP_node_caps"  then do;
   ROLE    = "INPUT" ;
   FAMILY  = "" ;
   REPORT  = "N" ;
   LEVEL   = "BINARY" ;
   ORDER   = "" ;
end;
