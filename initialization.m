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
%   Main paper: Yuanyuan Li; Lei Ni; Na Yao; Guoqiang Chen;         %
%               Lanqiang Zhang; Dongmei Zhao; Geng Wang;            %
%               Dumbo Octopus Algorithm:                            %
%               global optimization problems                        %
%   DOI:                                                            %
%___________________________________________________________________%

% This function initialize the first population of search agents
function Positions=initialization(SearchAgents_no,dim,ub,lb)

Boundary_no= size(ub,2); % numnber of boundaries

% If the boundaries of all variables are equal and user enter a signle
% number for both ub and lb
if Boundary_no==1
    Positions=rand(SearchAgents_no,dim).*(ub-lb)+lb;
end

% If each variable has a different lb and ub
if Boundary_no>1
    for i=1:dim
        ub_i=ub(i);
        lb_i=lb(i);
        Positions(:,i)=rand(SearchAgents_no,1).*(ub_i-lb_i)+lb_i;
    end

end