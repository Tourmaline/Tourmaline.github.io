function y_ut = KemiODE(t,y)
% y_ut = KemiODE(t,y)
% Beräknar högerledet till ordinära differentialekvationen    
%    y'(t) = [ s*(y(2)-y(1)*y(2)+y(1)-q*y(1)^2);
%              1/s*(-y(2)-y(1)*y(2)+y(3));
%              w*(y(1)-y(3))];
% y är en vektor med tre komponenter, y=[y1 y2 y3]
%

global s q w

y_ut = [ s*(y(2)-y(1)*y(2)+y(1)-q*y(1)^2);
         1/s*(-y(2)-y(1)*y(2)+y(3));
         w*(y(1)-y(3))];
         
         