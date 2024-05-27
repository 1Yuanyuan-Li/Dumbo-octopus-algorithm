You can simply define your cost in a seperate file and load its handle to F_obj

The initial parameters that you need are: F_obj = @YourCostFunction; Dim = number of your variables; Max_iterations = maximum number of generations; SearchAgents = number of search agents; LB=[LB1,LB2,... ,LBn], where LBn is the lower bound of variable n; UB=[UB1,UB2,... ,UBn], where UBn is the upper bound of variable n.

To run DOA: [Best_sDOA,Best_pDOA,DOA_curve,position_history,first_history,mean_fit]=DOA(SearchAgents,Max_iterations,LB,UB,Dim,F_obj);  
