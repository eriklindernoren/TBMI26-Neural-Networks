% what world to explore
world = 4;

% valid actions
actions = [1,2,3,4];

% initialization of Q-values
%Q = -1*rand(s.xsize, s.ysize, numel(actions));
Q = zeros(s.xsize, s.ysize, numel(actions));

% number of iterations
n_episodes  = 5000;

a = 0.5;        % learning rate
g = 0.9;        % discount factor
e = 0.6;        % exploration factor
e_lower = 0.3;  % the value e will approach

% factor which will be subtracted from expl. factor after each iteration
e_updt_fact = (e - e_lower) / n_episodes;


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
            r = new_state.feedback;
            update = a*(r + g*max(Q(new_s.pos(1), new_s.pos(2), :)));
            Q(s.pos(1), s.pos(2), action) = (1 - a) * Q(s.pos(1), s.pos(2), action) + update;
            s = new_s;
        else
            % penalize actions that lead to invalid positions
            Q(s.pos(1), s.pos(2), action) = -3;
        end
    end
    % set Q-value for all actions from goal state to zero
    Q(s.pos(1), s.pos(2), :) = 0;
    % update the exploration factor
    e = e - e_updt_fact;
    i
end


gwinit(world);
gwdraw();
s = gwstate()
while s.isterminal == 0
    action = choose_action(Q, s.pos(1), s.pos(2), actions, e, prob_a, [1 0]);
    new_s = gwaction(action);
    if new_s.isvalid == 1
        gwplotarrow(s.pos, action);
        r = new_state.feedback;
        update = a*(r + g*max(Q(new_s.pos(1), new_s.pos(2), :)));
        Q(s.pos(1), s.pos(2), action) = (1 - a) * Q(s.pos(1), s.pos(2), action) + update;
        s = new_s;
    else
        Q(s.pos(1), s.pos(2), action) = -10;
    end
end

