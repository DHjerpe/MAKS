function [perf, e] =  OneChromePerf(e, c)

% e - enviroment
% c - chromosome 1x54 array of ints
% perf - performance of chromosome

%1: go straight; 2: turn left; 3: turn right; 4: random turn left or right

grid_size = size(e);

height = grid_size(1); 
width = grid_size(2);

pos = [ceil(rand*height) ceil(rand*width)]; % random initial position
e(pos(1),pos(2)) = 1; % paint where the robot is standing


%perf = 0; 

%cur_dir = ['ENWS']; % begin pointing east
dir = [1 2 3 4]; % begin pointing east


   % %%% %%%  updateTable %%%%%% to add to update position of robot
   %                      X       Y
   %        E (=1)       +1       0   
   %        N (=2)        0      -1
   %        W (=3)       -1       0   
   %        S (=4)        0      +1
   %
   % to turn, just change the robots direction first, then move 
   % straight forward. 
   
   updateTable = [1 0;0 -1;-1 0;0 1];

%while sum(sum(e)) < height*width
 for i = 0:width*height   

    pos = moveRobot(dir, pos, updateTable, height, width); % update position
    
    e(pos(1),pos(2)) = 1; % paint where the robot is standing
    
    curr_rule = c(1); 
    dir = changeDir(dir,curr_rule); % update direction
    
    
    
    %perf = perf + 1; 
    c = circshift(c,-1);

    
 end

 perf = sum(sum(e))/(width*height);
 

    function dir = changeDir(cur_dir, rule)
        
        % dir is the new direction
        % rule decides which direction to turn to 
        % cur_dir is the array of [E N W S], first element is cur_dir
        % [E N W S] corresponds to [1 2 3 4], will be used to index matrix
        switch rule
            
            case 1
                dir = cur_dir; % do nothing    
            case 2
                dir = circshift(cur_dir,-1); % turn left  
            case 3 % turn right
                dir = circshift(cur_dir,1); % turn right 
            case 4
                rand_dir = [-1 1];
                rightOrLeft = rand_dir(ceil(rand*2)); % to choose either -1 or 1
                dir = circshift(cur_dir,rightOrLeft);
        end
    end 

    function newPos = moveRobot(cur_dir, cur_pos,updateTable, height, width)
        
        
        % cur_dir is current direction the robot is facing
        % cur_pos [x y] is the current position of the robot
        % newPos is vector [x y] with new position values for the robot
        
        newPos = cur_pos + updateTable(cur_dir(1),:);
        
        if (newPos(1) > height || newPos(1) < 1 || ...
                newPos(2) > width || newPos(2) < 1)
           newPos = cur_pos; 
        end
        
        
        
    end


end