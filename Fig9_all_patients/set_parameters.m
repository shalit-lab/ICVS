

global Pa Pv F_hr R_C Pp Pa_dot Pv_dot Pa_smooth
global w_pa w_pv w_RC w_Fhr w_Pp dt vec_index normalization bounds scaling


%% general:
parameter_names={ 'Cv' 'delta_V0' 'Iex' 'Pset' 'Kb' 'R_max' 'R_min' 'M_slope' 'M_const' 'Fhr_max'...
    'Fhr_min' 'S_slope' 'S_const' 'C_min' 'delta_C' 'RC_factor'};
save parameter_names parameter_names
N_parameters=length(parameter_names); % number of parameters to optimize

%% the coefficients of the different contributions to the cost function:
coefficients.Pa_cont=10;%1000;%
coefficients.Pv_cont=0.2;
coefficients.RC_cont=0.2;
coefficients.Fhr_cont=1;
coefficients.w_Pp_cont=0.2;

save coefficients coefficients

w_pa=coefficients.Pa_cont;
w_pv=coefficients.Pv_cont;
w_RC=coefficients.RC_cont;
w_Fhr=coefficients.Fhr_cont;
w_Pp=coefficients.w_Pp_cont;

%% data:
file_name_load=sprintf('subject_%d_interval_%g_%g.mat',id_number,time_interval(1),time_interval(2));
load(file_name_load)

measurements.Pa_time=Pa_for_analysis;
measurements.Pv_time=Pv_for_analysis;
measurements.Fhr_time=Fhr_for_analysis;
measurements.RC_time=RC_for_analysis;
measurements.Pp_time=Pp_for_analysis;


% get a smoothed version of the blood pressure:
Pa_smooth_coefficients=polyfit(dt:dt:length(measurements.Pa_time)*dt,measurements.Pa_time,1);
Pa_smooth=Pa_smooth_coefficients(1)*(dt:dt:length(measurements.Pa_time)*dt)+Pa_smooth_coefficients(2);

% calculate the time dependent derivatives:
measurements.Pa_dot_time=get_time_derivative(measurements.Pa_time,dt);
measurements.Pv_dot_time=get_time_derivative(measurements.Pv_time,dt);
measurements.RC_dot_time=get_time_derivative(measurements.RC_time,dt);

Pa=measurements.Pa_time;
Pv=measurements.Pv_time;
F_hr=measurements.Fhr_time;
R_C=measurements.RC_time;
Pp=measurements.Pp_time;
Pa_dot=measurements.Pa_dot_time;
Pv_dot=measurements.Pv_dot_time;

save measurements measurements


%% write the index of the parameters:
vec_index.Cv=1;
vec_index.delta_V0=2;
vec_index.Iex=3;
vec_index.Pset=4;
vec_index.Kb=5;
vec_index.R_max=6;
vec_index.R_min=7;
vec_index.M_slope=8;
vec_index.M_const=9;
vec_index.Fhr_max=10;
vec_index.Fhr_min=11;
vec_index.S_slope=12;
vec_index.S_const=13;
vec_index.C_min=14;
vec_index.delta_C=15;
vec_index.RC_factor=16;


save vec_index vec_index

%% parameters scaling:
scaling=ones(1,length(parameter_names));

%% parameters bounds and sacling (for the objective function):
scaling(vec_index.Cv)=50;

bounds.Low.Cv=10/scaling(vec_index.Cv);
bounds.Up.Cv=40/scaling(vec_index.Cv);

% set V0 according to age and weight:
if age<=1/4 % in years
    age_factor=100;% ml/kg
else
    age_factor=75;% ml/kg
end

Ca_upper_bound=0.15;% per kg
Ca_lower_bound= 0.02;%per kg

% delta_V0/Ca
scaling(vec_index.delta_V0)=500;
bounds.Low.delta_V0=(0.1*age_factor/Ca_upper_bound)/(scaling(vec_index.delta_V0));%
bounds.Up.delta_V0=(0.3*age_factor/Ca_lower_bound)/(scaling(vec_index.delta_V0));%






% I_ex - up to 1/4 of total blood volume in 1 hour -
% 0.25/3600*total_blood_volume in 1 sec.
bounds.Low.Iex=-(0.25/3600)*age_factor*weight/Ca_lower_bound;% ml/sec
bounds.Up.Iex=(0.25/3600)*age_factor*weight/Ca_lower_bound;

% set P_set according to the subject age (years)
if  age<=(1/12)
    bounds.Low.Pset=42;
    bounds.Up.Pset=73;
elseif ((1/12)<age) && (age <=1/4)
    bounds.Low.Pset=44;
    bounds.Up.Pset=76;
elseif ((1/4)<age) && (age <=1/2)
    bounds.Low.Pset=52;
    bounds.Up.Pset=80;
elseif ((1/2)<age) && (age <=1)
    bounds.Low.Pset=52;
    bounds.Up.Pset=86;
elseif (1<age) && (age<3)
    bounds.Low.Pset=56;
    bounds.Up.Pset=88;
elseif (3<=age) && (age<=6)
    bounds.Low.Pset=55;
    bounds.Up.Pset=83;
elseif (6<age) && (age<=9)
    bounds.Low.Pset=58;
    bounds.Up.Pset=87;
elseif (9<age) && (age<=11)
    bounds.Low.Pset=59;
    bounds.Up.Pset=87;
elseif (11<age) && (age<=15)
    bounds.Low.Pset=59;
    bounds.Up.Pset=89;
elseif (15<age)
    bounds.Low.Pset=60;
    bounds.Up.Pset=91;
end

scaling(vec_index.Pset)=100;
bounds.Low.Pset=bounds.Low.Pset/scaling(vec_index.Pset);
bounds.Up.Pset=bounds.Up.Pset/scaling(vec_index.Pset);


bounds.Low.Kb=0.1838;
bounds.Up.Kb=0.1838;

load('R_bounds.mat')
bounds.Low.R_max=0.25;
bounds.Up.R_max=3;
bounds.Low.R_max=max(bounds.Low.R_max,R_bounds.Low_R_max);

bounds.Low.R_min=0.1;
bounds.Up.R_min=2.5;
bounds.Up.R_min=min(bounds.Up.R_min,R_bounds.Up_R_min);




bounds.Low.M_slope=-2/(time_interval(2)-time_interval(1));
bounds.Up.M_slope=2/(time_interval(2)-time_interval(1));


bounds.Low.M_const=-1;
bounds.Up.M_const=1;
%% set Fhr min and max according to subject age: for Fhr_max - 75%-95% from Eitan et al. 2017, for Fhr_min 5%-25%.
if  age<=(1/12)
    bounds.Low.Fhr_max=150/60;
    bounds.Up.Fhr_max=180/60;
    
    bounds.Low.Fhr_min=110/60;
    bounds.Up.Fhr_min=130/60;
    
elseif ((1/12)<age) && (age <=1)
    bounds.Low.Fhr_max=145/60;
    bounds.Up.Fhr_max=180/60;
    
    bounds.Low.Fhr_min=90/60;
    bounds.Up.Fhr_min=130/60;
    
elseif (1<age) && (age<=3)
    bounds.Low.Fhr_max=140/60;
    bounds.Up.Fhr_max=180/60;
    
    bounds.Low.Fhr_min=80/60;
    bounds.Up.Fhr_min=110/60;
    
elseif (3<age) && (age<=6)
    bounds.Low.Fhr_max=130/60;
    bounds.Up.Fhr_max=160/60;
    
    bounds.Low.Fhr_min=75/60;
    bounds.Up.Fhr_min=110/60;
    
elseif (6<age) && (age<=9)
    bounds.Low.Fhr_max=125/60;
    bounds.Up.Fhr_max=160/60;
    
    bounds.Low.Fhr_min=70/60;
    bounds.Up.Fhr_min=100/60;
elseif (9<age) && (age<=11)
    bounds.Low.Fhr_max=120/60;
    bounds.Up.Fhr_max=160/60;
    
    bounds.Low.Fhr_min=65/60;
    bounds.Up.Fhr_min=100/60;
elseif (11<age) && (age<=15)
    bounds.Low.Fhr_max=115/60;
    bounds.Up.Fhr_max=160/60;
    
    bounds.Low.Fhr_min=60/60;
    bounds.Up.Fhr_min=90/60;
elseif (15<age)
    bounds.Low.Fhr_max=110/60;
    bounds.Up.Fhr_max=150/60;
    
    bounds.Low.Fhr_min=60/60;
    bounds.Up.Fhr_min=90/60;
    
end

load('Fhr_bounds.mat')
bounds.Low.Fhr_max=max(bounds.Low.Fhr_max, Fhr_bounds.Low_Fhr_max);
if bounds.Low.Fhr_max>bounds.Up.Fhr_max
    bounds.Low.Fhr_max=bounds.Up.Fhr_max;
end
bounds.Up.Fhr_min=min(bounds.Up.Fhr_min, Fhr_bounds.Up_Fhr_min);
if bounds.Up.Fhr_min < bounds.Low.Fhr_min
    bounds.Up.Fhr_min =bounds.Low.Fhr_min;
end


bounds.Low.S_slope=-1/(time_interval(2)-time_interval(1));
bounds.Up.S_slope=1/(time_interval(2)-time_interval(1));

bounds.Low.S_const=0;
bounds.Up.S_const=1;



% C bounds: note that C is: Contractility*Cven/Ca
scaling(vec_index.C_min)=100;
bounds.Low.C_min=(2/(Ca_upper_bound))/scaling(vec_index.C_min);
bounds.Up.C_min=(30/(Ca_lower_bound))/scaling(vec_index.C_min);

scaling(vec_index.delta_C)=100;
bounds.Low.delta_C=(50/(Ca_upper_bound))/scaling(vec_index.delta_C);
bounds.Up.delta_C=(200/(Ca_lower_bound))/scaling(vec_index.delta_C);

% the factor of the RC measurement
bounds.Low.RC_factor=0.05;
bounds.Up.RC_factor=2.5;

save bounds bounds

%% Set the normalization constant:
normalization.delta_V_cost=bounds.Up.Iex;
normalization.RC_cost=mean(R_C);
normalization.F_hr_cost=mean(F_hr);
normalization.Pp_cost=mean(Pp);
normalization.Pa_dot_cost=mean(F_hr.*Pp);

