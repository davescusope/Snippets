# Machine Learning Code With Python
```
import sklearn
```
### GridSearch
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


### Serializar el modelo
```python
import pickle
#se indica el modelo ya cargado(clfDT) , extensión del modelo pickle o pkl e indicar que sea escritura y binary
pickle.dump(clfDT,open("modelo.pickle","wb"))
#se carga el modelo ya guardado, extesión pickle o pkl indicando que sea lectura y binary
clf_loaded = pickle.load(open("modelo.pickle","rb"))

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

#La regresión no tiene parametros para hacer el GridSearch, por lo que simplemente se hace cross validation
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
                  scoring="accuracy",
                  verbose=9)
                     
                      
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
                  scoring="accuracy",
                  verbose=9)
                     
                      
# Fit will test all of the combinations
clfDT .fit(X,y)


print(clfDT.best_params_)
print(clfDT.best_score_)
```
### Random Forest
```python
# Import Library
from sklearn.model_selection import GridSearchCV
from sklearn.ensemble import RandomForestClassifier

# Create instance
clfRF = GridSearchCV(RandomForestClassifier(n_jobs=-1),
                  param_grid = {"min_samples_leaf":np.arange(3,50),"max_depth":np.arange(1,4),"n_estimators":[10,100,1000]},
                  cv=5,
                  scoring="accuracy",
                  verbose=9)
                     
                     
# Fit will test all of the combinations
clfRF .fit(X,y)


print(clfRF.best_params_)
print(clfRF.best_score_)
```


### SVM
```python
# Import Library
from sklearn.model_selection import GridSearchCV
from sklearn.svm import SVC

# Create instance
clfSVM = GridSearchCV(SVC(kernel="poly",),
                  param_grid = {"C":np.arange(10,100),"degree":np.arange(1,5)},
                  cv=5,
                  scoring="accuracy")
                     
                      
# Fit will test all of the combinations
clfSVM .fit(X,y)


print(clfSVM.best_params_)
print(clfSVM.best_score_)
```

### Metrics

#Accurary
#AUC(Area under the Curve
#Precision/Recall
