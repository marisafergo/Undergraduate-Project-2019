% THIS SCRIPT PLOTS LEEDS DATA UNFILTTERED TO ANALYSE THE BEHAVIOUR
% OF THE THERMAL BOUNDARY CONDITIONS

% PS: For MATLAB to be able to read the data:

%BH=1
%IH=2
%BHIH = 3

%FTFF = 1
%FFFF = 2

% Clearing workspace, figures, variables and command window
clear all; close all; clear var; clc
 
% plot fontsize
pfzise = 8;
markersize = 7;

%% Loading all Leeds data
data13 = load('leeds-all-thermal.txt');

E3 = data13(:,1);
Pm3 = data13(:,2);
Pr3 = data13(:,3);
Ra3 = data13(:,4);
El3 = data13(:,5);
fohm3 = data13(:,6);
Bw3 = data13(:,7);
q3 = data13(:,8);
fdip3 = data13(:,9);
Bl1 = data13(:,12);
Bl10 = data13(:,13);
Bl32 = data13(:,14);
BC_source = data13(:,17);
BC_boundary = data13(:,18);

    
%% Relationships
% Lehnert and Elsasser
lehn3 = sqrt(2*El3.*E3./Pm3);
Pc3 = ((q3.^2).*Ra3.*Pm3)./E3;
Pa3 = (8*((E3./Pm3).^3)) .* Pc3;
    
%% Setting the axes and plotting the results
x = Pa3;
y = lehn3./sqrt(fohm3);

%IH and FTFF
L = BC_source == 2 & BC_boundary == 1;
loglog(x(L),y(L),'o', 'MarkerFaceColor',[255, 51, 51]/255,'MarkerEdge',[0.25, 0.25, 0.25],'MarkerSize',markersize);

%BHIH and FTFF
hold on
L = BC_source == 3 & BC_boundary == 1;
loglog(x(L),y(L),'o', 'MarkerFaceColor',[191, 255, 0]/255,'MarkerEdge',[0.25, 0.25, 0.25],'MarkerSize',markersize);

%BH and FTFF
hold on
L = BC_source == 1 & BC_boundary == 1;
loglog(x(L),y(L),'o', 'MarkerFaceColor',[0, 191, 255]/255,'MarkerEdge',[0.25, 0.25, 0.25],'MarkerSize',markersize);

%BH and FFFF
L = BC_source == 1 & BC_boundary == 2;
hold on
loglog(x(L),y(L),'o', 'MarkerFaceColor',[255, 191, 0]/255,'MarkerEdge',[0.25, 0.25, 0.25],'MarkerSize',markersize);

% Best-fit
[a,b,plotbfit,y_hat] = slopeestimate(x,y);

% Best fitting through weighted linear regression
[a,siga,b,sigb] = lserror(log(x),log(y));

% 3sigma limits
[line1,line2] = sigmalines(x,y,y_hat,a,b);


% Plot details
title({'Estimating the slope with Pc = ((q3.^2).*Ra3.*Pm3)./E3 and Pa = (8*((E/Pm)^3))*Pc; (unfiltered data)'})
ax = gca;
ax.FontSize = pfzise;
xlabel('$\it{\bf{Pa}}$','Interpreter','Latex','FontSize', 15)
ylabel('$\it{\bf{\lambda/(f_{ohm})^{1/2}}}$','Interpreter','Latex','FontSize', 15 )     
legend('IH and FTFF','BHIH and FTFF','BH and FTFF','BH and FFFF', 'Location', 'southeast');
     
    
    
    
