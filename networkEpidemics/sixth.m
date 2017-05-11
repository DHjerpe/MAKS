%clear all; 
clc; close all; 

T = 1000; % number of days 
N = 5000; % individuals 
p = [0.001: 0.001: 0.01];
r = 0.03; % probability of recovery
ld = 0.0016; % link density


init = 100; % number of infected initially

infected = zeros(T,N);

index_infected = randperm(N,init);     % generate random indeces
infected(1,index_infected) = 1; % set values to one on generated indeces


%[links, distr] = preferentialNetwork(4,N,4); 

firstFig = figure;
secondFig = figure;


h = waitbar(0, 'Simulating...');

for k = 1:length(p)

infected = zeros(T,N);

index_infected = randperm(N,init);     % generate random indeces
infected(1,index_infected) = 1; % set values to one on generated indeces


for i = 2:T % simulate over time 
   
    infected(i,:) = infected(i-1,:); % update time step
    
    for j = 1:N % loop over every individual
        n = distr(j);
        if rand < 1 - exp(-p(k)*n) % risk to get ill 
            infected(i,j) = 1;
        end
        if rand < r % chance to get well 
            infected(i,j) = 0; 
        end
    end
    waitbar(i/T);
end

figure(firstFig)
plot(sum(infected'))
hold on

infected_equilibrium(k) = sum(infected(end,:));



end 

close(h);

% figure
% plot(sum(infected'))
% set(gcf,'color','white')
% set(gca,'FontSize',16)
% xlabel('Time','fontsize',16)
% ylabel('# Infected individuals','fontsize',16)
% 


figure(firstFig)
set(gcf,'color','white')
set(gca,'FontSize',16)
xlabel('Time','fontsize',16)
ylabel('# Infected individuals','fontsize',16)
legend('p=0.001','p=0.002','p=0.003','p=0.004','p=0.005','p=0.006',...
    'p=0.007','p=0.008','p=0.009','p=0.010')


figure(secondFig)
plot(r./p,infected_equilibrium, 'o-')
set(gcf,'color','white')
set(gca,'FontSize',16)
xlabel('r/p','fontsize',16)
ylabel('# Infected individuals','fontsize',16)
 