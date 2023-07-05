

% filter:
tau_filter=500; %sec - time constant of the exponential filter

%% create initial filter
create_initial_filter();

first_interval=1;
%% analysis
if optimization_analysis
    for ttt=1:num_intervals
        close all
        time_interval=[time_start+interval_step*(ttt-1) (time_start+interval_length)+interval_step*(ttt-1)];
        
        load(sprintf('subject_%d_interval_%g_%g',id_number,time_interval(1),time_interval(2)));
        valid=valid_data; % the internal validation inside the analysis. if valid - check the next condition:
        if valid==1
            valid=check_data_validation(Pa_for_analysis,Pp_for_analysis,Pv_for_analysis,Fhr_for_analysis,RC_for_analysis);
        end
        if valid % if the data is valid 
            make_perturbation=0;
            % update the bounds of R_min R_max, Fhr_min, Fhr_max
            if first_interval
                set_measured_bounds(min(RC_for_analysis),max(RC_for_analysis),min(Fhr_for_analysis),max(Fhr_for_analysis))
                first_interval=0;
            end
            update_measured_bounds(min(RC_for_analysis),max(RC_for_analysis),min(Fhr_for_analysis),max(Fhr_for_analysis))
            
            current_file_name= master_estimation(id_number,time_interval,weight,age,make_perturbation);
        end
        %% updae filter:
        
        update_filter(valid,interval_step,tau_filter, current_file_name)
        
    end
end




%% plot results:
plot_results(id_number,[time_start time_start+interval_length],num_intervals)