% CA06 ONLY

% Clearing workspace, figures, variables and command window
 clear all; close all; clear var; clc
 

% plot fontsize
pfzise = 6;


%% Obtaining Christensen and Aubert (2006) data
    
% Obtaining p for CA06
[Pa2,fileout2] = ca06p('ca06-all.txt','ca06-p.txt');
    
% Loading the C06 data
data12 = load(fileout2);

E2 = data12(:,1);
Rastar2 = data12(:,2);
Pr2 = data12(:,3);
Pm2 = data12(:,4);
Nu2 = data12(:,12);
Lo2 = data12(:,13);
fdip2 = data12(:,14);
fohm2 = data12(:,16);
bdip2 = data12(:,15);
q2 = Pm2./Pr2;
p2 = data12(:,17);

%% Relationships
length_scale = 1;
Vs = 14.59;

% Aubert
lehn2 = Lo2;
p2 = Pa2;


%% Inside the core
disp(' ')
disp('++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++')
disp('CA06 Inside the core')

x = Pa2;
y = lehn2./(sqrt(fohm2));

[plotdataD2,plotdataC2,plotdataE2] = dataplot_ca06('ca06-p.txt',fileout2);
    
% Best-fit
[a,b,plotbfit,y_hat] = slopeestimate(x,y);

% Best fitting through weighted linear regression
[a,siga,b,sigb] = lserror(log(x),log(y));

% 3sigma limits
[line1,line2] = sigmalines(x,y,y_hat,a,b);

title('Estimating the slope inside the core')

    
%% CMB 
disp(' ')
disp('--- CMB field at l=1,l=12 (estimating parameters) ---------------------------------------------------------')

figure        
disp(' ')
disp('***** l=1 *****')
[plotdataD2,plotdataC2,plotdataE2,a,siga,b,sigb,y_hat,plotbfit,line1,line2] = bdegree_ca06(1,Lo2,bdip2,Pa2,fohm2,fdip2,'ca06-p.txt',fileout2);
        
% Plot details
title('Estimating the slope (l=1) using method 1')
ax = gca;
ax.FontSize = pfzise;
xlabel('$\it{\bf{p}}$','Interpreter','Latex','FontSize', 15)
ylabel('$\it{\bf{B_{l=1}/(f_{ohm})^{1/2}}}$','Interpreter','Latex','FontSize', 15 )
%text(x(56),y(7),"exponent = "+(b))
%text(x(56),y(3),"pre-factor = "+(a))


disp(' ')
disp('***** l=12 *****')
[plotdataD2,plotdataC2,plotdataE2,a,siga,b,sigb,y_hat,plotbfit,line1,line2] = bdegree_ca06(10,Lo2,bdip2,Pa2,fohm2,fdip2,'ca06-p.txt',fileout2);
    
% Plot details
title('Estimating the slope (l=12) using method 1')
ax = gca;
ax.FontSize = pfzise;
xlabel('$\it{\bf{p}}$','Interpreter','Latex','FontSize', 15)
ylabel('$\it{\bf{B_{l=12}/(f_{ohm})^{1/2}}}$','Interpreter','Latex','FontSize', 15 )
%text(x(56),y(7),"exponent = "+(b))
%text(x(56),y(3),"pre-factor = "+(a))


    

