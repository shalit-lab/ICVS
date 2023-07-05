function S_time=get_S_time(S_const,S_slope,window_length,dt)


S_time=S_const+S_slope*(1:window_length)*dt;
