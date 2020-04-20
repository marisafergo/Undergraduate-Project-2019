function [plotdataD11,plotdataC11,plotdataE11,plotdataD12,plotdataC12,plotdataE12,plotdataD13,plotdataC13,plotdataE13,plotdataD31,plotdataC31,plotdataE31,plotdataD32,plotdataC32,plotdataE32,plotdataD33,plotdataC33,plotdataE33] = dataplot_bdegree_a09_leeds(l,A09all,LEEDSideal,fdip1file,fdip3file,Pc3)
% This function plots A09 and Leeds data at degrees 1 and 10/12

%% For A09 data
A1 = load(A09all);
B1 = load(fdip1file); %here would go fileout1

C1 = setdiff(B1,A1,'rows','stable');      %Rows only in B
D1 = setdiff(B1,C1,'rows','stable');      %Rows in A and B
E1 = setdiff(A1,[C1;D1],'rows','stable'); %Rows only in A




%% For Leeds data
A3 = load(LEEDSideal);
B3 = load(fdip3file); %here would go fileout3

C3 = setdiff(B3,A3,'rows','stable');      %Rows only in B
D3 = setdiff(B3,C3,'rows','stable');      %Rows in A and B
E3 = setdiff(A3,[C3;D3],'rows','stable'); %Rows only in A

%% Setting the axes for A09

% ***** A09 - x and y for D *****
if l == 1
   Lo1 =  D1(:,8);
   bdip1 = D1(:,9);
   fohm1 = D1(:,14);
   
   Bdip1 = Lo1./bdip1;
   
   x1D = D1(:,13);
   y1D = Bdip1./sqrt(fohm1);
    
else  % l=12 (A09)
   Lo1 =  D1(:,8);
   bdip1 = D1(:,9);
   fohm1 = D1(:,14);
   fdip1 = D1(:,10);
   
   Bdip1 = Lo1./bdip1;
   Bcmb1 = Bdip1./fdip1;
   
   x1D = D1(:,13);
   y1D = Bcmb1./sqrt(fohm1);
    
end


% ***** A09 - x and y for C ****
if l == 1
   Lo1 =  C1(:,8);
   bdip1 = C1(:,9);
   fohm1 = C1(:,14);
   
   Bdip1 = Lo1./bdip1;
   
   x1C = C1(:,13);
   y1C = Bdip1./sqrt(fohm1);
    
else  % l=12 (A09) 
   Lo1 =  C1(:,8);
   bdip1 = C1(:,9);
   fohm1 = C1(:,14);
   fdip1 = C1(:,10);
   
   Bdip1 = Lo1./bdip1;
   Bcmb1 = Bdip1./fdip1;
   
   x1C = C1(:,13);
   y1C = Bcmb1./sqrt(fohm1);
    
end


% ***** A09 - x and y for E *****
if l == 1
   Lo1 =  E1(:,8);
   bdip1 = E1(:,9);
   fohm1 = E1(:,14);
   
   Bdip1 = Lo1./bdip1;
   
   x1E = E1(:,13);
   y1E = Bdip1./sqrt(fohm1);
    
else  % l=12 (A09) 
   Lo1 =  E1(:,8);
   bdip1 = E1(:,9);
   fohm1 = E1(:,14);
   fdip1 = E1(:,10);
   
   Bdip1 = Lo1./bdip1;
   Bcmb1 = Bdip1./fdip1;
   
   x1E = E1(:,13);
   y1E = Bcmb1./sqrt(fohm1);
    
end





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
if l == 1
   
   Bl1 = D3(:,12);
   Bdip3 = Bl1;
   fohm3 = D3(:,6);
   
   y3D = Bdip3./sqrt(fohm3); 

    
else  % l=10 in this study 
   Bl1 = D3(:,12);
   Bdip3 = Bl1;
   fdip3 = D3(:,9);
   fohm3 = D3(:,6);

   Bcmb3 = Bdip3./fdip3;
   
   y3D = Bcmb3./sqrt(fohm3);
    
end


% ***** Leeds - y for C *****
if l == 1
   
   Bl1 = C3(:,12);
   Bdip3 = Bl1;
   fohm3 = C3(:,6);
   
   y3C = Bdip3./sqrt(fohm3); 

    
else  % l=10 in this study 
   Bl1 = C3(:,12);
   Bdip3 = Bl1;
   fdip3 = C3(:,9);
   fohm3 = C3(:,6);

   Bcmb3 = Bdip3./fdip3;
   
   y3C = Bcmb3./sqrt(fohm3);
    
end

% ***** Leeds - y for E *****
if l == 1
   
   Bl1 = E3(:,12);
   Bdip3 = Bl1;
   fohm3 = E3(:,6);
   
   y3E = Bdip3./sqrt(fohm3); 

    
else  % l=10 in this study 
   Bl1 = E3(:,12);
   Bdip3 = Bl1;
   fdip3 = E3(:,9);
   fohm3 = E3(:,6);

   Bcmb3 = Bdip3./fdip3;
   
   y3E = Bcmb3./sqrt(fohm3);
    
end



%% A09 plot
%% A09 plot E=3.0e-5
L = D1(:,1) == 0.00003;
plotdataD11 = loglog(x1D(L), y1D(L),'o', 'MarkerFaceColor',[0.60, 0.60, 0.60],'MarkerEdge',[0.25, 0.25, 0.25],'MarkerSize',8);
hold on 
L = C1(:,1) == 0.00003;
plotdataC11 = loglog(x1C(L), y1C(L),'^', 'MarkerEdge',[153, 153, 153]/255,'MarkerSize',8);
hold on
L = E1(:,1) == 0.00003;
plotdataE11 = loglog(x1E(L), y1E(L),'v', 'MarkerEdge',[153, 153, 153]/255,'MarkerSize',8);

%% A09 plot E=1.0e-4
hold on
L = D1(:,1) == 0.0001;
plotdataD12 = loglog(x1D(L), y1D(L),'o', 'MarkerFaceColor',[0.60, 0.60, 0.60],'MarkerEdge',[0.25, 0.25, 0.25],'MarkerSize',12);
hold on 
L = C1(:,1) == 0.0001;
plotdataC12 = loglog(x1C(L), y1C(L),'^', 'MarkerEdge',[153, 153, 153]/255,'MarkerSize',12);
hold on
L = E1(:,1) == 0.0001;
plotdataE12 = loglog(x1E(L), y1E(L),'v', 'MarkerEdge',[153, 153, 153]/255,'MarkerSize',12);

%% A09 plot E=3.0e-4
hold on
L = D1(:,1) == 0.0003;
plotdataD13 = loglog(x1D(L), y1D(L),'o', 'MarkerFaceColor',[0.60, 0.60, 0.60],'MarkerEdge',[0.25, 0.25, 0.25],'MarkerSize',16);
hold on 
L = C1(:,1) == 0.0003;
plotdataC13 = loglog(x1C(L), y1C(L),'^', 'MarkerEdge',[153, 153, 153]/255,'MarkerSize',16);
hold on
L = E1(:,1) == 0.0003;
plotdataE13 = loglog(x1E(L), y1E(L),'v', 'MarkerEdge',[153, 153, 153]/255,'MarkerSize',16);




%% Leeds E=1.2e-4 plot

hold on
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