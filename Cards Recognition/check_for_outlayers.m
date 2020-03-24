function outlayers = check_for_outlayers(df)
  labels = unique(df(:,1));
  outlayers = cell(columns(df)-1,1);
  for j = 1:rows(labels)
  df = df(df(:,1) == labels(j), 1:end);
    for i =2:columns(df);
      mean_value = mean(df(:,i));
      std_value = std(df(:,i));
      outlayers{i, j} = find(((df(:,i) < (mean_value - std_value)) | (df(:,i) > (mean_value + std_value))));
    end
  end




end
%teraz tak, jeśli sprawdzimy wartości tą funkcją dla każdej klasy oddzielnie to nie dostaniemy żadnych outlayerów, wygląda na to, że wiersz 186 nie wyróżnia się aż tak na poziomie swojej klasy
%jeśli natomiast wykonamy funkcję bez podziału na klasy otrzymamy wartość wiersz 186 któremu warto się przyjrzeć
