% data_analysis:
%oldpath = path;
close all
clear all

id_number=3; 
weight=3.5; % the weight is modified to avoide patient identification 

age=10/365; % years % the age is modified to avoide patient identification


time_start=13900;
interval_length=300;
interval_step=100; % sec
num_intervals=20;

analyse_data_now=0;
optimization_analysis=1;
perform_perturb_analysis=0;

single_patient_analysis
