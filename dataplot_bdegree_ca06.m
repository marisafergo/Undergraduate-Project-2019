function [plotdataD2,plotdataC2,plotdataE2] = dataplot_bdegree_ca06(l,CA06all,fdip2file)
% This function plots CA06 data at degrees 1 and 10/12

%% For CA06 data
A2 = load(CA06all);
B2 = load(fdip2file); %here would go fileout2

C2 = setdiff(B2,A2,'rows','stable');      %Rows only in B
D2 = setdiff(B2,C2,'rows','stable');      %Rows in A and B
E2 = setdiff(A2,[C2;D2],'rows','stable'); %Rows only in A



%% Setting the axes for CA06

% ***** CA06 - x and y for D *****
if l == 1
   Lo2 =  D2(:,13);
   bdip2 = D2(:,15);
   fohm2 = D2(:,16);
   
   Bdip2 = Lo2./bdip2;
   
   x2D = D2(:,17);
   y2D = Bdip2./sqrt(fohm2);
    
else  % l=12 for CA06 
   Lo2 =  D2(:,13);
   bdip2 = D2(:,15);
   fohm2 = D2(:,16);
   fdip2 = D2(:,14);
   
   Bdip2 = Lo2./bdip2;
   Bcmb2 = Bdip2./fdip2;
   
   x2D = D2(:,17);
   y2D = Bcmb2./sqrt(fohm2);
    
end


% ***** CA06 - x and y for C ****
if l == 1
   Lo2 = C2(:,13);
   bdip2 = C2(:,15);
   fohm2 = C2(:,16);
   
   Bdip2 = Lo2./bdip2;
   
   x2C = C2(:,17);
   y2C = Bdip2./sqrt(fohm2);
    
else  % l=12 for CA06 
   Lo2 =  C2(:,13);
   bdip2 = C2(:,15);
   fohm2 = C2(:,16);
   fdip2 = C2(:,14);
   
   Bdip2 = Lo2./bdip2;
   Bcmb2 = Bdip2./fdip2;
   
   x2C = C2(:,17);
   y2C = Bcmb2./sqrt(fohm2);
    
end

% ***** CA06 - x and y for E *****
if l == 1
   Lo2 =  E2(:,13);
   bdip2 = E2(:,15);
   fohm2 = E2(:,16);
   
   Bdip2 = Lo2./bdip2;
   
   x2E = E2(:,17);
   y2E = Bdip2./sqrt(fohm2);
    
else  % l=12 for CA06 
   Lo2 =  E2(:,13);
   bdip2 = E2(:,15);
   fohm2 = E2(:,16);
   fdip2 = E2(:,14);
   
   Bdip2 = Lo2./bdip2;
   Bcmb2 = Bdip2./fdip2;
   
   x2E = E2(:,17);
   y2E = Bcmb2./sqrt(fohm2);
    
end



%% CA06 plot

plotdataD2 = loglog(x2D, y2D,'x','MarkerEdge',[255,99,71]/255,'MarkerSize',10);
hold on 
plotdataC2 = loglog(x2C, y2C,'^', 'MarkerEdge',[255, 198, 179]/255,'MarkerSize',4);
hold on
plotdataE2 = loglog(x2E, y2E,'v', 'MarkerEdge',[255, 198, 179]/255,'MarkerSize',4);


end