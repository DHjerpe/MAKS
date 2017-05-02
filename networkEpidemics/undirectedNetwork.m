function [links, distr] = undirectedNetwork(N,ld)

links = zeros(N,N); % store the graph in a matrix
distr = zeros(1,N);

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


end