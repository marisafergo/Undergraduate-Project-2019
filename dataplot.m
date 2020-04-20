function [plotdataD1,plotdataC1,plotdataE1,plotdataD2,plotdataC2,plotdataE2,plotdataD31,plotdataC31,plotdataE31,plotdataD32,plotdataC32,plotdataE32,plotdataD33,plotdataC33,plotdataE33] = dataplot(A09all,CA06all,LEEDSideal,fdip1file,fdip2file,fdip3file,Pc3)
% This function plots A09, CA06 and Leeds data

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

% A09
x1D = D1(:,13);
y1D = (D1(:,8))./sqrt(D1(:,14));
x1C = C1(:,13);
y1C = (C1(:,8))./sqrt(C1(:,14));
x1E = E1(:,13);
y1E = (E1(:,8))./sqrt(E1(:,14));


% CA06
x2D = D2(:,17);
y2D = (D2(:,13))./sqrt(D2(:,16));
x2C = C2(:,17);
y2C = (C2(:,13))./sqrt(C2(:,16));
x2E = E2(:,17);
y2E = (E2(:,13))./sqrt(E2(:,16));


% Leeds
% Leeds - x for D
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
    
% Leeds - x for C
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
    

% Leeds - x for E
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

% Leeds - y for D
El3 = D3(:,5);
Ek3 = D3(:,1);
Pm3 = D3(:,2);
fohm3 = D3(:,6);
lehn3 = sqrt(2*El3.*Ek3./Pm3);    
y3D = lehn3./sqrt(fohm3);

% Leeds - y for C
El3 = C3(:,5);
Ek3 = C3(:,1);
Pm3 = C3(:,2);
fohm3 = C3(:,6);
lehn3 = sqrt(2*El3.*Ek3./Pm3);    
y3C = lehn3./sqrt(fohm3);

% Leeds - y for E
El3 = E3(:,5);
Ek3 = E3(:,1);
Pm3 = E3(:,2);
fohm3 = E3(:,6);
lehn3 = sqrt(2*El3.*Ek3./Pm3);    
y3E = lehn3./sqrt(fohm3);




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