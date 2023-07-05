function dStot_dSb=get_dStot_dSb(Sb, Sext)


dStot_dSb = (2*exp(2 - 2*Sext - 2*Sb))./(exp(2 - 2*Sext - 2*Sb) + 1).^2;