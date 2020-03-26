%leave-one-out test of clslnn classifier on ts
%ts - training set (first columns is a label)
%ercf - error coeficient of cls1nn on training set ts
function ercf = jacknife(ts)
  res = zeros(rows(ts),1);
  for i=1:rows(ts)
    res(i) = cls1nn(ts(1:end ~= i, :), ts(i, 2:end));
  endfor

  ercf = mean(res ~= ts(:,1));
endfunction
