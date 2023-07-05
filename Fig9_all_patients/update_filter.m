function update_filter(valid,interval_step,tau_filter,file_name_load)
% this functions updates an exponential filter over the previous results:
global current_filter1 current_filter2 filter_factor
% current_filter1=~sum_t'[ -2*exp(t-t'/tau)*theta_hat(t')*theta]->sum_t'
% current_filter1=[exp(t-t'/tau)*theta_hat(t')]
% current_filter2=  sum_t'[ exp(t-t'/tau)*theta^2 ] -> current_filter2=
% sum_t' [exp(t-t'/tau)]


%% if the current interval is not valid - calculate an expnential decay:
if valid==0
    load('current_filter_file.mat')
    N_parameters=length(param_filter_names);
    for i=1:N_parameters
        current_filter1.(param_filter_names{i})= current_filter1.(param_filter_names{i})-1/tau_filter*interval_step*( current_filter1.(param_filter_names{i}));
        current_filter2.(param_filter_names{i})= current_filter2.(param_filter_names{i})-1/tau_filter*interval_step*( current_filter2.(param_filter_names{i}));
        
    end
end

%% if the current interval is valid - update the filter according to the current results;
if valid==1
    load(file_name_load)
    load('current_filter_file.mat')
    
    N_parameters=length(param_filter_names);
    for i=1:N_parameters
        %the value of the optimal parameter in the current simulation:
        last_simulation=optimal_parameters(vec_index.(param_filter_names{i}));
        
        current_filter1.(param_filter_names{i})= current_filter1.(param_filter_names{i})-1/tau_filter*interval_step*( current_filter1.(param_filter_names{i}))+last_simulation;
        
        % for current_filter2 we simply add 1 each time when the
        % estimator exists. this term reflects the new exponential decay
        % which starts in each estimation
        current_filter2.(param_filter_names{i})= current_filter2.(param_filter_names{i})-1/tau_filter*interval_step*( current_filter2.(param_filter_names{i}))+1;
        
    end
end


save ('current_filter_file','current_filter1','current_filter2','param_filter_names','filter_factor');