function gwinit(k)
% Initialize Gridworld and robot
%

global GWWORLD;
global GWXSIZE;
global GWYSIZE;
global GWPOS;
global GWFEED;
global GWTERM;
global GWISVALID;
global GWROBOT;
global GWGOAL;
global GWDYN;
global GWFMAPS;
global GWTMAPS;
global GWLASTFEED;
GWLASTFEED = 0;

GWWORLD = k;

GWROBOT = imread('robot.jpg');
GWGOAL = imread('goal.jpg');

GWXSIZE = 10;
GWYSIZE = 15;

GWFEED = -0.1 * ones(GWXSIZE,GWYSIZE);
GWDYN = 0;

switch k
%  case 1 % One goal only
%   GWTERM = GWFEED * 0;
%   GWTERM(4,end-2) = 1;
%  case 2 % Two goals
%   GWTERM = GWFEED * 0;
%   GWTERM(4,end-2) = 1;
%   GWTERM(3,6) = 1;
%  case 3 % Fast lane
%   GWXSIZE = 25;
%   GWYSIZE = 30;
%   GWFEED = -0.5 * ones(GWXSIZE,GWYSIZE);
%   GWTERM = GWFEED * 0;
%   GWTERM(3,end-2) = 1;
%   GWFEED(:,7:9) = -0.01;
%   GWFEED(:,20:20) = -0.01;
%   GWFEED(1:3,:) = -0.01;
%   GWFEED(16:18,:) = -0.01;
%  case 4 % Warpspace
%   GWTERM = GWFEED * 0;
%   GWTERM(4,end-2) = 1;
%   GWFEED(3,3) = 0.1234; % special warp space code
 case 1 % Annoying blob
  GWTERM = GWFEED * 0; 
  GWTERM(4,end-2) = 1;
  GWFEED(1:8,5:8) = -(0.1+0.1+0.1+0.2+11)/5;
 case 2 % Stochastic annoying blob
  GWTERM = GWFEED * 0;
  GWTERM(4,end) = 1;
  if rand < 0.2
    GWFEED(1:8,5:8) = -11;
  end
 case 3 % HG the return
  GWXSIZE = 10;
  GWYSIZE = 15;
  GWFEED = -0.5 * ones(GWXSIZE,GWYSIZE);
  GWTERM = GWFEED * 0;
  GWTERM(10,14) = 1;
  GWFEED(1:3,:) = -0.01;
  GWFEED(8:8,:) = -0.01;
  GWFEED(:,1:3) = -0.01;
  GWFEED(:,13:15) = -0.01;
 case 4 % HG the return
  GWXSIZE = 10;
  GWYSIZE = 15;
  GWFEED = -0.5 * ones(GWXSIZE,GWYSIZE);
  GWTERM = GWFEED * 0;
  GWTERM(end-2,2) = 1;
  GWFEED(1:3,:) = -0.01;
  GWFEED(8:8,:) = -0.01;
  GWFEED(:,1:3) = -0.01;
  GWFEED(:,13:15) = -0.01;
%  case 9 % Choices
%   GWXSIZE = 10;
%   GWYSIZE = 15;
%   GWFEED = -0.5 * ones(GWXSIZE,GWYSIZE);
%   GWTERM = GWFEED * 0;
%   GWTERM(end-2,2) = 1;
%   GWFEED(1:3,:) = -0.01;
%   GWFEED(5:5,:) = -0.01;
%   GWFEED(7:7,:) = -0.01;
%   GWFEED(9:9,:) = -0.01;
%   GWFEED(5,7) = -0.5;
%   GWFEED(7,7) = -0.5;
%   GWFEED(9,7) = -0.1;
%   GWFEED(:,1:3) = -0.01;  
%   GWFEED(:,13:15) = -0.01;

end




while 1
  GWPOS = ceil([rand*GWXSIZE,rand*GWYSIZE])';
  if k == 4 %8 if using all worlds
      GWPOS(1) = 10;
      GWPOS(2) = 14;
  end
  if k == 3 %7 if using all worlds
      GWPOS(1) = 8;
      GWPOS(2) = 2;
  end
  if GWTERM(GWPOS(1),GWPOS(2))
    continue
  end
  break;
end

GWISVALID = 1;


