You can simply define your cost in a seperate file and load its handle to F_obj

The initial parameters that you need are: F_obj = @YourCostFunction; Dim = number of your variables; Max_iterations = maximum number of generations; SearchAgents = number of search agents; LB=[LB1,LB2,... ,LBn], where LBn is the lower bound of variable n; UB=[UB1,UB2,... ,UBn], where UBn is the upper bound of variable n.

To run DOA: [Best_sDOA,Best_pDOA,DOA_curve,position_history,first_history,mean_fit]=DOA(SearchAgents,Max_iterations,LB,UB,Dim,F_obj);  

The code was developed based on the MATLAB 2022a environment and performed performance verification and experimental testing in this revision. It is recommended that users run code using MATLAB 2022a or later to ensure accuracy and consistency of results. In addition, while the implementation has shown good performance in a variety of test functions and FOPID controller tuning, due to the nature of the heuristic algorithm, it may face long computation times or insufficient memory when dealing with very large-scale optimization problems. The authors recommend that users adjust the algorithm parameters appropriately when dealing with large-scale problems, or consider running the code in a higher performance computing environment.
