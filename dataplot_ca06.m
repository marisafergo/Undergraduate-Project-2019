function [plotdataD2,plotdataC2,plotdataE2] = dataplot_ca06(CA06all,fdip2file)
% This function plots CA06 data

%% For CA06 data
A2 = load(CA06all);
B2 = load(fdip2file); %here would go fileout2

C2 = setdiff(B2,A2,'rows','stable');      %Rows only in B
D2 = setdiff(B2,C2,'rows','stable');      %Rows in A and B
E2 = setdiff(A2,[C2;D2],'rows','stable'); %Rows only in A

% CA06
x2D = D2(:,17);
y2D = (D2(:,13))./sqrt(D2(:,16));
x2C = C2(:,17);
y2C = (C2(:,13))./sqrt(C2(:,16));
x2E = E2(:,17);
y2E = (E2(:,13))./sqrt(E2(:,16));

%% CA06 plot
plotdataD2 = loglog(x2D, y2D,'x','MarkerEdge',[255,99,71]/255,'MarkerSize',10);
hold on 
plotdataC2 = loglog(x2C, y2C,'^', 'MarkerEdge',[255, 198, 179]/255,'MarkerSize',4);
hold on
plotdataE2 = loglog(x2E, y2E,'v', 'MarkerEdge',[255, 198, 179]/255,'MarkerSize',4);

end