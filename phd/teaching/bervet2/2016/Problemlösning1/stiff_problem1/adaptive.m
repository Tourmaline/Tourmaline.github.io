function y = adaptive(mu)

y0 = 0;
tspan = [0, 15];

opt = odeset('RelTol', 1e-13);

[x, y] = ode45(@(x, y)ode3(x, y, mu), tspan, y0, opt);


figure
plot(x, y);