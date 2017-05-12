%script for 2.1 sppm model
%parameters
clear all; close all; clc;
T = 500; N = 50;
L = 20; R = 2;

p = 0.3;
q = 0.3;

%initial conditions
x_0(1,:) = ceil(rand(1,N).*L);
y_0(1,:) = ceil(rand(1,N).*L);
theta_0 = ceil(2*pi*rand);

%get direction of flock in x, y direction
[x,y, ~,~] = sppm(p, q, N, x_0, y_0, theta_0, L, R, T);

figure;
axis([0 L 0 L]);
axis('square');


for i = 1:T
    plot(x(i,:),y(i,:),'*')
    xlabel('World X');
    ylabel('World Y');
    drawnow;
    
end


