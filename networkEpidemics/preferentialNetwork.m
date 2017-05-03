function [links, k] = preferentialNetwork(N,T,m) 

links = zeros(T,T);

links(1,2) = 1; % initial linking
links(2,1) = 1; % initial linking

links(3,4) = 1; % initial linking
links(4,3) = 1; % initial linking

P = zeros(T,1); 
k = zeros(T, 1);
k(1:N) = 1; % surrounding individuals now have one link

for i = 5:T % first four already initiated 
    
    for j = 1:N
        P(j,1) = k(j)/sum(k);
    end
    
    new_links = randsample(1:N, m, 1, P(1:i-1));
    
    links(j,new_links) = 1; 
    links(new_links,j) = 1; 
    
    
    k(new_links) = k(new_links) + 1; % each picked individual recieves one more link to the new individual
    k(i) = k(i) + m;  % add four links to the individual that is being added
    N = N + 1; % increase total number of individuals 
    
end 

end