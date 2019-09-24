function y = BE(mu, Nt)
% Euler bakåt

x = linspace(0, 15, Nt); % alla tidsteg
h = x(2) - x(1);

y = zeros(1, Nt);
y(1) = 0;

for n = 1:Nt-1
    y(n+1) = 1/(1+h*mu) * (y(n) + h*mu*sin(x(n+1)));
end


figure
plot(x, y);