close all
clear all
addpath(fullfile(cd, '..'))

id_number=1;
weight=3; % the weight is modified to avoide patient identification
age=10/365; % the weight is modified to avoide patient identification


make_perturbation=0;

time_start=7000;
interval_length=300;
interval_step=100;
num_intervals=15;

analyse_data_now=0;
optimization_analysis=1;
perform_perturb_analysis=0;
num_of_perturbations=10;

single_patient_analysis
