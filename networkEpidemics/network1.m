
clc; clear all; close all; 

% indirected social network


N = 5000; % number of individuals

ld = 0.0016; % link density

links = zeros(N,N); % store the graph in a matrix

distr = zeros(1,N); % the distrubution to be plotted in histogram


for i = 1:N
    
    for j = i:N
        
        if rand < ld && i ~= j
            links(i,j) = 1;
            links(j,i) = 1;
        end
        
        
    end
    
end


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