% what world to explore
world = 4;

% valid actions
actions = [1,2,3,4];

gwinit(world);
s = gwstate();

% initialization of Q-values
%Q = -1*rand(s.xsize, s.ysize, numel(actions));
Q = zeros(s.xsize, s.ysize, numel(actions));

% number of iterations
n_episodes  = 5000;

% parameters
a = 0.4;        % alpha - learning rate
g = 0.7;        % gamma - discount factor
e = 0.6;        % epsilon - exploration factor

% epsilon update
e_lower = 0.1;                          % the value epsilon will approach
e_update = (e - e_lower) / n_episodes;  % update factor for epsilon

% uniform probability of executing actions when exploring
prob_a = (1/numel(actions)) * ones(size(actions));

% main program loop
for i = 1:n_episodes
    % get new random starting position
    gwinit(world);
    s = gwstate();
    % traverse state space until we are at goal state
    while s.isterminal == 0
        action = choose_action(Q, s.pos(1), s.pos(2), actions, e, prob_a, [(1-e) e]);
        new_s = gwaction(action);
        if new_s.isvalid == 1
            r = new_s.feedback;
            update = a*(r + g*max(Q(new_s.pos(1), new_s.pos(2), :)));
            Q(s.pos(1), s.pos(2), action) = (1 - a) * Q(s.pos(1), s.pos(2), action) + update;
            s = new_s;
        else
            % penalize actions that lead to invalid positions
            Q(s.pos(1), s.pos(2), action) = -10;
        end
    end
    % update the exploration factor
    e = e - e_update;
    i
end


% Test agent by disabling random explorations and plotting the path
% from start to goal. Count the number of actions needed to reach the goal.
gwinit(world);
gwdraw();
s = gwstate();
n_actions = 0;
while s.isterminal == 0
    % Choose the action that maximizes the expected reward
    action = choose_action(Q, s.pos(1), s.pos(2), actions, e, prob_a, [1 0]);
    new_s = gwaction(action);
    if new_s.isvalid == 1
        gwplotarrow(s.pos, action);
        r = new_s.feedback;
        update = a*(r + g*max(Q(new_s.pos(1), new_s.pos(2), :)));
        Q(s.pos(1), s.pos(2), action) = (1 - a) * Q(s.pos(1), s.pos(2), action) + update;
        s = new_s;
    else
        Q(s.pos(1), s.pos(2), action) = -10;
    end
    n_actions = n_actions + 1;
end

% Show the number of actions needed to reach the goal
n_actions
