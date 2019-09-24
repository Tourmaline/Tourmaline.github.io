function dz = ode(t, z, mu)

v = z(1);
w = z(2);

dv = w;
dw = mu*(1-v^2)*w-v;

dz = [dv; dw];

end