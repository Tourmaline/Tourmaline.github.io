function [T, X] = Example( stoich_matrix, propensity_fcn, x0, Tspan)
% Example Simulate a two-state model of gene expression
%
% Input: stoich_matrix  - function generating stoichiometry matrix
%        propensity_fcn - function returning values of propensity functions
%        for the given state
%        x0             - initial state (vector with initial numbers of molecules) [mRNA protein]
%        Tspan          - time period where we run the calculations
%
% The current state variables (u) are ordered as:
%    mRNA protein


% Example is taken from 
% http://www.mathworks.com/matlabcentral/fileexchange/34707-gillespie-stochastic-simulation-algorithm
%
% Run: [T, X] = Example( @stoich_matrix, @propensities, [0;0], [0 10000]);

                     
% params
kR = 0.1;%0.01;      
kP = 0.1;%1;                     
gR = 0.1;                        
gP = 0.002;

params = [kR, kP, gR, gP];

Nr = stoich_matrix();

% T - times of events
% X - matrix containing number of molecules at every time event
% for example: 
% 	          X(1, 1) is a number of mRNA molecules in initial state
%              T(1) initial time     
%              X(1, 3) is a number of mRNA molecules at second event
%              T(3) gives time when second event occur

Tf = Tspan(2);
t = Tspan(1);


T(1) = t;
x = x0;
X(:, 1) = x;

count = 1;

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
    T(count+1)   = T(count)   + tau; 
    x = x + Nr(:, r);
    X(:,count+1) = x;    % NOTE: do not save states at every time T(count)!!! 
                         % try to save all of them and see the size of
                         % vector T and matrix X - it is huge for large Tf!
    
    count = count + 1;
end  

T = T(1:count);
X = X(:, 1:count);


% plot results
figure
plot(T, X(1, :), '.-r'); % NUMBER OF MOLECULES!
hold on; 
plot(T, X(2, :), '.-b'); 
set(gca,'XLim', Tspan); 
legend('mRNA', 'protein');
xlabel('Time [h]');
ylabel('Number of molecules');
hold off;

end

