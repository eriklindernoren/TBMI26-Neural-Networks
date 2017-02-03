function gwdraw()
% Draw Gridworld and robot.
  
global GWXSIZE;
global GWYSIZE;
global GWPOS;
global GWFEED;
global GWTERM;

cla;
pause(0.2);
hold on;
title('Feedback Map');
xlabel('Y');
ylabel('X');
axis equal;
axis ij;
h = imagesc(GWFEED);
hold on;

% Create a gray rectangle for the robot
rectangle('Position',[GWPOS(2)-0.5, GWPOS(1)-0.5, 1, 1], 'FaceColor', [0.5,0.5,0.5]);

colorbar;
   
for x = 1:GWXSIZE
  for y = 1:GWYSIZE
    if GWTERM(x,y)
      % green circle for the goal
      radius = 0.5; 
      rectangle('Position',[y-0.5, x-0.5, radius*2, radius*2],...
      'Curvature',[1,1],...
      'FaceColor','g');
    end
  end
end
pause(0.2);

hold on;

    



