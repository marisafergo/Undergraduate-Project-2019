function [plotdataD31,plotdataC31,plotdataE31,plotdataD32,plotdataC32,plotdataE32,plotdataD33,plotdataC33,plotdataE33,a,siga,b,sigb,y_hat,plotbfit,line1,line2] = bdegree_leeds(Bl32,Pm3,E3,fohm3,LEEDSideal,fdip3file,Pc3,k)
% This function estimates the exponent and the pre-factor for the scalings
% at degree 32
% 
% Data used: Leeds


    % Pa* and Pc*
    Pa3 = (8*((E3./Pm3).^3)) .* Pc3;

    % Setting the axes
    x3 = Pa3;
    y3 = Bl32./sqrt(fohm3);  
    
    x = [x3];
    y = [y3];
    
    % Plotting all data
    subplot(1,2,k)
    [plotdataD31,plotdataC31,plotdataE31,plotdataD32,plotdataC32,plotdataE32,plotdataD33,plotdataC33,plotdataE33] = dataplot_bdegree_leeds(LEEDSideal,fdip3file,Pc3);
    
    % Best-fit
    [a,b,plotbfit,y_hat] = slopeestimate(x,y);

    % Best fitting through weighted linear regression
    [a,siga,b,sigb] = lserror(log(x),log(y));

    % 3sigma limits
    [line1,line2] = sigmalines(x,y,y_hat,a,b);

    
    




end

