function [A_inaquality,b_inaquality]=get_inaquality_constraints(N_parameters,delta_t)
% set inaqulity constraints of the form: Ax<0. 
% here we define the matrix A. 
% This script add inaqualities that relate different parameters. 

A_inaquality=zeros(1,N_parameters);

load('vec_index.mat')

% for al the variables that have both 'min' and 'max', make sure that min
% is smaller than max: note that everything should have the sign "-" due to
% the structure of the inaquality. 

% Fhr:
A_inaquality(1,vec_index.Fhr_max)=-1;
A_inaquality(1,vec_index.Fhr_min)=1;


% peripheral resistance:
A_inaquality(2,vec_index.R_max)=-1;
A_inaquality(2,vec_index.R_min)=1;

% minimal and maximal S:
A_inaquality(3,vec_index.S_slope)=delta_t;
A_inaquality(3,vec_index.S_const)=1;

A_inaquality(4,vec_index.S_slope)=-delta_t;
A_inaquality(4,vec_index.S_const)=-1;

A_inaquality(5,vec_index.M_slope)=delta_t;
A_inaquality(5,vec_index.M_const)=1;

A_inaquality(6,vec_index.M_slope)=-delta_t;
A_inaquality(6,vec_index.M_const)=-1;




b_inaquality=zeros(size(A_inaquality,1),1);
b_inaquality(3)=1; % maximal autonomic activation is 1
b_inaquality(4)=0; % minimal autonomic activation is 0

b_inaquality(5)=1; % maximal M is 1
b_inaquality(6)=1; % minimal M is -1