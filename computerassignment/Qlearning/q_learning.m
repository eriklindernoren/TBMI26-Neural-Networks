clearvars;

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
g = 0.8;        % gamma - discount factor
e = 0.6;        % epsilon - exploration factor

% epsilon greedy exploration
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
            update = r + g*max(Q(new_s.pos(1), new_s.pos(2), :));
            Q(s.pos(1), s.pos(2), action) = (1 - a) * Q(s.pos(1), s.pos(2), action) + a * update;
            s = new_s;
        else
            % Penalize actions that lead to invalid positions

            % In what direction did the robot move
            ver_dir = s.pos(1) - new_s.pos(1); % 1: up, -1: down
            hor_dir = s.pos(2) - new_s.pos(2); % 1: left, -1: right
            % Did we take a delibirate action that resulted in us going
            % out of bounds our did we tumble out of bounds do to
            % stochasticy
            up = (ver_dir == 1 && action == 2); 
            down = (ver_dir == -1 && action == 1);
            left = (hor_dir == 1 && action == 4);
            right = (hor_dir == -1 && action == 3);
            % If true: Took bad action
            if up || down || left || right
                % Heavy penalty because of bad action
                Q(s.pos(1), s.pos(2), action) = -inf;
            % Else: Tumble because of stochasticy
            else
                % Risky position
                r = -2;
                update = r + g*max(Q(s.pos(1), s.pos(2), :));
                Q(s.pos(1), s.pos(2), action) = (1 - a) * Q(s.pos(1), s.pos(2), action) + a * update;
            end
        end
    end
    % update the exploration factor
    e = e - e_update;
    i
end

% Plot the Q-values
figure(1)
imagesc(Q(:,:,1))
figure(2)
imagesc(Q(:,:,2))
figure(3)
imagesc(Q(:,:,3))
figure(4)
imagesc(Q(:,:,4))
figure(5)


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
        update = r + g*max(Q(new_s.pos(1), new_s.pos(2), :));
        Q(s.pos(1), s.pos(2), action) = (1 - a) * Q(s.pos(1), s.pos(2), action) + a * update;
        s = new_s;
    else
        % Penalize actions that lead to invalid positions

        % In what direction did the robot move
        ver_dir = s.pos(1) - new_s.pos(1); % 1: up, -1: down
        hor_dir = s.pos(2) - new_s.pos(2); % 1: left, -1: right
        % Did we take a delibirate action that resulted in us going
        % out of bounds our did we tumble out of bounds do to
        % stochasticy
        up = (ver_dir == 1 && action == 2); 
        down = (ver_dir == -1 && action == 1);
        left = (hor_dir == 1 && action == 4);
        right = (hor_dir == -1 && action == 3);
        % If: Took bad action
        if up || down || left || right
            % Heavy penalty because of bad action
            Q(s.pos(1), s.pos(2), action) = -inf;
        % Else: Tumble because of stochasticy
        else
            % Risky position
            r = -2;
            update = r + g*max(Q(s.pos(1), s.pos(2), :));
            Q(s.pos(1), s.pos(2), action) = (1 - a) * Q(s.pos(1), s.pos(2), action) + a * update;
        end
    end
    n_actions = n_actions + 1;
end

% Show the number of actions needed to reach the goal
n_actions
