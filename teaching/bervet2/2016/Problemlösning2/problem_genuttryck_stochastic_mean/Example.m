function [Ts, Xs] = Example( stoich_matrix, propensity_fcn, x0, Tspan)
% Example used for the demonstration of the Law of large numbers
% see test_many_traj.m

                     
% params
kR = 0.1;%0.01;      
kP = 0.1;%1;                     
gR = 0.1;                        
gP = 0.002;

params = [kR, kP, gR, gP];

Nr = stoich_matrix();

Tf = Tspan(2);
t = Tspan(1);

Tcurrent = t;

Ts(1) = t; % here I will save my time checkpoints (can be avoided)
x = x0;
Xs(1) = x(2); % I am saving just number of molecules of protein, ignoring mRNA

count = 1;
countTs = 1;

while t < Tf  
    
    % calculate reaction propensities
    a = propensity_fcn(x, params);
    
    % choose time
    a0 = sum(a);
    u = rand(1,2);
    tau = -log(u(1))/a0; % u or 1-u  
    
    % choose reaction
    r = find((cumsum(a) >= u(2)*a0), 1);

    % update time and state
    t = t + tau;
    Tcurrent   = Tcurrent   + tau;
    x = x + Nr(:, r);    
    
    % this part of code is used if we want to save number of proteins
    % every 50 hours
    if Tcurrent - Ts(countTs) > 50
        Ts(countTs + 1) = Ts(countTs) + 50;
        Xs(countTs + 1) = x(2);
        countTs = countTs  + 1;
    end
    
    count = count + 1;
end  

end

