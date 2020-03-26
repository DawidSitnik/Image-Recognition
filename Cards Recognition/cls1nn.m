%1-nn clasifier of x on training set ts^M
%ts - training set (first column contains label)^M
%x - sample to be classified into label (no label here)^M

function lab = cls1nn(ts, x)
  sqdist = sumsq(ts(:,2:end) - x, 2);
  [mv, mi] = min(sqdist);
  lab=ts(mi, 1);
endfunction
