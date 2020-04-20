
% This script combines A09 and CA06 data with Leeds's data

% Aubert et al.(2009) = A09
% Christensen and Auebert (2006) = CA06

% variables with 1, 2 and 3 represent A09, CA06 and Leeds correspondingly

% !!!! THIS SCRIPT USED ELSASSER AND Pc INSTEAD OF LEHNERT AND Pa !!!!

% --------------------------------
%  Marisabel Gonzalez - 2018/2019
% --------------------------------

% Clearing workspace, figures, variables and command window
 clear all; close all; clear var; clc
 

 % plot fontsize
   pfzise = 10;
 
 
% ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
% FILTERING METHOD 1: VISUAL INTERPRETATION

disp(' ')
disp('++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++')
disp('FILTERING METHOD 1: VISUAL INTERPRETATION')


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



    %% Obtaining Christensen and Aubert (2006) data
    
    % Obtaining p for CA06
    [p2,fileout2] = ca06p('ca06-all.txt','ca06-p.txt');
    
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


    
    %% Loading all Leeds data
    
    data13 = load('leeds-simulations-ideal.txt');
    [fileout3] = excludefdip('leeds-simulations-all.txt',0.35,9,'leeds-simulations-035.txt');

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

 
     %% Relationships
    length_scale = 1;
    Vs = 14.59;

    % Aubert
    lehn1 = Lo1;
    lehn2 = Lo2;
    Pa1 = p1;
    Pa2 = p2;

    % Lehnert and Elsasser
    %lehn3 = sqrt(2*El3.*E3./Pm3);
    El1 = (Pm1.*(lehn1).^2)./(2*E1);
    El2 = (Pm2.*(lehn2).^2)./(2*E2);


    
    
    %% -------------------------------------------------------------------------
    %     *** ESTIMATING THE SLOPE FOR THE MAC and ENERGY BALANCE ***
    %  -------------------------------------------------------------------------
    %% Inside the core (using Pc1)
    disp(' ')
    disp('--- Core field (estimating parameters) ---------------------------------------------------------')
    
    
            disp(' ')
            disp('***  Bw/Vs  ***')
            
            %Pa3 = (8*((E3./Pm3).^3)) .* Pc3(j);
            Pc1 = (1/8)*((Pm1./E1).^3).*p1;
            Pc2 = (1/8)*((Pm2./E2).^3).*p2;
            Pc3 = Bw3/Vs;
            
    
            % Setting the axes
            x1 = Pc1;
            x2 = Pc2;
            x3 = Pc3;
            y1 = El1./sqrt(fohm1);
            y2 = El2./sqrt(fohm2);
            y3 = El3./sqrt(fohm3);

            % Final axes
             x = [x1; x2; x3];
             y = [y1; y2; y3];

    
            % Plotting all data (CA06 + A09 + Leeds)
            %subplot(1,2,j);
            figure
            [plotdataD1,plotdataC1,plotdataE1,plotdataD2,plotdataC2,plotdataE2,plotdataD31,plotdataC31,plotdataE31,plotdataD32,plotdataC32,plotdataE32,plotdataD33,plotdataC33,plotdataE33] = dataplot_Elsasser('aubert2009-all.txt','ca06-p.txt','leeds-simulations-ideal.txt',fileout1,fileout2,fileout3,Pc3);

            % Plotting the Earth
            [plotearth, x_m] = earthplot();
        
            % Best-fit
            [a,b,plotbfit,y_hat] = slopeestimate(x,y);

            % Best fitting through weighted linear regression
            [a,siga,b,sigb] = lserror(log(x),log(y));

            % 3sigma limits
            [line1,line2] = sigmalines(x,y,y_hat,a,b);

            % Plot details
            title('Estimating the slope with Pc = Bw/Vs')
            ax = gca;
            ax.FontSize = pfzise;
            xlabel('$\it{\bf{p}}$','Interpreter','Latex','FontSize', 15)
            ylabel('$\it{\bf{\Lambda/(f_{ohm})^{1/2}}}$','Interpreter','Latex','FontSize', 15 )
            %text(x(56),y(7),"exponent = "+(b))
            %text(x(56),y(3),"pre-factor = "+(a))

            % Extrapolating for the Earth
            loglog([x;x_m], [a*(x.^b);a*(x_m^b)],'k--','LineWidth',1);
                   

            
    %% -------------------------------------------------------------------------
    %     *** ESTIMATING THE SLOPE FOR THE MAC and ENERGY BALANCE ***
    %  -------------------------------------------------------------------------
    %% Inside the core (using Pc2)
    disp(' ')
    disp('--- Core field (estimating parameters) ---------------------------------------------------------')
    
    
            disp(' ')
            disp('***  ((q^2)*Ra*Pm)/E  ***')
            
            %Pa3 = (8*((E3./Pm3).^3)) .* Pc3(j);
            Pc1 = (1/8)*((Pm1./E1).^3).*p1;
            Pc2 = (1/8)*((Pm2./E2).^3).*p2;
            Pc3 = ((q3.^2).*Ra3.*Pm3)./E3;
            
    
            % Setting the axes
            x1 = Pc1;
            x2 = Pc2;
            x3 = Pc3;
            y1 = El1./sqrt(fohm1);
            y2 = El2./sqrt(fohm2);
            y3 = El3./sqrt(fohm3);

            % Final axes
             x = [x1; x2; x3];
             y = [y1; y2; y3];

    
            % Plotting all data (CA06 + A09 + Leeds)
            %subplot(1,2,j);
            figure
            [plotdataD1,plotdataC1,plotdataE1,plotdataD2,plotdataC2,plotdataE2,plotdataD31,plotdataC31,plotdataE31,plotdataD32,plotdataC32,plotdataE32,plotdataD33,plotdataC33,plotdataE33] = dataplot_Elsasser('aubert2009-all.txt','ca06-p.txt','leeds-simulations-ideal.txt',fileout1,fileout2,fileout3,Pc3);

            % Plotting the Earth
            [plotearth, x_m] = earthplot();
        
            % Best-fit
            [a,b,plotbfit,y_hat] = slopeestimate(x,y);

            % Best fitting through weighted linear regression
            [a,siga,b,sigb] = lserror(log(x),log(y));

            % 3sigma limits
            [line1,line2] = sigmalines(x,y,y_hat,a,b);

            % Plot details
            title('Estimating the slope with Pc = ((q^2)*Ra*Pm)/E3')
            ax = gca;
            ax.FontSize = pfzise;
            xlabel('$\it{\bf{p}}$','Interpreter','Latex','FontSize', 15)
            ylabel('$\it{\bf{\Lambda/(f_{ohm})^{1/2}}}$','Interpreter','Latex','FontSize', 15 )
            %text(x(56),y(7),"exponent = "+(b))
            %text(x(56),y(3),"pre-factor = "+(a))

            % Extrapolating for the Earth
            loglog([x;x_m], [a*(x.^b);a*(x_m^b)],'k--','LineWidth',1);
