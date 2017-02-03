function plotCase(X,D)

[dummy,I]  = max(D);

clf;hold on
for k=1:3
   ind = I==k;
   if k==1
      plot(X(1,ind),X(2,ind),'rx');
   elseif k==2
      plot(X(1,ind),X(2,ind),'gx');
   elseif k==3
      plot(X(1,ind),X(2,ind),'bx');
   end   
end
hold off

