function [a,b,plotbfit,y_hat] = slopeestimate(x,y)

% THIS MATLAB FUNCTION ESTIMATES THE BEST-FIT LINE
% AND PLOTS IT

% --------------------------
%  RELEVANT NOMENCLATURE
% --------------------------
% m: slope
% k: y-intercept
% y_hat: y-estimate


%% Computing y estimate 
d = log(y);
G = [log(x),ones(length(d),1)];

mhat = inv(G'*G) * G'*d;

b = mhat(1);          % slope
a = exp(mhat(2));     % intercept
y_hat = a*(x.^b);     % y-estimate/slope

%% Plotting best-fit
hold on
b_fit = y_hat;
plotbfit = loglog(x,b_fit,'k-','LineWidth',1);

disp(' ')
disp(['The slope is: ' num2str(b)])
disp(['The intercept is: ' num2str(a)])

end

