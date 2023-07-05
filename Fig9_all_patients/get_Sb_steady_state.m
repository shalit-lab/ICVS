function Sb=get_Sb_steady_state(Pa,kb,Pset)

% calculate the baro reflex activation, assumind steady state
Sb=( 1-1./(1+exp(-kb.*(Pa-Pset) ) ) );

