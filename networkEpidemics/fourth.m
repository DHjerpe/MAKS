clear all; close all; clc

T = 5000; % number of days 
N = 4;    % number of individuals 
m = 4;    % links to add with  each individual

[~, k] = preferentialNetwork(N,T,m); 


bins = histcounts(k, 1:T)./T;
figure


plot(1:T-1, bins, 'o-')
set(gcf,'color','white')
set(gca,'FontSize',16)
ylabel('Relative frequency','fontsize',16)
xlabel('Number of links','fontsize',16)
xlim([0 80])


figure
loglog(1:T-1, bins, 'o')
ylabel('Relative frequency','fontsize',16)
xlabel('Number of links','fontsize',16)