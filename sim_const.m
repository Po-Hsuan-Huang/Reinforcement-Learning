%%
% Constants for Q Learning and SARSA Simulation in the Cliff Walk Example
%
% Feel free to try out different values
%
% Author: Nicolas Ludolph (06/2015)
% Edited By:
%% Constants (feel free to change)
eps = 0.1;   % epsilon (for the epsilon-greedy policy)

%% Constants (no change necessary)
gamma = 1.0; % discounting (1.0 = no discounting)
alpha = 0.3; % learning rate
maxEpisodes = 500; % number of simulated episodes

%% Initialization for the Random Number Generation
% (Makes it easier to compare students solutions)
% No change necessary
rng(999);