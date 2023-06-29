% figure  model demonstration:
addpath(fullfile(cd, '..'))

close all
clear all
label='hypovolemic';%'Control';%'distributive';

%% for hypovolemic:

if strcmp(label,'hypovolemic')
    
    id_number=1;
    
    total_iterations=12;
    start_time=[7000 7300];
    
    Sb_y=[0 0.6];
    S_y=[0 0.5];
    M_y=[-1 1.5];
    Iex_y=[-0.025 0.025];
    Pa_y=[50 65];
    Pv_y=[8 10];
    Fhr_y=[120 130];
    RC_y=[0.45 0.66];
    Pp_y=[40 50];
    C_y=[0 3000];
    
end



if strcmp(label,'Control')
    id_number=9; %
    total_iterations=12;
    start_time=[100100 100400];
    Sb_y=[0.5 1];
    S_y=[0 0.5];
    M_y=[-1.2 1.2];
    Iex_y=[-0.3 0.3];
    Pa_y=[40 52];
    Pv_y=[5 12.5];
    Fhr_y=[145 158];
    RC_y=[0.85 1.1];
    C_y=[0 600];
    
end


%% for distributive:
if strcmp(label,'distributive')
    
    id_number=5;
    
    total_iterations=12;
    start_time=[4200 4500];
    
    Sb_y=[0.5 1];
    S_y=[0 0.5];
    M_y=[-1 1];
    Iex_y=[-0.05 0.05];
    C_y=[0 800];
end

a_color= [0.6392 0.0784 0.1804];
v_color=[0 0.4510 0.7412];
RC_color=[0.4706    0.6706    0.1882];
Pp_color=[1.0000    0.0745    0.6510];

measurements_position=[10 10 500 100];
estimation_position=[10 10 500 170];
font_size=12;

%%%%%%%%%

close all
%% open each file and plot the time dependent estimations
num_of_exist=0;
times_of_exist=[];
I_ex_vec=[];
M_vec_time=[];
C_vec=[];

for ttt=0:total_iterations-1
    time_interval(1)=start_time(1)+100*ttt;
    time_interval(2)=start_time(2)+100*ttt;
    time_plot=time_interval/3600;
    curr_time=0.5*(time_interval(2)+time_interval(1))/60; % in minutes
    time_plot_vec(ttt+1) = curr_time;
    
    if exist(sprintf('../Fig9_all_patients/subject %d/results_%d_interval_%g_%g.mat',id_number,id_number,time_interval(1),time_interval(2)))
        
        num_of_exist=num_of_exist+1;
        % times of existing files
        times_of_exist(num_of_exist)=time_interval(1)+(time_interval(2)-time_interval(1))/2;
        
        %%  load results
        load (sprintf('../Fig9_all_patients/subject %d/results_%d_interval_%g_%g.mat',id_number,id_number,time_interval(1),time_interval(2)))% load results
        
        
        time_plot_first=(time_interval(1)+dt:dt:time_interval(1)-100+dt*(length(measurements.Pa_time)-1))/60;
        time_plot=(time_interval(1)+100:dt:time_interval(1)-100+dt*(length(measurements.Pa_time)-1))/60;
        figure(1)
        set(gcf,'position',measurements_position)
        set(gca,'FontSize',font_size)
        
        hold all
        if num_of_exist==1
            plot(time_plot_first-time_plot_first(1),measurements.Pa_time(1:2000),'color',a_color,'linewidth',2)
            first_point=time_plot_first(1);
        else
            plot([last_Pa(1)-first_point time_plot(1)-first_point],[last_Pa(2) measurements.Pa_time(1000)],'color',a_color,'linewidth',2)
            plot(time_plot-first_point,measurements.Pa_time(1000:2000),'color',a_color,'linewidth',2)
            
        end
        last_Pa=[time_plot(end) measurements.Pa_time(2000)]; % keep for the next step - connect between each two point
        title('$$\widehat{P_a}$$ (mmHg)','Interpreter','Latex')
        
        
        
        % venous BP
        figure(2)
        set(gcf,'position',measurements_position)
        set(gca,'FontSize',font_size)
        
        
        hold all
        if num_of_exist==1
            plot(time_plot_first-time_plot_first(1),measurements.Pv_time(1:2000),'color',v_color,'linewidth',2)
        else
            plot([last_Pv(1)-first_point time_plot(1)-first_point],[last_Pv(2) measurements.Pv_time(1000)],'color',v_color,'linewidth',2)
            plot(time_plot-first_point,measurements.Pv_time(1000:2000),'color',v_color,'linewidth',2)
            
        end
        last_Pv=[time_plot(end) measurements.Pv_time(2000)]; % keep the last point for the next step 
        title('$$\widehat{P_v}$$ (mmHg)','Interpreter','Latex')
        
        
        % heart rate
        figure(3)
        set(gcf,'position',measurements_position)
        set(gca,'FontSize',font_size)
        
        
        hold all
        if num_of_exist==1
            plot(time_plot_first-time_plot_first(1),measurements.Fhr_time(1:2000)*60,'color','k','linewidth',2)
        else
            plot([last_Fhr(1)-first_point time_plot(1)-first_point],[last_Fhr(2) measurements.Fhr_time(1000)*60],'color','k','linewidth',2)
            plot(time_plot-first_point,measurements.Fhr_time(1000:2000)*60,'color','k','linewidth',2)
            
        end
        last_Fhr=[time_plot(end) measurements.Fhr_time(2000)*60]; % keep the last point for the next step 
        title('$$\widehat{\rm Hr}$$ (1/min)','Interpreter','Latex')
        
        
        % RC
        figure(4)
        set(gcf,'position',measurements_position)
        set(gca,'FontSize',font_size)
        
        
        hold all
        if num_of_exist==1
            plot(time_plot_first-time_plot_first(1),measurements.RC_time(1:2000),'color',RC_color,'linewidth',2)
        else
            plot([last_RC(1)-first_point time_plot(1)-first_point],[last_RC(2) measurements.RC_time(1000)],'color',RC_color,'linewidth',2)
            plot(time_plot-first_point,measurements.RC_time(1000:2000),'color',RC_color,'linewidth',2)
            
        end
        last_RC=[time_plot(end) measurements.RC_time(2000)]; % keep the last point for the next step 
        title('$$\widehat{RC}$$ (sec)','Interpreter','Latex')
        
        
        % RC
        figure(5)
        set(gcf,'position',measurements_position)
        set(gca,'FontSize',font_size)
        
        
        hold all
        if num_of_exist==1
            plot(time_plot_first-time_plot_first(1),measurements.Pp_time(1:2000),'color',Pp_color,'linewidth',2)
        else
            plot([last_Pp(1)-first_point time_plot(1)-first_point],[last_Pp(2) measurements.Pp_time(1000)],'color',Pp_color,'linewidth',2)
            plot(time_plot-first_point,measurements.Pp_time(1000:2000),'color',Pp_color,'linewidth',2)
            
        end
        last_Pp=[time_plot(end) measurements.Pp_time(2000)]; % keep the last point for the next step 
        title('$$\widehat{P_p}$$ (mmHg)','Interpreter','Latex')
        
        
        
        
        % Iex
        delta_V=optimal_parameters(vec_index.delta_V0)*scaling(vec_index.delta_V0);
        I_ex_plot=optimal_parameters(vec_index.Iex)*60./delta_V;
        I_ex_vec(ttt+1)= I_ex_plot;
        
       
        
        %M
        length_interval=length(Pa);
        M_time=get_M_time(optimal_parameters(vec_index.M_slope),optimal_parameters(vec_index.M_const),dt:dt:dt*length_interval);
        
        M_vec(num_of_exist)=mean(M_time);
        M_vec_time(ttt+1)=mean(M_time);
        
        % contractility
        C_vec_time(ttt+1)=optimal_parameters(vec_index.C_min)*scaling(vec_index.C_min)+optimal_parameters(vec_index.delta_C)*scaling(vec_index.delta_C);
        
        
        
    end
    
end

%% plot mooving average for Iex:
figure(17)
set(gcf,'position', estimation_position)
num_averaging=4;
movmean(I_ex_vec,num_averaging)
plot(time_plot_vec-time_plot_vec(1),I_ex_vec,'o','MarkerFaceColor',[0.5 0.5 0.5])
hold all
plot(time_plot_vec-time_plot_vec(1),movmean(I_ex_vec,num_averaging),'-','color','k','linewidth',3)
title('$\bar{I}_{\rm ex}$ (1/min)', 'Interpreter','latex','FontSize',font_size) 
set(gca,'FontSize',font_size)
yline(0,'--')


figure(18)
set(gcf,'position', estimation_position)
plot(time_plot_vec-time_plot_vec(1),-M_vec_time,'o','MarkerFaceColor',[0.5 0.5 0.5])
hold all
plot(time_plot_vec-time_plot_vec(1),movmean(-M_vec_time,num_averaging),'-','color','k','linewidth',3)
title('$M_{\rm SVR}$', 'Interpreter','latex','FontSize',font_size) 
set(gca,'FontSize',font_size)

figure(19)
set(gcf,'position', estimation_position)
plot(time_plot_vec-time_plot_vec(1),C_vec_time,'o','MarkerFaceColor',[0.5 0.5 0.5])
hold all
plot( time_plot_vec-time_plot_vec(1),movmean( C_vec_time,num_averaging),'-','color','k','linewidth',3)
title('$\tilde{K}_{\rm max}$ (mmHg)', 'Interpreter','latex','FontSize',font_size) 
set(gca,'FontSize',font_size)




    figure(17)
    ylim(Iex_y)
    yline(0,'--')

    
    figure(18)
    ylim(M_y)
    
    figure(19)
    ylim(C_y)


    figure(1)
    ylim(Pa_y)
    
    figure(2)
    ylim(Pv_y)
    
    figure(3)
    ylim(Fhr_y)
    
    figure(4)
    ylim(RC_y)
    
    
