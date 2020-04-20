
% This script combines A09 and CA06 data with Leeds's data

% Aubert et al.(2009) = A09
% Christensen and Auebert (2006) = CA06

% variables with 1, 2 and 3 represent A09, CA06 and Leeds correspondingly

% !!!! THE DATA IN THIS SCRIPT HASN'T BEEN FILTERED !!!!
% the filtering of fdip > 0.15 has only been performed to have the same
% number of s.f. for A09 and Leeds and avoid division by zero; no data
% has actually been filtered


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
disp('UNFILTERED DATA')


    %% Loading A09 data   
    
     % Filtering fdip > 0.15
    [fileout1] = excludefdip('aubert2009-all.txt',0.15,10,'aubert2009-015.txt');

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
    data12 = load('ca06-p.txt');

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
   
     % Filtering fdip > 0.15
    [fileout3] = excludefdip('leeds-simulations-all.txt',0.15,9,'leeds-simulations-015.txt');
    data13 = load(fileout3);


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
    lehn3 = sqrt(2*El3.*E3./Pm3);

    % Power relationship (where Pa = (8*((E/Pm)^3)) *Pc)
    % Pc3 and Pc3s are arrays required for the j loop
    Pc3 = [Bw3/Vs;((q3.^2).*Ra3.*Pm3)./E3];
    Pc3s = ["Bw/Vs","((q^2)*Ra*Pm)/E"];


    
    %% -------------------------------------------------------------------------
    %     *** ESTIMATING THE SLOPE FOR THE MAC and ENERGY BALANCE ***
    %  -------------------------------------------------------------------------
    %% Inside the core
    disp(' ')
    disp('--- Core field (estimating parameters) ---------------------------------------------------------')
    
        %figure
        for j = 1:2
    
            disp(' ')
            disp(['***' Pc3s(j) '***'])
            
            Pa3 = (8*((E3./Pm3).^3)) .* Pc3(j);
    
            % Setting the axes
            x1 = Pa1;
            x2 = Pa2;
            x3 = Pa3;
            y1 = lehn1./sqrt(fohm1);
            y2 = lehn2./sqrt(fohm2);
            y3 = lehn3./sqrt(fohm3);

            % Final axes
            x = [x1; x2; x3];
            y = [y1; y2; y3];
    
            % Plotting all data (CA06 + A09 + Leeds)
            %subplot(1,2,j);
            figure
            [plotdataD1,plotdataD2,plotdataD31,plotdataD32,plotdataD33] = dataplot_unfiltered(fileout1,'ca06-p.txt',fileout3,Pc3(j));

            % Plotting the Earth
            [plotearth, x_m] = earthplot();
        
            % Best-fit
            [a,b,plotbfit,y_hat] = slopeestimate(x,y);

            % Best fitting through weighted linear regression
            [a,siga,b,sigb] = lserror(log(x),log(y));

            % 3sigma limits
            [line1,line2] = sigmalines(x,y,y_hat,a,b);

            % Plot details
            title({'Estimating the slope with Pc = ' num2str(Pc3s(j)) ' and Pa = (8*((E/Pm)^3))*Pc; (filtering method 1)'})
            ax = gca;
            ax.FontSize = pfzise;
            xlabel('$\it{\bf{p}}$','Interpreter','Latex','FontSize', 15)
            ylabel('$\it{\bf{\lambda/(f_{ohm})^{1/2}}}$','Interpreter','Latex','FontSize', 15 )
            %text(x(56),y(7),"exponent = "+(b))
            %text(x(56),y(3),"pre-factor = "+(a))

            % Extrapolating for the Earth
            loglog([x;x_m], [a*(x.^b);a*(x_m^b)],'k--','LineWidth',1);
                   

        end
        
        
        
        
%% CMB 
    disp(' ')
    disp('--- CMB field at l=1,l=10,l=12 (estimating parameters) ---------------------------------------------------------')
    
    % Pc3 and Pc3s are arrays required for the third loop
    Pc3 = [Bw3/Vs;((q3.^2).*Ra3.*Pm3)./E3];
    Pc3s = ["Bw/Vs","((q^2)*Ra*Pm)/E"];

    
    for k = 1:2
    
        disp(' ')
        disp(['===============' Pc3s(k) '==============='])
        
        disp(' ')
        disp('***** l=1 *****')
        [plotdataD1,plotdataD31,plotdataD32,plotdataD33,a,siga,b,sigb,y_hat,plotbfit,line1,line2] = bdegree_unfiltered(1,Lo1,bdip1,Bl1,Pm3,E3,Pa1,fohm1,fohm3,fdip1,fdip3,fileout1,fileout3,Pc3(k));
    
        % Plot details
        title(['Estimating the slope (l=1) using method 1 and ' Pc3s(k)])
        ax = gca;
        ax.FontSize = pfzise;
        xlabel('$\it{\bf{p}}$','Interpreter','Latex','FontSize', 15)
        ylabel('$\it{\bf{B_{l=1}/(f_{ohm})^{1/2}}}$','Interpreter','Latex','FontSize', 15 )
        %text(x(56),y(7),"exponent = "+(b))
        %text(x(56),y(3),"pre-factor = "+(a))


        disp(' ')
        disp('***** l=10, l=12 *****')
        [plotdataD1,plotdataD31,plotdataD32,plotdataD33,a,siga,b,sigb,y_hat,plotbfit,line1,line2] = bdegree_unfiltered(10,Lo1,bdip1,Bl1,Pm3,E3,Pa1,fohm1,fohm3,fdip1,fdip3,fileout1,fileout3,Pc3(k));
    
        % Plot details
        title(['Estimating the slope (l=10, l=12) using method 1 and ' Pc3s(k)])
        ax = gca;
        ax.FontSize = pfzise;
        xlabel('$\it{\bf{p}}$','Interpreter','Latex','FontSize', 15)
        ylabel('$\it{\bf{B_{l=10,l=12}/(f_{ohm})^{1/2}}}$','Interpreter','Latex','FontSize', 15 )
        %text(x(56),y(7),"exponent = "+(b))
        %text(x(56),y(3),"pre-factor = "+(a))
    
     

        
    end