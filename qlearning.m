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

    xt = 1;
    yt = 1;
    
    % simulate one episode
    iterations = 0;
    while ~((yt==1 && xt==12) || (yt==1 && (2<=xt && xt<=11))) && iterations < 10^8  % goal or cliff
        % frequency of state visits (stats)
        Sa((yt-1)*12 + xt,1) = Sa((yt-1)*12 + xt,1) + 1;
        
        % action selection
        if rand()>eps
            % greedy
            [mQt,at] = max(Q((yt-1)*12 + xt, :, episode));
            atSameQ = find(Q((yt-1)*12 + xt, :, episode) == mQt);
            if length(atSameQ)>1
                rndIdx = randperm(length(atSameQ),1);
                at = atSameQ(rndIdx);
            end
        else
            % epsilon exploration
            at = randperm(4,1);
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
        
        % td err:
        % ----------------------------------------------------------------
        % calculate Q values
        Qt  = Q((yt-1)*12  + xt, at, episode);
        Qt1 = max(Q((yt1-1)*12 + xt1, :, episode));
        
        tderr = rt + gamma * Qt1 - Qt;
        % ----------------------------------------------------------------
        
        % update Q
        Q((yt-1)*12 + xt, at, episode) = Qt + alpha * tderr;
        
        R(1,episode) = R(1,episode) + rt;
        
        % iterate...
        xt = xt1;
        yt = yt1;
        
        %
        iterations = iterations + 1;
    end
    
    % progress report
    fprintf('Episode %i done.\n', episode);
end


%%
qlearn_R  = R;
qlearn_Sa = Sa;
qlearn_Q = Q;

save('qlearn.mat', 'qlearn_R', 'qlearn_Sa', 'qlearn_Q', 'eps', 'alpha');

clear all;

load('qlearn.mat');


