#################################################################
#              Curso de análisis de datos con R
#Asociación Argentina de Bioinformática y Biologíca Computacional
#                         Octubre 2020
#            Práctica Elementos básicos de R
#################################################################
#1) Asignale a la variable x el valor 2 y a la variable y el valor “10”. Ahora asignale a la variable w el valor x+y y a la variable z el valor x == y (observá que tiene dos signos = y no sólo uno, ¿Por qué?). ¿De qué clase son estas dos últimas variable?. Ayuda: la asignación de una variable se realiza con el operador “<-”, así por ejemplo para asignar el valor “Hola Mundo” a la variable Saludo debo tipear Saludo<-”Hola Mundo”
x <- 2
print(x)
y <- 10
print(y)
w <- x + y
print(w)
z <- x == y
print(z)

#2) Creá una variable que se llame “GFP” y asignale el valor 509. ¿Qué clase de dato es? Ahora convierte la variable “GFP” en “character”. Ayuda:  tipeá en la consola ?as.character
GFP <- 509
class(GFP)
GFP <- as.character(GFP)
class(GFP)

#3) Asignale a la variable GFP el valor “verde” e intenta convertirla en la clase numeric ¿Qué ocurre?
GFP <- "verde"  
as.numeric(GFP)

#4) Crea un vector que se llame “r1” que contenga 10 números aleatorios entre -100 y 100. Ayuda: ?runif.
r1 <- runif(n = 10, min = -100, max = 100)

#5) Con la misma operación que en el ejercicio anterior crea un nuevo vector r2, ahora realiza las siguientes operaciones: r1+r2, r1*r2, r1/r2. ¿Cómo realiza R estas operaciones?
r2 <-  runif(n = 10, min = -100, max = 100)
r1 + r2
r1 * r2
r1 / r2

#6) Intenten ordenar de mayor a menor y de menor a mayor el vector r1. ¿De qué largo es el vector r1?¿Cómo podría agregarle un elemento al vector r1? Ayuda: ?sort,  ?length
sort(r1)
length(r1)
nuevo_elemento <- runif(n = 1, min = -100, max = 100)
r1 <- c(r1, nuevo_elemento)
length(r1)

#7) A partir de un vector “Co2” con los siguientes elementos: “Bajo”, “Medio” y “Alto”; crea un objeto de tipo factor. ¿Qué niveles (o levels) tiene? Ahora cambia el primer valor del objeto por “Medio” de la siguiente forma Co2[1] <- “Medio” ¿Cambiaron los niveles del objeto Co2? Ahora si quiero cambiar el primer valor por “Muy bajo”, ¿Qué ocurre? ¿Por qué? Ayuda: ?factor
Co2 <- factor(c("Bajo", "Medio", "Alto"))
Co2
levels(Co2)
Co2[1] <- "Medio"
Co2
Co2[1] <- "Muy bajo"

#8) Creá dos vectores. Uno llamado fp que contenga los siguientes datos: "Sirius", "CFP", "GFP", "Citrine", y otro llamado nm que contenga los siguientes valores: 424, 476, 509, 528. A partir de estos dos vectores crea un dataframe que se llame df_fp. Con la función class comprueba que el objeto creado es de la clase data.frame. Ayuda: ?cbind, ?as.data.frame
fp <- c("Sirius", "CFP", "GFP", "Citrine")
nm <- c(424, 476, 509, 528)
df <- data.frame(fp, nm)
class(df)
df

#9) Crea una matriz m de 3x3 dimensiones que contenga en todas las posiciones el valor 0. Ayuda: ?matrix, ?rep
m <- matrix(0, ncol = 3, nrow = 3)
m
#10) A la matriz del punto anterior cambiale el valor de la primera fila y columna por “Bla” con el siguiente código: m[1, 1] <- “Bla”. Imprimir el resultado en pantalla, ¿Qué ocurrió con el resto de los valores de la matriz? ¿Por qué?
m[1, 1] <- "Bla"  
m

#Subsetting

#11) Generen dos listas a partir de las siguientes sintaxis: nombres1 <- list(c("Juana", "Pedro", "Camila")) y nombres2 <- list("Juana", "Pedro", "Camila"). ¿Cuántos elementos tienen cada una de ellas? Para cada caso intenten imprimir en pantalla solamente el nombre Camila
nombres1 <- list(c("Juana", "Pedro", "Camila")) 
nombres1
nombres2 <- list("Juana", "Pedro", "Camila")
nombres2

#A partir del paquete dataset generen un data.frame “air” que contiene datos climáticos de la ciudad de Nueva York, usando el siguiente comando: air <- datasets::airquality.
#Cargamos el dataset
air <- datasets::airquality

#12) Imprime en pantalla solamente las primeras filas del data.frame y luego las últimas. Ayuda: ?head, ?tail
head(air)
tail(air)

#13) Imprime en pantalla todos los valores correspondientes con la Temperatura registrada y luego solamente el valor de Temperatura que se registró el tercer día.
air$Temp #Todas
air$Temp[3] #Solo el 3er día

#14) Seleccioná todas las filas de air del mes de mayo.
mayo <- air[air$Month == 5, ]
mayo

#15) ¿Qué día fue en el que hubo menor radiación solar? Ayuda: ?which.min
air[which.min(air$Solar.R), ]

#16) ¿Cuál fue la temperatura el 27 de Agosto? Ayuda: ?which, & (and)
air[which(air$Month == 8 & air$Day == 27), ]

#17) Seleccioná todas las filas de air del mes de mayo cuya radiación solar sea mayor a 150.
mayo[mayo$Solar.R > 150, ]

#18) Genera un nuevo data.frame llamado “calor” que contenga la información de los días en los que hizo más de 90 °F.  Utilizando la función table contesta a qué meses pertenecen los días más calurosos.
calor <- air[air$Temp > 90, ]
head(calor)
table(calor$Month)
#Agosto (el mes 8) tiene mayor cantidad de días calurosos

#19) La temperatura en el data.frame está expresada en grados Fahrenheit, convierte la columna de temperaturas para que las mismas se expresen en grados Celsius. Ayuda: °C = (°F - 32)/1.8
convertir <- function(f){
  return((f - 32)/1.8)
}
air$Temp <- convertir(air$Temp)
