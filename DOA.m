
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
%   Main paper: Yuanyuan Li; Lei Ni;                                %
%               Lanqiang Zhang; Sumeet S. Aphale; Geng Wang;        %
%               Dumbo Octopus Algorithm:                            %
%               global optimization problems                        %
%   DOI:                                                            %
%___________________________________________________________________%


function [Best_score,Best_pos,conv,position_history,first_history,mean_fit]=DOA(SearchAgents_no,Max_iterations,lb,ub,dim,F_obj) 
action_num = 2;
Reward_table =  [-1 1;1 1];
Q_table = zeros(action_num, action_num);
alpha = 0.1; % 学习率S
gamma = 0.9; % 折扣因子
cur_state = randi(action_num);

Best_pos=zeros(1,dim);
Best_score=inf; %change this to -inf for maximization problems
conv=zeros(1,Max_iterations);
position_history=zeros(SearchAgents_no,Max_iterations,dim);
first_history=zeros(1,Max_iterations);
mean_fit=zeros(1,Max_iterations);

% Initialize the positions of search agents
    X=initialization1(SearchAgents_no,dim,ub,lb,F_obj);    
    GX=X(:,:);    
    for i=1:SearchAgents_no      
        Fit(i)=F_obj(X(i,:));    
    end


for Iter=1:Max_iterations 
   
%% Global exploration
    for i=1:SearchAgents_no     
        if rand<0.1
            GX(i,:)=(ub-lb)*rand+lb; 
        else
           t1=randperm(SearchAgents_no,1);
           t2=randperm(SearchAgents_no,1);
           GX(i,:)=X(i,:)+rand.*(X(t1,:)-X(t2,:));
        end
    end
           GX = boundaryCheck(GX,lb,ub);  
    
    
    for i=1:SearchAgents_no       
         New_Fit(1,i)=F_obj(GX(i,:));  
         if New_Fit(1,i)<Fit(i)
            Fit(i)=New_Fit(1,i);
            X(i,:)=GX(i,:);
         end

    end 

 %% Balance global exploration and local exploitation
    
    for i=1:SearchAgents_no      
         a1=2;
        lambda=rand();
        t=(1-Iter/Max_iterations)^(1*Iter/Max_iterations);
         m1=a1*sign(rand-rand).*(exp(-lambda.*t)-1);
        a=ceil((SearchAgents_no-1)*rand());     
        GX(i,:)=X(i,:)+rand*m1*(X(i,:)-2*rand()*X(a,:));   
    end
    
        GX = boundaryCheck(GX,lb,ub); 
    
    for i=1:SearchAgents_no           
         New_Fit(1,i)=F_obj(GX(i,:));  
         if New_Fit(1,i)<Fit(i)
            Fit(i)=New_Fit(1,i);
            X(i,:)=GX(i,:);
         end

         if  New_Fit(1,i)<Best_score 
        Best_score= New_Fit(1,i); 
        Best_pos=GX(i,:);
         end
    end


%%  Local exploitation
    for i=1:SearchAgents_no   
  
       if Iter<0.5*Max_iterations
           if Q_table(cur_state, 1) >= Q_table(cur_state, 2)
                 action = 1;
                GX(i,:)=cos(2*pi*rand)*(2*Iter/Max_iterations*Best_pos-X(i,:)).*trnd(6,1,dim)+Best_pos;  
           else
                 action = 2;
                 GX=GX;
           end

       else
                 action = 2;
                [~,ind]=sort(Fit); Best_pos(1,:)=X(ind(1),:);
                Second_pso(1,:)=X(ind(2),:); Third_pso(1,:)=X(ind(3),:);
                Four_pos(1,:)=X(ind(4),:);    
                X1(1,:)=(Best_pos+Second_pso)/2;
                X2(1,:)=(Best_pos+Second_pso+Third_pso)/3;
                X3(1,:)=(Best_pos+Second_pso+Third_pso+Four_pos)/4;
                c=ceil((SearchAgents_no-1)*rand());    
                GX(i,:)=Best_pos+rand*sin(2*pi*rand)*(((X1(1,:)-X2(1,:))+(X3(1,:)-Four_pos))/2+rand*X(c,:));
       end


    
        GX = boundaryCheck(GX,lb,ub);
    
        New_Fit(1,i)=F_obj(GX(i,:));     
        if New_Fit(1,i)<Fit(i)
            Fit(i)=New_Fit(1,i);
            X(i,:)=GX(i,:);   
            Reward_table(cur_state, action, i) = 1;  
        else   
            Reward_table(cur_state, action, i) = -1;    
        end
    
    if  New_Fit(1,i)<Best_score 
        Best_score= New_Fit(1,i); 
        Best_pos=GX(i,:);
    end
    
    % update the Q_table
        r =  Reward_table(cur_state, action);
        qCurrent=Q_table(cur_state, action);
        maxQ = max(Q_table(action, :));
        Q_table(cur_state, action) = qCurrent+ alpha * (r + gamma * maxQ - qCurrent);
        cur_state = action;
end

end

