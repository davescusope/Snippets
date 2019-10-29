# R Cheatsheet 

## 1. Carga de librerias durante la ejecucion


```{r}
# Creamos un vector con la lista de librerias a cargar
list.of.packages <- c("R.utils", "rvest", "stringr", "foreach", "doParallel","dplyr", "tidyverse", "ggplot2", "tidyr", 'lubridate')

# Las librerias las buscamos en la varialbe interna installed.packages() y sacamos las
# que o esten en la lista buecando en el campo[,"Package"] del DataFrame devulveto
# de la funcion  installed.packages()
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]

# Si el vector devulveto tiene tamañan, instalamos las librerias que quedan en el vector
if(length(new.packages)) install.packages(new.packages)


remove.packages("data.table")			# elimina una libreria de la memoria
```


## 2. Ficheros y Rutas 

```{r}

getwd() 				# Ruta actual
setwd("ruta") 				# Cambiar de ruta

if(!file.exists("downloads")){		# comprobar si una carpeta o fichero existe
  dir.create("downloads")		# Creacion de una carpeta
}

tempdir()				# Variable reserbada que guarda la ruta temporal de Windows

file.path(tmp_dir, '2007.csv') 					# Construccion de una ruta

# Descarga un fichero desde un URL a la carpeta indicada
download.file('http://stat-computing.org/dataexpo/2009/2007.csv.bz2', tmp_file)

file.info(tmp_file) 						# Informacion de un fichero


system('head -5 fichero.csv')					# Una forma ms de leer un fichero

readLines("fichero.csv", n = 5)					# una forma mas de leer un fichero grande

length(readLines("downloads/2007.csv", n = 5))			# Contomos el numerod elineas de un fichero

nrow( data.table::fread("fichero.csv", select=1L, nThread=2))	# lectura de una fichero por hilos. Con nrwo contamos los lineas

																
df <- sqldf::read.csv.sql("ruta_fichero.csv", select=c("UniqueCarrier", "Dest", "ArrDelay"))	
								# Lectura de colimnas especificas de una fichero

	
df <- readr::read_csv('fichero.csv')				# lectura de un fichero csv en un DataFrame

df <- read_csv("https://...pub?output=csv")			# lectura de un fichero diretamente desde una web
```


## 3. Acceso a una base de datos

```{r}
db <- dbConnect(RSQLite::SQLite(), dbname='flights_db.sqlite')
dbListTables(db)

delays.df <- dbGetQuery(db, "SELECT UniqueCarrier, AVG(ArrDelay) AS AvgDelay FROM delays GROUP BY UniqueCarrier")  
delays.df

unlink("flights_db.sqlite")
dbDisconnect(db)

Ejmplo de como importarimaos una fichero a una base de datos SQLite

		db <- DBI::dbConnect(RSQLite::SQLite(), dbname='flights_db.sqlite')
		dbListTables(db)
		dbWriteTable(db,"jfkflights",jfk) # Inserta en df en memoria en la base de datos
		dbGetQuery(db, "SELECT count(*) FROM jfkflights")  
		dbRemoveTable(db, "jfkflights")
		rm(jfk)
```
## 4. Creacion de variables

```{r}

x <- "Hola"				# Crea una variable de tipo String
n <- 2					# Crea una variable de tipo numerica
h <- c("1", "2", "3")			# Crea una variable de tipo Vector
1:10					# Crea una secuencia de nueros de 1 al 10
seq(from = 1, to = 21, by = 2)  	# Crea una secuencia de numeros de 1 al 21 de dos en dos
seq(0, 21, length.out = 15)		# Crea una secuencia de numeros de 1 al 21 de 15 elementos
rep(1:4, times = 2)			# Repetimos una secuencia del 1 al 4 dos veces
rep(1:4, times = 2)			# repetimos una secuencia del 1 al 4, repitiendo cada elemento 2 veces
v1[2]					# Seleccionamos un elemento de un vector
v1[2:4]					# Seleccioanmos desde elemento 2 al 4 de un vector
v1[-1]					# Selecciona todos los elementos menos el primero

hist(df)				# Crea el histograma de un vector 

ls()					# lista de variables
exisits(var)				# nos indica si existen o no una variables
rm (var1, var2...)			# Elimina variables

help(comando)				# nos devulve la ayuda de un comando o libreria
?comando				# nos devulve la ayuda de un comando o libreria
example(comando)			# nos devulve un ejemplo de un comando
help(package = "dplyr")			# Provee de ayuda extra de una libreria dada
vignette(package = "dplyr")		# Informacion de los origenes de una paquete

install.packages("dplyr")		# instacion de una nueva liberia del repositorio de Ruta
library(dplyr)   			# Cargar una libreria en memoria
```


## 5. Functions
```{r}

levels(var)		# Nos indica los nuveles de una variable

Datos ejemplo: x <- 1000

abs(x)      		# Valor absoluto
sqrt(x)     		# Raiz cuadrada
exp(x)      		# exponenecial
log(x)      		# Logaritmo
log(x, 10)		# Logaritmo en base 10
log10(x) 		# logaritmos en base 10
10^log10(x) 		# 10 elevador al logaritmo en base 10  
cos(x)      		# Coseno
sin(x) 			# Seno
tan(x)			# Tangente

round(x)		# Redonde los ele de un vector
round(x, digits = 1)	# Redondea en base al decimal indicado
ceiling(x)		# Redondea ahcia arriba
floor(x)		# Redondea hacia abajo	

paste(a, b)		# Concatena dos cadenas
paste("1", "2", sep = "-")			# Concatena cadenas pero las separas por el caracter indicado
sprintf("Learning to %s in R", x) 		# sustituye en una cadena la variable acontinuación
sprintf("This is R version: %d", version)	# sustituye un numero en la cadena inicial

length(vector)	# numero de elementos de un vector
nchar("cadena")	# numero de caracteres de una cadena
nchar(vector)	# numero de caracteres de cada elemento de una vector


Datos ejemplo:
x <- c(1, 4, 9, 12)
y <- c(4, 4, 9, 13)

x == y			# Pregunta si son iguales estos dos vectores
sum(x)			# suma todos los elelentos de un vector
sum(x == y)		# suma cuantos elementos de cada vector son iguales
which(x == y)		# Nos devulve las posiciones de elementos de de cada vector que son iguales
x[which(x == y)]	# nos devulve los elementos de las posiciones de cada vector que son iguales
 
Datos ejemplo:
x <- c(5, 14, 10, 22)

x > 13			# Nos indica por cada elemento del vector cuales son mayores que 13
12 %in% c(12, 11, 8)	# Busca una cadena en un vector devolviendo True o False

x <- c(5, 14, 10, 22)
sum(x > 13)		# Cuenta cuantos elementos del vector son mayores de 13

is.na(x)		# Pregunta que elemntos del vector es un NA, devolviendo True o False
is.vector(c)		# Pregunta si es un vector
is.na(x)		# Pregunta su los valores de una vector son NA, devolveindo True o False

as.numeric(c)		# Transforma los elementos de un vector en numeros
as.integer(c)		# Transforma los elementos de un vector en enteros
as.character(c)		# Transforma los elementos de un vector en string
as.date(c)		# Transforma los elementos de un vector en fechas
as.factor(c)		# Factorizo el valor indicado, asiganando una valor numerico
identical(x, y)		# Nos idica si dos vectores son iguales


x + y			# suma de vectores
x * y			# Multiplicar vectores
x%%year			# Extrae el resto de una division
log10(n)		# Genera el logaritmo que usaremos para cabiar la escala 
exp(n)			# exponenecial de un numero dado

Datos ejemplo:
x <- c(1, 3, 4)
y <- c(1, 2, 4)

seq_along(x)			# Devulve cada elemento de un vector uno a uno

				for (i in seq_along(x)) {
				  z[i] <- x[i] + y[i]
				  print(z)
				}


df %>% view()	# nos muestra un DataFrame en un visor

Datos ejemplo:
x <- c(1:4, NA, 6:7, NA)

x
is.na(x)				# Me devuleve True o False por cada dato del vector
which(is.na(x))				# Selecciona las posiciones que son NA
x[is.na(x)]				# Selecciona los elementos que son NA
x[!is.na(x)]				# Selecciona los elmentos que no son NA
x[is.na(x)] <- mean(x, na.rm = TRUE)	# Selecciona los elementos que son NA, y les asigna la media de los valores que NO son NA
mean(vector, [na.rm = TRUE])		# Saca la media de los datos del vector, opcionalmente podemos indicarle que no teng aen cuenta 					los datos NA
```


## 6. Listas, Matrices y DataFrames 
```{r}

l <- list(1:3, "a", c(TRUE, FALSE, TRUE), c(2.5, 4.2))	# Creacion de una lista. Una lista es un vector pero sus elementos, pueden ser 								de distinto tipo
														
l1[1]							# Seleccionamos el primer elemento de una lista
matrix <- matrix(1:12, nrow = 4)			# Creacion de una matriz de 12 elelentos, repartidos en 4 filas		
df <- data.frame(item1 = 1:18, item2 = LETTERS[1:18])	# Creacion de una DataFrame.
							#La primera columna con numeros del 1 al 18. 
							#La segunda columna con letras de la A a la R$

str(variable)						# nos devuelve informacion del item que le indiquemos

class(vector)						# Me devulve la clase del vector
class(list)						# Me devulve la clase de la lista
class(matrix)						# Me devulve la clase de la matriz
class(df)						# Me devulve la clase del DataFrame

names(df)						# Me devuelve o asigno los nombre de las cabeceras de un DataFrame
summary(df)						# informacion completa de una DataFrame					
dim(df)							# Me devulve las dimensiones de un DataFrame
na.omit(df)						# Elimna todos los ceros de una DataFrame
length(df)						# Mnumero de comulnas de un DataFrame
ncol(df)						# nos devulve el numero de columnas de un DataFrame

rownames(df)						# Nombre de las las filas de un DataFrame
rownames(df) <- c("r1", "r2", "r3")			# Asignar nombre de filas a un DataFrame

colnames(df)						# nos devulve los nombres de columnas de un DataFrame
colnames(df) <- c("c1", "c2", "c3", "c4")		# Asignar nombre a la las columnas

df <- data.frame(col1 = 1:3, 
                 col2 = c("this", "is", "text"), 
                 col3 = c(TRUE, FALSE, TRUE), 
                 col4 = c(2.5, 4.2, pi))		# Creamos un DataFrame dando nombre a las columnas

drop_na(df)						# Limpia una Dataframe de las filas que contiene NA
table( df$campo )					# la funcion table nos puede contar cuantas 
							# veces se repite el campo indicado de una DataFrame
							
unique(df$campo)					#  nos devulve los valores unicos de un campo dado
lapply(df, funcion)					# Aplica la funcion indicada a cada elelento del DataFrame indicado	
airbnb <- lapply(files, read_csv)			# Generamos una lista en donde cada posicion es una DataFame
bind_rows(lista)					# Une todos los DataFame de una lista en un solo DataFame
collapse_by						# permite agrupar por un capo un DataFame

	airbnb %>%
		collapse_by(period = "1 year") %>%
		group_by(last_modified) %>%
		summarise(median_price = median(price, na.rm = T))


ulist(lista)		# Transorma una lista a un vector
recode			# Equivale a un Selec...Case

foo <- flights %>% 
	mutate(CancellationCode = 
	recode(campo, 
	"A"="Carrier", 
	"B"="Weather", 
	"C"="National Air System", 
	.missing="Not available", 
	.default="Others" ))

tabulate(v)		# Recibe como parametro una vector y cuenta cuantas veces se repite cada elelento
match(v1, v2) 		# Busca los elemento de dos vectores y extrae los comunes
which.max(v)		# Extrae el ID mas alto de un vector dado
								
```

## 7. Plots

```{r}
plot(cos(seq(0,10,0.1)),type="l")	# Crea una grafico del coseno de un vector creado de una secuencia de 0 a 10 de 0,1 en 0,1
plot( table( df$campo1 ) )		# Generacion de una grafico con el resultado
						# X -> valores del campo1
						# y -> numero de veces que se repite cada valor del campo1
									  
lines(sin(seq(0,10,0.1)), col='red')	# Crea una grafico del coseno de un vector creado de una secuencia de 0 a 10 de 0,1 en 0,1

```


## 8. Dates

```{r}
Sys.timezone()		# Devuelve la zona horaria
Sys.Date()			# Devulve la fecha actual
Sys.time()			# Devulve la hora actual

as.POSIXct("2013-09-06", format="%Y-%m-%d")				# generacion de fechas
as.POSIXct("2013-09-06 12:30", format="%Y-%m-%d %H:%M")	# generacion de fechas

```

## 9. Libraries


### 9.1 Dplyr 

```{r} 

Esta libreria permite realizar acciones sobre DataFrames


```{r}	
Select  	-> Devulve una conjunto de columnas   ej: select(iris, 'Sepal.Length')
filter  	-> Filtra columnas
arrange 	-> Ordena un DataFrames
rename		-> Renombre variables(columnas) de un DataFrames
sumarise	->Reliza cuniones de sumarizado, media, mediana, contar... sobre una DataFrames
%>%		-> Permito topar la salida de una de la operaciones anteriores para volcarlaen la siguiente instruccion



Una de la librerias mas utilies y utilizadas para la gestion de ficheros

library(dplyr)


SELECT -> Utilizazo para extraer variables o campos
======

# Asi sacariamos un lista de cmapos dede R de forma nativa

	flights[c('ActualElapsedTime','ArrDelay','DepDelay')] # base R

# Asi sacaremos los mismos campos con la libreria dplyr

	select(flights, ActualElapsedTime,ArrDelay,DepDelay)

Para referenciales a campos, el comando "select" podemos apliccar filtros

	starts_with(“X”)	# cada capo que empiea con el caractere indicado
	ends_with(“X”)		# Cada campo que termina con el caracter indicado
	contains(“X”)		# Cada nombre de cmapo que contenga el caractere indicado
	matches(“X”)		# cada nombre de campo cumpla una referencia ambigua indicada
	num_range(“x”, 1:5)	# the variables named x01, x02, x03, x04 and x05
	one_of(x)		# Cada campos que tenga en el nombre el caracter indicado

Selecciona las columnas que se encuentras entre los campo indicados

	select(flights, Origin:Cancelled)

Selecciona las columnas que NO se encuentran entre los campos indicados
	
	select(flights, -(DepTime:AirTime))

Selecciona 
	los campos indicados
	contains("Tail")	# los que contiene la palabra "Tail"
	ends_with("Delay")	# Los campos que termiana en "Delay"
	
	select(flights, UniqueCarrier, FlightNum, contains("Tail"), ends_with("Delay"))

MUTATE -> Añade campos al DataFrame
======

Crea un DataFrame con los datos del DataFrame indicado y un nuevo campo que
contiene el resultado de la operacion de otros dos cmapos 

	foo <- mutate(flights, ActualGroundTime = ActualElapsedTime - AirTime)
	

Añadinos dos columnas 

	foo <- mutate(flights, 
              loss = ArrDelay - DepDelay, 
              loss_percent = (loss/DepDelay) * 100 )
	
	

FILTER -> Permite filtrar datos en un DataFrame
======

	# x < y		Menos que
	# x <= y	Menos os igual que
	# x == y	igual
	# x != y	Distinto de
	# x >= y	Mayor o igual a 
	# x > y		Mayor que
	# x %in% c(a, b, c) # Busca una cadena el vector indicado
	# !is.na(campo)	# Campos con valor distinto de na

filtramos

	filter(flights, Distance > 3000)

Eliminamos los valores NA

	filter(flights, !is.na(ArrDelay))
	
filtamos las filas donde el valor del campo "UniqueCarrier" esta en el vector c('AA', 'UA')

	filter(flights, UniqueCarrier %in% c('AA', 'UA'))

filtramos

	filter(flights, TaxiIn + TaxiOut > AirTime)

Filtramos 
	
	filter(flights, DepDelay > 0 & ArrDelay < 0)


	
ARRANGE -> Permite ordenar un DataFrame
=======

Ordenar un DatAFrame por el campo indicado

	arrange(cancelled, DepDelay)

Ordenar DataFrame por dos campos

	arrange(cancelled, UniqueCarrier, DepDelay)

Ordenar el resultado de una filtros

	arrange(filter(flights, Dest == 'JFK'), desc(AirTime))


SUMMARISE -> Aplica una serie de opera sobre un conjunto de datos
=========

	# min(x) 		# Extraer el valos minino del campo/vector indicado
	# max(x) 		# Extraer el valos maximo del campo/vector indicado
	# mean(x) 		# Extraer la medioa del campo/vector indicado
	# median(x) 	# Extraer la mediona del campo/vector indicado
	# quantile(x, p) # pth quantile of vector x.
	# sd(x) 		#  desviacion estandard del campo/vector indicado
	# var(x) 		# varianza del campo/vector
	# IQR(x) 		# Rango intercuartil IQR) del campo/vector indicado.

	Este metodo nos da una serie de utilidades
	
	# first(x) 		# Primer elemento de un vector
	# last(x) 		# Ultimp elemento de un vector
	# nth(x, n) 	# Extrae el elemento del vectos de la posicion "n" indicada
	# n() 			# Numero de filas de un DataFrame dado.
	# n_distinct(x)	# Valores unicos de un vector dado (el como el distinct de SQL)


Asigna o crea un campo con el valor minimo y otro con el maximo

	summarize(flights, min_dist = min(Distance), max_dist = max(Distance))

Crea una vector con los resultados del minimo, maximo, media y desviacion estandard
	
	summarise(na_array_delay, 
          earliest = min(ArrDelay), 
          average = mean(ArrDelay), 
          latest = max(ArrDelay), 
          sd = sd(ArrDelay))

	summarise(taxi, maxima = max(TaxiIn - TaxiOut) )	  

	summarise(aa,
          n_flights = n(),
          n_canc = sum(Cancelled),
          p_canc = 100 * (n_canc/n_flights),
          avg_delay = mean(ArrDelay, na.rm =TRUE)
          )
		
	jfk <- mutate(flights, Date = as.Date( paste(Year, Month, DayofMonth, sep="-") ) )

	
	
GROUP_BY -> Agrupaciones
========

Agrupamos por el campo indicado

	group_by(UniqueCarrier)

Se suele usar con funciones como summarize para obtener un resultado

	flights %>% 
	group_by(UniqueCarrier) %>% 
	summarise(	n_flights = n(), 
				n_canc = sum(Cancelled), 
				p_canc = 100*n_canc/n_flights, 
				avg_delay = mean(ArrDelay, na.rm = TRUE)) %>% 
	arrange(avg_delay)
	
	
	flights %>% 
	group_by(DayOfWeek) %>% 
	summarize(avg_taxi = mean(TaxiIn + TaxiOut, na.rm = TRUE)) %>% 
	arrange(desc(avg_taxi))
	
	
	flights %>% 
	filter(!is.na(ArrDelay)) %>% 
	group_by(UniqueCarrier) %>% 
	summarise(p_delay = sum(ArrDelay >0)/n()) %>% 
	mutate(rank = rank(p_delay)) %>% 
	arrange(rank) 
	
	
top_n(x, campo) -> funciona que extrae x filas mas altas del campo indicado
=======

	flights %>% 
	group_by(UniqueCarrier) %>% 
	top_n(2, ArrDelay) %>% 
	select(UniqueCarrier,Dest, ArrDelay) %>% 
	arrange(desc(UniqueCarrier))

joins	-> Unis DataFrames por medio de un campo
=====

	Por defecto jont busca los copos que se llaman igual en ambos DataFrame
	, pero le podemos indicar los campos de union de ambos DataFrame
	

	inner_join(x, y)	-> (Extrae los comunes entre las dos tables)
	left_join(x, y) 	-> respeta los valores de la izquierda
	
		df %>% 
			group_by(UniqueCarrier) %>%
			top_n(1, DepDelay) %>% 
			left_join(df2, by = c("col1" = "col2"))

		(co1 perteneda a df y col2 petenece a col2)
  
		df1 %>% 
			left_join(df2, by = c("col1" = "col2"))

		df1 %>% 
			left_join(df2 %>% select(iata, lat, long), by = c("Dest" = "iata"))

		df1 %>% 
			left_join(df2 %>% rename("Dest" = "iata"))

  
	right_join(x, y, by = "z") 	-> 	respeta los de la derecha y los que no 
									esten en la tabla de la izquierda, 
									se rellenarian con nulos
	full_join(x, y, by = "z") 	->	Genera una producto cartesioano

	semi_join(x, y)
	anti_join(x, y)
```

### 9.2 Stringr 

```{r}
LIBRERIA CON FUNCIONES ESPECIFICAS PARA CADENAS DE TEXTO

library(stringr)

str_c("cad1", "Cad2", "CadN", ..., sep="-")	# Concatena cadenas


text = c("Learning", "to", NA, "use", "the", NA, "stringr", "package")
str_length(text)				# Nos da la longitud de cada una la las posiciones de un vectos


x <- "Learning to use the stringr package"
str_sub(x, start = 10, end = 15)		# Corta un trozo de una cadena dada
str_sub(x, end = 15)				# Corta desde el pincipio hasta el caracter indicado


text <- c("Text ", "  with", " whitespace ", " on", "both ", " sides ")
str_trim(text, side = "both")			# elimina espacios en blanco por ambos lados


set_1 <- c("lagunitas", "bells", "dogfish", "summit", "odell")
set_2 <- c("sierra", "bells", "harpoon", "lagunitas", "founders")
union(set_1, set_2)				# Concatena/une dos o mas vectores eliminado duplicados
intersect(set_1, set_2)				# Me devulve los elementos en comun
setdiff(set_1, set_2)				# Me devulve los elementos que no tiene en comun
identical(set_1, set_2)				# Me indica si son vectores iguales
'sierra' %in% set_2				# Busca una cadena en un vector
'sierra' %in% set_2				# Ordena una vector

sub(pattern = "\\$", "\\!", "I love R$")	# Sustitulle "$" por "!"
gsub(pattern = "\\\\", " ", "I\\need\\space") 	# Sustitulle "\\" por un espacio en blanco

str_to_upper(x)				# Pasa a mayusculas (devuelve una lista)
str_split(x, " ")			# Separa por el separador indicado (devuelve una lista)
boundary(x, "word")			# separa por palabras (devuelve una lista)
str_count(x)				# contador de caracteres (devuelve una lista)
"cadena" %>% str_sub(0, 6)		# corta un parte de la cadena (devuelve una lista)
"cadena" %>% str_replace('\\.', '')	# reemplaza una cadena (devuelve una lista)

```

### 9.3 Rvest 
```{r}

Libreria para atacar a paginas WEBS por webScraping

library(rvest)
library(stringr) 						# Par tratar strings

Leemos una web y la cargamos en un vector

			url_madrid <- "http://resultados.elpais.com/elecciones/2011/municipales/12/28/79.html"
			html_madrid <- read_html(url_madrid)

	# Atacamos un grupo de NODOS
			html_nodes(".nombrePartido")
			html_nodes("#nombrePartido")
	
			partidos <- html_madrid %>% html_nodes(".nombrePartido") %>% html_text()
			
	# extraeos todos los elementos "href"
	
			linked_resources <- html_attr(all_links, "href")
	
	# extraemos los nombre de los ficheros
	
			linked_bz2_files <- str_subset(linked_resources, "\\.bz2")	
								# \\ -> que contiene
								# $ -> Que terminan
								# ^ -> Que empiezan

	# Devolvemos el contido HTML

			partidos <- html_madrid %>% html_nodes(".nombrePartido") %>% html_text()

	# Montamos un DataFame cpon los nodos
	
			madrid <- data_frame(partidos, concejales, votos)
			madrid

	# Atacamos a un nodo concrero
		html_node("#tablaVotosPartidos")
		
	# Extraemos los datos en modo de tabla
		html_table()
		
			madrid <- html_madrid %>% html_node("#tablaVotosPartidos") %>% html_table()
			names(madrid) <- c("partidos", "concejales", "votos", "porcentaje")
			madrid

	# Abre la URL indicada
	
			browseURL(url)
			
			
	
```

### 9.4 Treemap 

```{r}

Libreria que nos pinta una grafico de cuadros

library treemap

	treemap(madrid, 
		index=c("partidos"), 
		vSize="votos", 
		type="index",
		border.lwds=.3,
		border.col="#FFFFFF")
		
```


### 9.5 Readr 


```{r}
Lectura de ficheros por trozos para ficheros muy grandes

library(readr)

	jfk <- read_csv_chunked("fichero.csv",
			chunk_size = 50000,
			callback = DataFrameCallback$new(f))

ejemplo de como leeriamos un fichero por chunks y enviamos los datos a una base de datos de SQLite

		db <- DBI::dbConnect(RSQLite::SQLite(), dbname='flights_db.sqlite')
		writetable <- function(df,pos) {
		  dbWriteTable(db,"flights",df,append=TRUE)
		}
		readr::read_csv_chunked(file="./data/flights/2008.csv", 
								callback=SideEffectChunkCallback$new(writetable), 
								chunk_size = 50000)

		# Check
		num_rows <- dbGetQuery(db, "SELECT count(*) FROM flights")
		num_rows == nrow(data.table::fread("data/flights/2008.csv", select = 1L, nThread = 2)) 

		dbGetQuery(db, "SELECT * FROM flights LIMIT 6") 

		dbRemoveTable(db, "flights")
		dbDisconnect(db)

	# sqlite3 /Users/jose/Documents/GitHub/master_data_science/flights_db.sqlite
	# sqlite> .tables
	# sqlite> SELECT count(*) FROM flights;
```



### 9.6 R.utils 


```{r}  

Libreria para tratar ficheros comprimidos

library(R.utils)


bunzip2(tmp_file, "downloads/2007.csv", remove = FALSE, skip = TRUE) 		# Compresion de un fichero
utils:::format.object_size(file.info("downloads/2007.csv")$size, "auto") 	# Tamaño del archivo sin comprimir
```







### 9.7 Foreach & DoParallel 

```{r}  

Librerias para hilos de trabajo 

library("foreach") 				# for foreach
library("doParallel") 				# for makeCluster, registerDoParallel

detectCores()					# nos indica de cuantos procesadores disponemos

cl <- makeCluster(detectCores() - 1) 		# Creamos un cluster que apunte a todos los procesados menos 1
											
registerDoParallel(cl) 				# Registramos los procesadores que vamos a usar


res <- foreach(i = 1:num_files, 
               .packages = c("R.utils", "stringr")) %dopar% {
                 this_file_link <- bz2_files_links[i]
                 download_flights_datasets(this_file_link)
               }
			   
			# foreach(i = 1:num_files 	-> Bucle 
					
			# .packages = c("R.utils", "stringr")) %dopar% 	-> exporta librerias a los entornos de trabajo en paralelo
																	  
			# %dopar%  -> Este el parametro que indica que se ejcute en paralelo. Si indicamos solo %do% se realiza de forma secuencial
			# this_file_link <- bz2_files_links[i] 	-> selecciono un fichero llamo la funcion de descargar
																	
```

### 9.8 Lubridate 

```{r}
LIBRERIA CON FUNCIONES ESPECIFICAS PARA FECHAS

install.packages('lubridate')
library(lubridate)

now()				# Fecha y hora actual
today()				# Fecha actual
x <- c("2015-07-01", "2015-08-01", "2015-09-01")
year(x)				# Extrae el año de una fecha
month(x)			# Extrae el mes de una fecha
day(x)				# Extrae el dia de una fecha
x <- c("2015-07-01", "2015-08-01", "2015-09-01")
ymd(x)				# Transforma los datos de una vector una fecha en formato yyy-mm-dd en fecha
y <- c("07/01/2015", "07/01/2015", "07/01/2015")
mdy(y)				# Transforma los datos de una vector una fecha en formato dd/mm/yyyy en fecha


yr <- c("2012", "2013", "2014", "2015")
mo <- c("1", "5", "7", "2")
day <- c("02", "22", "15", "28")
ISOdate(year = yr, month = mo, day = day)	# concatena vectores para crear afechas

seq(as.Date("2010-1-1"), as.Date("2015-1-1"), by = "years")	# Crea secuencias de fechas por años
seq(as.Date("2015/1/1"), as.Date("2015/12/30"), by = "quarter")	# por cuartos de año

x <- as.Date("2012-03-1")
y <- as.Date("2012-02-28")
x - y				# Resta de fechas

x <- as.POSIXct("2017-01-01 01:00:00", tz = "US/Eastern")	# Crea una fecha en base a una zona horaria
x + days(4)			# sumar dias
x - hours(4)			# sumar horas

(datetime <- ymd_hms(now(), tz = "UTC"))			# Extra la ona horaria
(datetime <- ymd_hms(now(), tz = 'Europe/Madrid'))		# extrae la fecha y hora actual con la zona horaria

Sys.getlocale("LC_TIME")					# Extrae la zona horaria
Sys.getlocale(category = "LC_ALL")				# Extrae la zona horaria con mas detalles


ymd_hm("2013-09-06 12:3")	# genera una fecha en el formato indicado

datetime + days(n)		# suma dias a una fecha
minutes(10)			# peridos de tiempo
days(7)
months(1:6)
weeks(3)

ejemplo:

		pb.txt <- "2007-01-01 12:32:00"
		# Greenwich Mean Time (GMT)
		(pb.date <- as.POSIXct(pb.txt, tz="Europe/London"))
		# Pacific Time (PT)
		format(pb.date, tz="America/Los_Angeles",usetz=TRUE)
		# Con lubridate
		with_tz(pb.date, tz="America/Los_Angeles")
		# Coordinated Universal Time (UTC)
		with_tz(pb.date, tz="UTC") 
```



### 9.9 Tidyr 
```{r}	
Libreria utilizada par un pivotrar un DataFrame con las funciones [spread] y [gather]

	spread -> 
				df %>% 
				  group_by(Origin, Dest) %>% 
				  summarise(n = n()) %>% 
				  arrange(-n) %>% 
				  spread(Origin, n) %>% 
				  gather("Origin", "n", 2:ncol(.)) %>% 
				  arrange(-n) 

	rowSums -> funcion que tevuelve el total por fila 	
	
				flights %>% 
				  group_by(UniqueCarrier, Dest) %>% 
				  summarise(n = n()) %>%
				  ungroup() %>% 
				  group_by(Dest) %>% 
				  mutate(total= sum(n), pct=n/total, pct= round(pct,4)) %>% 
				  ungroup() %>% 
				  select(UniqueCarrier, Dest, pct) %>% 
				  spread(UniqueCarrier, pct) %>% 
				  replace(is.na(.), 0) %>% 
				  mutate(total = rowSums(select(., -1))) 


	unite() -> 	Une dos columnas separadas por el separador indicado
				  
				  
				flights %>% 
				  head(20) %>% 
				  unite("code", UniqueCarrier, TailNum, sep = "-") %>% 
				  select(code) 
				  
				  
	separate() -> 	separa una columnaa por seperador indicado o 
					indicando el numeros de caracteres
					** En el caso separate(code2, c("code3", "code4"), -3) 
					** separa por 3 ultimos caracteres admite expresiones regulares

				flights %>% 
				  head(20) %>% 
				  unite("code", UniqueCarrier, TailNum, sep = "-") %>% 
				  select(code) %>% 
				  separate(code, c("code1", "code2"), sep="-") %>% 
				  separate(code2, c("code3", "code4"), -3)

  
```
### 9.10 Ggplot2

```{r}
Libreria para pintar graficos
	
library(ggplot2)

	
ggplot(flights) + geom_histogram(aes(x = ActualElapsedTime))

boxplot(flights$ActualElapsedTime,horizontal = TRUE)
	
boxplot(no_outliers$ActualElapsedTime,horizontal = TRUE)
	
barplot(table(flights$UniqueCarrier))

Creamos un lienzo en el que dibujar un grafico
	
	ggplot()
		
		# creamos dos vectores 
		(vector_y <- sample(10)) # Variable dependiente
		(vector_x <- sample(10)) # Variable independiente
	
	
	mapping = DataFrame a cargar nombrado del DataFrame avisualizar	
	aes(y = vector_y, x = vector_x) -> es para especificar que queremos dibujas
		
		ggplot(mapping = aes(y = vector_y, x = vector_x))
	

	+ geom_point()	-> Indicamos como queremos visualizar el grafico
	
		ggplot(mapping = aes(y = vector_y, x = vector_x))  
			+ geom_point()
	
	+ scale_x_log10() -> Cambiamos laestala

		ggplot(gapminder, aes(x = gdpPercap, y = lifeExp)) 
			+ geom_point() 
			+ scale_x_log10()
	
	+ geom_point(aes(color=continent)) -> indicamos el color en base a que campo lo queremos 

		ggplot(gapminder, aes(x = gdpPercap, y = lifeExp)) 
			+ geom_point() 
			+ scale_x_log10() 
			+ geom_point(aes(color=continent)) 

	+ geom_smooth() -> Nos aplica un modelo GAP, es un modelo generalizado lineal, 
	que escapaz de detectar patrones no lineales 

		ggplot(gapminder, aes(x = gdpPercap, y = lifeExp)) 
			+ geom_point() 
			+ scale_x_log10() 
			+ geom_point(aes(color=continent)) 
			+ geom_smooth()

	
	+ geom_smooth(lwd=1, se=FALSE, method="lm", col="black") -> Aplica una modelo de regresión simple. Me permite indicar el grado de confianza de los datos que aparece como una franja gris cercando la linea 
	
method="lm" -> indica que queremos una regresion simple

		ggplot(gapminder, aes(x = gdpPercap, y = lifeExp)) 
			+ geom_point() 
			+ scale_x_log10() 
			+ geom_point(aes(color=continent)) 
			+ geom_smooth(lwd=1, se=TRUE, method="lm", col="black")

	+ geom_smooth(se=F, lwd=1) -> Genera las lineas que indican como se mueve la renta 
								percapita pero por continente  

		ggplot(gapminder, aes(x = gdpPercap, y = lifeExp, color = continent))  
			+ geom_point() 
			+ scale_x_log10()  
			+ geom_smooth(se=F, lwd=1)

	ejemplo
	
		# size = pop -> indicamos que el tamaño del punto sea la poblacion
		# Transparencia del color del productos
		# frame = year -> Indica por que campo se va a animar el grafico (se ve mas adelante)

			gappminder_plot <- ggplot(gapminder) +
				aes(x = gdpPercap, y = lifeExp, colour = continent,size = pop, frame = year) 
				+ geom_point(alpha = 0.4) 
				+ scale_x_log10()

			# guaramos el resultado en un vector
			gappminder_plot

	Histograma: Generacion de una histograma. 
				Distribución de una variable cuantitativa
				Me va a sacar el conteo de elementos que se repiten
				
		geom_histogram() -> 

				ggplot(gapminder, aes(x = lifeExp)) + geom_histogram()

	Ejemplos
	
	
			# Añadimos una nueva variable: continent
			# Indicamos la columna a contbilizar en el hostograma y que campo rrelana sus valores o como esta distribuido

				ggplot(gapminder, aes(x = lifeExp, fill = continent)) +   geom_histogram()


			# Gráfico de frecuencias con líneas

				ggplot(gapminder, aes(x = lifeExp, color = continent)) 
					+ geom_freqpoly()

			# Gráfico de densidad
			# geom_density() -> Grafigo de tipo desnsidad

				ggplot(gapminder, aes(x = lifeExp)) 
					+ geom_density()

			# Gráfico de densidad con más de una variable
			# Grafico de densidad con mas de una variable

				ggplot(gapminder, aes(x = lifeExp, color = continent)) 
					+ geom_density()

			# alpha 
			# Transparencia

					ggplot(gapminder, aes(x = lifeExp, fill = continent)) 
						+ geom_density(alpha = 0.2)

	Guardar graficos en un fichero
		
			# guardamos el ultimo grafico generado
			
					ggsave("gapminder.pdf", last_plot())

			# Guardamos el grafico indicado

					ggsave("gapminder.pdf", gappminder_plot)

			# si no indicamos objeto, se guarda el ultimo grafico que se ha generado 

					ggsave("gapminder.png", width = 6, height = 4)
```



### 9.11 Ggthemes 
```{r}
Libreria que permite añadir aspectos o temas de los graficos ggplot

library("ggthemes")

	gappminder_plot + theme_excel() + scale_fill_excel()

	gappminder_plot + theme_economist() + scale_fill_economist()

	gappminder_plot + theme_wsj() + scale_fill_wsj(palette = "black_green")


```

### 9.12 Ggmap 
```{r}
Libreria que nos permite pintar un grafico sobre una mapa indicando coordenas
de latitud y longitud

library ggmap

	qmplot(longitude, latitude, data = ., geom = "blank") +
	geom_point(aes(color = price), alpha = .2, size = .3) +
	scale_color_continuous(low = "red", high = "blue")
	
		qmplot(x, y, ..., data, zoom, source = "stamen",
			  maptype = "toner-lite", extent = "device", legend = "right",
			  padding = 0.02, force = FALSE, darken = c(0, "black"),
			  mapcolor = "color", facets = NULL, margins = FALSE,
			  geom = "auto", stat = list(NULL), position = list(NULL),
			  xlim = c(NA, NA), ylim = c(NA, NA), main = NULL, f = 0.05,
			  xlab = "Longitude", ylab = "Latitude")
		
		x		#	longitude values
		y		# 	latitude values
		data	#	data frame to use (optional). 
					If not specified, will create one, extracting vectors 
					from the current environment.
		zoom	#	map zoom, see get_map
		source	#	map source, see get_map
		maptype	# 	map type, see get_map
		...
	
```


### 9.13 GoogleLanguageR 


```{r}

Libreria de google que nos permite analizar lenguaje natural
El uso de esta libreria cuesta dinero.
Para poder usarla debemos de cargarle un fichero JSON con la KEY obtenida desde google al contratar este servicio


library(googleLanguageR)

# Carga del JSON desde un fichero
gl_auth('cpb100-162913-faf075966c64.json')
```

```{r}
	# ############
	# fichero JSON
	# ############
	#{
	#  "type": "service_account",
	#  "project_id": "cpb100-162913",
	#  "private_key_id": "faf075966c64b1868a86c304bebfad14f8e34fe6",
	#  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDuoRK6SzLWr9Qn\n4nGyeJtOPQT3inGtK7VchNNOdtG2a0Kpl2rrVYM5+GUrkAuHeVVQfqZpjTtgy72e\nGuydPm/+SLOoRrZ6ml2Ch20ECVAldy5L1DpQiKaBuUv/1UR25hy9/m7EFtTOr0AV\n5kAhu6GUz37+iGima3ZOzrU66x6fuORJt0vJOv7X1QJdCpCUlaAC/RLYV75PFXsf\naF2MHePkYJBzlzjuopm8SeOs39xEQOB1PExb+LqeJzb6x0jwaqSMYW3wKLoX7S+I\n6k1USqARFnGCMeqhndjS2Ro22AMohLO03+uuZ5Uf7LAj8eoVuTRGyh9jfMhsDClp\nlBrt1DI3AgMBAAECggEAF+5GqYYXEBlL+7/6ylIhXmRCK5entMfNr/yQuwKxdKDR\nwPOIFm0EnvtTx12dD7X8TKPsM75Py8eYOX3WaCKLKq4ceO4L028dnOnQkKIPy+IQ\nM4HnYzeBCJYOPWwkKeRZJ43s38oGXL/jJmRpNA4pXc9n8JtkxfkVlpZQ7cVcfy84\nTbi9VozjJplZy2iDwEkXI83q/oVmB9FuxPTrA1KeWpolB8yli1CkgPvFEUUoWC8Z\nJC++5GxDUrhoJY0krmtgKuUN2yGgOpaxIP+HvtiMk9R2/m+YsZERajAYX3gvRRHT\nYteISwfElSCQFpS8lOGO9Ii6ygk+wXzbhx2D452AwQKBgQD/8SfeWMYb9NYJtXDV\nMvtqoXTW2ZiuMbaJgolcT/pIdeA63Gtd1C7GjlfAnvPwFodFkBlj5oZfWdHMOV9Y\n1y2TqtTr5q3mck1ycf+axkRKxfAS5vFEjDj/8h6zXO1rdjREDEmK17FXFWItnJCd\nboJIgnN48YgjWyiHnur80PwdFwKBgQDurunOCjN1wKkU51aqMtdYY6IeZq2/RQf0\nugggHSKlXlspzHFvavheqke/5WqlTNe9luafHsLnh9wJkvBf7nElkQqJo2VgaHlH\nZCTtLLNF11VdT9vqgFz0LDITqyPpsRpeACpweaRnodJad+xcmV5R6AEJMgkTh2TH\ny8ncxgUH4QKBgDQYxmC/+TNfluHLCPictAh0bO/+wtFSVTGQXJ1puixdshLJIyGq\nOws3li0jLcxFCavjNQfcuKVYBxhm5T2ULzbLoyORhPxPb+xHwBulF+mQeNmgIKQv\nVrricdVYqQsiuGjRh3a3iOWM+LsID3e8MtDHnPGVWHy55XoVowdrEqZpAoGATBsn\n4BPunrBk+Y5eWvzFH6D9U5ZH9oIrbERZTOwdXP9+MBDJZs6EDaNcJ3sei0C6VfCk\n7r3fRfZTGhZpYR1lpKXf501biOcnLLVo9NtY+n8T8CIDrH1rpkvlV9ItLFnVX33M\nCnsvCgBWU5SDoG8i3RkOI4F51WlJoE+BuUzG0+ECgYEA7uUd+/bL6kNoldb0xn9K\n5IcR+bwG2lrQofyYUp08krp4nJ712L/octqetSaaShlw9eIVVwC42VTatkIF502t\nugd9UEy29tcJlnRvqz6FvvH3g5PZ4Ym3PH7n2qn+5rCeYnvf089MJ+FX/r7zqsUd\nW4tncCY17gNUcLR+Cpw+S54=\n-----END PRIVATE KEY-----\n",
	#  "client_email": "gcp-api-language-kschool@cpb100-162913.iam.gserviceaccount.com",
	#  "client_id": "106786631638335294490",
	#  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
	#  "token_uri": "https://oauth2.googleapis.com/token",
	#  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
	#  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/gcp-api-language-kschool%40cpb100-162913.iam.gserviceaccount.com"
	#}
```
```{r}
# Analisis del lenguaje natura. Este sistema nos devulve una lite

	lista_resultado <- lapply(df$campo, function(t) gl_nlp(t))

# Traduccion de datos
  
	# Cargamos la libreria de GOOGLE con la key JSON
	
		gl_auth('cpb100-162913-faf075966c64.json')

	# Leemos el HTML
		html <- read_html(article_url)
		
	# Traduccion de cada elemento
	
		results <- html %>% 
			html_node(".post-content") %>% 
			html_text() %>% 
			gl_translate(format="html", target="es") %>% 
			dplyr::select(translatedText)
		
```


### 9.14 Tidytext 

```{r}
Libreria para traducir texto, limpiar

library(tidytext)

	Cargamos un diccionarios en inglés	->
	
		get_sentiments("nrc")

	Generamos iuna vector con las traducciones	->
	
		traduccion <- lapply(opiniones_amazon$opinion, function(t) gl_translate(t, target = "en")$translatedText)

	 Tokenización
		Número de línea de la que proviene cada palabra
		La puntuación ha sido eliminada
		Convierte los tokens a minúsculas
		
			unnest_tokens(word, text)
			
	Carga de la palabras que no tiene pesodata
	
			data(stop_words)
	
	Elimnamos las stop_word de un DataFame
	
		text_df <- text_df %>% anti_join(stop_words)
		
```


