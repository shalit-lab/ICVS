function dStot_dSext=get_dStot_dSext(Sb, Sext)


dStot_dSext = (2*exp(2 - 2*Sext - 2*Sb))./(exp(2 - 2*Sext - 2*Sb) + 1).^2;