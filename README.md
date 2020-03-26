# Card Classification With Optimal Bayes Classifiers

Bayes Calssifiers are implemented in files:
* **pdf_indep.m** - classifiers which treats every attribute independely while calculating pdf
* **pdf_multi.m** - classifier which takes into account all of the attributes while classification
* **pdf_para.m** - classifier with Parzen window
* **para_indep.m** - support function for pdf_indep
* **para_multi.m** - support function for pdf_multi
* **para_parzen.m** - support function for pdf_parzen

## Dataset 
Dataset contains combination of two datasets, each containing 4 class of cards represented by image moments. Being aware that used dataset haven't been normalized we got 8 classes overall.

### Outlayers
While outlayers identification the process was based mainly on calculatting means, medians, min, max, std values for each
class, flagging suspicious rows and inspecting them manually. 

The exact procedures made were:
* callculating min and max values for each class
* finding rows with the biggest and smallest mean for each class
* for each attribute, flagging rows with values spaced for more than standard deviation value from the mean
* repeating previous step but with additional split for classes

After identifying selected samples manually, rows which were considered as outlayers were: 25, 393, 186.

At the pictures we can see each row and its surrounding neighbours. The outlayer row is alway in the middle.

For the 25th row we can see, that its values in 2nd, 4th and 6th columns are significantly smaller than in corresponding columns in neighbours rows. Even though this case isn't drastic, I decided to exclude it from the training dataset.
<p align="center">
  <img src = "https://imgur.com/UmSqwER.png"/>
</p>

In the case of row 186, each value of its column if much bigger than the rest.
<p align="center">
  <img src = "https://imgur.com/aFYjWq7.png"/>
</p>

In this case, the value of 5th columns was spaced further than std for the column form the middle value of the column. Even though this case also might not be an anomaly, deletion of one more row will not significantly decrease the size of training set, so this row was also deleted.
<p align="center">
  <img src = "https://imgur.com/Gw0mmsq.png"/>
</p>

## Feature Selection
The next step is feature selection. For our case I decided to plot distribution of the points taking into consideration only two attributes. This process was repeated for each possible pair of the attributes and two the best results can be seen at the pictures bellow. 

For attributes 2 and 4
<p align="center">
  <img src = "https://imgur.com/sbRgAmn.png"/>
</p>

For attributes 2 and 5
<p align="center">
  <img src = "https://imgur.com/4rZzyg9.png"/>
</p>

Better separation was obtained for the pair 2 and 4, so in the next part of our process the data will be limited only to those two features. 

## Classification
### Bayesian Classifiers
Firstly the classifiers has been tested on full length of datasets but containing features to chosen in previous part. Apriori of each class equaled to 1/(number of clases).

**Obtained Results (mean errors)**
* pdf_indep = 0.0279605
* pdf_multi = 0.0038377
* pdf_parzen = 

Than the classification was tested only on the part of the length of the dataset. Because deleted rows were rejected randomly, the classification process was repeated 6 times for each classifiers and obtained result is the mean of those 6 attemps.

The parts on which classifiers were trained has [0.1 0.25 0.5] of total amount of samples and each class has the same amount of samples deleted.

**Obtained Results (mean errors)**

size = 0.1 of training data:
* pdf_indep = 0.0081104
* pdf_multi = 0.0025344
* pdf_parzen =

size = 0.25 of training data:
* pdf_indep = 0.0076888
* pdf_multi = 0.0018925
* pdf_parzen =

size = 0.5 of training data:
* pdf_indep = 0.0024620
* pdf_multi = 0.0000000
* pdf_parzen =

At the end classification process was repeated with apriori = [0.165, 0.085, 0.085, 0.165, 0.165, 0.085, 0.085, 0.165], taking into account [1.0 0.5 0.5 1.0 1.0 0.5 0.5 1.0] number of samples from each class respectively.

**Obtained Results (mean errors)**
* pdf_indep = 0.0012163
* pdf_multi = 0.00000
* pdf_parzen = 

For the better understanding of the result there is a confusion matrix for the last case of pdf_indep classifier:
<p align="center">
  <img src = "https://imgur.com/yKJJqat.png"/>
</p>

Form that picture we can deduce classification errors:
* 1 sample of class 4 was classified as class 1
* 1 sample of class 4 was classified as class 3
* 4 samples of class 3 were classified as class 6


### 1-NN Classifier
At the end the testing dataset was also classified with 1 nearest neighbour classifier. 

**Obtained Results (mean errors)**
* before normalization: 0.014254
* after normalization: 0.0027412

*Formula used for normalization: (df(:,2) - min(df(:,2)))/(max(df(:,2)) - min(df(:,2)));*

**At the end the whole process of classification was repeated for the same data but using only 4 features. As it was said before, the full dataset consist of two subsets from different sources so it is better to treat their classes separatelly. Lets check what happens if we ignore this issue.

**Obtained Results (mean errors)**

size = 1.0 of training data:
* pdf_indep: 0.197368
* pdf_multi: 0.049342
* pdf_parzen: 

size = 0.1 of training data:
* pdf_indep = 0.17824
* pdf_multi = 0.033255
* pdf_parzen =

size = 0.25 of training data:
* pdf_indep = 0.17862
* pdf_multi = 0.034846
* pdf_parzen =

size = 0.5 of training data:
* pdf_indep = 0.17141
* pdf_multi = 0.025353
* pdf_parzen =

1-NN, for full dataset:
* before normalization: 0.0098684
* after normalization: 5.4825e-04

## Summary
* For the chosen dataset, the best choice for the classifier was pdf_multi
* The bigger training set is used, the better classifier we get
* Data normalization significantly brightened 1-NN classifier
* It was puproseful to use 8 classes while classification, however limiting its number to 4 doesn't soften the result that much
* Taking into consideration appriori may strenghten our classifier
