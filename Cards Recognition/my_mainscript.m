[train test] = load_cardsuits_data();

check_for_outlayers(train);
find_outlayers(train);

%po przebadaniu danych, podejrzane próbki to: 25, 393, 539, 642, 186
outlayers = [25, 393, 186];
for i =1:columns(outlayers)
  midx = outlayers(i)
  train(midx-2:midx+2, :)
  train(midx, :) = [];
end
