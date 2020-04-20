function [a,siga,b,sigb] = lserror(x,y)
% Least squares linear fitting y = a + bx
% errors are treated equally
 
    N = length(y);

    smx2 = sum(x.^2);   %sum of x^2
    smy = sum(y); %sum of y
    smx = sum(x); %sum of x
    smxy = sum(x.*y); %sum of x times y
    delta = (N.*(smx2)) - (smx.*smx); %calculating delta

    a = ((smx2.*smy) - (smx.*smxy))./delta;
    b = ((N.*(smxy)) - (smx.*smy))./delta;

    a = exp(a);

    siga = (sqrt(smx2./delta));
    sigb = (sqrt(N/delta));
    
    %disp(' ')
    %disp(['The intercept is: ' num2str(a)]) % same result as
    %slopeestimate.m
    %disp(['The slope is: ' num2str(b)]) % same result as slopeestimate.m
    
    disp(' ')
    disp(['The slope error is: ' num2str(sigb)])
    disp(['The intercept error is: ' num2str(siga)])
    disp(' ')

    
end

