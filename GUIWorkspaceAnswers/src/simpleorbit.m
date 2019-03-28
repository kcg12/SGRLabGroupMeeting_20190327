function [r,ev, R_S, a, v, T] = simpleorbit(eccentricity, sun_Mu, R, sma, theta)
% Executes the 2D Earth orbit integration around Sun with 2 bodies
% equations
% Orbit parameters:
e       = eccentricity; % Orbit eccentricity
mu_S    = sun_Mu; %132712439935.5; % Sun parameter (Km^3/s^2)
R_S     =  R; %6.957*10^6; % Sun radius (Km)
a       = sma; %149.6*1e6; %Semimajor axis (Km)
theta0  = theta; %0;
% Time
T       = 2*pi*sqrt(a^3/mu_S);
tfin    = T;
% IC:
rx0     = a*(1-e^2)/(1+e*cos(theta0));
vy0     = sqrt(2*mu_S/rx0-mu_S/a);
X0      = [rx0,0,0,0,vy0,0];
options = odeset('Reltol',2.22045e-14,'AbsTol',1e-15);
% Integration:
[T, X]  = ode113(@dynamics, [0,tfin], X0, options, mu_S);
r = [X(:,1),X(:,2),X(:,3)];
v = [X(:,4),X(:,5),X(:,6)];
% Additional results:
h = cross(r,v);
ev = cross(v(1,:),h(1,:))/mu_S-r(1,:)/norm(r(1,:));
% % Draw planet
% fig = figure(1);
% clf;
% [sx,sy,sz] = sphere(100);
% surf(R_S*sx,R_S*sy,R_S*sz,'EdgeColor','none','FaceColor','y')
% fig.Children.Color = [0.8 0.8 0.8];
% % Aspect
% hold on
% axis equal
% grid on
% axis([-2*a,2*a,-2*a,2*a,-2*R_S,2*R_S])
% % Plot:
% % quiver3(0,0,0,h(1,1),h(1,2),h(1,3))
% quiver3(0,0,0, ev(1),ev(2),ev(3))
% comet3(r(:,1),r(:,2),r(:,3))
% quiver3(r(1:10:end,1),r(1:10:end,2),r(1:10:end,3),v(1:10:end,1),v(1:10:end,2),v(1:10:end,3))
end
function [dX] = dynamics(~,X,mu)
rx = X(1);
ry = X(2);
rz = X(3);
vx = X(4);
vy = X(5);
vz = X(6);
r  = sqrt(rx.^2+ry.^2+rz.^2);
dX(1,1) = vx;
dX(2,1) = vy;
dX(3,1) = vz;
dX(4,1) = -mu*rx/r.^3;
dX(5,1) = -mu*ry/r.^3;
dX(6,1) = -mu*rz/r.^3;
end