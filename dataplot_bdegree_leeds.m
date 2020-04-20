function [plotdataD31,plotdataC31,plotdataE31,plotdataD32,plotdataC32,plotdataE32,plotdataD33,plotdataC33,plotdataE33] = dataplot_bdegree_leeds(LEEDSideal,fdip3file,Pc3)
% This function plots Leeds data at l=32


%% For Leeds data
A3 = load(LEEDSideal);
B3 = load(fdip3file); %here would go fileout3

C3 = setdiff(B3,A3,'rows','stable');      %Rows only in B
D3 = setdiff(B3,C3,'rows','stable');      %Rows in A and B
E3 = setdiff(A3,[C3;D3],'rows','stable'); %Rows only in A


%% Setting the axes for Leeds

% ***** Leeds - x for D *****
    if Pc3 == Pc3(1)
         x3Pc = D3(:,7)/14.59;
         Ek3 = D3(:,1);
         Pm3 = D3(:,2);
         x3D = (8*((Ek3./Pm3).^3)) .* x3Pc;
    else
         q3 = D3(:,8);
         Ra3 = D3(:,4);
         Pm3 = D3(:,2);
         Ek3 = D3(:,1);
        x3D = ((q3.^2).*Ra3.*Pm3)./Ek3;  
    end
    
% ***** Leeds - x for C *****
    if Pc3 == Pc3(1)
         x3Pc = C3(:,7)/14.59;
         Ek3 = C3(:,1);
         Pm3 = C3(:,2);
         x3C = (8*((Ek3./Pm3).^3)) .* x3Pc;
    else
         q3 = C3(:,8);
         Ra3 = C3(:,4);
         Pm3 = C3(:,2);
         Ek3 = C3(:,1);
        x3C = ((q3.^2).*Ra3.*Pm3)./Ek3;  
    end
    

% ***** Leeds - x for E *****
    if Pc3 == Pc3(1)
         x3Pc = E3(:,7)/14.59;
         Ek3 = E3(:,1);
         Pm3 = E3(:,2);
         x3E = (8*((Ek3./Pm3).^3)) .* x3Pc;
    else
         q3 = E3(:,8);
         Ra3 = E3(:,4);
         Pm3 = E3(:,2);
         Ek3 = E3(:,1);
        x3E = ((q3.^2).*Ra3.*Pm3)./Ek3;  
    end

% ***** Leeds - y for D *****
   Bl32 = D3(:,14);
   fohm3 = D3(:,6);
   
   y3D = Bl32./sqrt(fohm3); 




% ***** Leeds - y for C *****
   Bl32 = C3(:,14);
   fohm3 = C3(:,6);
   
   y3C = Bl32./sqrt(fohm3); 
   
   
   

% ***** Leeds - y for E *****
   Bl32 = E3(:,14);
   fohm3 = E3(:,6);
   
   y3E = Bl32./sqrt(fohm3); 


%% Leeds E=1.2e-4 plot

L = D3(:,1) == 0.000120;
plotdataD31 = loglog(x3D(L), y3D(L),'s', 'MarkerFaceColor',[0.9290, 0.6940, 0.1250],'MarkerEdge',[0.25, 0.25, 0.25],'MarkerSize',8);
hold on 
L = C3(:,1) == 0.000120;
plotdataC31 = loglog(x3C(L), y3C(L),'^', 'MarkerEdge',[230, 184, 0]/255,'MarkerSize',4);
hold on
L = E3(:,1) == 0.000120;
plotdataE31 = loglog(x3E(L), y3E(L),'v', 'MarkerEdge',[230, 184, 0]/255,'MarkerSize',4);



%% Leeds E=1e-3 plot
hold on
L = D3(:,1) == 0.001000;
plotdataD32 = loglog(x3D(L), y3D(L),'s', 'MarkerFaceColor',[0, 154/255, 255/255],'MarkerEdge',[0.25, 0.25, 0.25],'MarkerSize',8);
hold on 
L = C3(:,1) == 0.001000;
plotdataC32 = loglog(x3C(L), y3C(L),'^', 'MarkerEdge',[0, 154/255, 255/255],'MarkerSize',4);
hold on
L = E3(:,1) == 0.001000;
plotdataE32 = loglog(x3E(L), y3E(L),'v', 'MarkerEdge',[0, 154/255, 255/255],'MarkerSize',4);



%% Leeds E=5e-4 plot
hold on
L = D3(:,1) == 0.000500;
plotdataD33 = loglog(x3D(L), y3D(L),'s', 'MarkerFaceColor',[50,205,50]/255,'MarkerEdge',[0.25, 0.25, 0.25],'MarkerSize',8);
hold on 
L = C3(:,1) == 0.000500;
plotdataC33 = loglog(x3C(L), y3C(L),'^', 'MarkerEdge',[50,205,50]/255,'MarkerSize',4);
hold on
L = E3(:,1) == 0.000500;
plotdataE33 = loglog(x3E(L), y3E(L),'v', 'MarkerEdge',[50,205,50]/255,'MarkerSize',4);


end