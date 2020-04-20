function [plotdataD11,plotdataC11,plotdataE11,plotdataD12,plotdataC12,plotdataE12,plotdataD13,plotdataC13,plotdataE13,a,siga,b,sigb,y_hat,plotbfit,line1,line2] = bdegree_a09(l,Lo1,bdip1,Pa1,fohm1,fdip1,A09all,fdip1file)
% This function estimates the exponent and the pre-factor for the scalings
% at degree 12
% 
% Data used: A09


if l == 1
    
    % A09 (getting Bdip where l=1)
    Bdip1 = Lo1./bdip1;


    % Setting the axes
    x1 = Pa1;
    y1 = Bdip1./sqrt(fohm1);
    
    x = [x1];
    y = [y1];
    
    % Plotting all data
    figure
    subplot(1,2,1)
    [plotdataD11,plotdataC11,plotdataE11,plotdataD12,plotdataC12,plotdataE12,plotdataD13,plotdataC13,plotdataE13] = dataplot_bdegree_a09(l,A09all,fdip1file);
    
    % Best-fit
    [a,b,plotbfit,y_hat] = slopeestimate(x,y);

    % Best fitting through weighted linear regression
    [a,siga,b,sigb] = lserror(log(x),log(y));

    % 3sigma limits
    [line1,line2] = sigmalines(x,y,y_hat,a,b);

    
    
else % l=12 for A09
    
    % A09 DATA (getting Bdip where l=1)
    Bdip1 = Lo1./bdip1;
    Bcmb1 = Bdip1./fdip1;

    % Setting the axes
    x1 = Pa1;
    y1 = Bcmb1./sqrt(fohm1);
    
    x = [x1];
    y = [y1];
    
    % Plotting all data
    %figure
    subplot(1,2,2)
    [plotdataD11,plotdataC11,plotdataE11,plotdataD12,plotdataC12,plotdataE12,plotdataD13,plotdataC13,plotdataE13] = dataplot_bdegree_a09(l,A09all,fdip1file);
    
    % Best-fit
    [a,b,plotbfit,y_hat] = slopeestimate(x,y);

    % Best fitting through weighted linear regression
    [a,siga,b,sigb] = lserror(log(x),log(y));

    % 3sigma limits
    [line1,line2] = sigmalines(x,y,y_hat,a,b);
    
end



end

