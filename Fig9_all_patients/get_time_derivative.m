function time_derivative=get_time_derivative(time_dep_vector,dt)

% this function receives a time dependent vector and calculates the time
% dependent numerical derivative assuming dt interval between the
% measurements


reshaped_forward_vec=[time_dep_vector(2:end) time_dep_vector(1)];

Der=(reshaped_forward_vec-time_dep_vector)/dt;

time_derivative=Der(1:end);
% remove the last point:
time_derivative(end)=time_derivative(end-1);
