
clc; clear all; close all; 

N = 5000; % number of individuals

ld = 0.0016; % link density

[links, distr] = undirectedNetwork(N,ld);


figure
hist(distr)
set(gcf,'color','white')
set(gca,'FontSize',16)
xlabel('Number of links in network','fontsize',16)
ylabel('Frequency','fontsize',16)
xlim([0 max(distr)])  