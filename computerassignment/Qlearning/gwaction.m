function s = gwaction(action)
% state = gwaction(action)
% Let the robot perform an action and then return the resulting robot state.
%  
% action           - integer, moves the robot, 1=down, 2=up, 3=right and 4=left
% 
% state.feedback   - robot reinforcement for this action
% state.pos        - robot position after action
% state.isterminal - 1=robot reached goal, 0=goal not reached
% state.isvalid    - 1=action valid, 0=action invalid 
%
% Typical reasons for invalid actions is when the robot bumps into
% a wall. When this happens, simply ignore all state variables and
% perform another (hopefully) valid action.
%
  
global GWWORLD;
global GWPOS;
global GWXSIZE;
global GWYSIZE;
global GWFEED;
global GWTERM;
global GWISVALID;
global GWDYN;
global GWFMAPS;
global GWTMAPS;
global GWLASTFEED;

%GWLASTFEED = GWFEED(GWPOS(1),GWPOS(2));

if GWTERM(GWPOS(1),GWPOS(2))
  GWISVALID = 0;
  s = gwstate;  
  return
end

if GWWORLD == 4 % HG the return
    if rand < 0.3
        action = sample([1,2,3,4],[0.25,0.25,0.25,0.25]);
    end
end

next_position = GWPOS + [(action==1) - (action==2),(action==3) - (action==4)]';


if sum(next_position(2)<1 | next_position(2)>GWYSIZE | ...
       next_position(1)<1|next_position(1)>GWXSIZE)
  GWISVALID = 0;
else
  GWISVALID = 1;
  GWPOS = next_position;
end

if GWFEED(GWPOS(1),GWPOS(2)) == 0.1234;
  GWPOS = [6 14]';
end

    
    

GWLASTFEED = GWFEED(GWPOS(1),GWPOS(2));

s = gwstate;
if GWDYN > 0
  if s.feedback == 10;
    p = size(GWFMAPS,3);
    q = GWDYN - 1;
    q = mod(q + 1,p);
    GWDYN = q + 1;
    GWFEED = GWFMAPS(:,:,GWDYN);
    GWTERM = GWTMAPS(:,:,GWDYN);
  end
end


