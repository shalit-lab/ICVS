function dSb_dPa=get_dSb_dPa(Pset,kb,Pa)

% the derivative of the steady state baro-reflex in respect to arterial
% pressure Pa
dSb_dPa=-(kb.*exp(-kb.*(Pa - Pset)))./(exp(-kb.*(Pa - Pset)) + 1).^2;


