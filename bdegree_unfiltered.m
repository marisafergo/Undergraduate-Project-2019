function [plotdataD1,plotdataD31,plotdataD32,plotdataD33,a,siga,b,sigb,y_hat,plotbfit,line1,line2] = bdegree_unfiltered(l,Lo1,bdip1,Bl1,Pm3,E3,Pa1,fohm1,fohm3,fdip1,fdip3,A09all,LEEDSall,Pc3)
% This function estimates the exponent and the pre-factor for the scalings
% at degree 1 (dipolar field) or 10/12 and plots the results
% Degree 10 is used as a proxy for A09 that uses degree 12
% 
% Data used: A09 + CA06 + Leeds (unfiltered)


if l == 1
    
    % A09 AND CA06 DATA (getting Bdip where l=1)
    Bdip1 = Lo1./bdip1;

    % LEEDS DATA
    Bdip3 = Bl1; % using fdip files

    % Pa* and Pc*
    Pa3 = (8*((E3./Pm3).^3)) .* Pc3;

    % Setting the axes
    x1 = Pa1;
    x3 = Pa3;
    y1 = Bdip1./sqrt(fohm1);
    y3 = Bdip3./sqrt(fohm3);  
    
    x = [x1; x3];
    y = [y1; y3];
    
    % Plotting all data
    figure
    subplot(1,2,1)
    [plotdataD1,plotdataD31,plotdataD32,plotdataD33] = dataplot_bdegree_unfiltered(l,A09all,LEEDSall,Pc3);
    
    % Best-fit
    [a,b,plotbfit,y_hat] = slopeestimate(x,y);

    % Best fitting through weighted linear regression
    [a,siga,b,sigb] = lserror(log(x),log(y));

    % 3sigma limits
    [line1,line2] = sigmalines(x,y,y_hat,a,b);

    
    
else % l=10 in this study
    
    % A09 DATA (getting Bdip where l=1)
    Bdip1 = Lo1./bdip1;

    % LEEDS DATA
    Bdip3 = Bl1; % using fdip files
    
    Bcmb1 = Bdip1./fdip1;
    Bcmb3 = Bdip3./fdip3;

    % Pa* and Pc*
    Pa3 = (8*((E3./Pm3).^3)) .* Pc3;

    % Setting the axes
    x1 = Pa1;
    x3 = Pa3;

    y1 = Bcmb1./sqrt(fohm1);
    y3 = Bcmb3./sqrt(fohm3);
    
    x = [x1; x3];
    y = [y1; y3];
    
    % Plotting all data
    %figure
    subplot(1,2,2)
    [plotdataD1,plotdataD31,plotdataD32,plotdataD33] = dataplot_bdegree_unfiltered(l,A09all,LEEDSall,Pc3);
    
    % Best-fit
    [a,b,plotbfit,y_hat] = slopeestimate(x,y);

    % Best fitting through weighted linear regression
    [a,siga,b,sigb] = lserror(log(x),log(y));

    % 3sigma limits
    [line1,line2] = sigmalines(x,y,y_hat,a,b);
    
end



end

