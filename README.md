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




