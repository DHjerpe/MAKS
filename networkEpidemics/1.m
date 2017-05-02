
clc; clear all; close all; 

N = 5000; % number of individuals

ld = 0.0016; % link density

distr = zeros(1,N); % the distrubution to be plotted in histogram

links = undirectedNetwork(N,ld);


for i = 1:N
   distr(i) = sum(links(i,:)); 
end

figure
hist(distr)
set(gcf,'color','white')
set(gca,'FontSize',16)
xlabel('Number of links in network','fontsize',16)
ylabel('Frequency','fontsize',16)
xlim([0 max(distr)])  