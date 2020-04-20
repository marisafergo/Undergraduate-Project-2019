function [plotdataD11,plotdataC11,plotdataE11,plotdataD12,plotdataC12,plotdataE12,plotdataD13,plotdataC13,plotdataE13] = dataplot_bdegree_a09(l,A09all,fdip1file)
% This function plots A09 data at degrees 1 and 10/12

%% For A09 data
A1 = load(A09all);
B1 = load(fdip1file); %here would go fileout1

C1 = setdiff(B1,A1,'rows','stable');      %Rows only in B
D1 = setdiff(B1,C1,'rows','stable');      %Rows in A and B
E1 = setdiff(A1,[C1;D1],'rows','stable'); %Rows only in A


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


end