function [plotdataD1,plotdataC1,plotdataE1,plotdataD2,plotdataC2,plotdataE2,plotdataD31,plotdataC31,plotdataE31,plotdataD32,plotdataC32,plotdataE32,plotdataD33,plotdataC33,plotdataE33] = dataplot_Elsasser(A09all,CA06all,LEEDSideal,fdip1file,fdip2file,fdip3file,Pc3)
% This function plots A09, CA06 and Leeds data (using Elsasser and Pc)

%% For A09 data
A1 = load(A09all);
B1 = load(fdip1file); %here would go fileout1

C1 = setdiff(B1,A1,'rows','stable');      %Rows only in B
D1 = setdiff(B1,C1,'rows','stable');      %Rows in A and B
E1 = setdiff(A1,[C1;D1],'rows','stable'); %Rows only in A



%% For CA06 data
A2 = load(CA06all);
B2 = load(fdip2file); %here would go fileout2

C2 = setdiff(B2,A2,'rows','stable');      %Rows only in B
D2 = setdiff(B2,C2,'rows','stable');      %Rows in A and B
E2 = setdiff(A2,[C2;D2],'rows','stable'); %Rows only in A



%% For Leeds data
A3 = load(LEEDSideal);
B3 = load(fdip3file); %here would go fileout3

C3 = setdiff(B3,A3,'rows','stable');      %Rows only in B
D3 = setdiff(B3,C3,'rows','stable');      %Rows in A and B
E3 = setdiff(A3,[C3;D3],'rows','stable'); %Rows only in A

%% Setting the axes
% Where x = Pa and y = lehn/sqrt(fohm)

% A09 - D
Ek1 = D1(:,1);
Pm1 = D1(:,4);
lehn1 = D1(:,8);
p1 = D1(:,13);
fohm1 = D1(:,14);

El1 = (Pm1.*(lehn1).^2)./(2*Ek1);
Pc1 = (1/8)*((Pm1./Ek1).^3).*p1;

x1D = Pc1;
y1D = El1./sqrt(fohm1);

% A09 - C
Ek1 = C1(:,1);
Pm1 = C1(:,4);
lehn1 = C1(:,8);
p1 = C1(:,13);
fohm1 = C1(:,14);

El1 = (Pm1.*(lehn1).^2)./(2*Ek1);
Pc1 = (1/8)*((Pm1./Ek1).^3).*p1;

x1C = Pc1;
y1C = El1./sqrt(fohm1);

% A09 - E
Ek1 = E1(:,1);
Pm1 = E1(:,4);
lehn1 = E1(:,8);
p1 = E1(:,13);
fohm1 = E1(:,14);

El1 = (Pm1.*(lehn1).^2)./(2*Ek1);
Pc1 = (1/8)*((Pm1./Ek1).^3).*p1;

x1E = Pc1;
y1E = El1./sqrt(fohm1);



% CA06 - D
Ek2 = D2(:,1);
Pm2 = D2(:,4);
lehn2 = D2(:,13);
fohm2 = D2(:,16);
p2 = D2(:,17);

El2 = (Pm2.*(lehn2).^2)./(2*Ek2);
Pc2 = (1/8)*((Pm2./Ek2).^3).*p2;

x2D = Pc2;
y2D = El2./sqrt(fohm2);

% CA06 - C
Ek2 = C2(:,1);
Pm2 = C2(:,4);
lehn2 = C2(:,13);
fohm2 = C2(:,16);
p2 = C2(:,17);

El2 = (Pm2.*(lehn2).^2)./(2*Ek2);
Pc2 = (1/8)*((Pm2./Ek2).^3).*p2;

x2C = Pc2;
y2C = El2./sqrt(fohm2);

% CA06 - E
Ek2 = E2(:,1);
Pm2 = E2(:,4);
lehn2 = E2(:,13);
fohm2 = E2(:,16);
p2 = E2(:,17);

El2 = (Pm2.*(lehn2).^2)./(2*Ek2);
Pc2 = (1/8)*((Pm2./Ek2).^3).*p2;

x2E = Pc2;
y2E = El2./sqrt(fohm2);


% Leeds
% Leeds - x for D
    if Pc3 == Pc3(1)
         x3D = D3(:,7)/14.59;

    else
         q3 = D3(:,8);
         Ra3 = D3(:,4);
         Pm3 = D3(:,2);
         Ek3 = D3(:,1);
        x3D = ((q3.^2).*Ra3.*Pm3)./Ek3;  
    end
    
% Leeds - x for C
    if Pc3 == Pc3(1)
         x3C = C3(:,7)/14.59;

    else
         q3 = C3(:,8);
         Ra3 = C3(:,4);
         Pm3 = C3(:,2);
         Ek3 = C3(:,1);
        x3C = ((q3.^2).*Ra3.*Pm3)./Ek3;  
    end
    

% Leeds - x for E
    if Pc3 == Pc3(1)
         x3E = E3(:,7)/14.59;

    else
         q3 = E3(:,8);
         Ra3 = E3(:,4);
         Pm3 = E3(:,2);
         Ek3 = E3(:,1);
        x3E = ((q3.^2).*Ra3.*Pm3)./Ek3;  
    end
    

% Leeds - y for D
El3 = D3(:,5);
fohm3 = D3(:,6);   
y3D = El3./sqrt(fohm3);

% Leeds - y for C
El3 = C3(:,5);
fohm3 = C3(:,6);   
y3C = El3./sqrt(fohm3);

% Leeds - y for E
El3 = E3(:,5);
fohm3 = E3(:,6);   
y3E = El3./sqrt(fohm3);




%% A09 plot
plotdataD1 = loglog(x1D, y1D,'o', 'MarkerFaceColor',[0.60, 0.60, 0.60],'MarkerEdge',[0.25, 0.25, 0.25],'MarkerSize',8);
hold on 
plotdataC1 = loglog(x1C, y1C,'^', 'MarkerEdge',[153, 153, 153]/255,'MarkerSize',4);
hold on
plotdataE1 = loglog(x1E, y1E,'v', 'MarkerEdge',[153, 153, 153]/255,'MarkerSize',4);



%% CA06 plot

hold on
plotdataD2 = loglog(x2D, y2D,'x','MarkerEdge',[255,99,71]/255,'MarkerSize',10);
hold on 
plotdataC2 = loglog(x2C, y2C,'^', 'MarkerEdge',[255, 198, 179]/255,'MarkerSize',4);
hold on
plotdataE2 = loglog(x2E, y2E,'v', 'MarkerEdge',[255, 198, 179]/255,'MarkerSize',4);



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