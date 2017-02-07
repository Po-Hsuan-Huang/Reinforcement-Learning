%% Po-Hsuan Huang 2916 2 16
% This program implement a simple reinforce learning demo where the point robot
% has to the the best route to move from A to B with Q learning or SARSA

policy = 0;
%  Construct the world, 4 rows 12 columns. The first row consists a cliff(1,2:11)
%  and start point(1,1) and target(1,12). 
%  Reward :Cliff: -100; Non-target States : -1;

Reward = -1*ones(4,12);
target = [1,12];
start = [1,1];
Reward(start) = 0;
Reward(target)= 0;
Reward(1,2:11)= -100;

% Initialize State-Value function with normal distributed random number in
% [0,1]
S = randn([4,12]);
s = start;

% Q function for decision making
% the Q is the epected reward of all the possible movement

R_ex_func ;

% Policy 
Re_ex = zeros(4,12);
Gain = zeros(1,4);
a=[[0,1,],[0,-1],[1,0],[-1,0]]; 
T = zeros([1,1]);

for reps = 1:10
    t = 0;
    while   ~isequal(s, target)
        t= t+1;
        % possible states given action
        for i = 1:4
            if prod(s-a(i))<=0 % confine the actions inside the wolrdspace
                % Pass
            elseif prod (s-a(i))>0  % update expected reward state 
                
                Re_ex(s,i)= R_ex_func(s,a(i));

                Gain(i) = Re_ex(s,i)-S(s);
            end
        end

        switch policy 
            case 0 % Q learning
                eps = 0.01;
                if  max(Gain)>=eps 
                    % if the gain is large enough, than update accroding to the
                    % maxgain
                    a_index = Gain(Gain==max(Gain));
                elseif max(Gain)<eps
                    % i the gain is too small, the go in random direction
                    a_index = randi([1,4],1,1); 
                end

                s= s+a(a_index); % update state

                S(s) = Reward(s);
            case 1 % SARSA
        end
    end 
    T(reps)= t;
    s = start;
    fprintf('reps: %d; T: %d \n', reps, t);
end    

imagesc(S);




function [hNest,hLocal] = functionsExample(v)

hNest = @nestFunction;
hLocal = @localFunction;

    function y = nestFunction(x)
        y = x + v;
    end

end

function y = localFunction(z)
y = z + 1;
end