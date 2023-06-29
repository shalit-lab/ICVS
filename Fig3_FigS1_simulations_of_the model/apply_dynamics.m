
Pset=50;
Kb=0.1838;
if strcmp(type,'hypovolemic')
    length_bleeding = 900; %(in sec)
    length_const = (interval_length - length_bleeding)/2; 
     Iex= [zeros(1,(length_const/dt)) -0.02*ones(1,length_bleeding/dt) zeros(1,(length_const/dt))]; 
    
    M_slope=0;
    M_const=-0.5;
    M_time=get_M_time(M_slope, M_const,dt:dt:interval_length);

    Fhr_max=180/60;
    Fhr_min=100/60;
    S_slope=0;
    S_const=0.2;
    S_time=get_S_time(S_const,S_slope,interval_length/dt,dt);

    C_min=200; % this is K_tilde
    delta_C=600; % this is K_tilde
    
    R_max=1.8;
    R_min=0.8;
    Ca=0.45;
    Cv=10;
    delta_V0=65;
    
    
    Pa_axis = [0 interval_length/60 42 52];
    Pv_axis = [0 interval_length/60 2 4];
    Hr_axis = [0 interval_length/60 120 140];
    RC_axis = [0 interval_length/60 0.77 0.8];
    Pp_axis = [0 interval_length/60 20 32];
end

if strcmp(type,'distributive')
    
    Iex=0*ones(1,interval_length/dt);
    length_distributive = 900; %(in sec)
    length_non = (interval_length - length_distributive)/2; 
    max_M=1.5; 
    min_M=0;
    M_slope=(max_M-min_M)/length_distributive;
    M_const=-0.5;
    M_time = M_const +[zeros(1,(length_non/dt))  get_M_time(M_slope,0,dt:dt:length_distributive) max_M*ones(1,(length_non/dt))];

   
       
    Fhr_max=180/60;
    Fhr_min=100/60;
    S_slope=0;
    S_const=0.2;
    S_time=get_S_time(S_const,S_slope,interval_length/dt,dt);

    C_min=200; % this is K_tilde
    delta_C=600; % this is K_tilde
    
    R_max=1.8;
    R_min=0.8;
    Ca=0.45;
    Cv=10;
    delta_V0=65;
   
    Pa_axis = [0 interval_length/60 42 52];
    Pv_axis = [0 interval_length/60 3.5 5];
    Hr_axis = [0 interval_length/60 120 140];
    RC_axis = [0 interval_length/60 0.3 0.8];
    Pp_axis = [0 interval_length/60 20 50];
end

if strcmp(type,'combined')
    
    length_bleeding = 900; %(in sec)
    length_const = (interval_length - length_bleeding)/2; 
    Iex= [zeros(1,(length_const/dt)) -0.02*ones(1,length_bleeding/dt) zeros(1,(length_const/dt))]; %previous: -0.03*ones(1,interval_length/dt);
    
    length_distributive = 900; %(in sec)
    length_non = (interval_length - length_distributive)/2; 
    max_M=1.5;
    min_M=0;
    M_slope=(max_M-min_M)/length_distributive;
    M_const=-0.5;
    M_time = M_const +[zeros(1,(length_non/dt))  get_M_time(M_slope,0,dt:dt:length_distributive) max_M*ones(1,(length_non/dt))];

    Fhr_max=180/60;
    Fhr_min=100/60;
    S_slope=0;
    S_const=0.2;
    S_time=get_S_time(S_const,S_slope,interval_length/dt,dt);

    
    C_min=200; % this is K_tilde
    delta_C=600; % this is K_tilde
    
    R_max=1.8;
    R_min=0.8;
    Ca=0.45;
    Cv=10;
    delta_V0=65;
    
    Pa_axis = [0 interval_length/60 42 52];
    Pv_axis = [0 interval_length/60 3 4];
    Hr_axis = [0 interval_length/60 120 140];
    RC_axis = [0 interval_length/60 0.3 0.8];
    Pp_axis = [0 interval_length/60 20 50];
end

if strcmp(type,'S_ext_change')
    
  
    Iex=0*ones(1,interval_length/dt);
    
    % create S: 
    length_S_change = 800/4; %(in sec)
    length_non = (interval_length - 2*length_S_change)/4; 
    max_S=0.5; 
    min_S=0.2;
  
     S_slope=(max_S-min_S)/length_S_change;
    S_const=min_S;
    S_time1 = S_const +[zeros(1,(length_non/dt))  get_S_time(0,S_slope,length_S_change/dt,dt) (max_S-min_S)*ones(1,(length_non/dt))];
    S_time2=fliplr(S_time1);
    S_time= [S_time1  S_time2];

    M_slope=0;
    M_const=-0.5;
    M_time=get_M_time(M_slope, M_const,dt:dt:interval_length);

    
    Fhr_max=180/60;
    Fhr_min=100/60;
    
    
      
    C_min=200; % this is K_tilde
    delta_C=600; % this is K_tilde
    
    R_max=1.8;
    R_min=0.8;
    Ca=0.45;
    Cv=10;
    delta_V0=65;

    
    Pa_axis = [0 interval_length/60 46 56];
    Pv_axis = [0 interval_length/60 3.5 4];
    Hr_axis = [0 interval_length/60 120 130];
    RC_axis = [0 interval_length/60 0.76 0.8];
    Pp_axis = [0 interval_length/60 28 35];
end

if strcmp(type,'control')
    length_bleeding = 900; %(in sec)
    length_const = (interval_length - length_bleeding)/2; 
     Iex= 0*ones(1,interval_length/dt); 
    
    M_slope=0;
    M_const=-0.5;
    M_time=get_M_time(M_slope, M_const,dt:dt:interval_length);

    Fhr_max=180/60;
    Fhr_min=100/60;
    S_slope=0;
    S_const=0.2;
    S_time=get_S_time(S_const,S_slope,interval_length/dt,dt);

    C_min=200;% this is K_tilde
    delta_C=600; % this is K_tilde
    
    R_max=1.8;
    R_min=0.8;
    Ca=0.45;
    Cv=10;
    delta_V0=65;
    
    Pa_axis = [0 interval_length/60 38 50];
    Pv_axis = [0 interval_length/60 2.5 5];
    Hr_axis = [0 interval_length/60 128 142];
    RC_axis = [0 interval_length/60 0.99 1.03];
    Pp_axis = [0 interval_length/60 17 22];
end


% apply the dynamics over a single interval:

Pa_dot=0; %
Pa_vec=zeros(1,interval_length/dt);
Pv_vec=zeros(1,interval_length/dt);
RC_vec=zeros(1,interval_length/dt);
Fhr_vec=zeros(1,interval_length/dt);
Pp_vec=zeros(1,interval_length/dt);
Sb_vec=zeros(1,interval_length/dt);
Stot_vec=zeros(1,interval_length/dt);

Pa=Pa_initial;
Pv=Pv_initial;

% run the dynamics:
for i=1:interval_length/dt
    
    
    Sb=get_Sb_steady_state(Pa,Kb,Pset);
    
    
    % get current autonomic control and current derivative of autonomic
    % control:
    S_tot=get_S_tot(Sb,S_time(i));
    dStot_dSext=get_dStot_dSext(Sb, S_time(i));
    dStot_dSb=get_dStot_dSb(Sb, S_time(i));
    dSb_dPa=get_dSb_dPa(Pset,Kb,Pa);
    if i==1
       current_S_slope= 0;
    else
       current_S_slope=(S_time(i)-S_time(i-1))/dt;
    end
    
    S_dot =  dStot_dSb.*dSb_dPa.*Pa_dot+dStot_dSext*current_S_slope;
    
    total_resistance_control=get_total_resistance_control(S_tot,M_time(i));
    
    % update Pp, Fhr, RC :
    RC=Ca*R_min+Ca*(R_max-R_min).*(total_resistance_control); % 
    Fhr=Fhr_min+(Fhr_max-Fhr_min).*(S_tot);
    Pp=(C_min+delta_C*(S_tot) )./((Pa-Pv) ).*(Pv);
    
    % update Pv, Pa: 
    Pa_dot=Fhr*Pp - (Pa-Pv)/RC ;
    Pv_dot=1/Cv*(-Pa_dot*Ca+delta_V0*S_dot+Iex(i));
    
    Pa_new=Pa+dt* Pa_dot;
    Pv_new=Pv+dt* Pv_dot;
    
    % if Pv is negative - put 0:
    Pv_new=(Pv_new>=0).*Pv_new;
    
    
    Pa=Pa_new;
    Pv=Pv_new;
    
    Pa_vec(i)=Pa;
    Pv_vec(i)=Pv;
    RC_vec(i)=RC;
    Fhr_vec(i)=Fhr;
    Pp_vec(i)=Pp;
    Sb_vec(i)=Sb;
    Stot_vec(i)=S_tot;
    tot_RC_control(i) = total_resistance_control; 
    
    
end

times=dt:dt:interval_length;
ploting_indeces=10:length(times);

figure(1);plot(times(ploting_indeces)/60,Pa_vec(ploting_indeces),'linewidth',2,'color',a_color)
title('Pa (mmHg)')
set(gcf,'position',measurements_position)
set(gca,'FontSize',font_size)
axis(Pa_axis)

figure(2);plot(times(ploting_indeces)/60,Pv_vec(ploting_indeces),'linewidth',2,'color',v_color)
title('Pv (mmHg)')
set(gcf,'position',measurements_position)
set(gca,'FontSize',font_size)
axis(Pv_axis)


figure(3);plot(times(ploting_indeces)/60,RC_vec(ploting_indeces),'linewidth',2,'color',RC_color)
title('RC (sec)')
set(gcf,'position',measurements_position)
set(gca,'FontSize',font_size)
axis(RC_axis)



figure(4);plot(times(ploting_indeces)/60,Fhr_vec(ploting_indeces)*60,'linewidth',2,'color','k')
title('Hr (1/min)')
set(gcf,'position',measurements_position)
set(gca,'FontSize',font_size)
axis(Hr_axis)

figure(5);plot(times(ploting_indeces)/60,Pp_vec(ploting_indeces),'linewidth',2,'color',Pp_color)
title('Pp (mmHg)')
set(gcf,'position',measurements_position)
set(gca,'FontSize',font_size)
axis(Pp_axis)





figure(6);plot(times(ploting_indeces)/60,Sb_vec(ploting_indeces),'linewidth',2,'color','k')
title('Sb')
set(gcf,'position',S_position)
set(gca,'FontSize',font_size)
set(gca, 'color', S_color)
xlabel('Time (min)')
axis([0 25 0.4 1])


figure(7);
plot(times(ploting_indeces)/60,-M_time(ploting_indeces),'linewidth',2,'color','k')
title('M_{\rm SVR}')
set(gcf,'position',control_position)
set(gca,'FontSize',font_size)
set(gca, 'color', control_color)
%xlabel('Time (min)')
axis([0 25 -1.1 1.2])%axis([0 25 -1.1 0.8])


figure(8);
plot(times(ploting_indeces)/60,Iex(ploting_indeces)/delta_V0*60,'linewidth',2,'color','k')
title('$\bar{I}_{\rm ex}$ (ml/min)', 'Interpreter','latex','FontSize',font_size) 
%xlabel('Time (min)')
set(gcf,'position',control_position)
set(gca,'FontSize',font_size)
set(gca, 'color', control_color)
axis([0 25 -0.03 0.03])

figure(9);
plot(times(ploting_indeces)/60,(C_min+delta_C)*ones(1,length(ploting_indeces)),'linewidth',2,'color','k')
title('$k_{\rm max}$ (mmHg)', 'Interpreter','latex','FontSize',font_size) 
%xlabel('Time (min)')
set(gcf,'position',control_position)
set(gca,'FontSize',font_size)
set(gca, 'color', control_color)
axis([0 25 0 1500])

%%
function M_time=get_M_time(M_slope, M_const,times)
M_time=M_slope*times+M_const;
end
%%
function S_time=get_S_time(S_const,S_slope,window_length,dt)
S_time=S_const+S_slope*(1:window_length)*dt;
end
%%
function Sb=get_Sb_steady_state(Pa,kb,Pset)
% calculate the baro reflex activation, assumind steady state
Sb=( 1-1./(1+exp(-kb.*(Pa-Pset) ) ) );
end
%%
function S_tot=get_S_tot(Sb,Sext)
S_tot=1./(1 + exp(-3.3*(Sb+Sext-1) ) );
end
%%
function dStot_dSext=get_dStot_dSext(Sb, Sext)
dStot_dSext = (2*exp(2 - 2*Sext - 2*Sb))./(exp(2 - 2*Sext - 2*Sb) + 1).^2;
end
%%
function dStot_dSb=get_dStot_dSb(Sb, Sext)
dStot_dSb = (2*exp(2 - 2*Sext - 2*Sb))./(exp(2 - 2*Sext - 2*Sb) + 1).^2;
end
%%
function dSb_dPa=get_dSb_dPa(Pset,kb,Pa)
dSb_dPa=-(kb.*exp(-kb.*(Pa - Pset)))./(exp(-kb.*(Pa - Pset)) + 1).^2;
end
%%
function total_resistance_control=get_total_resistance_control(S_tot,M)
total_resistance_control=1./(1 + exp(-3.3*(S_tot-M) ) );
end




