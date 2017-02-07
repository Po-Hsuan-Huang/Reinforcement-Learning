%% Po-Hsuan Huang 2916 2 16
% This program implement a simple reinforce learning demo where the point robot
% has to the the best route to move from A to B with Q learning or SARSA
clear;
policy = 0;
alpha = 0.3;
beta = 0.1;
%  Construct the world, 4 rows 12 columns. The first row consists a cliff(1,2:11)
%  and start point(1,1) and target(1,12). 
%  Reward :Cliff: -100; Non-target States : -1;

Reward = -1*ones(4,12);
target = [1,12];
start = [1,1];
Reward(1,1) = -10;
Reward(1,12)= 0;
Reward(1,2:11)= -100;

% Initialize State-Value function with normal distributed random number in
% [0,1]
S = -1+ random('Normal',0,1,4,12,4);
%S = zeros([4,12]);
s = start;

% Q function for decision making
% the Q is the epected reward of all the possible movement
% the funciton is defined in file R_ex_func.m in the same folder.

% Policy 

a={[0, 1]; [0 -1];[1 0];[-1 0]}; 
T = zeros([1,1]);

for reps = 1:100
    % Reset the intial state, prepare for the next try.
    t = 0;
    s = start;

    while   ~isequal(s, target)
        t= t+1;
        % possible states given action
        Re_ex = zeros(1,4);
        Gain = zeros(1,4);
        for i = 1:4
            
            
            % confine the actions inside the wolrdspace
            if prod(s+a{i})<=0 
                Re_ex(i) = -Inf;
                Gain(i) = -inf;

            %confine the actions inside the wolrdspace
            elseif (s(1)+a{i}(1))>=5 || (s(2)+a{i}(2))>=13 
                Re_ex(i) = -Inf;
                Gain(i) = -inf;
                
            % update expected reward state    
            elseif prod (s+a{i})>0  
                Re_ex(i)= R_ex_func(S,s,a{i},i);
                Gain(i) = Re_ex(i)-S(s(1),s(2),i);
                
            end
            
            
        end

        switch policy 
            case 0 % Q learning
                eps = 0.1;
                
                % epsilon greedy
                if  max(Gain)>=eps 
                    % if the gain is large enough, than update accroding to the
                    % maxgain
                    if sum(Gain==max(Gain))>1 % exist more than one max gain, then randomly sample one of them
                        valid = find(Gain==max(Gain));
                        a_index = randsample(valid,1);
                    else
                        a_index = find(Gain==max(Gain));
                    end
                    
                elseif max(Gain)<eps
                    % i the gain is too small, the go in random direction
                    % that is insdie the worldspace
                    valid = find(Re_ex ~=-Inf);
                    a_index = randsample(valid,1); 
                    
                end

                s= s+a{a_index}; % update state

                S(s(1),s(2),a_index) = alpha*( Reward(s(1),s(2)) +beta * Gain(a_index)   );
                %fprintf('Update: S(%d,%d)= %.2f \n',s(1),s(2),S(s(1),s(2)))
                
                 % break the while loop when fall off cliff.
                if     s(1)<=1 && s(2)>=2 && s(2) <=11
                    fprintf('fall from the cliff \n');
                    break; 
                    
                 % timer   
                elseif  t >10000
                    fprintf('time is up \n');
                    break;
                elseif s(1)==1 && s(2)==12
                    fprintf('congratulations, you finished the task!');
                    break;
                end
                
                
                
                
                
            case 1 % SARSA
                
               % pass  
                
                
        end
    end 
    
    T(reps)= t;
    fprintf('reps: %d; T: %d ; s: [%d,%d] \n', reps, t,s(1),s(2));

end    
%%
figure(1)
imagesc(S(:,:,1));
colorbar;
figure(2);
x=linspace(1,reps,reps);
plot(x,T,'-*');
xlabel('reps')
ylabel('timelapse')



