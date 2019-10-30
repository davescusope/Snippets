# R Functions & Machine Learning Snippets 


## 1. Modelos 

Un modelo es una previsión teórica de valores (PREV) basada en correlaciones matemáticas de unos valores originales (TRAIN).

Todo modelo tiene errores, los cuales son añadidos a todos los modelos estadisticos
Un error es aquello que el modelo no puede explicar, por lo que el error no esta en el dato, está en el modelo.

	- Usaremos modelos para definir que esta pasando (modelo descriptivo)
	- Usaremos modelos para ver que va a pasar (pmodelo predictivo)
	
rmse 	-> 	Es una medida para modelos de validacion, que es la raiz cuadrada 
		de la media del cuadrado de restar dos valores o distancia para ver 
		para medir como se alejan los valores precedidos de los valores reales
		
		sqrt(sum((x - mean(x))^2) / (n - 1))
		

```{r}
cor(df$col1, df$col2)	-> Nos genera el valor correlativo entre columnas para saber cual es la dependencia a la hora de aplicar modelos					
```

Estos paquetes cuenta con varios modelos que podemos utilizar y podemos comparar con nuestro bechmark
```{r}
# install.packages("e1071")

library(e1071)
library(tree)
library(randomForest)
```

Aplicación de modelo genérica


```{r}
filas_aletorias 	<- sample(1:nrow(df), 0.8*nrow(df))  
datos_entrenamiento 	<- df[filas_aletorias, ]  
datos_validacion  	<- df[-filas_aletorias, ] 

RegresionLinealSimple	<- lm(colObjetivo ~ col1 , 			data=datos_entrenamiento)
RegresionLinealMultiple <- lm(colObjetivo ~ col1 + col2 + col3, 	data=datos_entrenamiento)
RegresionLogistica 	<- glm(formula = colObjetivo ~ col1 + col2,  	data=datos_entrenamiento, family=binomial)
NaiveBayes 		<- naiveBayes(colObjetivo ~ col1+col2+col3, 	data=datos_entrenamiento)
ArbolDecisiones 	<- tree(colObjetivo ~ col1+col2, 		data=datos_entrenamiento)
RandomForest		<- randomForest(colObjetivo ~ col1+col2, 	data=datos_entrenamiento)


summary (modelo)

predicciones 		<- predict(modelo, datos_validacion) 
df_final 		<- data.frame(cbind(df_real=datos_validacion$colobjetivo, df_estimado=predicciones)) 
df_final


rmse(df_final$df_estimado, df_final$datos_validacion)

fitted(modelo)		->	Extr de los valores adjuntos al modelo
residuals(modelo)	->	Me devulve los errores del modelo, los quemas se alejan de la linea de regresion

library(pROC)
modelo.roc <- pROC::roc(datos_validacion$am, datos_validacion$pred)	# Grafico o curvas ROC que enfrentan los falsos positivos y 										verdaderos positivos y presenta el unto de corte
	
plot(modelo.roc)
modelo.roc$auc



```

### 1.1	Modelo de Regresion Lineal
	
	
#### Modelo de Regresión Simple
	

ej1:

```{r}	
modelo <- lm(dist ~ speed, data=cars)  			# Mostramos el grafico de la regresion calculada
		
plot(	x= cars$speed, 
	y = cars$dist, 
	main = "Cars", 
	sub = "Gráfico de dispersión", 
	bty="n", 
	cex=0.5, 
	cex.axis=0.6, 
	pch=19, 
	xlab="Velocidad", 
	ylab="Distancia de frenado")
		
abline( modelo, col="red")


coefficients(modelo)			 		# Extraccion del termino independiente y mis betas (la pendiente) 

nuevos_datos <- data.frame(speed = 17)			# creamos nuevos datos aletorios, en esta caso velocidades
predict(modelo, nuevos_datos) 				# Función "predict"   precide que valor tendría o debería tener la Y en funcion 							# de los datos que tiene mi DataFrame

datos_entrenamiento <- cars[filas_aletorias, ]  	# Extraemos datos aleatorios para entrener el modelo con indices 
datos_validacion  <- cars[-filas_aletorias, ]   	# obtener todos las filas con el incice que NO esten en vector
modelo <- lm(dist ~ speed, data=datos_entrenamiento) 	# sobre la captura de datos aleatorios calculamos la regresion simple
predicciones <- predict(modelo, datos_validacion) 


# Unimos la prediccion con la distancia de mi Dataframe original y visualizamos el resultado
			
distancias <- data.frame(cbind( distancia_real=datos_validacion$dist, distancia_estimada=predicciones)) 
View( distancias ) 

```

ej2

```{r}
	
plot(df)				#Mostramos posibles graficos de nuestro DataFame
RegS <- lm(col1 ~ col2, df)		# Creamos el vector de regresion simple en base a dos campos
summary(RegS)				# mostramos informcion del vector de regresion
predict(RegS)				# cálculo de la previsión
coef(summary(RegS))			# Extraemos el coeficiente de la regresion
		
new_data = data.frame(col1=4.5)		# creamos un valor nuevo para comprobar la predicción
predict(RegS, new_data)			# Comprobamos el modelo obteniendo su prediccion y añadiendo el nuevo valor al modelo
	
ggplot(mtcars, aes(wt, mpg)) 		# Pintamos el modelo
	+ geom_point() 
	+ geom_smooth(method="lm")

```


#### Modelo de Regresión multiple


```{r}	


RegM = lm(col1 ~ col2 + col3 + col4, data=df)		# añadimos al calculo de la regresion las variables que deseamos añadir 
summary(RegM)						# Vemos las caracetristicas y peso de los datos obtenidos
coef(summary(RegM))					# Vemos su coeficiente de error
predict(RegM)						# Mostramos la prediccion del modelo	
dato_nuevo = data.frame(col2=4.5, col3=300, col4=8)	# Creamos dato nuevo al modelo que obtenemos del propio modelo en este caso
predict(RegM, dato_nuevo)				# Vemos como se comporta el modelo cuando metemos el nuevo dato
anova(RegS, RegM)					# Comparativa de dos modelos
```

		
			
### 1.2	Modelo de Clasificacion o regresion logistica


```{r}				
Formula para aplicar el modelo de clasificacion
		
	modelo.4 = glm(formula = am ~ hp + wt,  data=datos_entrenamiento, family=binomial)
		
		El resto es el mismo que el resto de modelos
		
			summary (modelo.4)
			coche_nuevo = data.frame(hp=120, wt=2.8)
			coche_nuevo
			predict(modelo.4, coche_nuevo, type="response") 
			datos_validacion$pred <- round(predict(modelo.4, datos_validacion, type = "response") ,2)
			datos_validacion[, c('am', 'pred')]
		
			
			
			
			
			
Errores del modelo
==================
	
fitted(modelo.3)	->	Extr de los valores adjuntos al modelo
residuals(modelo.3)	->	Me devulve los errores del modelo, los quemas se alejan de la linea de regresion

```





### 1.3	Modelo NaiveBayes


```{r}	
Puedo aplicar una formla para actualizar las probalidades de que ocurra un un fenomeno
Cuando no tengo informacion no puedo predecir algo, por loq ue puedo fcilitar datos apririo o inventados , es decir, dar unos valores que yo mimso eligo par apartir de algo.

# Survived ~ Class+Sex+Age -> Data a predecir y los campos en los cueles me apoyo para predecirlos
# data=titanic -> DataFrame sobre elq ue crearemos el modole para futuras prediucciones

nb = naiveBayes(Survived ~ Class+Sex+Age, data=titanic)

No tiene peso, pero permite indicarle al modelo los campos que interviene en la decision, es decir, la mportacia relativa de cada registro


si en vez de DataFrame le damos la tabla original este tipo de modelos es capaz de detectar cual es la columna que marca el peso deberiamos transformas el DataFrame en una Tabla de frecuencia
nb = naiveBayes(Survived ~ Class+Sex+Age, data=Titanic)

# informacion del modelos
summary(nb)

# mostramos el restuldo del modelo
predict(nb, newdata = Titanic)

# La fila devulta de esta lectura la añadimos al datasets
# PARA PROBAR EL MODOLES PODEMOS USAR EL COMENDO PREDICT QUE NOS VALODA UNdATAfRAME CONTR ANUESTRO MODELO
# Y EN TE CASO NOS DEVIULVE TRUE O FLASE EN FUNCION DEL VALOR DEVULVETO 
predict(nb, newdata = Titanic) 

# vamos aunid estre TRUE o FALSE a nuesto DatAFrame para ver el resultado en pantalla
cbind(titanic, predict(nb, newdata = Titanic))

# Vamos a intentar mejorar el modelo
# vamod a ver que nos devuelve nuestro modelo de "bechmark" para compararlo con el modelo de "naiveBayes"
predict(bechmark, newdata = Titanic, type="response")

# Tenemos que indicar una pounto de corte para evaluar el modelo
# podemos usar la curva roc para indicar el punto de corte
# para indicar 

# Le damos una vuelta a los datos para decir cual es nuestro punto de corte 
hist(predict(bechmark, newdata = Titanic, type="response"), breaks = 30)

# Así inicamos el punto de corte
# Validamos nuetros modelo de "bechmark" y extraemos los que tiene un porcentaje por envismo de 0.6 
predict(bechmark, newdata = Titanic, type="response") > 0.6

# Comparamos, unimos y comparamos los resultadso de los dos modelos
View(
  cbind(titanic, 
        predict(nb, newdata = Titanic),
        predict(bechmark, newdata = Titanic, type="response") > 0.6
        )
)


# Vemos que los modelos nos dan el miso resultado y no hemos tenido en cuenta que los campos a evaluar 
# pueden interactuar entre si.
# Es decir, no es lo mimos ser mujer de 1 clase que de  clase. 
# Esto se llama "supuesto de aditividad". Estos indicando que estamos añadiendo efectos que interactuan

# Para indiar que dos campos interactuan entre si lo indaremos con els igno *
# Sex*Class -> indicamos que dos caractereisticas interactuan entre si

nb2 <- naiveBayes(Survived~Class+Sex+Age+Sex*Class, data=Titanic)

# //////////////////////////////////////////////////////////////////////////////////////////////////////
# el resultado es el mismo entre nb y bn2 debido a que naiveBayes no puede realizar efectos interactivo
# //////////////////////////////////////////////////////////////////////////////////////////////////////

# Con esttos modelos tanto el "backmark" como el "naiveBayes" nos dan el mimso dato apesar de que le indiquemos que
# los datos interactuan entre si, debido a qeu estos modelo no adminten interacciones entre los campos
```



### 1.4 Modelo de Árboles


Este modelo que permite realizar efectos INTERACCION
Son muy flexibles, demasiado flexibles, lo que nos puede dar pie a confusión si son muy profundos



#### Arboles de clasificacion 


```{r}
# Debemos encontrar el mejor punto de corte en cada decision del arbol, para calcularlo lo podemos indicar nosotros o usar una formula matematica.
Tambien debemos de elegir la variable a evaluar. En funcion de la importancia y finalidad se suele seleccionar la variable que mas separe los datos . Son faciles de interpretar

# hiperparametro -> es un parametros que no es del modelo, sino que que sale del metodo del modelo.
# NODO -> Cada punto de decision  
# Hojas -> Lo que cuelga de cada NODO
# profundidad -> numero de decisiones
# % minumo

# Tenemos que saber que variables debemos usar, que debemos evaluar, cunado saltos o profundidad necesitamos

# Para arboles de clasificacion tenemos dos tipos. Linales y NO lineales

# Arboles de clasificacion - Modelo lineal      (incrementos pequequeños crear cambios proporcinales)
# Arboles de clasificacion - Modelo NO lineales ( no permite cortes y tiene datos caoticos)


library(tree)			# Libreria que nos mermite usar modelos de arboles para clasificacion
library(titanic)		# Libreria que nos caga el DataFrame  de Titanic
library(dplyr)
library(randomForest)
library(caret)
library(ROCR)
library("ggplot2")

# La forma de usar el modelo de arbol
# Survived ~ Age -> Datoa a evaluar en base a los campos indicados


# Creamos aun modelo y lo guardamos en una variable     
miarbol <- tree(Survived ~ Age+Pclass, titanic_train)

# Validamos nuestro modelo arbon pasandole una Data Frame enteno 
predict(miarbol, newdata=titanic_test )

# Pintado del arbol
plot(miarbol, y=NULL, type = c("proportional","uniform"))
text(miarbol, une.n=TRUE, all=TRUE, cex=.8)
```


#### Modelo: rabdomforest 

```{r}
library(randomForest)  

# modelo que crea muchos arboles de decision independientes contruidos a partir datos ligeramente distintos
# este modelo puede hacer "regresion" y "clasificacion"
# NO ADMITE VALORES NA

# limiamos de dataframe los filas que tiene en el campo "Age" un valor Na

# Otra forma de limpiar los datos: titanic_train <- titanic_train[,!is.na(titanic_train$Age),]
titanic_train <- titanic_train %>%  filter(!is.na(Age))

# Para poder crear juna modelo del tipo "RANDOMFOREST"
# Survived ~ Age+Pclass -> Campo a detectar y capos de los qu ededende
# titanic_train -> DataFrame sobre el qu egeneraremos las decisiones
randomForest(Survived ~ Age+Pclass, titanic_train)
```




### 1.5 MODELO knn [REGRESION Y CLASIFICACION ] 

```{r}
library(class)

# KNN -> se usa con regresion o clasificacion. en este caso vamos a ver clasificacion, 
# Busca items cerca que puedan predecir correctamente mi valor
# busca cortes por distanca para indicar en que lugar del portentaje caes.
#' 
#' Las distancia se puede medir de varias formas, por distancia metritrica o coseno (por angulos parecidos)
#' 
#' k -> priner parametro, los vecinos de los que tengo que ver si estoy cerca o no, Para saber cuentos vecinos debo
#' indicar, tengo que saber como de desnso es mi entorno, si hay venos muy lejanos es posible obtener error
#' 
#' 
# DataSet de iris de ejemplo, donde el tamaño de petalo y distancia entre ellas  puede darnos flores similares

# Datis de DataSet
iris

# Numero de filas del DataSet
nrow(iris)

# Dibujamos el DataSet
ggplot(iris) + geom_point(aes_string(x="Sepal.Length", 
                                   y="Sepal.Width", 
                                   color="Species"))


iris %>% sample_(110)				# Seleccion 110 indices de registros aleatorios 
idxTraining <-sample(1:nrow(iris), 110) 	# esto selecciona numeros aletorios de entre los indices del DataFrame iris

iris_Training <- iris[idxTraining,]		# Selecciono los registros correspondientes al indice de la seleccion aleatoria
iris_test <- iris[-idxTraining,]		# los indices queNO estan entre los seleccionado en el ejemplo

cl <- iris_Training$Species			# nos quedamos con la lista de tipos de flores que hay en el DataSet 

iris_Training <- iris_Training[,-5]		# Eliminas el campo "especie" el train porque si ya tiene la respuesta no nos vale

iris_Training <- iris_Training[,colnames(iris_Training) != "Species"]
iris_test <- iris_test[,colnames(iris_test) != "Species"]

# k=1 -> niveles de probabilidad. si indicamos muchos vecinos pierde el sentido de la estadistica

knn(iris_Training, iris_test, cl, k=5, prob=T)
	
```

