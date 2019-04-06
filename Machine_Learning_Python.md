# Machine Learning Code With Python
```
import sklearn
```
## GridSearch
```python
from sklearn.model_selection import GridSearchCV
from sklearn.neighbors import KNeighborsRegressor
clfKN = GridSearchCV(KNeighborsRegressor(),
 param_grid={"n_neighbors":np.arange(3,50)})
# Fit will test all of the combinations
clfKN.fit(X,y)


print(clfKN.best_score_)
print(clfKN.best_params_)
```

## Regression

### Linear Regression
```python
# Load the library
from sklearn.linear_model import LinearRegression
# Create an instance of the model
reg = LinearRegression()
# Fit the regressor
reg.fit(X,y)
# Do predictions
reg.predict([[2540],[3500],[4000]])
```

### k nearest neighbor
parameters: n_neighbors
```python
# Load the library
from sklearn.neighbors import KNeighborsRegressor
# Create an instance
regk = KNeighborsRegressor(n_neighbors=2)
# Fit the data
regk.fit(X,y)
```
### Decision Tree
Max_depth: Number of Splits
Min_samples_leaf: Minimum number of observations per leaf
```python
# Load the library
from sklearn.tree import DecisionTreeRegressor
# Create an instance
regd = DecisionTreeRegressor(max_depth=3)
# Fit the data
regd.fit(X,y)
```

### Metrics

MAE/MAPE
RMSE
CON/Bias

## Classification

### Logisitc Regression
```python
# Load the library
from sklearn.linear_model import LogisticRegression
from sklearn.model_selection import cross_val_score

# Create an instance of the classifier
clfLR=LogisticRegression()

# Fit the data
clfLR.fit(X,y)

cross_val_score(clfLR,X,y,  cv=5,scoring = 'accuracy').mean()
```
### k nearest neighbor
```python
# Import Library
from sklearn.model_selection import GridSearchCV
from sklearn.neighbors import KNeighborsClassifier

# Create instance
clfKN = GridSearchCV(KNeighborsClassifier(),
                  param_grid = {"n_neighbors":np.arange(3,50)},
                  cv=5,
                  scoring="accuracy")
                     
                      
# Fit will test all of the combinations
clfKN .fit(X,y)


print(clfKN.best_params_)
print(clfKN.best_score_)
```
### Decision Tree
```python
# Import Library
from sklearn.model_selection import GridSearchCV
from sklearn.tree import DecisionTreeClassifier

# Create instance
clfDT = GridSearchCV(DecisionTreeClassifier(),
                  param_grid = {"min_samples_leaf":np.arange(3,50),"max_depth":np.arange(1,4)},
                  cv=5,
                  scoring="accuracy")
                     
                      
# Fit will test all of the combinations
clfDT .fit(X,y)


print(clfDT.best_params_)
print(clfDT.best_score_)
```
### Metrics

Accurary
AUC  roc curve
Precision/Recall
