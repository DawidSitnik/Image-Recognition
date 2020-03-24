function [outlayers_min, outlayers_max, outlayers_min_mean, outlayers_max_mean] = pdf_parzen(df)

  outlayers_min = [];
  outlayers_max = [];

  a=0
  for i=2:columns(df)
    [~, idx] = min(df(:,i));
    outlayers_min(i-1) = idx;

    [~, idx] = max(df(:,i));
    outlayers_max(i-1) = idx;

  end

  [~, idx] = min(mean(df(:, 2:columns(df)), 2));
  outlayers_min_mean = idx;

  [~, idx] = max(mean(df(:, 2:columns(df)), 2));
  outlayers_max_mean = idx;

  outlayers_max = unique(outlayers_max);
  outlayers_min = unique(outlayers_min);


end

%po wyliczeniu sredniej dla kazdego wiersza wychodzi, że wartością o najmniejszej średniej jest 642 (wartość ta też pojawiła się w outlayers_min)
%a największą wartość średnią ma row o indexie 186, ktory za to pojawił się w outlayers_max
%te dwa wiersze uznałbym za outlayersy
