function [plotearth, x_m] = earthplot()
% This function plots the Earth 
% and includes its errors


%% Defining the ranges of the dimensionless paramteres (From Treatise V8)
fohm = 1;
El = 1e1; % From Aubert et al.(2017)

Pm_l = 1e-6;
Pm_u = 3e-6;
Pm_m = (Pm_l+Pm_u)/2;

E_l = 1e-15;
E_u = 5e-15;
E_m = (E_l+E_u)/2;

Pr_l = 0.05;
Pr_u = 0.2;
Pr_m = (Pr_l+Pr_u)/2;

q_l = Pm_l/Pr_l;
q_u = Pm_m/Pr_u;
q_m = Pm_m/Pr_m;

Ra = 1e17;

lehn_l = sqrt((2*El*E_l)/Pm_l);
lehn_u = sqrt((2*El*E_u)/Pm_u);
lehn_m = (lehn_l+lehn_u)/2;


%% Working out the power

% Pc related to dimensionless parameters
Pc_l = ((q_l^2)*Ra*Pm_l)/E_l;  % Pc = Bw/Vs
Pc_u = ((q_u^2)*Ra*Pm_u)/E_u;
Pc_m = (Pc_l+Pc_u)/2;

% Converting Pc into Pa
Pa_l = (8*((E_l./Pm_l).^3)) .* Pc_l;
Pa_u = (8*((E_u./Pm_u).^3)) .* Pc_u;
Pa_m = (Pa_l+Pa_u)/2;


%% Setting the axis

x_l = Pa_l;
y_l = lehn_l/sqrt(fohm);

x_u = Pa_u;
y_u = lehn_u/sqrt(fohm);

x_m = Pa_m;
y_m = lehn_m/sqrt(fohm);


hold on

x_u = 3.2000e-12;
x_m = 2.7111e-12;
x_l = 2.2222e-12;
y_u = 1.8257e-04;
y_m = 1.6200e-04;
y_l = 1.4142e-04;

plotearth = errorbar(x_m, y_m, y_l, y_u, x_l, x_u);
plotearth.Color = [0.15, 0.15, 0.15];
set(gca, 'XScale','log', 'YScale','log')


end

