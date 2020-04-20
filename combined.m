
% This script combines A09 and CA06 data with Leeds's data and determines
% the exponent and pre-factor of the data set

% Aubert et al.(2009) = A09
% Christensen and Auebert (2006) = CA06

% variables with 1, 2 and 3 represent A09, CA06 and Leeds correspondingly

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

% This nested loop filters all the combined data from A09, CA06 and Leeds.
% Leeds data is filtering from visual interpretation. For each iteration Pa 
% is computed when Pc = Bw/Vs and Pc = ((q^2)*Ra*Pm)/E

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
            x = [x1; x2; x3]; xtest = x;
            y = [y1; y2; y3];
    
            % Plotting all data (CA06 + A09 + Leeds)
            %subplot(1,2,j);
            figure
            [plotdataD1,plotdataC1,plotdataE1,plotdataD2,plotdataC2,plotdataE2,plotdataD31,plotdataC31,plotdataE31,plotdataD32,plotdataC32,plotdataE32,plotdataD33,plotdataC33,plotdataE33] = dataplot('aubert2009-all.txt','ca06-p.txt','leeds-simulations-ideal.txt',fileout1,fileout2,fileout3,Pc3(j));

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
            
            %% F-test between MAC and Energy Balance
            x = xtest;
            [H_F_m,H_F_e,H_F_both] = ftestme(x,b,1/4,1/3);   
                   

        end


%% CMB 
    disp(' ')
    disp('--- CMB field at l=1,l=10,l=12 (estimating parameters) ---------------------------------------------------------')
    
    % Pc3 and Pc3s are arrays required for the k loop
    Pc3 = [Bw3/Vs;((q3.^2).*Ra3.*Pm3)./E3];
    Pc3s = ["Bw/Vs","((q^2)*Ra*Pm)/E"];

    
    for k = 1:2
    
        disp(' ')
        disp(['===============' Pc3s(k) '==============='])
        
        disp(' ')
        disp('***** l=1 *****')
        [plotdataD1,plotdataC1,plotdataE1,plotdataD2,plotdataC2,plotdataE2,plotdataD31,plotdataC31,plotdataE31,plotdataD32,plotdataC32,plotdataE32,plotdataD33,plotdataC33,plotdataE33,a,siga,b,sigb,y_hat,plotbfit,line1,line2] = bdegree(1,Lo1,Lo2,bdip1,bdip2,Bl1,Pm3,E3,Pa1,Pa2,fohm1,fohm2,fohm3,fdip1,fdip2,fdip3,'aubert2009-all.txt','ca06-p.txt','leeds-simulations-ideal.txt',fileout1,fileout2,fileout3,Pc3(k));
    
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
        [plotdataD1,plotdataC1,plotdataE1,plotdataD2,plotdataC2,plotdataE2,plotdataD31,plotdataC31,plotdataE31,plotdataD32,plotdataC32,plotdataE32,plotdataD33,plotdataC33,plotdataE33,a,siga,b,sigb,y_hat,plotbfit,line1,line2] = bdegree(10,Lo1,Lo2,bdip1,bdip2,Bl1,Pm3,E3,Pa1,Pa2,fohm1,fohm2,fohm3,fdip1,fdip2,fdip3,'aubert2009-all.txt','ca06-p.txt','leeds-simulations-ideal.txt',fileout1,fileout2,fileout3,Pc3(k));
    
        % Plot details
        title(['Estimating the slope (l=10, l=12) using method 1 and ' Pc3s(k)])
        ax = gca;
        ax.FontSize = pfzise;
        xlabel('$\it{\bf{p}}$','Interpreter','Latex','FontSize', 15)
        ylabel('$\it{\bf{B_{l=10,l=12}/(f_{ohm})^{1/2}}}$','Interpreter','Latex','FontSize', 15 )
        %text(x(56),y(7),"exponent = "+(b))
        %text(x(56),y(3),"pre-factor = "+(a))
   

        
    end
     
    
    
    
       
% ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
% FILTERING METHOD 2: FDIP FILTERING

disp(' ')
disp('++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++')
disp('FILTERING METHOD 2: FDIP FILTERING')



% This nested loop filters all the combined data from A09, CA06 and Leeds
% for fdips of 0.25, 0.35 and 0.45. For each iteration Pa is computed when
% Pc = Bw/Vs and Pc = ((q^2)*Ra*Pm)/E

for i = 1:3

    filtering = ["fdip = 0.25"; "fdip = 0.35"; "fdip = 0.45"];
    disp(' ')
    disp(' ')
    disp(['***************************************** ' filtering(i) ' *****************************************'])
    
    % Arrays required for the main loop of iterations i 
    fdip = [0.25; 0.35; 0.45];
    fileoutname1 = ["aubert2009-025.txt";"aubert2009-035.txt";"aubert2009-045.txt"];
    fileoutname2 = ["ca06p-025.txt";"ca06p-035.txt";"ca06p-045.txt"];
    fileoutname3 = ["leeds-simulations-025.txt";"leeds-simulations-035.txt";"leeds-simulations-045.txt"];
    fdips = ["0.25";"0.35";"0.45"];
    
    
    
    %% Filtering and loading A09 data    
    % Filtering fdip > l 
    [fileout1] = excludefdip('aubert2009-all.txt',fdip(i),10,fileoutname1(i));

    % Loading the A09 data
    data21 = load(fileout1);

    E1 = data21(:,1);
    Pr1 = data21(:,3);
    Pm1 = data21(:,4);
    Lo1 = data21(:,8);
    bdip1 = data21(:,9);
    fdip1 = data21(:,10);
    p1 = data21(:,13);
    fohm1 = data21(:,14);
    q1 = Pm1./Pr1;



    %% Obtaining Christensen and Aubert (2006) data
    % Obtaining p for CA06
    [p2,newfile] = ca06p('ca06-all.txt','ca06-p.txt');
    
    % Filtering fdip > l 
    [fileout2] = excludefdip(newfile,fdip(i),14,fileoutname2(i));
    
    % Loading the C06 data
    data22 = load(fileout2);

    E2 = data22(:,1);
    Rastar2 = data22(:,2);
    Pr2 = data22(:,3);
    Pm2 = data22(:,4);
    Nu2 = data22(:,12);
    Lo2 = data22(:,13);
    fdip2 = data22(:,14);
    fohm2 = data22(:,16);
    bdip2 = data22(:,15);
    q2 = Pm2./Pr2;


    
    %% Loading all Leeds data and excluding data with fdip > l
    [fileout3] = excludefdip('leeds-simulations-all.txt',fdip(i),9,fileoutname3(i));

    data23 = load(fileout3);

    E3 = data23(:,1);
    Pm3 = data23(:,2);
    Pr3 = data23(:,3);
    Ra3 = data23(:,4);
    El3 = data23(:,5);
    fohm3 = data23(:,6);
    Bw3 = data23(:,7);
    q3 = data23(:,8);
    fdip3 = data23(:,9);
    Bl1 = data23(:,12);
    Bl10 = data23(:,13);
    Bl32 = data23(:,14);



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
    
        figure
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
            x = [x1; x2; x3]; xtest = x;
            y = [y1; y2; y3];
    
            % Plotting all data (CA06 + A09 + Leeds)
            subplot(1,2,j);
            [plotdataD1,plotdataC1,plotdataE1,plotdataD2,plotdataC2,plotdataE2,plotdataD31,plotdataC31,plotdataE31,plotdataD32,plotdataC32,plotdataE32,plotdataD33,plotdataC33,plotdataE33] = dataplot('aubert2009-all.txt','ca06-p.txt','leeds-simulations-ideal.txt',fileout1,fileout2,fileout3,Pc3(j));

            % Plotting the Earth
            [plotearth, x_m] = earthplot();
        
            % Best-fit
            [a,b,plotbfit,y_hat] = slopeestimate(x,y);

            % Best fitting through weighted linear regression
            [a,siga,b,sigb] = lserror(log(x),log(y));

            % 3sigma limits
            [line1,line2] = sigmalines(x,y,y_hat,a,b);

            % Plot details
            title({'Estimating the slope with Pc = ' num2str(Pc3s(j)) ' and Pa = (8*((E/Pm)^3))*Pc; with fdip > ' num2str(fdips(i))})
            ax = gca;
            ax.FontSize = pfzise;
            xlabel('$\it{\bf{p}}$','Interpreter','Latex','FontSize', 15)
            ylabel('$\it{\bf{\lambda/(f_{ohm})^{1/2}}}$','Interpreter','Latex','FontSize', 15 )
            %text(x(56),y(7),"exponent = "+(b))
            %text(x(56),y(3),"pre-factor = "+(a))

            % Extrapolating for the Earth
            loglog([x;x_m], [a*(x.^b);a*(x_m^b)],'k--','LineWidth',1);
         
            %% F-test between MAC and Energy Balance
            x = xtest;
            [H_F_m,H_F_e,H_F_both] = ftestme(x,b,1/4,1/3);  
            
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
        [plotdataD1,plotdataC1,plotdataE1,plotdataD2,plotdataC2,plotdataE2,plotdataD31,plotdataC31,plotdataE31,plotdataD32,plotdataC32,plotdataE32,plotdataD33,plotdataC33,plotdataE33,a,siga,b,sigb,y_hat,plotbfit,line1,line2] = bdegree(1,Lo1,Lo2,bdip1,bdip2,Bl1,Pm3,E3,Pa1,Pa2,fohm1,fohm2,fohm3,fdip1,fdip2,fdip3,'aubert2009-all.txt','ca06-p.txt','leeds-simulations-ideal.txt',fileout1,fileout2,fileout3,Pc3(k));
    
        % Plot details
        title(['Estimating the slope (l=1) with fdip > ' num2str(fdips(i)) ' and ' Pc3s(k)])
        ax = gca;
        ax.FontSize = pfzise;
        xlabel('$\it{\bf{p}}$','Interpreter','Latex','FontSize', 15)
        ylabel('$\it{\bf{B_{l=1}/(f_{ohm})^{1/2}}}$','Interpreter','Latex','FontSize', 15 )
        %text(x(56),y(7),"exponent = "+(b))
        %text(x(56),y(3),"pre-factor = "+(a))


        disp(' ')
        disp('***** l=10, l=12 *****')
        [plotdataD1,plotdataC1,plotdataE1,plotdataD2,plotdataC2,plotdataE2,plotdataD31,plotdataC31,plotdataE31,plotdataD32,plotdataC32,plotdataE32,plotdataD33,plotdataC33,plotdataE33,a,siga,b,sigb,y_hat,plotbfit,line1,line2] = bdegree(10,Lo1,Lo2,bdip1,bdip2,Bl1,Pm3,E3,Pa1,Pa2,fohm1,fohm2,fohm3,fdip1,fdip2,fdip3,'aubert2009-all.txt','ca06-p.txt','leeds-simulations-ideal.txt',fileout1,fileout2,fileout3,Pc3(k));
    
        % Plot details
        title(['Estimating the slope (l=10, l=12) with fdip > ' num2str(fdips(i)) ' and ' Pc3s(k)])
        ax = gca;
        ax.FontSize = pfzise;
        xlabel('$\it{\bf{p}}$','Interpreter','Latex','FontSize', 15)
        ylabel('$\it{\bf{B_{l=10,l=12}/(f_{ohm})^{1/2}}}$','Interpreter','Latex','FontSize', 15 )
        %text(x(56),y(7),"exponent = "+(b))
        %text(x(56),y(3),"pre-factor = "+(a))

        
    end

        
end

% --------------------------------
%  END
% --------------------------------
