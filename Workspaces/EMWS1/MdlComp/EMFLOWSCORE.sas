drop _temp_;
if (P_classrecurrence_events ge 0.7037037037037) then do;
_temp_ = dmran(1234);
b_class = floor(1 + 2*_temp_);
end;
else
if (P_classrecurrence_events ge 0.30048221820373) then do;
_temp_ = dmran(1234);
b_class = floor(3 + 4*_temp_);
end;
else
do;
_temp_ = dmran(1234);
b_class = floor(7 + 14*_temp_);
end;
