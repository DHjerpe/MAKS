function [x,y, theta, phi] = sppm(p, q, N, x_0, y_0, theta_0, L, R,T)


ita = 0.1; %noise
dt = 0.5; %delta
%pre-allocate
x = zeros(T,N);
y = zeros(T,N);
theta = zeros(T,N);
phi = zeros(1,T);
ind = zeros(1,N); 
dist = zeros(N,1);
%initial conditions
x(1,:) = x_0(1,:);
y(1,:) = y_0(1,:);
theta(1,:) = theta_0;
%for interval of ita when noise is added
interval = [-1 1];

for t = 1:T
    %noise
    noise = interval(ceil(rand+1))*rand*ita/2;

    for i = 1:N %i, j comparison of two individuals
        prob = rand;
        %k # of individuals
        k = 0;
        if prob < p + q
            for j = 1:N
                %distance of bird in x and y direction
                x_d = x(t,i) - x(t,j);
                y_d = y(t,i) - y(t,j);
                dist(j) = sqrt((x_d)^2 + (y_d)^2);
                % 2.3
                %measure of aggregation
                phi(t) = min(mean(dist));

                if  dist(j) < R && dist(j) ~= 0
                    k = k + 1;
                    ind(k) = j;
                end
            end
            
            if k == 0
            %add noise
                theta(t+1,i) = theta(t,i) + noise;
            else
                tmp = ind(ceil(rand*(k-1)+1));
                if  prob < p
                    theta(t+1, i) =  atan2((y(t,i) - y(t,tmp)), ...
                        x(t,i) - x(t,tmp)) + noise;
                else
                    theta(t+1,i) = theta(t,tmp) + noise;
                end
            end
        else
        %add noise
            theta(t+1,i) = theta(t,i) + noise;
        end

        %updating movement
        y(t+1,i) = y(t,i) + dt*sin(theta(t+1,i));
        x(t+1,i) = x(t,i) + dt*cos(theta(t+1,i));
        
        if y(t+1,i) > L
            y(t+1,i) = y(t+1,i) - L;
        elseif y(t+1,i) < 0
            y(t+1,i) =  L - abs(y(t+1,i) - y(t,i));
        end
        
        if x(t+1,i) > L
            x(t+1,i) = x(t+1,i) - L;
        elseif x(t+1,i) < 0
            x(t+1,i) =  L - abs(x(t+1,i) - x(t,i));
        end

    end
end

end