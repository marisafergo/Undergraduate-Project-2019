function [line1,line2] = sigmalines(x,y,y_hat,a,b)
% PLOTTING 3-SIGMA LIMITS
% As in Aubert et al. (2009)

%% Finding the errors ei 
ei = log(y_hat) - log(y);

%% Plotting 3sigma lines
yrow = ei';            % var deals with row vectors
vary = var(yrow);      % vertical variance
sigma = sqrt(vary);    % standard deviation

y1 = (a/exp(3*sigma))*(x.^b); % lower
y2 = (a*exp(3*sigma))*(x.^b); % upper

hold on 
line1 = loglog(x,y1,'k-','LineWidth',0.5);
hold on
line2 = loglog(x,y2,'k-','LineWidth',0.5);


%% Imposing the slope and determining the intercept
% lower 3sigma
k = mean(log(y1)-b*log(x));
a_low = exp(k);

% upper 3sigma
k = mean(log(y2)-b*log(x));
a_up = exp(k);

disp(['The lower 3sigma intercept is: ' num2str(a_low)])
disp(['The best-fit intercept is: ' num2str(a)])
disp(['The upper 3sigma intercept is: ' num2str(a_up)])



end

