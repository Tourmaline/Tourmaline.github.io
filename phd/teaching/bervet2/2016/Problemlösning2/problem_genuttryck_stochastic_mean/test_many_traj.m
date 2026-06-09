% Demonstration of the Law of large numbers
%
% Our expected mean value is the same which we got by the deterministic
% model.
% With increasing N, our computed mean value (sum of all trajectories divided by N) 
% will approach expected mean value.


N = 20; % number of tests

Res = zeros(1, 10000 / 50 + 1);
for i = 1:N
    [T, X] = Example( @stoich_matrix, @propensities, [0;0], [0 10000]); % one particular trajectory
    Res = Res + X(1, :);
end

Xfin = Res/N; % "mean" trajectory


figure
plot(T, Xfin(1, :), '.-r'); 
hold on; 
set(gca,'XLim', [0 10000]); 
xlabel('Time [h]');
ylabel('Number of proteins');
hold off;