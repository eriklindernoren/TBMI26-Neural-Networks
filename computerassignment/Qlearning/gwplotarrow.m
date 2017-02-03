function gwplotarrow(position, action)
% gwplotarrow(position, action)
%
% Plots an arrow at position given the action. Same encoding of
% actions as in gwaction. Useful for plotting the behaviour of an
% optimal policy given a Q-function.
  
hold on;
if action == 0
    scatter(position(1),position(2),5,'b','filled');
else
    hold on;
    if action == 1
      symb = 'rv';
      next_position = [position(1) position(2)]' + 0.5*[1 0]';
    elseif action == 2
      symb = 'r^';
      next_position = [position(1) position(2)]' + 0.5*[-1 0]';
    elseif action == 3
      symb = 'r>';
      next_position = [position(1) position(2)]' + 0.5*[0 1]';
    elseif action == 4
      symb = 'r<';
      next_position = [position(1) position(2)]' + 0.5*[0 -1]';
    end
    plot([position(2),next_position(2)], [position(1),next_position(1)],'r');
    plot([next_position(2)], [next_position(1)],symb);
    %        scatter(next_position(1),next_position(2),5,'r', 'filled');
end



    
    