function [plotdataD11,plotdataC11,plotdataE11,plotdataD12,plotdataC12,plotdataE12,plotdataD13,plotdataC13,plotdataE13,plotdataD31,plotdataC31,plotdataE31,plotdataD32,plotdataC32,plotdataE32,plotdataD33,plotdataC33,plotdataE33,a,siga,b,sigb,y_hat,plotbfit,line1,line2] = bdegree_a09_leeds(l,Lo1,bdip1,Bl1,Pm3,E3,Pa1,fohm1,fohm3,fdip1,fdip3,A09all,LEEDSideal,fdip1file,fdip3file,Pc3)
% This function estimates the exponent and the pre-factor for the scalings
% at degree 1 (dipolar field) or 10/12 and plots the results
% Degree 10 is used as a proxy for A09 that uses degree 12
% 
% Data used: A09 + Leeds


if l == 1
    
    % A09 (getting Bdip where l=1)
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
    %[plotdata1,plotdata2,plotdata31,plotdata32,plotdata33] = dataplotekman(x1,y1,x2,y2,x31,y31,x32,y32,x33,y33);
    [plotdataD11,plotdataC11,plotdataE11,plotdataD12,plotdataC12,plotdataE12,plotdataD13,plotdataC13,plotdataE13,plotdataD31,plotdataC31,plotdataE31,plotdataD32,plotdataC32,plotdataE32,plotdataD33,plotdataC33,plotdataE33] = dataplot_bdegree_a09_leeds(l,A09all,LEEDSideal,fdip1file,fdip3file,Pc3);
    
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
    [plotdataD11,plotdataC11,plotdataE11,plotdataD12,plotdataC12,plotdataE12,plotdataD13,plotdataC13,plotdataE13,plotdataD31,plotdataC31,plotdataE31,plotdataD32,plotdataC32,plotdataE32,plotdataD33,plotdataC33,plotdataE33] = dataplot_bdegree_a09_leeds(l,A09all,LEEDSideal,fdip1file,fdip3file,Pc3);
    
    % Best-fit
    [a,b,plotbfit,y_hat] = slopeestimate(x,y);

    % Best fitting through weighted linear regression
    [a,siga,b,sigb] = lserror(log(x),log(y));

    % 3sigma limits
    [line1,line2] = sigmalines(x,y,y_hat,a,b);
    
end



end

