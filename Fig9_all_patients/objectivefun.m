function cost=objectivefun(X)
global Pa Pv F_hr R_C Pp Pa_dot Pv_dot Pa_smooth dt
global w_pa w_pv w_RC w_Fhr w_Pp vec_index normalization scaling


Cv=X(vec_index.Cv)*scaling(vec_index.Cv);
delta_V0=X(vec_index.delta_V0)*scaling(vec_index.delta_V0);
Iex=X(vec_index.Iex);
Pset=X(vec_index.Pset)*scaling(vec_index.Pset);
Kb=X(vec_index.Kb);
R_max=X(vec_index.R_max);
R_min=X(vec_index.R_min);
M_slope=X(vec_index.M_slope);
M_const=X(vec_index.M_const);
Fhr_max=X(vec_index.Fhr_max);
Fhr_min=X(vec_index.Fhr_min);
S_slope=X(vec_index.S_slope);
S_const=X(vec_index.S_const);
C_min=X(vec_index.C_min)*scaling(vec_index.C_min); 
delta_C=X(vec_index.delta_C)*scaling(vec_index.delta_C);
RC_factor=X(vec_index.RC_factor);


%% calculate cost function
S_time=get_S_time(S_const,S_slope,length(Pa),dt);
Sb=get_Sb_steady_state(Pa,Kb,Pset);
S_tot=get_S_tot(Sb,S_time);
dStot_dSext=get_dStot_dSext(Sb, S_time);
dStot_dSb=get_dStot_dSb(Sb, S_time);
M_time=get_M_time(M_slope, M_const,dt:dt:length(Pa)*dt);
total_resistance_control=get_total_resistance_control(S_tot,M_time);

% Pv dot contribution:
dSb_dPa=get_dSb_dPa(Pset,Kb,Pa_smooth);

volume_change_cost=Pa_dot+Cv*Pv_dot-(delta_V0).*(dStot_dSb.*dSb_dPa.*Pa_dot+dStot_dSext*S_slope)-Iex;


norm_volume_change=normalization.delta_V_cost;
volume_change_cost_norm=volume_change_cost./norm_volume_change;



RC_cost=R_min+(R_max-R_min).*(total_resistance_control)-R_C;

norm_RC=normalization.RC_cost;
RC_cost_norm=RC_cost./norm_RC;

% Fhr contribution
Fhr_cost=Fhr_min+(Fhr_max-Fhr_min).*(S_tot)-F_hr;

norm_Fhr_cost=normalization.F_hr_cost;
Fhr_cost_norm=Fhr_cost./norm_Fhr_cost;


% Pp contribution
Pp_cost=(C_min+delta_C*(S_tot) )./((Pa-Pv) ).*(Pv)-Pp;

norm_Pp_cost=normalization.Pp_cost;
Pp_norm=Pp_cost./norm_Pp_cost;

% 
Pa_dot_cost= Pp.*F_hr - (Pa-Pv)./( R_min+(R_max-R_min).*(total_resistance_control) )*RC_factor - Pa_dot;

norm_Pa_dot_cost=normalization.Pa_dot_cost;
Pa_dot_norm=Pa_dot_cost./norm_Pa_dot_cost;

cost_model=(Pa_dot_norm*Pa_dot_norm.')*w_pa +(volume_change_cost_norm*volume_change_cost_norm.')*w_pv+(RC_cost_norm*RC_cost_norm.')*w_RC +(Fhr_cost_norm*Fhr_cost_norm.')*w_Fhr+(Pp_norm*Pp_norm.')*w_Pp;

cost_filter=get_cost_filter(Cv/scaling(vec_index.Cv),delta_V0/scaling(vec_index.delta_V0),Pset/scaling(vec_index.Pset),Fhr_max,Fhr_min,R_max,R_min,RC_factor);
cost=cost_filter+cost_model;
