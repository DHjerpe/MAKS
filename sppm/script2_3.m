%script 2.3
clear all; close all; clc;
%parameters

T = 200; N = 50;
L = 20; R = 2;
p = 0.5;
q = 0.5;
%initial condition
x_0(1,:) = ceil(rand(1,N).*L);
y_0(1,:) = ceil(rand(1,N).*L);
theta_0 = ceil(2*pi*rand);


phi = zeros(1,T);
%for i = 1:N
[~,~,~, phi] = sppm(p, q, N, x_0, y_0, theta_0, L, R,T);

%end
plot(phi)
ylabel('Average distance');
xlabel('Time [s]');

