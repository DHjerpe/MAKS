clear all; close all; clc; 


N_gen = 200; 
N_chroms = 50;
chrom_sims = 10;
mut_rate = 0.02; 
%chroms = ceil(rand(N_chroms,54)*4); % 50 chromosoms, each 54 long 

chroms = randi([1 4], 54, N_chroms);

new_chroms = zeros(54, N_chroms); 
e = zeros(20,40);
fitness = zeros(N_gen, N_chroms);

h = waitbar(0, 'Simulating...');


for i = 1:N_gen
    
    for j = 1:N_chroms % play each chromosome
        
        avgPerf = 0;
        for k = 1:chrom_sims % play each cromosom several times
            
           % [perf, trajectory] =  OneChromePerf(e, chroms(j,:)); % perf = efficiency [%]
            [perf, trajectory] =  OneChromePerf(e, chroms(:,j)); % perf = efficiency [%]
            avgPerf = avgPerf + perf; % calculate mean value step 1
        end
        
        avgPerf = avgPerf/chrom_sims;  % calculate mean value step 2
        fitness(i,j) = avgPerf;
    end
    
    
    
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
           mut = ceil(rand*54); % mutate random cromosome
           new_chroms(mut,k) = ceil(rand*4); 
        end
    end
    
    chroms = new_chroms;  % update all chromosoms 
    waitbar(i/N_gen);
    
end

close(h);

plot(1:N_gen, mean(fitness,2)); 


