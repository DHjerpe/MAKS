clear all; close all; clc; 


N_gen = 200; 
N_chroms = 50;
chrom_sims = 5;
chroms = ceil(rand(N_chroms,54)*4); % 50 chromosoms, each 54 long 
e = zeros(20,40);


h = waitbar(0, 'Simulating...');


for i = 1:N_gen

for j = 1:N_chroms % play each chromosome

    avgPerf = 0;
    for k = 1:chrom_sims % play each cromosom several times
    
        [perf, trajectory] =  OneChromePerf(e, chroms(j,:)); % perf = efficiency [%]
        avgPerf = avgPerf + perf; % calculate mean value step 1
    end
    
    avgPerf = avgPerf/chrom_sims;  % calculate mean value step 2
    
end

 waitbar(i/N_gen);

end

close(h);