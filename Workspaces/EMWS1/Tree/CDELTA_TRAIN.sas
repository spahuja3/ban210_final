if upcase(NAME) = "AGE" then do;
ROLE = "REJECTED";
end;
else 
if upcase(NAME) = "AVGAGE" then do;
ROLE = "REJECTED";
end;
else 
if upcase(NAME) = "AVGTUMORSIZE" then do;
ROLE = "REJECTED";
end;
else 
if upcase(NAME) = "BREAST" then do;
ROLE = "REJECTED";
end;
else 
if upcase(NAME) = "BREAST_QUAD" then do;
ROLE = "REJECTED";
end;
else 
if upcase(NAME) = "INV_NODES" then do;
ROLE = "REJECTED";
end;
else 
if upcase(NAME) = "IRRADIAT" then do;
ROLE = "REJECTED";
end;
else 
if upcase(NAME) = "MENOPAUSE" then do;
ROLE = "REJECTED";
end;
else 
if upcase(NAME) = "NODE_CAPS" then do;
ROLE = "REJECTED";
end;
else 
if upcase(NAME) = "Q_CLASSNO_RECURRENCE_EVENTS" then do;
ROLE = "ASSESS";
end;
else 
if upcase(NAME) = "Q_CLASSRECURRENCE_EVENTS" then do;
ROLE = "ASSESS";
end;
else 
if upcase(NAME) = "TUMOR_SIZE" then do;
ROLE = "REJECTED";
end;
else 
if upcase(NAME) = "_NODE_" then do;
ROLE = "SEGMENT";
LEVEL = "NOMINAL";
end;
