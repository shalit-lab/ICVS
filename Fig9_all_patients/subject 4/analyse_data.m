% data_analysis:
clear all;
close all;


id_number=4;
weight=3; % % the weight is modified to avoide patient identification 
age=10/365; % years % the age is modified to avoide patient identification

time_start=15400 % 15300;%  - before chest opening  23400 - chest opening
interval_length=300;
interval_step=100; % sec
num_intervals=35;



analyse_data_now=0;
optimization_analysis=1;
perform_perturb_analysis=0;

single_patient_analysis
