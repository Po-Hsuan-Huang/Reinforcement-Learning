%%
% NO CHANGES NEED TO BE MADE!
% 
% Author: Nicolas Ludolph (06/2015)
% Edited By:
%% Simulation
clear all;
qlearning();
clear all;
sarsalearning();

%% Load simulation results
clear all;
load('qlearn.mat');
load('sarsa.mat');
%% Plot frequency of state visits
figure;
subplot(2,1,1);
show_satab( qlearn_Sa );
title(' Q-Learning ');
subplot(2,1,2);
show_satab( sarsa_Sa );
title(' SARSA ');

%% Plot Q Function
figure;
subplot(2,1,1);
show_qtab( qlearn_Q, 400 );
title(' Q-Learning ');
subplot(2,1,2);
show_qtab( sarsa_Q, 400 );
title(' SARSA ');

%% Plot return (smoothed)
figure;
hold on;
plot( smooth(qlearn_R,0.2,'lowess'),'b', 'DisplayName', 'Q-Learning' );
plot( smooth(sarsa_R,0.2,'lowess'),'r',  'DisplayName', 'SARSA' );

ylabel(' smoothed Return ');
xlabel(' Episode ');

legend('show','Location','southeast');

ylim([-100 -10]);







