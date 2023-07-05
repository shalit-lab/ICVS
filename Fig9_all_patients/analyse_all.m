%% analyse all:

clear all;
close all;
length_analysis=12;
figure(1); hold all;
figure(2);hold all;
index=0;
distributive_color= [0.9350 0.4 0.50];

%% plot hypovolemic vs. non hypovolemic:

% plot defined as  hipovolemic:
id_numbers_hypovolemic=[ 1 2 3 4];
for i=1:length(id_numbers_hypovolemic)
    index=index+1;
    id_number=id_numbers_hypovolemic(i);
    file_name=sprintf('./subject %d/total_results_%d',id_number,id_number);
    
    load(file_name)
    figure(1)
    I_over_deltaV=I_ex_vec./delta_V_vec;
    errorbar(index,mean(I_over_deltaV(1:length_analysis)),std(I_over_deltaV(1:length_analysis))/sqrt(length(1:length_analysis)),'o','color',[0 0.4510 0.7412],'linewidth',2,'MarkerFaceColor',[0 0.4510 0.7412],'MarkerSize',8)
    
    means_Iex_hypovolemic(index)=mean(I_over_deltaV(1:length_analysis));
    STD_Iex_hypovolemic(index)=std(I_over_deltaV(1:length_analysis))/sqrt(length(1:length_analysis));
    
end

index_non_hypo=0;
% plot defined as non- hipovolemic:
id_numbers_hypovolemic=[5 6 7 8 9 10];
means_Iex_non_hypovolemic=0;
STD_Iex_non_hypovolemic=0;
for i=1:length(id_numbers_hypovolemic)
    index=index+1;
    index_non_hypo=index_non_hypo+1;% count only non hypovolemic
    id_number=id_numbers_hypovolemic(i);
    file_name=sprintf('./subject %d/total_results_%d',id_number,id_number);
    
    load(file_name);
    figure(1)
    I_over_deltaV=I_ex_vec./delta_V_vec;
    errorbar(index,mean(I_over_deltaV(1:length_analysis)),std(I_over_deltaV(1:length_analysis))/sqrt(length(1:length_analysis)),'o','color','k','linewidth',2,'MarkerFaceColor','k','MarkerSize',8)
    means_Iex_non_hypovolemic(index_non_hypo)=mean(I_over_deltaV(1:length_analysis));
    STD_Iex_non_hypovolemic(index_non_hypo)=std(I_over_deltaV(1:length_analysis))/sqrt(length(1:length_analysis));
    
end

%% get p value for hypovolemic vs non. hypovilemic:
[h,p_value_hypovolemic] = ttest2( means_Iex_hypovolemic,means_Iex_non_hypovolemic)
I_ex_hypovolemic=fitdist(means_Iex_hypovolemic','Normal')
I_ex_non_hypovolemic=fitdist(means_Iex_non_hypovolemic','Normal')



%% plot distributive vs. non-distrobutive:
% plot defined as pure distributive
id_numbers_distributive_labeled=[3 5 6];
id_numbers_distributive_treated=[2 4 10];
indexM=0;
for i=1:length(id_numbers_distributive_labeled)
    indexM=indexM+1;
    index=index+1;
    id_number=id_numbers_distributive_labeled(i);
    file_name=sprintf('./subject %d/total_results_%d',id_number,id_number);
    load(file_name)
    
    figure(2)
    errorbar(index,-mean(M_vec(1:length_analysis)),std(M_vec(1:length_analysis))/sqrt(length(1:length_analysis)),'o','color',[0.6350 0.0780 0.1840],'linewidth',2,'MarkerFaceColor',[0.6350 0.0780 0.1840],'MarkerSize',8)
    means_M_distributive_labeled(indexM)=mean(M_vec(1:length_analysis));
    STD_M_distributive__labeled(indexM)=std(M_vec(1:length_analysis))/sqrt(length(1:length_analysis));
    
end

indexM=0;
for i=1:length(id_numbers_distributive_treated)
    indexM=indexM+1;
    index=index+1;
    id_number=id_numbers_distributive_treated(i);
    file_name=sprintf('./subject %d/total_results_%d',id_number,id_number);
    load(file_name)
    
    figure(2)
    errorbar(index,-mean(M_vec(1:length_analysis)),std(M_vec(1:length_analysis))/sqrt(length(1:length_analysis)),'o','color',distributive_color,'linewidth',2,'MarkerFaceColor',distributive_color,'MarkerSize',8)
    means_M_distributive(indexM)=mean(M_vec(1:length_analysis));
    STD_M_distributive(indexM)=std(M_vec(1:length_analysis))/sqrt(length(1:length_analysis));
    
end


% plot defined as non distributive
index_non_distributive=0;
id_numbers_distributive_treated=[1 7 8  9 ];
for i=1:length(id_numbers_distributive_treated)
    index=index+1;
    index_non_distributive=index_non_distributive+1;
    id_number=id_numbers_distributive_treated(i);
    file_name=sprintf('./subject %d/total_results_%d',id_number,id_number);
    load(file_name)
    
    figure(2)
    errorbar(index,-mean(M_vec(1:length_analysis)),std(M_vec(1:length_analysis))/sqrt(length(1:length_analysis)),'o','color','k','linewidth',2,'MarkerFaceColor','k','MarkerSize',8)
    means_M_non_distributive(index_non_distributive)=mean(M_vec(1:length_analysis));
    STD_M_non_distributive(index_non_distributive)=std(M_vec(1:length_analysis))/sqrt(length(1:length_analysis));
    
end
[h,p_value_distributive] = ttest2(means_M_distributive_labeled,means_M_non_distributive)
M_distributive=fitdist(-means_M_distributive_labeled','Normal')
M_non_distributive=fitdist(-means_M_non_distributive','Normal')

%%
figure(1);
ylabel(' Mean $\tilde{I}{\rm ex}$ (1/min)', 'Interpreter','latex')
xlabel('# Patient')
X_names_hypovolemic={'#1';'#2';'#3';'#4';'#5';'#6';'#7';'#8';'#9';'#10'};
set (gca,'xtick',[1:10],'xticklabel',X_names_hypovolemic);
set (gca,'fontsize',14)

figure(2);
ylabel(' Mean $M_{\rm SVR}$', 'Interpreter','latex')
xlabel('# Patient')
X_names_distributive={'#3';'#5';'#6';'#2';'#4';'#10';'#1';'#7';'#8';'#9' };
set (gca,'xtick',[11:20],'xticklabel',X_names_distributive);
set (gca,'fontsize',14)

