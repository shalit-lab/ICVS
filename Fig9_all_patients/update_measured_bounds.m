function update_R_bounds(min_R_measured,max_R_measured,min_Fhr_measured,max_Fhr_measured)
load('R_bounds.mat')
load('Fhr_bounds.mat')
% this funcion gurentees that R min is not larger than the minimal which is
% meausred and R max is not smaller than the maximal which is measured
% until now. 
R_bounds.Up_R_min=min(R_bounds.Up_R_min,min_R_measured);
R_bounds.Low_R_max=max(R_bounds.Low_R_max,max_R_measured);

Fhr_bounds.Up_Fhr_min=min(Fhr_bounds.Up_Fhr_min,min_Fhr_measured);
Fhr_bounds.Low_Fhr_max=max(Fhr_bounds.Low_Fhr_max,max_Fhr_measured);

save R_bounds R_bounds
save Fhr_bounds Fhr_bounds 