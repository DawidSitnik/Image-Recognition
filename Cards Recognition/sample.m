%comparing bayes classifiers with 1 nearest neighbour classifier
jackknife(test)

test_normalized = test;
test_normalized(:, 2) = (test(:,2) - min(test(:,2)))/(max(test(:,2)) - min(test(:,2)));
test_normalized(:, 3) = (test(:,3) - min(test(:,3)))/(max(test(:,3)) - min(test(:,3)));
jackknife(test_normalized)

