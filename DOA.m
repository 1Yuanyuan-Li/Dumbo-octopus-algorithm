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


function [Best_score,Best_pos,conv,position_history,first_history,mean_fit]=DOA(SearchAgents_no,Max_iterations,lb,ub,dim,F_obj) 

Best_pos=zeros(1,dim);
Best_score=inf; %change this to -inf for maximization problems
conv=zeros(1,Max_iterations);
position_history=zeros(SearchAgents_no,Max_iterations,dim);
first_history=zeros(1,Max_iterations);
mean_fit=zeros(1,Max_iterations);
%% Initialization
X=initialization(SearchAgents_no,dim,ub,lb);
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
           t1=ceil((SearchAgents_no-1)*rand());
           t2=ceil((SearchAgents_no-1)*rand());
           GX(i,:)=X(i,:)+rand.*(X(t1,:)-X(t2,:));
        end
        F_UB=GX(i,:)>ub;
        F_LB=GX(i,:)<lb;
        GX(i,:)=(GX(i,:).*(~(F_UB+F_LB)))+ub.*F_UB+lb.*F_LB;
          New_Fit(1,i)=F_obj(GX(i,:));  
         if New_Fit(1,i)<Fit(i)
            Fit(i)=New_Fit(1,i);
            X(i,:)=GX(i,:);
         end  
  end 

%% Balance global exploration and local exploitation
      a1=2; 
      t=(1-Iter/Max_iterations)^(1*Iter/Max_iterations);
   for i=1:SearchAgents_no
       m1=a1*sign(rand-rand).*(exp(-rand.*t)-1); % lambda=rand()
        a=ceil((SearchAgents_no-1)*rand());
        GX(i,:)=X(i,:)+rand*m1*(X(i,:)-2*rand()*X(a,:));
        F_UB=GX(i,:)>ub;
        F_LB=GX(i,:)<lb;
        GX(i,:)=(GX(i,:).*(~(F_UB+F_LB)))+ub.*F_UB+lb.*F_LB;
         New_Fit(1,i)=F_obj(GX(i,:));         
         if New_Fit(1,i)<Fit(i)
            Fit(i)=New_Fit(1,i); X(i,:)=GX(i,:);
         end
  end
     
%% Local exploitation
  for i=1:SearchAgents_no   
      [~,ind]=sort(Fit); 
      Best_pos(1,:)=X(ind(1),:);        
       if Iter<0.5*Max_iterations
          GX(i,:)=cos(2*pi*rand)*(2*Iter/Max_iterations*Best_pos-X(i,:)).*rand+Best_pos;
       else        
          X1(1,:)=(Best_pos+X(ind(2),:))/2;
          X2(1,:)=(Best_pos+X(ind(2),:)+X(ind(3),:))/3;
          X3(1,:)=(Best_pos+X(ind(2),:)+X(ind(3),:)+X(ind(4),:))/4; 
          c=ceil((SearchAgents_no-1)*rand());  
          GX(i,:)=Best_pos+rand*sin(2*pi*rand)*(((X1(1,:)-X2(1,:))+(X3(1,:)-X(ind(4),:)))/2+rand*X(c,:));
       end
        F_UB=GX(i,:)>ub; F_LB=GX(i,:)<lb;
        GX(i,:)=(GX(i,:).*(~(F_UB+F_LB)))+ub.*F_UB+lb.*F_LB;
      New_Fit(1,i)=F_obj(GX(i,:));  
         if New_Fit(1,i)<Fit(i)
            Fit(i)=New_Fit(1,i);
            X(i,:)=GX(i,:);
         end
  end

     [~,ind]=sort(Fit); 
     Best_pos(1,:)=X(ind(1),:);
     Best_score=Fit(ind(1));
     conv(Iter)=Best_score;
     position_history(:,Iter,:)=X;
     first_history(Iter)=Fit(1);
     mean_fit(Iter)=mean(Fit);
end
end
