
% non linear constraints:
opts = optimoptions(@fmincon,'Algorithm','sqp');
problem = createOptimProblem('fmincon','objective',...
    @(X)0,'x0',X0,'Aineq',A_inaquality,'bineq',b_inaquality, ...
    'lb',lb,'ub',ub,'options',opts);
ms = GlobalSearch;%ms = MultiStart;
[x0_new,f] = run(ms,problem)