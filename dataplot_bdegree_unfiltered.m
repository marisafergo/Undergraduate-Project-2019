function [plotdataD11,plotdataD12,plotdataD13,plotdataD31,plotdataD32,plotdataD33] = dataplot_bdegree_unfiltered(l,A09all,LEEDSall,Pc3)
% This function plots A09 and Leeds data (unfiltered) at degrees 1 and 10/12

%% For A09 data
A1 = load(A09all);

%% For Leeds data
A3 = load(LEEDSall);


%% Setting the axes for A09

% ***** A09 - x and y for D *****
if l == 1
   Lo1 =  A1(:,8);
   bdip1 = A1(:,9);
   fohm1 = A1(:,14);
   
   Bdip1 = Lo1./bdip1;
   
   x1D = A1(:,13);
   y1D = Bdip1./sqrt(fohm1);
    
else  % l=10 in this study 
   Lo1 =  A1(:,8);
   bdip1 = A1(:,9);
   fohm1 = A1(:,14);
   fdip1 = A1(:,10);
   
   Bdip1 = Lo1./bdip1;
   Bcmb1 = Bdip1./fdip1;
   
   x1D = A1(:,13);
   y1D = Bcmb1./sqrt(fohm1);
    
end



%% Setting the axes for Leeds

% ***** Leeds - x for D *****
    if Pc3 == Pc3(1)
         x3Pc = A3(:,7)/14.59;
         Ek3 = A3(:,1);
         Pm3 = A3(:,2);
         x3D = (8*((Ek3./Pm3).^3)) .* x3Pc;
    else
         q3 = A3(:,8);
         Ra3 = A3(:,4);
         Pm3 = A3(:,2);
         Ek3 = A3(:,1);
        x3D = ((q3.^2).*Ra3.*Pm3)./Ek3;  
    end


% ***** Leeds - y for D *****
if l == 1
   
   Bl1 = A3(:,12);
   Bdip3 = Bl1;
   fohm3 = A3(:,6);
   
   y3D = Bdip3./sqrt(fohm3); 

    
else  % l=10 in this study 
   Bl1 = A3(:,12);
   Bdip3 = Bl1;
   fdip3 = A3(:,9);
   fohm3 = A3(:,6);

   Bcmb3 = Bdip3./fdip3;
   
   y3D = Bcmb3./sqrt(fohm3);
    
end


%% A09 plot
%% A09 plot E=3.0e-5
L = A1(:,1) == 0.00003;
plotdataD11 = loglog(x1D(L), y1D(L),'o', 'MarkerFaceColor',[0.60, 0.60, 0.60],'MarkerEdge',[0.25, 0.25, 0.25],'MarkerSize',8);


%% A09 plot E=1.0e-4
hold on
L = A1(:,1) == 0.0001;
plotdataD12 = loglog(x1D(L), y1D(L),'o', 'MarkerFaceColor',[0.60, 0.60, 0.60],'MarkerEdge',[0.25, 0.25, 0.25],'MarkerSize',12);


%% A09 plot E=3.0e-4
hold on
L = A1(:,1) == 0.0003;
plotdataD13 = loglog(x1D(L), y1D(L),'o', 'MarkerFaceColor',[0.60, 0.60, 0.60],'MarkerEdge',[0.25, 0.25, 0.25],'MarkerSize',16);


%% Leeds E=1.2e-4 plot
hold on
L = A3(:,1) == 0.000120;
plotdataD31 = loglog(x3D(L), y3D(L),'s', 'MarkerFaceColor',[0.9290, 0.6940, 0.1250],'MarkerEdge',[0.25, 0.25, 0.25],'MarkerSize',8);


%% Leeds E=1e-3 plot
hold on
L = A3(:,1) == 0.001000;
plotdataD32 = loglog(x3D(L), y3D(L),'s', 'MarkerFaceColor',[0, 154/255, 255/255],'MarkerEdge',[0.25, 0.25, 0.25],'MarkerSize',8);


%% Leeds E=5e-4 plot
hold on
L = A3(:,1) == 0.000500;
plotdataD33 = loglog(x3D(L), y3D(L),'s', 'MarkerFaceColor',[50,205,50]/255,'MarkerEdge',[0.25, 0.25, 0.25],'MarkerSize',8);



end