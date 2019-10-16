
# Python Snippets for Data Science

### Keyboard Shortcuts

<b> Command Mode </b>

Press Esc to enable the Command Mode and then press H to enter in the Keyboard Shortcuts Guide (Blue Color labeled)


```python
# shift + enter -- run cell, select below
# ctrl + enter -- run cell
# option (left Alt) + enter -- run cell, insert below
# A -- insert cell above
# B -- insert cell below
# C -- copy cell
# V -- paste cell
# D , D -- delete selected cell
# I , I -- interrupt kernel
# 0 , 0 -- restart kernel (with dialog)
# Y -- change cell to code mode
# M -- change cell to markdown mode (good for documentation)
# shift + M -- merge selected cells, or current cell with cell below if only one cell selected
```

<b> Edit Mode </b>

Press in any cell to enable the Edit Mode on it (Green Color labeled) 


```python
# ctrl + click -- multi-cursor editing
# option + scrolling click -- column editing
# ctrl + /  -- toggle comment lines
# ctrl + ç  -- toggle comment lines
# tab -- code completion or indent
# shift + tab -- tooltip on selection
# ctrl + shift + - split cell in two (Edit Mode) 
```

### Magic Commands


```python

%%timeit
df.unstack?
help[df.unstack]
history                 #muestra el historial de comandos ejecutados en el notebook
! ls
! pwd                   #devuelve la ruta donde estamos trabajando
! cd                    #el cd de python sirve para moverme, despues de moverse, vuelve automaticamente a la ruta inicial
! bzcat ./bookings_sample.csv.bz2 | wc -l #nos dice cuantas lineas tiene el archivo que hemos importado
!conda install --yes GeoBases #instala una libreria cualquiera en el directorio de conda, en este caso GeoBases


```


```python
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
%matplotlib inline
plt.style.use('ggplot')
import os as os
import zipfile as zp
import bz2     as bz2             # libreria estandar para archivos comprimidos
```


```python
import sqlite3
conn = sqlite3.connect('example.db') #Para conectar con una db de sqlite
```


```python
# importar archivos html
from IPython.display import IFrame
IFrame('readme.html', width=700, height=350)
```

Importación y exportación de archivos


```python
#Defining path to  file in the same folder as jupiter
my_file_path='xxx.csv'
```


```python
# Importar archivo de excel , Csv o SQlite
df = pd.read_excel('out.xls', 
                    index_col=0, 
                    header=7, 
                    sheet='2010', 
                    skip_footer=1,
                    usecols='A:K'))

df = pd.read_csv(my_file_path)
df.head()

pd.read_sql_query('SELECT * FROM traffic WHERE SEATS > 160', conn)
```


```python
# exportar archivo a excel o csv
df.to_excel('out.xlsx')
df.to_csv('out.csv')
```

Acciones a realizar sobre los Data Frames


```python
# Acciones de inspeccion del contenido

df.describe()                                 # Devuelve una descripción del contenido con medidas arimeticas  
df.shape                                      # Devuelve la forma del df 
df.dtypes                                     # Devuelve los tipos de datos 
df.size                                       # Devuelve el tamaño del df 
df.corr()                                     # Devuelve las correlaciones entre las columnas numericas del df
df.count()                                    # Devuelve el count de las columnas 
df.info                                       # Devuelve información sobre el df
```


```python
# Busquedas y funciones estadisticas sobre df's

pd.set_option('display.max_columns',100)        #muestra 100 columnas
pd.set_option('display.max_columns',None)       #para devolverlo a ninguna
df[df['LUGAR'].str.startswith("ARDEMANS").strip()]
df[df['LUGAR'].str.contains("ARDEMANS").strip()]
df['IMP_BOL'].mean()
df['IMP_BOL'].sum()
df['IMP_BOL'].count()
df['IMP_BOL'].max()
df['IMP_BOL'].min()
def peak_to_peak(s): #Maximo menos el mínimo
    return s.max() - s.min()
def rango_normal(s):#2 std por cada lado
    return 4*s.std()


# Data transformations
df2=df1.copy()                                 # Crea una copia por valor y no por referencia
df1.drop('column')
df1.duplicated()                               # Boolean que informa de los duplicados
df1[df1.duplicated()]                          # Se queda con los duplicados
df1.drop_duplicates(keep='last',inplace=False) # Elimina los duplicados quedandose con el ultimo de ellos
df1.isna                                       # Indicate missing values.
df1.notna                                      # Indicate existing (non-missing) values.
df1.fillna                                     # Replace missing values.
df1.dropna                                     # Drop missing values.
Index.dropna                                   # Drop missing indices.
df1['data'].fillna.mean()                      # Rellena los vacios con el valor que le pongamos
df1.index = list('plfjdmh')                    # Renombra el indice df1.index = range (7)

df1.rename(columns={'age': 'is_just_a_number'}, inplace=True)
df1.sort_values(by='DepDelay', ascending=False).head()


# Numerical transformations
df1 = np.arange(0,24).reshape(4,6)             # Creación de df y redimensionado con numpy
np.round(df1.head(20),decimals=1)              # Redondea valores
X = np.linspace(0, 10, 50)                     # Crea una linea de 50 puntos de rango  0 a 10
X = np.random.randn(100)                       # Crea una nube de 100 puntos
X = np.sin(X)
X = np.cos(X)
X = np.tanh(X)
X = np.exp(X)
ts = pd.to_datetime('2015-01-15 08:30')        # This is the format pd.to_datetime needs Timestamp('2015-01-15 08:30:00')



# Acciones de entrelazado de df's 

df1.merge(df2) #si no se especifica, hace inner por la columna común segun el nombre de columna
df1.merge(df2, how='inner')
df1.merge(df2, how='outer')
df1.merge(df2, how='left')
df1.merge(df2, left_on='column_on_the_left', right_on='column_on_the_right')
df1.merge(df2, on='key', suffixes=['_left', '_right'])
df1.merge(df2, left_on='key', right_index=True) # merge on index

pd.concat([df1, df5])           #concatena en el eje x
pd.concat([df1, df5], axis = 1) #concatena en el eje y
a = df.groupby('producto')['balance'].mean() #realiza un group by que devolverá la media de la columna balance según producto
df1.groupby(['producto', 'vendedor']).agg(['mean', 'count']) #con agg lo que hacemos es poder pedir todas las funciones que queramos sobre una agregación de groupby
                                                            #group by según producto y vendedor que devuelve la media y la cuenta de todas las columnas numericas
df1.groupby('producto')['vendedor'].agg(lambda strseries: strseries.str.len().sum()) # en vez de usar una función definida, usa una labda creada para sumar los caracteres
df1.groupby('market')['data'].apply(lambda x: x.fillna(x.mean())) # Podemos utilizar apply para aplicar una función sobre la serie
                                                                    # Apply siempre espera una función como argumento
df1.unstack('vendedor') #pivota la tabla como transpuesta sobre la columna vendedor
df1.pivot(columns='vendedor')




#ejemplo que engloba todo lo anterior
df[df['vendedor']=='Celia'].groupby('producto').mean().unstack()
```

String Manipulation


```python
#en pandas, cuando trabajamos con strings, hay que definirlo como tal
#con pandas no hay qu definir ninguna fucnion lambda para que afecte sobre todos los elementos de la lista (map),
#directamente pandas nos permite hacer transformaciones que ya afectan directamente a la serie entera

animals_series.str
animals.columns.str.strip()                #quita los espacios en los nombres de las columnas
animals_series.str.split()
animals_series.str.capitalize()
animals_series.str.upper()
animals_series.str.len()
animals_series.str.count()
animals_series.str.contains('m')
df1['animals']=df1['animals'].str.upper() #cambio la columna animals por si misma pero en mayusculas
```

Ejemplo de archivo importado y navegación por él


```python
all_accidents = pd.read_excel(file_path, index_col=0, header=7, sheet_name=None)
all_accidents['2009'] #por ejemplo
list1 = all_accidents.keys()
for year in list1:
    print (year)
    df2 = all_accidents[year]
    df2['YEAR'] = year 
```

Actuación si se elimina una función restringida en algún modulo


```python
del(pd.concat) #se borra la función que hayamos renombrado y por ello ya no funciona la original
import imp     #importamos imp y desde ahi recargamos pandas
imp.reload(pd)
```

Representación Gráfica


```python
plt.hist(ages,bins=bins)                   # Grafico tipo histograma donde le definimos los ejes y los intervalos que se llaman como nuestra lista (bins)
plt.plot(X, X,'r--',label=r'lin');         # Grafico ordinario ; el -- hace que la linea sea discontinua
plt.legend(['Sin', 'Identity'],loc=2);     # Leyenda del grafico
plt.bar();                                 # Grafico de barras
plt.scatter(x,y,color='b');                # Grafico de puntos
plt.show()

#Definimos una función para ver las posibilidades de modificación de parametros en plt
def set_fig_props():
    plt.rcParams['figure.figsize']=(10.0,8.0)
    plt.rcParams['savefig.dpi']=300
    plt.rcParams['figure.facecolor']='white'
    sizefont=30
    font={'family':'normal','weight':'normal','size':sizefont}
    plt.rc('font',**{'family':'serif','serif':['Computer Modern'],'size':sizefont})
    plt.rc('xtick',labelsize=sizefont)
    plt.rc('ytick',labelsize=sizefont)

    
fig, axs = plt.subplots(2,2)                #Crea un plot de 4 subplots forma de matriz 2,2
axs[0,0].plot (X,Y, 'r--')                  #recta discontinua roja
axs[0,1].plot (X,X,c='purple' ,'bs')        #cuadrados azules 
axs[0,1].plot (X,X,c='purple' ,'g^')        # triangulos verdes
axs[1,0].scatter (X2,Y2_randomized,c='green')
axs[1,1].scatter (X,Y,c='blue')
 
```

Gestión de errores try-except


```python
#usa los try error por si acaso dan fallos al abrir el archivo
filename2 = './bookings_sample.csv'
try:
    with open (filename2, "r") as file_input:
        for p, line in enumerate(file_input):
            pass

    print ( "%s has %d lines"%(filename2, p+1))
except IOError:
    print ("Error.File did not open")
except ValueError:
    print("Cannot convert to integer")
except:
    print("Unknown error")
```

partición de ficheros grandes con iterator = true and get_chunk


```python
#del fichero, no un data frame, pero al poner el iterator = True, corre un marcador donde al
# ejecutarlo por segunda vez, nos sacaria las siguientes lineas

df2 =pd.read_csv(filename2, sep='^', usecols=['year','pax','arr_port'],iterator = True)
# nos devuelve una lecdtura del fichero, no un data frame, pero al poner el iterator = True, corre un marcador donde al
# ejecutarlo por segunda vez, nos sacaria las siguientes lineas

b0=df2.get_chunk(6000)
b1=df2.get_chunk(3000) #traemos las siguientes 3000
#...
```


```python
# ahora lo hacemos definiendo el tamaño maximo del chunk en vez de un iterator
df2 =pd.read_csv(filename2, sep='^', usecols=['year','pax','arr_port'],chunksize=1000)
```


```python
bc =pd.read_csv(filename2, sep='^', usecols=['year','pax','arr_port'],chunksize=1000)
for i, chunk in enumerate(bc):
    print(chunk.head())
    print("-----------")
    if i==3:
        break
```


```python

```


```python

```


```python

```


```python

```


```python

```


```python

```


```python

```


```python

```


```python

```


```python

```


```python

```


```python

```


```python

```
