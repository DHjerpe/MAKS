clear all; clc; close all; 

T = 1000; % number of days 
N = 5000; % individuals 
p = 0.01; % probability of being infected
r = 0.03; % probability of recovery
ld = 0.0016; % link density

init = 100; % number of infected initially

infected = zeros(T,N);

index_infected = randperm(N,init);     % generate random indeces
infected(1,index_infected) = 1; % set values to one on generated indeces


[links, distr] = undirectedNetwork(N,ld);

for i = 2:T % simulate over time 
   
    infected(i,:) = infected(i-1,:); % update timestep
    
    for j = 1:N % loop over every individual
        n = distr(j);
        if rand < 1 - exp(-p*n) % risk to get ill 
            infected(i,j) = 1;
        end
        if rand < r 
            infected(i,j) = 0; 
        end
    end
    
end



figure
plot(sum(infected'))
set(gcf,'color','white')
set(gca,'FontSize',16)
xlabel('Time','fontsize',16)
ylabel('# Infected individuals','fontsize',16)
 