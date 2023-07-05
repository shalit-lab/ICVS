function valid=check_data_validation(Pa,Pp,Pv,F_hr,RC)
% this function checks whether the data is valid or not
valid=1;

% check arterial BP:
Pa_up=250;
Pa_low=20;
Pa_wrong_indeces=(Pa>Pa_up)+(Pa<Pa_low);
if sum(Pa_wrong_indeces)>0
   valid=0;
end 
    
% check heart rate
F_hr_up=250/60;
F_hr_low=30/60;
F_hr_wrong_indeces=(F_hr>F_hr_up)+(F_hr<F_hr_low);
if sum(F_hr_wrong_indeces)>0
   valid=0;
end

% check Pulse pressure

Pp_low=10;
Pp_wrong_indeces=(Pp<Pp_low);
if sum(Pp_wrong_indeces)>0
   valid=0;
end

% check RC

RC_low=0;
RC_wrong_indeces=(RC<RC_low);
if sum(RC_wrong_indeces)>0
   valid=0;
end

% check venous pressure
Pv_up=25;
Pv_low=0;
Pv_wrong_indeces=(Pv_up<Pv)+(Pv<Pv_low);
if sum(Pv_wrong_indeces)>0
   valid=0;
end


