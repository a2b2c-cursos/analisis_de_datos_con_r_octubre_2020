#################################################################
#              Curso de análisis de datos con R
#Asociación Argentina de Bioinformática y Biologíca Computacional
#                         Octubre 2020
#            Práctica Estadística descriptiva y AED
#################################################################

#Primero le decimos a R en qué directorio queremos que trabaje
setwd("~/trabajo/cursos/analisis_de_datos_con_r_octubre_2020/clases/clase_3")

#1)
#Cargamos los casos de covid por país
cases.covid.19.by.country <- read.csv("datasets/cases-covid-19-by-country.csv", stringsAsFactors=FALSE)

#Cantidad de datos
nrow(cases.covid.19.by.country)

#Cantidad de atributos
ncol(cases.covid.19.by.country)

#Tipo de los atributos
str(cases.covid.19.by.country)

#Nombre de los atributos
colnames(cases.covid.19.by.country)

#Primeros 5 y últimos 5 datos
head(cases.covid.19.by.country, n = 5)
tail(cases.covid.19.by.country, n = 5)

#El dataset consiste en 213 observaciones con 3 atributos cada una. El nombre del país es un atributo tipo 
#character, mientras que el acumulado de casos y el acumulado de fallecimientos es numérico.

#2)
#Medidas de centralidad, media, mediana y moda
mean(cases.covid.19.by.country$cum_conf)
median(cases.covid.19.by.country$cum_conf)
which.max(table(cases.covid.19.by.country$cum_conf))

mean(cases.covid.19.by.country$cum_death)
median(cases.covid.19.by.country$cum_death)
which.max(table(cases.covid.19.by.country$cum_death))

#Son muy diferentes las tres medidas

#Medidas de dispersión, rango, desvío estandar e IQR
max(cases.covid.19.by.country$cum_conf)-min(cases.covid.19.by.country$cum_conf)
sd(cases.covid.19.by.country$cum_conf)
IQR(cases.covid.19.by.country$cum_conf)

max(cases.covid.19.by.country$cum_death)-min(cases.covid.19.by.country$cum_death)
sd(cases.covid.19.by.country$cum_death)
IQR(cases.covid.19.by.country$cum_death)

#Los datos son muy dispersos. Convendría usar mediana e IQR como medidas de resumen

#Hacemos histogramas. Por lo que vimos antes, quizás es conveniente separar los datos más extremos.
hist(cases.covid.19.by.country$cum_conf)
#Vamos a analizar los países con menos casos.
#Nos podemos quedar con los datos que estén por debajo del "bigote", tercer cuartil + 1.5*IQR
#Calculamos los valores que nos interesan
tercer_cuartil <- summary(cases.covid.19.by.country$cum_conf)[5]
iqr            <- IQR(cases.covid.19.by.country$cum_conf)

#Vemos cuales cumplen con la condición y nos quedamos solo con esos
ids_casos <- which(cases.covid.19.by.country$cum_conf < tercer_cuartil + 1.5*iqr)
cum_conf <- cases.covid.19.by.country$cum_conf[ids_casos]
summary(cum_conf)
hist(cum_conf)

#Hacemos lo mismo con la variable de fallecimientos
hist(cases.covid.19.by.country$cum_death)
#Vamos a analizar los países con menos casos.
#Nos podemos quedar con los datos que estén por debajo del "bigote", tercer cuartil + 1.5*IQR
#Calculamos los valores que nos interesan
tercer_cuartil <- summary(cases.covid.19.by.country$cum_death)[5]
iqr            <- IQR(cases.covid.19.by.country$cum_death)

#Vemos cuales cumplen con la condición y nos quedamos solo con esos
ids_casos <- which(cases.covid.19.by.country$cum_death < tercer_cuartil + 1.5*iqr)
cum_death <- cases.covid.19.by.country$cum_death[ids_casos]
summary(cum_death)
hist(cum_death)

#Grafiquemos un histograma y un boxplot para cada variable
layout(matrix(1:4, ncol=2, nrow=2))
hist(cum_conf)
boxplot(cum_conf, horizontal = T)
hist(cum_death)
boxplot(cum_death, horizontal = T)

#Siguen apareciendo valores extremos en el boxplot porque al sacar algunos datos, cambian todas las
#medidas y las escalas. En particular, cambia la mediana y el IQR

#Grafiquemos un scatterplot
layout(1)
plot(cases.covid.19.by.country$cum_conf, cases.covid.19.by.country$cum_death, xlab = "Casos", ylab = "Fallecimientos", main = "Casos de COVID-19 por país")

#Los casos extremos no nos permiten visualizar con detalle la relación. Debemos sacarlos.
tercer_cuartil_conf <- summary(cases.covid.19.by.country$cum_conf)[5]
iqr_conf            <- IQR(cases.covid.19.by.country$cum_conf)

tercer_cuartil_death <- summary(cases.covid.19.by.country$cum_death)[5]
iqr_death            <- IQR(cases.covid.19.by.country$cum_death)

#Vemos cuales cumplen con las dos condiciones y nos quedamos solo con esos
ids_casos <- which(cases.covid.19.by.country$cum_conf < tercer_cuartil_conf + 1.5*iqr_conf &
                   cases.covid.19.by.country$cum_death < tercer_cuartil_death + 1.5*iqr_death)
casos_de_interes <- cases.covid.19.by.country[ids_casos, ]

#Grafiquemos
plot(casos_de_interes$cum_conf, casos_de_interes$cum_death)

#Sigue siendo dificil de identificar que le pasa a la mayor parte de los casos, recortemos nuevamente
#Vemos cuales cumplen con las dos condiciones y nos quedamos solo con esos
ids_casos <- which(cases.covid.19.by.country$cum_conf < 500 &
                   cases.covid.19.by.country$cum_death < 10)
casos_de_interes <- cases.covid.19.by.country[ids_casos, ]

#Grafiquemos
plot(casos_de_interes$cum_conf, casos_de_interes$cum_death, main = "Casos confirmados vs. fallecimientos", xlab = "Casos confirmados", ylab="Fallecimientos")

#Si bien para valores grandes de casos parece haber una relación entre cantidad de casos y cantidad
#de fallecimientos, no parece haber una relación inmediata entre la cantidad de casos y la cantidad
#de fallecimientos en los casos más chicos. ¿Por qué podría estar pasando esto?
