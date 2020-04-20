% A09 AND LEEDS ONLY

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


    
    %% Loading all Leeds data
    
    data13 = load('leeds-simulations-ideal.txt');
    
    
    data13_b = load('leeds-simulations-all.txt');
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
    Pa1 = p1;

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
            x3 = Pa3;
            y1 = lehn1./sqrt(fohm1);
            y3 = lehn3./sqrt(fohm3);

            % Final axes
            x = [x1; x3];
            y = [y1; y3];
    
            % Plotting data (A09 + Leeds)
            subplot(1,2,j);
            [plotdataD11,plotdataC11,plotdataE11,plotdataD12,plotdataC12,plotdataE12,plotdataD13,plotdataC13,plotdataE13,plotdataD31,plotdataC31,plotdataE31,plotdataD32,plotdataC32,plotdataE32,plotdataD33,plotdataC33,plotdataE33] = dataplot_a09_leeds('aubert2009-all.txt','leeds-simulations-ideal.txt',fileout1,fileout3,Pc3(j));     

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
    
    % Pc3 and Pc3s are arrays required for the k loop
    Pc3 = [Bw3/Vs;((q3.^2).*Ra3.*Pm3)./E3];
    Pc3s = ["Bw/Vs","((q^2)*Ra*Pm)/E"];

    
    for k = 1:2
    
        disp(' ')
        disp(['===============' Pc3s(k) '==============='])
        
        disp(' ')
        disp('***** l=1 *****')
        [plotdataD11,plotdataC11,plotdataE11,plotdataD12,plotdataC12,plotdataE12,plotdataD13,plotdataC13,plotdataE13,plotdataD31,plotdataC31,plotdataE31,plotdataD32,plotdataC32,plotdataE32,plotdataD33,plotdataC33,plotdataE33,a,siga,b,sigb,y_hat,plotbfit,line1,line2] = bdegree_a09_leeds(1,Lo1,bdip1,Bl1,Pm3,E3,Pa1,fohm1,fohm3,fdip1,fdip3,'aubert2009-all.txt','leeds-simulations-ideal.txt',fileout1,fileout3,Pc3(k));
    
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
        [plotdataD11,plotdataC11,plotdataE11,plotdataD12,plotdataC12,plotdataE12,plotdataD13,plotdataC13,plotdataE13,plotdataD31,plotdataC31,plotdataE31,plotdataD32,plotdataC32,plotdataE32,plotdataD33,plotdataC33,plotdataE33,a,siga,b,sigb,y_hat,plotbfit,line1,line2] = bdegree_a09_leeds(10,Lo1,bdip1,Bl1,Pm3,E3,Pa1,fohm1,fohm3,fdip1,fdip3,'aubert2009-all.txt','leeds-simulations-ideal.txt',fileout1,fileout3,Pc3(k));
    
        % Plot details
        title(['Estimating the slope (l=10, l=12) using method 1 and ' Pc3s(k)])
        ax = gca;
        ax.FontSize = pfzise;
        xlabel('$\it{\bf{p}}$','Interpreter','Latex','FontSize', 15)
        ylabel('$\it{\bf{B_{l=10,l=12}/(f_{ohm})^{1/2}}}$','Interpreter','Latex','FontSize', 15 )
        %text(x(56),y(7),"exponent = "+(b))
        %text(x(56),y(3),"pre-factor = "+(a))
    
     

        
    end
    
    
    
    %% 
    %% 
disp(' ')
disp('++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++')
disp('FILTERING METHOD 1: VISUAL INTERPRETATION')
disp('Leeds only for degrees l=32')
%% Inside the core

disp(' ')
disp('--- Core field (estimating parameters) ---------------------------------------------------------')

         figure
        for j = 1:2
    
            disp(' ')
            disp(['***' Pc3s(j) '***'])
            
            Pa3 = (8*((E3./Pm3).^3)) .* Pc3(j);
    
            % Setting the axes
            x3 = Pa3;
            y3 = lehn3./sqrt(fohm3);

            % Final axes
            x = [x3];
            y = [y3];
    
            % Plotting data (Leeds)
            subplot(1,2,j);
            [plotdataD31,plotdataC31,plotdataE31,plotdataD32,plotdataC32,plotdataE32,plotdataD33,plotdataC33,plotdataE33] = dataplot_leeds('leeds-simulations-ideal.txt',fileout3,Pc3(j));     

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
    disp('--- CMB field at l=32 (LEEDS ONLY) ---------------------------------------------------------')
    
    % Pc3 and Pc3s are arrays required for the k loop
    Pc3 = [Bw3/Vs;((q3.^2).*Ra3.*Pm3)./E3];
    Pc3s = ["Bw/Vs","((q^2)*Ra*Pm)/E"];

    figure
    
    for k = 1:2
    
        disp(' ')
        disp(['===============' Pc3s(k) '==============='])
        
        disp(' ')
        disp('***** l=32 *****')
        [plotdataD31,plotdataC31,plotdataE31,plotdataD32,plotdataC32,plotdataE32,plotdataD33,plotdataC33,plotdataE33,a,siga,b,sigb,y_hat,plotbfit,line1,line2] = bdegree_leeds(Bl32,Pm3,E3,fohm3,'leeds-simulations-ideal.txt',fileout3,Pc3(k),k);
        
        
        % Plot details
        title(['Estimating the slope (l=32) using method 1 and ' Pc3s(k)])
        ax = gca;
        ax.FontSize = pfzise;
        xlabel('$\it{\bf{p}}$','Interpreter','Latex','FontSize', 15)
        ylabel('$\it{\bf{B_{l=32}/(f_{ohm})^{1/2}}}$','Interpreter','Latex','FontSize', 15 )
        %text(x(56),y(7),"exponent = "+(b))
        %text(x(56),y(3),"pre-factor = "+(a))
     

        
    end   
    
    
    