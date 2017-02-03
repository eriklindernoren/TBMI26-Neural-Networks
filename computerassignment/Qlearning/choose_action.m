function [ action opt_action] = choose_action( Q,state_x,state_y,...
    actions,eps,prob_a,prob )

 %Check the optimal action
    Q_values=Q(state_x,state_y,:);
    [Q_opt index_opt]=max(Q_values);
        
    opt_action=index_opt;        
    rand_action=sample(actions,prob_a);
        
    pos_actions=[opt_action rand_action];
            
    action_index=sample(pos_actions,prob);
    action=pos_actions(action_index); 


end

