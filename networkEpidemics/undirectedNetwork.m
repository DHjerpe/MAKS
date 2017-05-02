function links = undirectedNetwork(N,ld) 

links = zeros(N,N); % store the graph in a matrix

for i = 1:N
    
    for j = i:N
        
        if rand < ld && i ~= j
            links(i,j) = 1;
            links(j,i) = 1;
        end
        
        
    end
    
end

end