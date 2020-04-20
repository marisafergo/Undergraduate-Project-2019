function [H_F_m,H_F_e,H_F_both] = ftestme(x,slopehat,slopemac,slopeene)
% F-Test for the MAC and Energy Balance
% for H=0: don't reject null hypothesis
% for H=1: reject null hypothesis


% Null hypothesis with the slope estimated from data
h0 = (x).^slopehat;

h1_m = (x).^(slopemac);
h1_e = (x).^(slopeene);

H_F_m = vartest2(h0,h1_m);
H_F_e = vartest2(h0,h1_e);

disp(' ')
disp('--- F-test ---')
disp('for H=0: do not reject null hypothesis')
disp('for H=1: reject null hypothesis')

disp(' ')
disp(' **Slopehat as the null hypothesis** ')
disp(['for the MAC balance H = ' num2str(H_F_m)]);
disp(['for the Energy balance H = ' num2str(H_F_e)]);

% Null hypothesis is the Energy Balance
h0_ene = h1_e;
h1_mac = h1_m;

H_F_both = vartest2(h0_ene,h1_mac);

disp(' ')
disp('** Energy Balance as the null hypothesis** ')
disp(['Comparing MAC and Energy Balance H = ' num2str(H_F_both)]);
disp('--------------')
disp(' ')


end

