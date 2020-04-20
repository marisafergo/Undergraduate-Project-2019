function [plotdataD2,plotdataC2,plotdataE2,a,siga,b,sigb,y_hat,plotbfit,line1,line2] = bdegree_ca06(l,Lo2,bdip2,Pa2,fohm2,fdip2,CA06all,fdip2file)
% This function estimates the exponent and the pre-factor for the scalings
% at degree 12
% 
% Data used: CA06


if l == 1
    
    % CA06 DATA (getting Bdip where l=1)
    Bdip2 = Lo2./bdip2;


    % Setting the axes
    x2 = Pa2;
    y2 = Bdip2./sqrt(fohm2);  
    
    x = [x2];
    y = [y2];
    
    % Plotting all data
    %figure
    subplot(1,2,1)
    [plotdataD2,plotdataC2,plotdataE2] = dataplot_bdegree_ca06(l,CA06all,fdip2file);
    
    % Best-fit
    [a,b,plotbfit,y_hat] = slopeestimate(x,y);

    % Best fitting through weighted linear regression
    [a,siga,b,sigb] = lserror(log(x),log(y));

    % 3sigma limits
    [line1,line2] = sigmalines(x,y,y_hat,a,b);

    
    
else % l=12 for CA06
    
    % CA06 DATA (getting Bdip where l=1)
    Bdip2 = Lo2./bdip2;
    Bcmb2 = Bdip2./fdip2;

    % Setting the axes
    x2 = Pa2;
    y2 = Bcmb2./sqrt(fohm2);
    
    x = [x2];
    y = [y2];
    
    % Plotting all data
    %figure
    subplot(1,2,2)
    [plotdataD2,plotdataC2,plotdataE2] = dataplot_bdegree_ca06(l,CA06all,fdip2file);
    
    % Best-fit
    [a,b,plotbfit,y_hat] = slopeestimate(x,y);

    % Best fitting through weighted linear regression
    [a,siga,b,sigb] = lserror(log(x),log(y));

    % 3sigma limits
    [line1,line2] = sigmalines(x,y,y_hat,a,b);
    
end



end

