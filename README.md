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

<p align="center">
  <img src = "https://imgur.com/UmSqwER.png"/>
</p>

<p align="center">
  <img src = "https://imgur.com/aFYjWq7.png"/>
</p>

<p align="center">
  <img src = "https://imgur.com/Gw0mmsq.png"/>
</p>
