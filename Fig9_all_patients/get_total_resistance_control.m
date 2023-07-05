function total_resistance_control=get_total_resistance_control(S_tot,M)

total_resistance_control=1./(1 + exp(-3.3*(S_tot-M) ) );


