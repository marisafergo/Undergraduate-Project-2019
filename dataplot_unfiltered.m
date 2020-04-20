function [plotdataD1,plotdataD2,plotdataD31,plotdataD32,plotdataD33] = dataplot_unfiltered(A09all,CA06all,LEEDSall,Pc3)
% This function plots A09, CA06 and Leeds data (unfiltered)

%% For A09 data
A1 = load(A09all);

%% For CA06 data
A2 = load(CA06all);

%% For Leeds data
A3 = load(LEEDSall);


%% Setting the axes
% Where x = Pa and y = lehn/sqrt(fohm)

% A09
x1 = A1(:,13);
y1 = (A1(:,8))./sqrt(A1(:,14));


% CA06
x2 = A2(:,17);
y2 = (A2(:,13))./sqrt(A2(:,16));


% Leeds
% Leeds - x
    if Pc3 == Pc3(1)
         x3Pc = A3(:,7)/14.59;
         Ek3 = A3(:,1);
         Pm3 = A3(:,2);
         x3 = (8*((Ek3./Pm3).^3)) .* x3Pc;
    else
         q3 = A3(:,8);
         Ra3 = A3(:,4);
         Pm3 = A3(:,2);
         Ek3 = A3(:,1);
        x3 = ((q3.^2).*Ra3.*Pm3)./Ek3;  
    end
    
% Leeds - y for D
El3 = A3(:,5);
Ek3 = A3(:,1);
Pm3 = A3(:,2);
fohm3 = A3(:,6);
lehn3 = sqrt(2*El3.*Ek3./Pm3);    
y3 = lehn3./sqrt(fohm3);





%% A09 plot
plotdataD1 = loglog(x1, y1,'o', 'MarkerFaceColor',[0.60, 0.60, 0.60],'MarkerEdge',[0.25, 0.25, 0.25],'MarkerSize',8);

%% CA06 plot
hold on
plotdataD2 = loglog(x2, y2,'x','MarkerEdge',[255,99,71]/255,'MarkerSize',10);


%% Leeds E=1.2e-4 plot
hold on
L = A3(:,1) == 0.000120;
plotdataD31 = loglog(x3(L), y3(L),'s', 'MarkerFaceColor',[0.9290, 0.6940, 0.1250],'MarkerEdge',[0.25, 0.25, 0.25],'MarkerSize',8);

%% Leeds E=1e-3 plot
hold on
L = A3(:,1) == 0.001000;
plotdataD32 = loglog(x3(L), y3(L),'s', 'MarkerFaceColor',[0, 154/255, 255/255],'MarkerEdge',[0.25, 0.25, 0.25],'MarkerSize',8);

%% Leeds E=5e-4 plot
hold on
L = A3(:,1) == 0.000500;
plotdataD33 = loglog(x3(L), y3(L),'s', 'MarkerFaceColor',[50,205,50]/255,'MarkerEdge',[0.25, 0.25, 0.25],'MarkerSize',8);


end