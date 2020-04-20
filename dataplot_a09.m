function [plotdataD11,plotdataC11,plotdataE11,plotdataD12,plotdataC12,plotdataE12,plotdataD13,plotdataC13] = dataplot_a09(A09all,fdip1file)
% This function plots A09 data

%% For A09 data
A1 = load(A09all);
B1 = load(fdip1file); %here would go fileout1

C1 = setdiff(B1,A1,'rows','stable');      %Rows only in B
D1 = setdiff(B1,C1,'rows','stable');      %Rows in A and B
E1 = setdiff(A1,[C1;D1],'rows','stable'); %Rows only in A



%% Setting the axes
% Where x = Pa and y = lehn/sqrt(fohm)

% A09
x1D = D1(:,13);
y1D = (D1(:,8))./sqrt(D1(:,14));
x1C = C1(:,13);
y1C = (C1(:,8))./sqrt(C1(:,14));
x1E = E1(:,13);
y1E = (E1(:,8))./sqrt(E1(:,14));


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