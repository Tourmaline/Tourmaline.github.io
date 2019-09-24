% Sätt start- och sluttid för simuleringen
starttid = 0;  % t0
sluttid = 120;  % tn
tidsintervall = [starttid sluttid]; % t1=starttid, t2, t3, ..., tn=sluttid

% Sätt parametrar
global N b d beta u v;

N = 1000;
b = 0.002/365;
d = 0.0016/365;
beta = 0.3;
u = 1/7;
%v = 0;
v = 0.01;

% Sätt begynnelsevärden (tid t0)
Istart = 5; % 5 personer är sjuka
Rstart = 0; % ingen är immun
Sstart = N-Istart-Rstart;  % S(t) + I(t) + R(t) = N
y0 = [Sstart; Istart; Rstart]; % placera i vektor y0


% Sätt olika värden som styr Matlabs odelösare. Observera att detta 
% ej nödvändigt utan används enbart då man vill ändra på standardvärden
% som är inbyggda i odelösarna (raden 'val=odeset' medför att inget ändras).
val = odeset;
%val = odeset('OutputFcn','odeplot','RelTol', 1e-2);


% Lös ode:n genom anrop av ode45. Parametern val kan uteslutas om man inte 
% vill ändra standardvärden i ode45.

% NOTE: 
% >> help ode45
%  ode45  Solve non-stiff differential equations, medium order method.
%     [TOUT,YOUT] = ode45(ODEFUN,TSPAN,Y0) with TSPAN = [T0 TFINAL] integrates 
%     the system of differential equations y' = f(t,y) from time T0 to TFINAL 
%     with initial conditions Y0. ODEFUN is a function handle. For a scalar T
%     and a vector Y, ODEFUN(T,Y) must return a column vector corresponding 
%     to f(t,y). Each row in the solution array YOUT corresponds to a time 
%     returned in the column vector TOUT.  To obtain solutions at specific 
%     times T0,T1,...,TFINAL (all increasing or all decreasing), use TSPAN = 
%     [T0 T1 ... TFINAL]. 

% y'(t) = EpidemiODE(t, y)

[T, Y] = ode45(@EpidemiODE, tidsintervall, y0, val);

% Rita upp lösningen
if isempty(val.OutputFcn)  % Plotta enbart om 'odeplot' inte är
  figure;
  plot(T,Y(:,1),'-',T,Y(:,2),'-.',T,Y(:,3),'.')   
end  
  xlabel('Tid')
  ylabel('Antal');
  title('Simulering av epidemi');
  legend('Antalet mottaglig','Antalet infekterad', 'Antalet immun');

