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

% This function initialize the first population of search agents
function Positions=initialization1(SearchAgents_no,dim,ub,lb,F_obj)

X_train = rand(SearchAgents_no,dim).*(ub-lb)+lb;

y_train=rand(SearchAgents_no,dim).*(ub-lb)+lb;

  net = feedforwardnet(10); % 使用10个隐藏层神经元

net.trainParam.showWindow = false;

 net = train(net, X_train, y_train);

% 使用训练好的神经网络模型生成初始解
input_features =rand(SearchAgents_no,dim).*(ub-lb)+lb;

Positions_NN = net(input_features);

%% 传统方法

    for i=1:dim

        Positions_X=rand(SearchAgents_no,dim).*(ub-lb)+lb;

    end

 for i=1:SearchAgents_no  
     
        Fit_NN(i,:)=F_obj(Positions_NN(i,:));

        Fit_X(i,:)=F_obj(Positions_X(i,:));

if Fit_NN(i)<Fit_X(i)

Positions(i,:)=Positions_NN(i,:);

else

Positions(i,:)=Positions_X(i,:);


 end

 end

end