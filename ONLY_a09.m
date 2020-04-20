% A09 ONLY

% Clearing workspace, figures, variables and command window
 clear all; close all; clear var; clc
 

% plot fontsize
pfzise = 6;


disp(' ')
disp('++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++')
disp('FILTERING METHOD 1: VISUAL INTERPRETATION')
disp('A09 + Leeds for degrees l=1 and l=10/l=12')


    %% Filtering and loading A09 data   
    
    % Filtering fdip > 0.35 
    [fileout1] = excludefdip('aubert2009-all.txt',0.35,10,'aubert2009-035.txt');

    % Loading the A09 data
    data11 = load(fileout1);

    E1 = data11(:,1);
    Pr1 = data11(:,3);
    Pm1 = data11(:,4);
    Lo1 = data11(:,8);
    bdip1 = data11(:,9);
    fdip1 = data11(:,10);
    p1 = data11(:,13);
    fohm1 = data11(:,14);
    q1 = Pm1./Pr1;

%% Relationships
length_scale = 1;
Vs = 14.59;

% Aubert
lehn1 = Lo1;
Pa1 = p1;

%% Inside the core
disp(' ')
disp('++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++')
disp('A09 Inside the core')

x = Pa1;
y = lehn1./(sqrt(fohm1));

[plotdataD11,plotdataC11,plotdataE11,plotdataD12,plotdataC12,plotdataE12,plotdataD13,plotdataC13] = dataplot_a09('aubert2009-all.txt',fileout1);
    
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
       
disp(' ')
disp('***** l=1 *****')
[plotdataD11,plotdataC11,plotdataE11,plotdataD12,plotdataC12,plotdataE12,plotdataD13,plotdataC13,plotdataE13,a,siga,b,sigb,y_hat,plotbfit,line1,line2] = bdegree_a09(1,Lo1,bdip1,Pa1,fohm1,fdip1,'aubert2009-all.txt',fileout1);
        
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
[plotdataD11,plotdataC11,plotdataE11,plotdataD12,plotdataC12,plotdataE12,plotdataD13,plotdataC13,plotdataE13,a,siga,b,sigb,y_hat,plotbfit,line1,line2] = bdegree_a09(12,Lo1,bdip1,Pa1,fohm1,fdip1,'aubert2009-all.txt',fileout1);
    
% Plot details
title('Estimating the slope (l=12) using method 1')
ax = gca;
ax.FontSize = pfzise;
xlabel('$\it{\bf{p}}$','Interpreter','Latex','FontSize', 15)
ylabel('$\it{\bf{B_{l=12}/(f_{ohm})^{1/2}}}$','Interpreter','Latex','FontSize', 15 )
%text(x(56),y(7),"exponent = "+(b))
%text(x(56),y(3),"pre-factor = "+(a))


    




    



    
    