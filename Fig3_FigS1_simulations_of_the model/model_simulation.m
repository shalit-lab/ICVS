% simulation of different patients according to our model:

clear all;
close all;
%% choose patient properties:
type='distributive';%'combined';%'S_ext_change';%'hypovolemic';%'distributive';%


%% ploting parameters:
a_color= [0.6392    0.0784    0.1804];
v_color=[  0    0.4510    0.7412];
RC_color=[0.4706    0.6706    0.1882];
Pp_color=[1.0000    0.0745    0.6510];
font_size=14;

measurements_position=[10 10 400 140];
control_color=[1 1 0.85];
control_position=[10 10 400 180];
S_position=[10 10 400 230];
S_color=[1 0.9 0.9];

%% simulation_properties:
interval_length=1500; %sec
dt=0.1; % sec

%% set initial value:
Pa_initial=48;% mmhg
Pv_initial=4; % mmhg

%% run the simulation according to the differential equations:
Pa=Pa_initial;
Pv=Pv_initial;

apply_dynamics


