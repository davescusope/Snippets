# Machine Learning Code With Python
```
import sklearn
```

# Support code

### Separación Train-Test
```python
# Import Library
from sklearn.model_selection import train_test_split

# Create Instance
X_train, X_test, y_train, y_test = train_test_split(X,y, test_size=0.10 , random_state = 42)
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


### Confusion Matrix (true possitives, true negatives, false possitives, false negatives)

```python
from sklearn.metrics import confusion_matrix
import seaborn as sns

#Se genera la matriz de confusión sobre los dos df's a tratar, el test y la predicción
confusion_matrix(y_test,clfk.predict(X_test))

#Se visualiza la matriz de confusión en un heatmap
sns.heatmap(confusion_matrix(y_test,clfk.predict(X_test)))
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



# Regression

### Linear Regression
Parameters: 
* no parameters

```python
# Load the library
from sklearn.linear_model import LinearRegression
# Create an instance of the model
regL = LinearRegression()
# Fit the regressor
regL.fit(X,y)
# Do predictions
regL.predict([[2540],[3500],[4000]])
```

### k nearest neighbor
parameters
* n_neighbors

```python
# Load the library
from sklearn.neighbors import KNeighborsRegressor
# Create an instance
regKN = KNeighborsRegressor(n_neighbors=2)
# Fit the data
regKN.fit(X,y)
```
### Decision Tree
parameters:

* Max_depth: Number of Splits
* Min_samples_leaf: Minimum number of observations per leaf
```python
# Load the library
from sklearn.tree import DecisionTreeRegressor
# Create an instance
regDT = DecisionTreeRegressor(max_depth=3)
# Fit the data
regDT.fit(X,y)
```

## Metrics

* MAE (suma los valores y errores absolutos)
``` python
mean_absolute_error(y_test,pred)
np.mean(np.abs(y_test-pred))
```
* MAPE # metrica MAPE (suma los valores y errores absolutos, y los pondera o divide por el total de los valores)
``` python
np.mean(np.abs(y_test-pred)/y_test)
```
* RMSE
* CON/Bias

# Classification

### Logisitc Regression
Parameters: 
* No parameters

```python
# Load the library
from sklearn.linear_model import LogisticRegression
from sklearn.model_selection import cross_val_score

# Create an instance of the classifier
clfLR=LogisticRegression()

# Fit the data
clfLR.fit(X,y)

# Validación cruzada (la regresión no tiene parametros para GridSearch)
cross_val_score(clfLR,X,y,  cv=5,scoring = 'accuracy').mean()
```
### k nearest neighbor
Parameters: 
* n_neighbors

#### Sin GridSearch
```python
# Load the library
from sklearn.neighbors import KNeighborsClassifier

# Create an instance
clfKN = KNeighborsClassifier(n_neighbors=2)

# Fit the data
clfKN.fit(X,y)
```

#### Con GridSearch

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
Parameters:
* Max_depth: Number of Splits
* Min_samples_leaf: Minimum number of observations per leaf

#### Sin GridSearch
```python
# Import Library
from sklearn.tree import DecisionTreeClassifier

# Create instance
clfDT = DecisionTreeClassifier(min_samples_leaf=20,max_depth=3)

# Fit
clfDT.fit(X,y)
```

#### Con GridSearch
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
                  param_grid = {"min_samples_leaf":[10,20,30,40,50],
                               "max_depth":np.arange(1,4),
                               "n_estimators":[50]},
                  cv=5,
                  scoring="accuracy",
                  verbose=9)
                     
                     
# Fit will test all of the combinations
clfRF .fit(X,y)


print(clfRF.best_params_)
print(clfRF.best_score_)
```


### GradientBoostingTrees
Parameters:
* max_depth
* learning_rate(ritmo de ruido para evitar overfitting

```python
# Import Library
from sklearn.model_selection import GridSearchCV
from sklearn.ensemble import GradientBoostingRegressor

# Create instance
clfGBT = GridSearchCV(GradientBoostingRegressor(n_estimators=100),
                  param_grid={"max_depth":np.arange(2,10),
                             "learning_rate":np.arange(1,10)/10},
                  cv=5,
                  scoring="neg_mean_absolute_error")
                  verbose=9)   
                     
# Fit will test all of the combinations
clfGBT .fit(X,y)


print(clGBT.best_params_)
print(clGBT.best_score_)
```



### SVM
Parameters:
* C: Sum of Error Margins
* kernel:
 * linear: line of separation
 * rbf: circle of separation
    * Additional param gamma: Inverse of the radius
 * poly: curved line of separation
    * Additional param degree: Degree of the polynome
    
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

## Metrics

```python

sorted(sklearn.metrics.SCORERS.keys())
```
* Accurary
* AUC(Area under the Curve ROC)
* Precision/Recall
