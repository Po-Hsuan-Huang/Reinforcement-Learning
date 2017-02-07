%%
% Q Learning (Framework only)
%
% Fill in code at the marked positions.
% 
% Author: Nicolas Ludolph (06/2015)
% Edited By:
%%
clear all
%% Simulation Constants
sim_const();
%% Action Space (definitions)
left  = 1;
up    = 2;
right = 3;
down  = 4;
A  = [left up right down];
nA = length(A);
%% Frequency of state visits (stats)
Sa = zeros(4*12,1);
%% 
% Field: width=12 height=4
% State Encoding: y*12+x
Q = zeros(4*12,nA,maxEpisodes);
%% 
R = zeros(1, maxEpisodes);
for episode=1:maxEpisodes
    if episode>1
        Q(:,:,episode) = Q(:,:,episode-1);
    end

    % initial state
    xt = 1;
    yt = 1;
    
    % simulate one episode
    iterations = 0;
    while ~((yt==1 && xt==12) || (yt==1 && (2<=xt && xt<=11))) && iterations < 10^8  % goal or cliff
        % frequency of state visits (stats)
        Sa((yt-1)*12 + xt,1) = Sa((yt-1)*12 + xt,1) + 1;
        
        % action selection
        if rand()>eps
            % greedy action selection
            
            % ---FILL IN CODE HERE----
            % mQt: Q value of the selected action
            % at:  selected action
            % -------
            
            % randomly select one action if there are more than one with
            % the same Q value
            atSameQ = find(Q((yt-1)*12 + xt, :, episode) == mQt);
            if length(atSameQ)>1
                rndIdx = randperm(length(atSameQ),1);
                at = atSameQ(rndIdx);
            end
        else
            % epsilon exploration
            
            % ---FILL IN CODE HERE----
            % at:  randomly selected action
            % -------
        end
        
        % state transition
        xt1 = xt;
        yt1 = yt;
        if at==left
            xt1 = xt - 1;
            xt1 = max(1, xt1); 
        elseif at==up
            yt1 = yt + 1;
            yt1 = min(4, yt1); 
        elseif at==right
            xt1 = xt + 1;
            xt1 = min(12, xt1); 
        elseif at==down
            yt1 = yt - 1;
            yt1 = max(1, yt1); 
        end
        
        % providing reward
        rt = -1; % all non-goal / -cliff states
        if yt1==1 && (2<=xt1 && xt1<=11)
            rt = -100; % cliff
        elseif yt1==1 && xt1==12
            rt = 0;    % goal
        end
        
        % calculte td error
        
        % ---FILL IN CODE HERE----
        % current state: (yt-1)*12 + xt
        % current action: at
        % current reward: rt
        % next state: (yt1-1)*12 + xt1
        % discount factor: gamma
        %
        % set the following variables:
        % Qt:  Q value of this time step
        % tderr: time difference error
        % -------
        
        % update Q
        Q((yt-1)*12 + xt, at, episode) = Qt + alpha * tderr;
        
        % stats...
        R(1,episode) = R(1,episode) + rt;
        
        % iterate...
        xt = xt1;
        yt = yt1;
        
        % prevent endless loop
        iterations = iterations + 1;
    end
    
    % progress report
    fprintf('Episode %i done.\n', episode);
end


%%
qlearn_R  = R;
qlearn_Sa = Sa;
qlearn_Q = Q;

save('qlearn.mat', 'qlearn_R', 'qlearn_Sa', 'qlearn_Q');

clear all;

load('qlearn.mat');


