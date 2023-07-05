function [lb,ub]=get_lower_upper_bounds(N_parameters)
% this function sets the lower and the upper bounds of the parameters,
% according to the values which are obtained in "set parameters". 

load('bounds.mat')
load('parameter_names.mat')
lb=zeros(N_parameters,1);
ub=zeros(N_parameters,1);

%the lower bounds:
for i=1:N_parameters
   lb(i)=bounds.Low.(parameter_names{i});
   ub(i)=bounds.Up.(parameter_names{i});
end