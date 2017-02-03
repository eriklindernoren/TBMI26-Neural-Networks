function coords = draw(fig, npoints)

if nargin < 1
  fig = gcf;
end

if nargin < 2
  npoints = 20;
end

figure(fig);
clf;
axis([0 1 0 1]);
set(fig, 'DoubleBuffer', 'On');
set(gca,'XTick',[])
set(gca,'YTick',[])
hold on;
axis manual;

set(fig, 'WindowButtonDownFcn', 'mousePressed');
set(fig, 'WindowButtonUpFcn', 'mouseReleased');

ud = cell(2);
ud{1} = timer('timerfcn', @disableDrawing, 'startdelay', 1);
set(fig, 'UserData', ud);

while(length(get(fig, 'WindowButtonDownFcn')) > 0); 
  pause(0.1);
end

hold off;

ud = get(fig, 'UserData');
p = ud{2};
set(fig, 'UserData', []);

diff = p(2:end,:)-p(1:end-1,:); % difference between coordinates
dist = sqrt(sum(diff.^2,2));    % Euclidean distance between the points
t = [0 cumsum(dist)']/sum(dist); % Normalized curve parameters (0-1)
duplets = t(1:end-1)==t(2:end); % find non-distinct data points
ind = find(~duplets);          % Index to no-duplets
ind = [ind ind(end)+1];        % Add the last point
tt = linspace(0, 1, npoints);
x(1,:) = spline(t(ind),p(ind,1),tt);
x(2,:) = spline(t(ind),p(ind,2),tt);

coords = x;
coords = coords + 0.001*var(coords(:))*randn(size(coords));

% ---


function mouseMoved()

cp = get(gca,'CurrentPoint'); % Get cursor position
p = cp(1,1:2);          % Cursor coordinate
plot(p(1),p(2),'.');

ud = get(gcf, 'UserData');
ud{2} = [ud{2}; p];
set(gcf, 'UserData', ud);


% ---


function mousePressed()

cp = get(gca,'CurrentPoint'); % Get cursor position
p = cp(1,1:2);          % Cursor coordinate
plot(p(1),p(2),'.');

ud = get(gcf, 'UserData');
ud{2} = [ud{2}; p];
set(gcf, 'UserData', ud);

stop(ud{1});

set(gcf, 'WindowButtonMotionFcn', 'mouseMoved');


% ---


function mouseReleased()

ud = get(gcf, 'UserData');
start(ud{1});

set(gcf, 'WindowButtonMotionFcn', []);


% ---


function disableDrawing(foo, bar)

set(gcf, 'WindowButtonDownFcn', '');
set(gcf, 'WindowButtonUpFcn', '');
set(gcf, 'WindowButtonMotionFcn', '');

