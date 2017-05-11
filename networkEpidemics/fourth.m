clear all; close all; clc

T = 5000; % number of days 
N = 4;    % number of individuals 
m = 4;    % links to add with  each individual

[~, k] = preferentialNetwork(N,T,m); 


figure
hist(k)

set(gcf,'color','white')
set(gca,'FontSize',16)
ylabel('Frequency','fontsize',16)
xlabel('Number of links','fontsize',16)
xlim([0 100])

figure
hist(k)

set(gcf,'color','white')
set(gca,'FontSize',16)
set(gca, 'YScale', 'log')
set(gca, 'XScale', 'log')

ylabel('Frequency','fontsize',16)
xlabel('Number of links','fontsize',16)