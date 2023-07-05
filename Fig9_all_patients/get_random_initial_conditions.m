function X0=get_random_initial_conditions(N_parameters)

load('bounds.mat')
load('parameter_names.mat')
load('vec_index.mat')
X0=zeros(N_parameters,1);
for i=1:N_parameters
    % for each parameter get a random initial value
   low_b=bounds.Low.(parameter_names{i});
   high_b=bounds.Up.(parameter_names{i});
   initial_r=unifrnd(low_b,high_b);
   parameter_ind=vec_index.(parameter_names{i});
   X0(parameter_ind)=initial_r;
end

