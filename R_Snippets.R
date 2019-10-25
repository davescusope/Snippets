
#########################################
Carga de libreriar durante la ejecucion #
#########################################

# Creamos un vector con la lista de librerias a cargar
list.of.packages <- c("R.utils", "rvest", "stringr", "foreach", "doParallel")

# Las librerias las buscamos en la varialbe interna installed.packages() y sacamos las
# que o esten en la lista buecando en el campo[,"Package"] del DataFrame devulveto
# de la funcion  installed.packages()
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]

# Si el vector devulveto tiene tamañan, instalamos las librerias que quedan en el vector
if(length(new.packages)) install.packages(new.packages)


remove.packages("data.table")			# elimina una libreria de la memoria
