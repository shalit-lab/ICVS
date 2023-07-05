function set_measured_bounds(min_R_measured,max_R_measured,min_Fhr_measured,max_Fhr_measured)
R_bounds.Up_R_min=min_R_measured;
R_bounds.Low_R_max=max_R_measured;
Fhr_bounds.Up_Fhr_min=min_Fhr_measured;
Fhr_bounds.Low_Fhr_max=max_Fhr_measured;

save R_bounds R_bounds
save Fhr_bounds Fhr_bounds