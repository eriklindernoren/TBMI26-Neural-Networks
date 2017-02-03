function plotData(X,I,I2)
   c='xo+*sd';
   hold on
   for k=1:6
      ind     = (I == k) & (I == I2);
      ind_err = (I == k) & (I ~= I2);
      plot(X(1,ind),X(2,ind),strcat('g',c(k)));
      plot(X(1,ind_err),X(2,ind_err),strcat('r',c(k)));
   end
   hold off
end

