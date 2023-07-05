function create_initial_filter()
global current_filter1 current_filter2 filter_factor
% current_filter1= -2*exp(t-t'/tau)*theta_hat(t')*theta
% current_filter2= exp(t-t'/tau)*theta^2


param_filter_names={ 'Cv' 'delta_V0' 'Pset' 'Fhr_max' 'Fhr_min' 'R_max' 'R_min' 'RC_factor'};
filter_factor=0.1;% the scale for contribution to the cost function
    
N_parameters=length(param_filter_names);
for i=1:N_parameters
   current_filter1.(param_filter_names{i})=0;
   current_filter2.(param_filter_names{i})=0;

end

save ('current_filter_file','current_filter1','current_filter2','param_filter_names','filter_factor');