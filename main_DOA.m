
%___________________________________________________________________%
%  Dumbo Octopus Algorithm source codes version 1.0                 %
%                                                                   %
%  Developed in MATLAB R2022a(7.13)                                 %
%                                                                   %
%  Author and programmer: Yuanyuan Li, Geng Wang                    %
%                                                                   %
%         e-Mail: wgmouse@163.com;                                  %
%                 geng.wang@swust.edu.cn                            %
%                                                                   %
%       Homepage:                                                   %
%                                                                   %
%   Main paper: Yuanyuan Li; Lei Ni; Guoqiang Chen;                 %
%               Lanqiang Zhang; Dongmei Zhao; Geng Wang;            %
%               Dumbo Octopus Algorithm:                            %
%               global optimization problems                        %
%   DOI:                                                            %
%___________________________________________________________________%

 close all; clc; clear;


SearchAgents =30;     
Max_iterations=500;

F_name='F1';    

[LB,UB,Dim,F_obj]=Get_Functions_details(F_name); 

[Best_sDOA,Best_pDOA,DOA_curve,position_history,first_history,mean_fit]=DOA(SearchAgents,Max_iterations,LB,UB,Dim,F_obj);  

display(['The best solution obtained by DOA is : ', num2str(Best_pDOA)]);
display(['The best optimal value of the objective funciton found by TO is : ', num2str(Best_sDOA)]);


figure('Position',[100,500,1600,300])

%Draw search space
subplot(1,5,1);
% hold on
func_plot(F_name);
title('F13')
xlabel('x_1');                                                                                              
ylabel('x_2');
set(gca,'FontName','Times New Roman','FontSize',12,'LineWidth',1.5);
zlabel([F_name,'( x_1 , x_2 )'])
grid off

subplot(1,5,2);
hold on 
for k1 = 1: size(position_history,1)
    for k2 = 1: size(position_history,2)
        plot(position_history(k1,k2,1),position_history(k1,k2,2),'.','markersize',1,'MarkerEdgeColor','k','markerfacecolor','k');
    end
end
plot(Best_pDOA(1),Best_pDOA(2),'.','markersize',10,'MarkerEdgeColor','r','markerfacecolor','r');
title('Search history (x1 and x2 only)')
xlabel('x1');
ylabel('x2');
set(gca,'FontName','Times New Roman','FontSize',12,'LineWidth',1.5);
box on
axis tight


%Draw objective space
subplot(1,5,3);
hold on
semilogy(DOA_curve,'Color','r')
title('Convergence curve')
xlabel('Iteration');
ylabel('Best score obtained so far');
set(gca,'FontName','Times New Roman','FontSize',12,'LineWidth',1.5);


%
subplot(1,5,4)
semilogx(first_history,'m-','LineWidth',1.5);
title('Fitness of 1st member')
xlabel('Iteration')
ylabel('Fitness value')
box on
axis tight
set(gca,'FontName','Times New Roman','FontSize',12,'LineWidth',1.5);


%
subplot(1,5,5)
semilogx(mean_fit,'b-','LineWidth',1.5);
title('Average fitness of all members')
xlabel('Iteration')
ylabel('Fitness value')
set(gca,'FontName','Times New Roman','FontSize',12,'LineWidth',1.5);
box on
axis tight
