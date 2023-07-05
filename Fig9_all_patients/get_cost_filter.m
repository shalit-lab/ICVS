function cost_filter=get_cost_filter(Cv,delta_V0,Pset,Fhr_max,Fhr_min,R_max,R_min,RC_factor)
% this function calculates the exponential filter:
% for each parameter theta the filter has the following shape:  sum_t'
% exp(t-t'/tau)*(theta_hat(t')-theta)^2=
%  sum_t' exp(t-t'/tau)*theta_hat(t')^2-2*exp(t-t'/tau)*theta_hat(t')*theta+exp(t-t'/tau)*theta^2
% note that the first expression does not depend on theta. Thus we left
% with:
% -2*exp(t-t'/tau)*theta_hat(t')*theta+exp(t-t'/tau)*theta^2
% For the first expression (filter_1) - we should calculate a weighted sum of the
% previous theta_hat using an exponential filter. For the second expression
% (filter 2)
% we should calculate just a weighted sum of exponents. 
% filter_1= -2*exp(t-t'/tau)*theta_hat(t')*theta
% filter_2= exp(t-t'/tau)*theta^2
% for each parameter:
% term=-2*theta*filter1 + filter2*theta^2

global current_filter1 current_filter2 filter_factor bounds

Cv_term      = -2*Cv*current_filter1.Cv           +Cv^2*current_filter2.Cv;
delta_V0_term=-2*delta_V0*current_filter1.delta_V0+delta_V0^2*current_filter2.delta_V0;
baro_term    =-2*Pset*current_filter1.Pset        + Pset^2*current_filter2.Pset;
Fhr_max_term = -2*Fhr_max*current_filter1.Fhr_max + Fhr_max^2*current_filter2.Fhr_max;
Fhr_min_term = -2*Fhr_min*current_filter1.Fhr_min + Fhr_min^2*current_filter2.Fhr_min;
R_max_term   = -2*R_max*current_filter1.R_max     + R_max^2*current_filter2.R_max;
R_min_term   = -2*R_min*current_filter1.R_min     + R_min^2*current_filter2.R_min;
RC_factor_term = -2*RC_factor*current_filter1.RC_factor     + RC_factor^2*current_filter2.RC_factor;



total=Cv_term./(bounds.Up.Cv.^2)+delta_V0_term./(bounds.Up.delta_V0.^2)...
    +baro_term./(bounds.Up.Pset.^2)+  Fhr_max_term./(bounds.Up.Fhr_max.^2)+  Fhr_min_term./(bounds.Up.Fhr_min.^2)...
    +R_max_term./(bounds.Up.R_max.^2) + R_min_term./(bounds.Up.R_min.^2)+RC_factor_term./(bounds.Up.RC_factor.^2);


cost_filter=total*filter_factor;