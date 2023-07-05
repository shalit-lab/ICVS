
function file_name_save= master_estimation(id_number,time_interval,weight,age,make_perturbation)
% time interval - 2 elements vec of t_start and t_end.
% weight (kg) and subject age (years).


%% set all parameters:
set_parameters

%% set linear inaquality constraints:
[A_inaquality,b_inaquality]=get_inaquality_constraints(N_parameters,(time_interval(2)-time_interval(1)));

%% set lower and upper bounds:
[lb,ub]=get_lower_upper_bounds(N_parameters);




%% generate X0:
X0=get_random_initial_conditions(N_parameters);

% put 0 in the autonomous activation:
X0(vec_index.S_slope)=0;
X0(vec_index.S_const)=0;
X0(vec_index.M_const)=0;
X0(vec_index.M_slope)=0;

get_X0
X0=x0_new;


%% Find optimal parameters:
opts = optimoptions(@fmincon,'Algorithm','sqp');



problem = createOptimProblem('fmincon','objective',...
    @objectivefun,'x0',X0,'Aineq',A_inaquality,'bineq',b_inaquality, ...
    'lb',lb,'ub',ub,'options',opts);

ms=GlobalSearch;
[x,f] =run(ms,problem)


optimal_parameters=x;
cost_value=f/(length(measurements.Pa_time));% normalization



if make_perturbation==0
    file_name_save=sprintf('results_%d_interval_%g_%g.mat',id_number,time_interval(1),time_interval(2));
    
else if make_perturbation
        file_name_save=sprintf('perturbed_data_results_%d_interval_%g_%g_%g.mat',id_number,time_interval(1),time_interval(2),make_perturbation);
    end
end

save(file_name_save)

