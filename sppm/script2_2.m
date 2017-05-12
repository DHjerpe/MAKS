%script 2.2
%bifurcation diagram how the alignment measure changes over q
%parameters
clear all; close all;
T = 500; N = 50;
L = 20; p = 0.1;
%q = 0.2;
%initial conditions
x_0(1,:) = ceil(rand(1,N).*L);
y_0(1,:) = ceil(rand(1,N).*L);
theta_0 = ceil(2*pi*rand);
R = 2;
q_vec = 0:0.1:0.99;
N_sims = 10;
alignment = zeros(length(q_vec),N_sims);

for i = 1:length(q_vec)
    q = q_vec(i);

    for n = 1:N_sims
    [~,~,theta,~] = sppm(p, q, N, x_0, y_0, theta_0, L, R, T);
    alignment(i,n) = ((1/N)*sqrt(sum(cos(theta(end,:))).^2 + sum(sin(theta(end,:))).^2));
    end
    %ali(i,:) = ali(i,:)/N_sims; ???

end
%bifurcation diagram
plot(q_vec,alignment,'.')
xlabel('Range of q');
ylabel('Psi');
figure(); 
imagesc(alignment); colormap hot;
xlabel('Range of q'); ylabel('Psi');