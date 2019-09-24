function run(mu)
%RUN Example of the stiff problem
% Parameter mu  controls the width of the function (for mu > 100 the problem become stiff)


vtime = [0; 10];
y0 = [0.5; 0];

opt = odeset('RelTol', 1e-3);

% NOTICE HOW WE SET PARAMETERS IN ode
tstart = tic;
[t1, y1] = ode45(@(t,z)ode(t,z,mu), vtime, y0, opt);
telapsed_ode45 = toc(tstart);

tstart = tic;
[t2, y2] = ode15s(@(t,z)ode(t,z,mu), vtime, y0, opt);
telapsed_ode15s = toc(tstart);

fprintf('(ode45) size(t) = [%f %f], size(y) = [%f %f]\n',size(t1, 1), size(t1, 2), size(y1, 1), size(y1, 2));
fprintf('(ode15s) size(t) = [%f %f], size(y) = [%f %f]\n',size(t2, 1), size(t2, 2), size(y2, 1), size(y2, 2));
fprintf('Elapsed time (ode45): %f\n',  telapsed_ode45 );
fprintf('Elapsed time (ode15s): %f\n', telapsed_ode15s );
% 
% figure
% plot(t1, y1(:, 1), '-*b');
% hold on
% plot(t2, y2(:, 1), '-or');
% legend('ode45', 'ode15s')
% hold off


% get "exact" solution - very small tolerance
opt = odeset('RelTol', 1e-13);
tstart = tic;
[t_exact, y_exact] = ode15s(@(t,z)ode(t,z,mu), vtime, y0, opt);

figure
plot(t1, y1(:, 1), '-*b');
hold on
plot(t_exact, y_exact(:, 1), '-r');
title('ode45')
hold off

figure
plot(t2, y2(:, 1), '-ob');
hold on
plot(t_exact, y_exact(:, 1), '-r');
title('ode15s')
hold off


end

