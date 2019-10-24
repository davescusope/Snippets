
#  SNIPPETS DE SQL Y SAS #  
## SQL ## 

### 1. TABLE CREATION WITH CONDITIONS:
```sql
PROC SQL;
	CREATE TABLE LIBRARY.TABLE_NAME AS 
   		SELECT DISTINCT 
		t1.COLUMN1 AS NAMECOLUM1,
		t1.COLUMN2,
		t1.DATE1,
		t1.DATE2
      	FROM LIBRARY.TABLE_NAME  t1
		WHERE t1.DATE1 	< TODAY() AND t1.DATE2 >= TODAY()
		AND t1.DATE1 = &PARAMETER_DATE
ORDER BY T1.COLUM2	
;
QUIT;
```
### 2. INSERT DATA INTO A PREEXISTING TABLE

#### 2.1 DIRECTLY INSERTING VALUE
```sql
PROC SQL;	
INSERT INTO LIBRARY.TABLE (COLUMN1, COLUMN2)
VALUES (‘VALUE_COLUMN1’, ‘VALUE_COLUMN2’)
;
QUIT;
```
#### 2.2 FROM ANOTHER TABLE

### 3. DELETE DATA FROM A TABLE WITH PARAM TO INDICATE THE OUTPUT LIBRARY
```sql
PROC SQL;
DELETE FROM &PARAM_OUTPUT_LIBRARY..OUTPUT_TABLE AS t1
WHERE t1.COLUMN = &PARAM_FILTER;
QUIT;
```

### 4. DATA SET JOINS
![picture alt](https://ingenieriadesoftware.es/wp-content/uploads/2018/07/sqljoin.jpeg )
#### 4.1. LEFT JOIN WITH JOIN CONDITIONS
```sql
PROC SQL;
	CREATE TABLE LIBRARY.EXAMPLE AS 
   		SELECT 
		t1.COLUMN1,
		DATEPART (t1.DATE1) FORMAT= DDMMYY10. AS FC_PERIODO, 
          	t1. COLUMN2,
 		t2. COLUMN3,
          	t1. COLUMN4

		FROM LIBRARY.TABLE1 t1 LEFT JOIN LIBRARY.TABLE2 T2 

ON t1. COLUMN1 = t2. COLUMN5
			AND t1.COLUMN2= ‘STRING REQUIRED’ 
			AND t1.DATE1 BETWEEN t2.DATE2 AND t2.DATE3
;
QUIT;
```
#### 4.2. INNER JOIN WITH FILTERS ON THE FIRST SET
```sql
PROC SQL;
   CREATE TABLE LIBRARY.EXAMPLE AS
   SELECT DISTINCT
		t1.COLUMN1 AS NAMECOLUM1,
		t1.COLUMN2,
		t1.DATE1,
		t1.DATE2,
t1.DATE3,
(t1.COLUMN3 * t3.COLUMN5) AS NEW_COLUMN_NAME
FROM LIBRARY.TABLE1 t1 INNER JOIN LIBRARY.TABLE2 T3 ON T1. COLUMN1 = T3. COLUMN5
      WHERE 
	  	INPUT(CAT("01",'/',SUBSTR("&MES_CIERRE",5,2),'/',SUBSTR("	&MES_CIERRE",1,4)),DDMMYY10.) < DATEPART(t1.DATE1)
			AND 	INPUT(CAT("01",'/',SUBSTR("&MES_CIERRE",5,2),'/',PUT(INPU	T(SUBSTR("&MES_CIERRE",1,4),4.)-1,4.)),DDMMYY10.) > 	DATEPART(t1.DATE1)

;
QUIT;
```
### 5. SUM & GROUP BY:
```sql
PROC SQL;
	CREATE TABLE LIBRARY.EXAMPLE AS 
   	SELECT  
      t1. COLUMN1, 
      t1. COLUMN2, 
      t1. COLUMN3, 
      t1. COLUMN4,
      t1. COLUMN5, 
      SUM(t1.COLUMN6) AS COLUMN_NAME

      FROM LIBRARY.TABLE1 t1

GROUP BY   t1. COLUMN1, 
      	t1. COLUMN2, 
      	t1. COLUMN3, 
      	t1. COLUMN4,
      	t1. COLUMN5, 

;
QUIT;
```

### 6. COLUMN TRANSFORMATIONS
```sql
PROC SQL;
	CREATE TABLE LIBRARY.EXAMPLE AS 
	SELECT
	T1.DATE1,   #REGULAR COLUMN
T1.COLUMN3 AS NEW_COLUMN_3 VARCHAR(50), #FORMATING
YEAR(t1.DATE1) AS YEAR ,  #COLUMN WITH EXPRESION
	DATEPART (t1.DATE-HOUR) FORMAT= DDMMYY10. AS FC_PERIODO, #EXPRESION + FORMAT
	CASE 
		WHEN t1.COLUMN2 IN (A,B)	THEN 'Z'
		WHEN t1.COLUMN2 = 'C' 	THEN 'Y'
		ELSE t1.COLUMN2
	END AS NEW_NAME_COLUMN_2, #COLUMN CREATED WITH CONDITIONS
(t1.COLUMN3 * t1.COLUMN5) AS NEW_COLUMN_NAME, #OPERATORS
(SELECT AVG(t2.COLUMN4) FROM WORK.TABLE2 T2 ) AS NEW_COLUMN3, # SUBQUERY
&PRC_MDO_CNMC AS PRC_MDO_CNMC, #VALUE FROM PARAMETRE
		
	FROM LIBRARY.TABLE T1 LEFT JOIN LIBRARY.TABLE2 ON T1.COLUM1 = T2.COLUMN 7
;QUIT;
```

 ### 7. DATA SET UNIONS
UNION  | UNION ALL
------------- | -------------
![picture alt](https://www.oracletutorial.com/wp-content/uploads/2017/09/Oracle-UNION.png) | ![picture alt](https://www.oracletutorial.com/wp-content/uploads/2017/09/Oracle-UNION-ALL.png)
          
   

```sql
PROC SQL;
	CREATE TABLE LIBRARY.EXAMPLE AS 
	SELECT
      t1. COLUMN1, 
      t1. COLUMN2

	FROM LIBRARY.TABLE1 t1 
	WHERE T1.COLUMN1>= 0

UNION ALL

	SELECT
	t1. COLUMN1, 
      t1. COLUMN2

	FROM LIBRARY.TABLE2 t1 
	WHERE T1.VALOR < 0

; 
QUIT;
```

### 8. USEFUL FUCTIONS
 
X IN Y --> Busca que X esté contenido en Y  
SUBSTR(X,2,3) --> extrae de la cadena de texto 'X', 2 caracteres empezando por la posición 3  
STRIP (X)--> Elimina espacios en blanco delante y detrás  
STRIP(LEFT(X))--> Elimina espacios a la izquierda  
STRIP(RIGHT(X))--> Elimina espacios a la derecha   
SCAN(X,'A')--> Te devuelve la posición del caracter 'A' dentro de la cadena X  
PUT(NUMERO,FORMATO) --> Convierte el numero en un texto con el formato indicado  
INPUT(TEXTO,FORMATO)--> Convierte el texto en un numero con el formato indicado  
AVG()--> Hace el promedio   
X CONTAINS Y --> Condiciona que la cadena X contenga la cadena Y  
X LIKE '%A' --> Que la cadena X termine en A   
X LIKE 'A%' --> Que la cadena X empiece por A  
CAT(X,Y,Z)--> Concatena los textos X, Y ,Z  
CATX(X,_)--> Concatena intercalando el caracter que le pases  
INTNX('month',t1.PRC_DATE,0,"BEGINNING") --> Devuelve el primer dia del mes moviendolo 0 dias, de la fecha que haya en PRC_DATE  
intnx('week.1',intnx('Month',mdy(3,1,INPUT(SUBSTR("&MES_CIERRE",1,4),4.)),0,'E'),0,'B') --> Saca el domingo de la primera semana del mes de marzo  

 
### 9.DATE TREATMENT

*DATEPART() para quedarnos con la parte de fecha de calendario(si incluye calendario y hora). ej:
datepart(t1.nombre_del_campo_de_fecha) as calculation FORMAT=YYMMN6.,

**FORMAT = XXXXXX., sirve para convertir el valor de la fecha juliana en un valor de calendario, sino, el valor obtenido seria el valor nominal juliano de SAS que toma como ref el 01/01/1960

***'01JAN2017'd  se indica con ese 'd que el valor introducido entre comillas es un valor de fecha


 #### 9.1 FORMATS

Formato de fechas numéricos General  23/07/1985

```sql
DDMMYY5.			23/07  
DDMMYY6. 			230785  
DDMMYY7.			230785  
DDMMYY8.			23/07/85  
DDMMYY10.			23/07/1985  
YYMMN4.				8507  
YYMMN6.				198507  	
YYMMDD8.			85-07-23  
YYMMDD10.			1985-07-23  
MMDDYY2.			07  
MMDDYY4.			0723  
MMDDYY8.			07/23/85  
MMDDYY10.			07/23/1985  
DATE9.				27JUL1985  
DATETIME20.			27JUL1985:00:00:00  	
```

Formato de fechas en Español 23/07/1985
```sql
ESPDFDD. 			23.07.1985   
ESPDFDE. 			23JUL1985   
ESPDFDN.  			31, la semana del año  
ESPDFDT. 			fecha-hora con formato español  
ESPDFDWN. 			domingo  
ESPDFMN. 			julio  
ESPDFMY. 			JUL85  
ESPDFWDX. 			23 DE JULIO DE 1985  
ESPDFWKX. 			DOMINGO, 23 DE JULIO DE 1985  
```

#### 9.2 Fuctions (date as reference 23/07/1985)
```sql
day()*				23 (formato numérico sin cero)  
month()*			7 (formato numérico sin cero)  
year()*				1985 (formato numérico sin cero)  
datejul('23jul85'd)*		16879 (devuelve la fecha en forma juliana)  
datepart() 			extrae la parte de fecha de una fecha-hora
datetime() 			extrae la parte horaria  de una fecha-hora
```

#### 9.3 Most used transformations

1.Definir diciembre del año anterior desde &MES_CIERRE
```sql
CAT("01",'/', "12",'/',PUT(INPUT(SUBSTR("&MES_CIERRE",1,4),4.)-1,4.)) 
```
2. Convertir &MES_CIERRE en una fecha con formato
```sql
INPUT(CAT("01",'/', SUBSTR("&MES_CIERRE",5,2) ,'/',SUBSTR("&MES_CIERRE",1,4) ),DDMMYY10.)
```
3. Convertir una fecha a valor numérico compatible con &MES_CIERRE
```sql
INPUT(PUT(t1.PRC_MONTH,YYMMN6.),6.) AS MES  	#-->NUMERICO  
PUT(t1.PRC_MONTH,YYMMN6.) AS MES  		#-->ALFANUMERICO
```



 
### 10. QUERY WITH RECURSIVE SUBQUERY EXAMPLE
```sql
PROC SQL;
	CREATE TABLE WORK.DATA_COEFICIENTES_AUSENCIAS AS
	SELECT 
		   t1.MES,
		   t1.ID_DISCRIM,
		   t1.ID_UPR,
		   t1.ID_UPR_AGRUPACION,
		   T1.ID_CONCEPTO_CTRL,
		   . AS VALOR,
		   (SELECT t2.COEFICIENTE
		   	    FROM WORK.DATA_COEF_PROD t2
				WHERE t1.ID_UNIDAD = t2.ID_UNIDAD
				AND t1.ID_UPR = t2.ID_UPR
				AND T1.ID_CONCEPTO_CTRL = T2.ID_CONCEPTO_CTRL
		   		AND t2.MES = (SELECT MAX(t3.MES)
							  FROM WORK.DATA_COEF_PROD t3
							  WHERE t3.ID_UNIDAD = t2.ID_UNIDAD
							  AND t3.ID_UPR_AGRUPACION = t2.ID_UPR_AGRUPACION
							  AND T3.ID_CONCEPTO_CTRL = T2.ID_CONCEPTO_CTRL
							  AND t3.MES < t1.MES
							  AND EXISTS (SELECT 1
									      FROM WORK.DATA_COEF_PROD t4
							  			  WHERE t4.ID_UNIDAD = t3.ID_UNIDAD
							  			  AND t4.ID_UPR_AGRUPACION = t3.ID_UPR_AGRUPACION
										  AND t4.MES = T3.MES
										  AND T4.ID_CONCEPTO_CTRL = T3.ID_CONCEPTO_CTRL
										  GROUP BY t4.ID_UPR_AGRUPACION, t4.ID_UNIDAD, T4.ID_CONCEPTO_CTRL
										  HAVING ROUND(SUM(COALESCE(T4.COEFICIENTE,0)),.1)=1
										 )
							 )
				 
			) AS COEFICIENTE,
			t1.ID_UNIDAD

	FROM WORK.DATA_AUSENCIAS t1
	;
QUIT;
```
 
## SAS

### 1.Variables Definition 
```sql
/*Definimos variables que sustiyen a los parametros de fechas de forma global*/
/*Dejamos comentadas las variables que irian en formato string despues ya que usamos directamente el formato fecha*/


%GLOBAL LIQ_ASOF_DATE;
%GLOBAL LIQ_ASOF_DATE_CO2;
%GLOBAL MAX_FECHA_REAL_FC;




DATA _NULL_;
SET PYC_EMI.CONFIG_DATES ;  
WHERE VERSION=&MES_CIERRE;

IF _N_ = 1 THEN do;
	%LET LIQ_ASOF_DATE=.; 
	%LET LIQ_ASOF_DATE_CO2=.; 
	%LET MAX_FECHA_REAL_FC=.;
end;

IF 	   TRIM(PARAMETER) = 'LIQ_ASOF_DATE' 		THEN do; CALL SYMPUT('LIQ_ASOF_DATE',DATE); 	end;
ELSE IF TRIM(PARAMETER) = 'LIQ_ASOF_DATE_CO2' 	THEN do; CALL SYMPUT('LIQ_ASOF_DATE_CO2',DATE); end;
ELSE IF TRIM(PARAMETER) = 'MAX_FECHA_REAL_FC' 	THEN do; CALL SYMPUT('MAX_FECHA_REAL_FC',DATE); end;
;
RUN;
```


### 2. Functions

Funciones y Procedimientos  a tener en cuenta en SAS

*lag() Fija el valor de la anterior observación de la tabla y fila que se defina.

```sql
data work.uscpi;
      set work.uscpi;
      cpilag = lag( cpi );
run;
```

*lagX() Fija el valor de la observación X veces anterior a la elegida de la tabla y fila que se defina.
```sql
data work.uscpi;
      set work.uscpi;
      cpilag = lag2( cpi );
run;
```

*First: Después de haber ordenado una tabla por una serie de variables la función first indica el primer registro por orden.
```sql
	data work.sedanTypes; 
   		set work.cars; 
   		by 'Sedan Types'n; 								
   		if 'first.Sedan Types'n then type=1;   
	run;  
```
*Last:  Después de haber ordenado una tabla por una serie de variables la función last indica el último registro por orden.
```sql
data work.new;
	set work.temp;
	by group;
	last=last.group;
run;
```
*Transpose: Procedimiento de SAS que permite cambiar filas por columnas. Muy útil para convertir valores en variables.
```sql
proc transpose data=work.temp
	out=work.outdata
	prefix=Columna
	let
	name=Fuente
	label=Etiqueta
	;
	BY  	id;
	  	var scores;
	  	id height;
	  	idlabel heightl;
run;
```
*Retain: Procedimiento de SAS que permite cambiar filas por columnas. Muy útil para convertir valores en variables.
```sql
proc sort data=work.ejemplo; 
	by region sales; 
quit;
data work.ranking;
	set work.ejemplo;
	by region;
	retain posicion ;
	if first.region then posicion=1;
	else posicion=posicion+1;
run;
```

###4. Environment variable creation
 
Definimos variable de entorno( a partir de ahora simplemente ENTORNO)  como una variable de selección que nos permite navegar entre librerias sin necesidad de modificar el codigo de los proyectos donde se emplea.

Suponiendo que tenemos dos librerías:

```sql
LIBNAME PYC_EMI META LIBRARY= PYC_EMI METAOUT=DATA;
LIBNAME PYC_DEV META LIBRARY= PYC_DEV METAOUT=DATA;
```

La variable se define en el editor de SAS guide. Cada vez que hagamos referencia a ENTORNO, lo haremos precedido del signo de aspersan ( &)  y se emplea punto como separador entre tabla y libreria.

Aquí sería el ejemplo:
```sql
PROC SQL;
    INSERT INTO &ENTORNO..DATA_DERIVADOS_VC
	SELECT &MES_CIERRE AS VERSION, 
```

*Creación de una macro de inserción o creación:

Se emplea una macroinstrucción de SAS que permite decidir entre crear una nueva tabla, o insertar en la tabla anterior, en el momento de ejecución del proyecto. ( Sin necesidad de modificar el código para tal fín).

Una macroinstrucción es una instrucción compleja, formada por otras instrucciones más sencillas. Esto permite la automatización de tareas repetitivas.
Las macroinstruciones se escriben dentro del lenguaje SAS; una vez escrita, el procesador de macros lee el macro lenguaje y lo transforma el código ya revisado. 

En SAS existen dos llamadas a variables: 
	&name -> las cuales son referencias a valores varialbes. 
	 %name-> las cuales son referencias a instrucciones repetitivas y recursivas

Observese el ejemplo siguiente donde creamos una macro para diferenciar entre inserción y creación:


```sql
%MACRO DATA_INTO_TABLE(ACCION);

%IF &ACCION=INSERCION %THEN %DO;

     PROC SQL;
          DELETE FROM &ENTORNO..DATA_DERIVADOS_CO2 AS t1
          WHERE t1.VERSION = &MES_CIERRE;
     QUIT;

     PROC SQL;
          INSERT INTO &ENTORNO..DATA_DERIVADOS_CO2
          SELECT &MES_CIERRE as VERSION,
                   TODAY() AS FECHA_EXTRACCION FORMAT=ddmmyy10., 
                   t1.* 
          FROM WORK.DATA_CO2 t1;
     QUIT;

%END;

%IF &ACCION=CREACION %THEN %DO;

     PROC SQL;
          CREATE TABLE &ENTORNO..DATA_DERIVADOS_CO2 AS
          SELECT &MES_CIERRE as VERSION,
                   TODAY() AS FECHA_EXTRACCION FORMAT=ddmmyy10., 
                   t1.* 
          FROM WORK.DATA_CO2 t1;
     QUIT;

%END;

%MEND;
%DATA_INTO_TABLE(&ACCION);
```


El % referencia código macro. 
Cada vez que se emplea %, se inicia codigo SAS macro y por lo tanto todas las sentencias se inician con %, ejemplo (%if, %do etc) y la macro se acaba con %mend.

Cuando vamos a hacer el llamamiento a la macro en cualquier parte del programa donde la hayamos escrito tendremos que meter % nombre de la macro y entre paréntesis los paramentros con los valores que va a recibir. 



```sql

INDEX(X,'A')--> Posicion de A en la cadena X

FUNCIONES MATEMATICAS:
SQRT(X) --> RAIZ DE X
ABS(X) --> VALOR ABSOLUTO DE X
COS(X) --> COSENO DE X
EXP(X) --> EXPONENTE DE X
LOG(X) -->  LOGARITMO DE X
SIN(X) --> SENO DE X
MIN(A) -->  DEVUELVE EL MINIMO DE A
MAX(A) -->  DEVUEVLE EL MAXIMO DE A
ROUND ( variable, unidad de redondeo) --> Redondea la variable a la unidad de redondeo.
INT ( variable) -->  Toma la parte entera de la variable. 
LAGn(variable)-. Devuelve el valor leído n iteraciones antes en el paso data.
DIFn(variable)-.Devuelve el valor var-lagn(var)

Funciones de generación de números aleatorios
RANBIN(semilla,n,p) -->  Genera una Observación de una B(n,p).
RANEXP(semilla) -->  Genera una Observación de una EXP(1).
RANGAM(semilla,a) -->  Genera una Observación de una Gamma(a).
RANNOR(semilla) -->  Genera una Observación de una N(0,1).
RANUNI(seed) -->  Genera una Observación de una U(0,1).
```

Ejemplo: generación de números aleatorios; genera el archivo uno con una sola observación y las variables x=U(0,1) e y=N(5,3). 
```sql
data uno;
 x=ranuni(0);
 y=rannor(0)*3+5;
 z=
run;
```


Bloques DO; ...;END 

data dos;
 set uno;
if edad<15 then
 do;
 edad=edad+7;
 tasa=altura/edad;
 end;
else
 do;
 edad=edad-5;
 tasa=altura/edad -4;
end;
run;

/*crear tabla con valores meses definidos por nosotros*/
data COLLAR_MESES;
	do i = 1 to INPUT(SUBSTR("&MES_CIERRE",5,2),2.);
		MES=input(catx('/', '01',i, SUBSTR("&MES_CIERRE",1,4)),ddmmyy10.);
		HORAS_MES= INTCK('HOUR',
						 DHMS(input(catx('/', '01',i, SUBSTR("&MES_CIERRE",1,4)),ddmmyy10.),0,0,0),
						 DHMS(intnx('month',input(catx('/', '01',i, SUBSTR("&MES_CIERRE",1,4)),ddmmyy10.),1),0,0,0));
	  output;
	end;

	format MES ddmmyy10.;
run;


BUCLES EN SAS:

Ejemplo: sintaxis básica de la sentencia do;…;end; (1)
data;
do i=1 TO 5;
 put 'HOLA';
end;
run;

data uno;
length mes $ 15;
conta=0;
do mes='enero', 'febrero','abril';
 conta=conta+1;
 put conta mes;
end;
run;
Aparece en la ventana LOG:
1 enero
2 febrero
3 abril 


data uno;
do cuenta=3 to 5, 20 to 26 by 2;
 output;
end;
run;
El archivo uno creado es:
Obs cuenta
 1 3
 2 4
 3 5
 4 20
 5 22
 6 24
 7 26


Ejemplo: sentencia do while(expresion);…;end;
data;
 n=0;
do while(n < 5);
 put n=;
 n=n+1;
end;
run;
Pondría en la ventana LOG:
n=0
n=1
n=2
n=3
n=4

Ejemplo: combinación de formatos DO, DO UNTIL, DO UNTIL y DO WHILE
data;
 suma=0;
do i=1 to 10 by .5 while(suma < 8.5);
 suma=suma+i;
 put suma=;
 end;
run;
Pone en la ventana LOG:
suma=1
suma=2.5
suma=7
suma=10 




CODIGO SAS PARA SEPARAR TEXTO:
/*Separar los campos CUENTA y TEXTO*/
DATA WORK.CONFIG_PARAM_2;
SET WORK.CONFIG_PARAM;
DO I=1 TO LENGTH(PARAM_ID);
	IF SUBSTR(PARAM_ID,I,1)='_' 				
			THEN 
				DO;
					CUENTA=SUBSTR(PARAM_ID,1,I-1);
					TEXTO=SUBSTR(PARAM_ID,I+1,LENGTH(PARAM_ID));
					I=LENGTH(PARAM_ID);
				END; 
END;
OUTPUT;
RUN;


/* Importar ficheros Excel */
proc import out=veo
datafile="c:\pasas\alumnos.xls"
dbms=excel97 replace;
sheet="hs0";
getnames=yes;
run;



ARRAYS:

Ejemplo: Supongamos que los datos son
data tiendas;
input ciudad $ edad domk wj hwow simbh kt aomm libm tr filp ttr;
array tienda (10) domk wj hwow simbh kt aomm libm tr filp ttr;
** cambias todos los ceros a valores missing;
do i=1 to 10;
if tienda(i) = 0 then tienda(i) = .;
end;
cards;
Zaragoza 54 4 3 5 0 0 2 1 4 4 0
Valencia 33 5 2 4 3 0 2 0 3 3 3
Oviedo 27 1 3 2 0 0 0 3 4 2 3
Santander 41 4 3 5 5 5 2 0 4 5 5
Sevilla 18 3 4 0 1 4 0 3 0 3 2
;
proc print data = tiendas;
run;

Ejemplo: transformación similar de varias variables usando arrays (1)
data uno;
array grupo a b c;
 input a b c;
 do i=1 to 3;
 if grupo{i}<4 then grupo{i}=4;
 end;
cards;
2 3 6
1 2 5
;
crea el  archivo uno, con las siguientes variables y observaciones:
a b c
4 4 6
4 4 5 


PROCEDIMIENTOS SAS: 
	PROC SORT(ORDENA)
	PROC TRANSPOSE (TRANSPONE)
	PROC CONTENTS (INFORMACION SOBRE ARCHIVOS)
	PROC FORMAT (UTILIDADES DE FORMATO DE LECTURA Y ESCRITURA)
	PROC PRINT(LISTADO DE LAS VARIABLES, LAS PINTA)
	PROC TABULATE (TABLAS)
	PROC MEANS, PROC UNIVARIATE (CALCULOS ESTADISTICOS)
	PROC CLUSTER(ANALISIS CONGLOMERADOS) PROC ANOVA (ANALISAS DE LA VARIANZA)

GRAFICOS:  PROC GPLOT, PROC GCHART...



Ejemplo: destinar por defecto a archivos de texto las salidas de la ventana OUTPUT y
LOG
 En el siguiente programa se destina al archivo datoslog.txt el contenido de la ventana LOG,
y al archivo datoutput.txt el contenido de la ventana OUTPUT.

proc printto log='c:\datlog.txt' print='c:\datoutput.txt';
run;
	data dos;
 		set uno;
 		if salario<1000 then put 'salario<1000' +5 'observación nº ' _n_;
	run;
	proc print data=uno noobs;run;

Aparecerá en el archivo c:\datlog.txt:



El procedimiento sort ordena el archivo por las variables indicadas.

proc sort data=archivo [OUT=archivo];BY variables;
run; 



El procedimiento transpose:

Ejemplo: transposición de un archivo SAS
data orig;
 input x y;
cards;
1 2
4 5
6 7
4 5
;
proc transpose data=orig prefix=a name=nombres out=trans;
run;
proc print data=trans;
run;
da como resultado en la ventana OUTPUT:
OBS NOMBRES A1 A2 A3 A4
 1 	X     1 4   6 4
 2 	Y     2 5   7 5 


PROC REG:
El procedimiento REG estima los parámetros de regresión por mínimos cuadrados,
aportando todas las opciones propias del análisis de regresión (tabla ANOVA, residuos, etc.). 


data uno (drop=i epsi);
 do i=1 to 20;
 epsi=rannor(111)*sqrt(6);
 x=rannor(222)*3+4;
 y=2+3*x+epsi;
 output;
 end;
run;
symbol i=rl v=star c=black;
proc gplot data=uno;plot y*x / overlay;run; 


proc reg data=uno;model y=x;
output out=dos r=resi p=predi;
run; 



keep mantiene en memoria las variables nombradas
drop elimina las variables nombradas
set Lee el/los fichero(s) dado(s). Si se nombra m´as de un fichero, se combinan en uno
merge Mezcla ficheros
where Condicionales
