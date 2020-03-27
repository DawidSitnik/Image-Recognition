[train test] = load_cardsuits_data();

%outlayers deletion
%check_for_outlayers(train);
%find_outlayers(train);

%suspicted rows: 25, 393, 539, 642, 186
outlayers = [25, 393, 186];
for i =1:columns(outlayers)
  midx = outlayers(i);
  train(midx-2:midx+2, :);
end
train(outlayers, :) = [];

%feature selection
%plot2features(train, 2,4);
first_idx = 4;
second_idx = 2;
train = train(:, [1 first_idx second_idx]);
test = test(:, [1 first_idx second_idx]);

%initialization of parameters for bayesian classifiers
pdfindep_para = para_indep(train);
pdfmulti_para = para_multi(train);
pdfparzen_para = para_parzen(train, 0.001);

%bayessian classification on the full dataset
base_ercf = zeros(1,2);
base_ercf(1) = mean(bayescls(test(:,2:end), @pdf_indep, pdfindep_para) != test(:,1));
base_ercf(2) = mean(bayescls(test(:,2:end), @pdf_multi, pdfmulti_para) != test(:,1));
%base_ercf(3) = mean(bayescls(test(:,2:end), @pdf_parzen, pdfparzen_para) != test(:,1));
base_ercf

%checking bayes classifier accuracy while training on smaller datasets
parts = [0.1 0.25 0.5];
%parts = [1];

labels = unique(train(:,1));
base_ercf_parts = zeros(labels,2);

rep_cnt=6
bayes_indep = zeros(columns(parts), rep_cnt)
bayes_multi = zeros(columns(parts), rep_cnt)
bayes_parzen = zeros(columns(parts), rep_cnt)

%apriori probability
%apriori = [0.165, 0.085, 0.085, 0.165, 0.165, 0.085, 0.085, 0.165]
%apriori = [0.125, 0.125, 0.125, 0.125, 0.125, 0.125, 0.125, 0.125]


%while we are working on random dataset, it is better to repeat this process few times and callculate average of the outcomes
for j = 1:6
  %calculating accuracies on each part of training table defined in parts array
  for i = 1:columns(parts)
    _parts = repmat(parts(i), 1, rows(labels))
    %_parts = [1.0 0.5 0.5 1.0 1.0 0.5 0.5 1.0]
    train_part = reduce(train, _parts)
    
    pdfindep_para = para_indep(train_part);
    pdfmulti_para = para_multi(train_part);
    %pdfparzen_para = para_parzen(train_part, 0.001);

    bayes_indep(i,j) = mean(bayescls(train_part(:,2:end), @pdf_indep, pdfindep_para) != train_part(:,1));
    bayes_multi(i,j) = mean(bayescls(train_part(:,2:end), @pdf_multi, pdfmulti_para) != train_part(:,1));
    %bayes_parzen(i,j) = mean(bayescls(train_part(:,2:end), @pdf_parzen, pdfparzen_para) != train_part(:,1));
  end
end

bayes_indep_parts = zeros(columns(parts), 1);
bayes_multi_parts = zeros(columns(parts), 1);

%callculating mean of obtained values
for i = 1:columns(parts)
  bayes_indep_parts(i,1) = mean(bayes_indep(i, :));
  bayes_multi_parts(i,1) = mean(bayes_multi(i, :));
  %bayes_parzen_parts(i,1) = mean(bayes_parzen(i, :));
end


%calculating confusion matrix for one of the classifiers
%parts = [1.0 0.5 0.5 1.0 1.0 0.5 0.5 1.0];
parts = [1.0 0.5 0.5 1.0];
%apriori = [0.165, 0.085, 0.085, 0.165, 0.165, 0.085, 0.085, 0.165]
apriori = [0.165, 0.085, 0.085, 0.165]


%checking influence of parzen window size on classification
parzen_widths = [0.5, 0.01, 0.005, 0.001, 0.0005, 0.0001];
parzen_res = zeros(1, columns(parzen_widths));
semilogx(parzen_widths, parzen_res)

for i = 1:columns(parzen_widths)
    pdfparzen_para = para_parzen(train, parzen_widths(i));
    parzen_res(1,i) = mean(bayescls(test(:,2:end), @pdf_parzen, pdfparzen_para) != test(:,1))   
end


test_part = reduce(test, parts)
confMx(test_part(:,1), bayescls(test_part(:,2:end), @pdf_indep, pdfindep_para, apriori))

%comparing bayes classifiers with 1 nearest neighbour classifier
jackknife(test)

%1-nn classifier with normalization
test_normalized = test;
test_normalized(:, 2) = (test(:,2) - min(test(:,2)))/(max(test(:,2)) - min(test(:,2)));
test_normalized(:, 3) = (test(:,3) - min(test(:,3)))/(max(test(:,3)) - min(test(:,3)));
jackknife(test_normalized)