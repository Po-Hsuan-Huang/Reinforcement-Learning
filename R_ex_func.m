%% Expected rewrad function for reinforcement learning homework.

function Reward = R_ex_func (S,s,a,i)

% s and a are matrix containin index of the state in the worldspace.
% we have to transform the two matrix into readible index.
% i denotes the motor command 
  A = s+a; 
  p = A(1,1);
  q = A(1,2);
  Reward = S(p,q,i);


