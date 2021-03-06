clear all; close all; clc; 


N_gen = 200; 
N_chroms = 50;
chrom_sims = 5;
mut_rate = 0.05; 
%chroms = ceil(rand(N_chroms,54)*4); % 50 chromosoms, each 54 long 

chroms = randi([1 4], 54, N_chroms);


most_effective_chrom = zeros(1, 54);
most_effective_traj = zeros(20,40); 

bestPerf = 0; 

new_chroms = zeros(54, N_chroms); 
e = zeros(20,40);
fitness = zeros(N_gen, N_chroms);
 D = zeros(N_gen,1);
%D = 0; 
h = waitbar(0, 'Simulating...');


for i = 1:N_gen
    
    for j = 1:N_chroms % play each chromosome
        
        avgPerf = 0;
        trajectory = zeros(20,40);
        for k = 1:chrom_sims % play each cromosom several times
            
            
            [perf, trajectory] =  OneChromePerf(e, chroms(:,j)); % perf = efficiency [%]
            avgPerf = avgPerf + perf; % calculate mean value step 1
            
            if perf > bestPerf
                bestPerf = perf;
                most_effective_chrom = chroms(:,j);
                most_effective_traj = trajectory;
            end
            
            
        end
        
        avgPerf = avgPerf/chrom_sims;  % calculate mean value step 2
        fitness(i,j) = avgPerf;
        
        
    end
    
    
    D(i) = getDiversity(N_chroms, N_gen, chroms, 54);
    
    
    
    for k = 1:2:N_chroms
    
        chroms_indx = 1:N_chroms; 
        co = randsample(chroms_indx, 1, 1, fitness(i,:)); % first parent
        chroms_indx(co) = []; 
        co(2) = randsample(chroms_indx, 1, 1, fitness(i,chroms_indx)); % second parent 
        
        splt = ceil(rand*54); 
        
        % first offspring 
        new_chroms(1:splt, k) = chroms(1:splt, co(2));
        new_chroms((splt + 1):end, k) = chroms(splt + 1:end, co(1));
        
        % second offspring
        new_chroms(1:splt, k+1) = chroms(1:splt, co(1));
        new_chroms((splt + 1):end, k+1) = chroms((splt + 1):end, co(2));
        
    end 
    
    
    % mutate with reasonable rate (3% ?)
    for k = 1:N_chroms
        
        if rand < mut_rate
           mut = ceil(rand*54); % mutate random within cromosome
           new_chroms(mut,k) = ceil(rand*4); 
        end
    end
    
    chroms = new_chroms;  % update all chromosoms 
    waitbar(i/N_gen);
    
end

close(h);

figure
set(gcf,'color','white')
set(gca,'FontSize',16)
plot(1:N_gen, mean(fitness,2)); 
xlabel('Generation #','fontsize',16)
ylabel('Efficiency','fontsize',16)


figure
set(gcf,'color','white')
set(gca,'FontSize',16)
plot(1:N_gen, D)
xlabel('Generation #','fontsize',16)
ylabel('Diversity','fontsize',16)

figure
bestPerf
most_effective_chrom
imagesc(most_effective_traj)


function D = getDiversity(N_chroms, N_gen, chroms, L)


    D = 0; 
    for k = 1:54 
        
        for i = 1:N_chroms
           
            for j = 1:N_chroms
               
                
                if (chroms(k,i) == chroms(k,j) && i~=j)
                
                    D = D + 1; 
                    
                end
             
            end
            
        end
        
    end
    D = D./(L*N_chroms*(N_chroms-1));

end
