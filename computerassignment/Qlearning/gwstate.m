function s = gwstate()
% gwstate
%
% Return the state resulting from the last robot action.
  
global GWPOS;
global GWXSIZE;
global GWYSIZE;
global GWFEED;
global GWLASTFEED;
global GWTERM;
global GWISVALID;


s = struct('xsize',GWXSIZE, ...
	   'ysize',GWYSIZE, ...
	   'pos', GWPOS, ...
	   'isterminal', GWTERM(GWPOS(1),GWPOS(2)), ...
	   'isvalid', GWISVALID, ...
	   'feedback', GWLASTFEED);

%s.xsize = GWXSIZE;
%s.ysize = GWYSIZE;
%s.pos = GWPOS;
%s.isterminal = 
%s.isvalid = 
%s.feedback = 

