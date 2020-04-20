function [p2,newfile] = ca06p(filein, fileout)
% This script computes p for CA06
% The output is written in a text file ca06p.txt


    % Loading filein
    data2 = load(filein);
    
    E2 = data2(:,1);
    Rastar2 = data2(:,2);
    Pr2 = data2(:,3);
    Nu2 = data2(:,12);
    
    % Conventional Rayleigh number as in CA06
    Ek2 = E2./Pr2; % eq. 8
    Ra2 = Rastar2./(Ek2.*E2); %eq. 15

    % Modified Nusselt number as in CA06
    Nustar2 = (Nu2 - 1).*Ek2;

    ro = 3480e3;
    ri = 1222e3;
    D = ro - ri;

    % CA06 yields fi and 1-fi to be replaced by 1 given their choice of fixed 
    % temperature boundary conditions (see A09 Fig1.)
    fig1 = 1;

    % finding gamma as in A09 eq. 18
    gamma1 = (3*(ro-ri)^2 ) / ((2*((ro^3) - (ri^3)))*ro);
    gamma2 = fig1 * (((3*((ro^5)-(ri^5))) / (5*((ro^3)-(ri^3)))) -(ri^2));
    gamma3 = fig1 * ((ro^2)- (3*((ro^5)-(ri^5))) / (5*((ro^3)-(ri^3))));

    gamma = (gamma1)*( (gamma2) + (gamma3)  );

    % finding RaQstar using eq.19 in CA06
    %RaQstar = Ra2.*(Nu2-1).*(Ek2.^2).*E2; % alternatively
    RaQstar = Rastar2.*Nustar2;

    % finding RaQ using eq.13 in A09
    RaQ = ((ro*ri)/D^2)*RaQstar;

    % finding the dimensionless convective power for CA06 using eq.17 in A09
    p2 = gamma*RaQ;
    
    
    % Writing p2 into fileout (contains filein data + p2 in final column)
    fidin = fopen(filein, 'r');
    fidout = fopen(fileout, 'w');
    line_ex = fgetl(fidin);
    i = 1;
    while line_ex > 0
        fprintf(fidout,['%s\t%f' newline], line_ex, p2(i));
        line_ex = fgetl(fidin);
        i = i + 1;
    end
    
    newfile = fileout;
    
    fclose(fidin);
    fclose(fidout);

end

