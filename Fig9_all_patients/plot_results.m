% plot results' time course
function plot_results(id_number,start_time,total_iterations)

close all
%% open each file and plot the time dependent estimated parameters:
num_of_exist=0;
times_of_exist=[];

for ttt=0:total_iterations-1
    time_interval(1)=start_time(1)+100*ttt;
    time_interval(2)=start_time(2)+100*ttt;
    
    if exist(sprintf('results_%d_interval_%g_%g.mat',id_number,time_interval(1),time_interval(2)))
        num_of_exist=num_of_exist+1;
        % times of existing files
        times_of_exist(num_of_exist)=time_interval(1)+(time_interval(2)-time_interval(1))/2;
        
        %% now load results
        load (sprintf('results_%d_interval_%g_%g.mat',id_number,time_interval(1),time_interval(2)))% load results
          
        length_interval=length(measurements.Pa_time);
        
        % Arterial BP
        figure(1)
        hold all
        plot(time_interval(1)+dt:dt:time_interval(1)+dt*length_interval,measurements.Pa_time,'b','linewidth',2)
        title('Arterial BP (mmHg)')
                
        % venous BP
        figure(2)
        hold all
        plot(time_interval(1)+dt:dt:time_interval(1)+dt*length_interval,measurements.Pv_time,'r','linewidth',2)
        title('Venous BP (mmHg)')
        
        % Heart rate
        figure(3)
        hold all
        plot(time_interval(1)+dt:dt:time_interval(1)+dt*length_interval,measurements.Fhr_time*60,'k','linewidth',2)
        title('Heart rate (1/min)')
        
        
        % RC
        figure(4)
        hold all
        plot(time_interval(1)+dt:dt:time_interval(1)+dt*length_interval,measurements.RC_time,'g','linewidth',2)
        title('RC')
        
        % RC
        figure(5)
        hold all
        plot(time_interval(1)+dt:dt:time_interval(1)+dt*length_interval,measurements.Pp_time,'c','linewidth',2)
        title('Pulse pressure (mm Hg)')
        
        
        curr_time=0.5*(time_interval(2)+time_interval(1));
        
        
        % Iex
        figure(6)
        hold all
        
        I_ex_plot=optimal_parameters(vec_index.Iex)*60./(optimal_parameters(vec_index.delta_V0)*scaling(vec_index.delta_V0));
       plot(curr_time,I_ex_plot,'o','color','k','linewidth',2)
        title('Iex over delta V0(ml/min)')
        
        I_ex_vec(num_of_exist)=optimal_parameters(vec_index.Iex)*60;
        delta_V_vec(num_of_exist)=optimal_parameters(vec_index.delta_V0)*scaling(vec_index.delta_V0);
        

        %M
        figure(7)
        hold all
        
        M_time=get_M_time(optimal_parameters(vec_index.M_slope),optimal_parameters(vec_index.M_const),dt:dt:dt*length_interval);
        
        plot(curr_time,-mean(M_time),'o','color','k','linewidth',2)
        title('mean M')
        
        M_vec(num_of_exist)=mean(M_time);
        
        % contractility
        figure(8)
        hold all
        C_to_plot=(optimal_parameters(vec_index.C_min).*scaling(vec_index.C_min)+optimal_parameters(vec_index.delta_C)*scaling(vec_index.delta_C));        
        
        plot(curr_time,C_to_plot,'o','color','k','linewidth',2)
        title('Total contractility over arterial compliance (mmHg)')
        
        C_vec(num_of_exist)=optimal_parameters(vec_index.C_min).*scaling(vec_index.C_min)+optimal_parameters(vec_index.delta_C)*scaling(vec_index.delta_C);
        C_min_vec(num_of_exist)=optimal_parameters(vec_index.C_min);
        
       
        
    end
end


%% plot all average measurements:
figure(17)
Pa_subplot = subplot(5,1,1);
Pv_subplot = subplot(5,1,2);
Fhr_subplot = subplot(5,1,3);
RC_subplot = subplot(5,1,4);
Pp_subplot = subplot(5,1,5);




% Pa
%Pa_fig = findobj(figure(1),'type','axes');
axes_to_be_copied = findobj(figure(1),'type','axes');
chilred_to_be_copied = get(axes_to_be_copied,'children');
copyobj(chilred_to_be_copied,Pa_subplot)
set(Pa_subplot,'title',get(axes_to_be_copied,'title'))

% Pv
axes_to_be_copied = findobj(figure(2),'type','axes');
chilred_to_be_copied = get(axes_to_be_copied,'children');
copyobj(chilred_to_be_copied,Pv_subplot)
set(Pv_subplot,'title',get(axes_to_be_copied,'title'))

%Fhr
axes_to_be_copied = findobj(figure(3),'type','axes');
chilred_to_be_copied = get(axes_to_be_copied,'children');
copyobj(chilred_to_be_copied,Fhr_subplot)
set(Fhr_subplot,'title',get(axes_to_be_copied,'title'))

%RC
axes_to_be_copied = findobj(figure(4),'type','axes');
chilred_to_be_copied = get(axes_to_be_copied,'children');
copyobj(chilred_to_be_copied,RC_subplot)
set(RC_subplot,'title',get(axes_to_be_copied,'title'))

%Pp
axes_to_be_copied = findobj(figure(5),'type','axes');
chilred_to_be_copied = get(axes_to_be_copied,'children');
copyobj(chilred_to_be_copied,Pp_subplot)
set(Pp_subplot,'title',get(axes_to_be_copied,'title'))



%% save results:
file_name_save=sprintf('total_results_%d.mat',id_number);

close all
save(file_name_save)
