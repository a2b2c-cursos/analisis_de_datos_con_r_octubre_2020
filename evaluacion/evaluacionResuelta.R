#############################################################################
#              Curso de análisis de datos con R
#Asociación Argentina de Bioinformática y Biología Computacional
#                         Octubre 2020
#                      Evaluación del curso
#
#Para organizarnos mejor: 
#Entregar un script de R cuyo nombre sea apellido_nombre.R con la resolución
#de los ejercicios a cursos@a2b2c.org y con el subject "Evaluación R".
#Pueden realizarnos consultas a ese mismo email con el subject "Consultas R". 
#############################################################################

##################################################################################################
#ABSTRACT
#Los animales durante su desarrollo se enfrentan con problemas en la asignación de recursos cuando reciben cantidades subóptimas
#de los mismos en ambientes naturales muy variables.
#Estos problemas se manifiestan posiblemente en el intercambio (trade-off) entre crecimiento y mantenimiento somático.
#Sin embargo, la medida en que se manifiesta este intercambio sigue siendo una pregunta abierta.
#Para intentar responder a esta pregunta, se inyectó a pichones de papamoscas cerrojillo (Ficedula hypoleuca) con 
#IGF-1 (insulin-like growth factor 1) para observar como IGF-1 afecta el despliegue de una respuesta antioxidante mediada por 
#la enzima glutathione peroxidasa (GPx). 

#################Consignas########################
#Cada ejercicio otorga 1 punto excepto el 7 que otorga 2.
#Los bonus "crack de R" otorgan medio punto. (hasta un máximo de 10 puntos totales)

#Problema 1: Abrir el dataset nestlings.csv en RStudio y describirlo exhaustivamente para comprender el contenido del mismo.
#ej: cantidad de observaciones, cantidad de atributos, tipo de atributos, etc. 

setwd("~/curso/evaluacion/datos") #Elegimos el directorio de trabajo

nestlings <-  read.csv("nestlings.csv") #Leemos el dataset

class(nestlings) #Tipo de objeto
nrow(nestlings) #Cantidad de filas u observaciones del dataset
ncol(nestlings) #Cantidad de columnas o atributos
str(nestlings) #Visualizamos la estructura del dataset
colnames(nestlings) #Los nombres de los atributos
View(nestlings) #Lo abrimos tipo excel para darle una mirada general rápida
#El dataset contiene 66 observaciones con 6 atributos cada una. En particular son de interés manipulation (chr), 
#que contiene el tratamiento realizado, GPx_activity (num) que contiene la actividad de la enzima y sample_weight (num) que contiene el peso de cada pichón

#Problema 2: Calcular cuántas observaciones hay de Control y cuántas de IGF.¿Los datos están
#balanceados (cantidades similares de observaciones de ambos tipos)?
table(nestlings$manipulation) #Usamos table para contar cuantos elementos hay de Control-injected y cuantos de IGF-1-injected. Toda esa información está en manipulation
#Hay 33 datos de cada tratamiento, están balanceados

#Problema 3: Calcular media, mediana, desvío estándar y distancia inter cuartil para GPx_activity
#y sample_weight. Realizar esta descripción para cada tratamiento por separado.
#¿Las medidas de centralidad son similares para cada tratamiento y para cada atributo? ¿Y las de 
#dispersión? 
#GPx_activity
GPx_activityControlInjected <- nestlings$GPx_activity[nestlings$manipulation=="Control-injected"]#Podemos subsetear y guardar en una nueva variable 
GPx_activityIGF1injected    <- nestlings$GPx_activity[nestlings$manipulation=="IGF-1-injected"]#Podemos subsetear y guardar en una nueva variable 
mean(GPx_activityControlInjected) #Calculamos media
mean(GPx_activityIGF1injected) #Calculamos media
median(GPx_activityControlInjected) #Calculamos mediana
median(GPx_activityIGF1injected) #Calculamos mediana
sd(GPx_activityControlInjected) #Calculamos desvío estándar
sd(GPx_activityIGF1injected) #Calculamos desvío estándar
IQR(GPx_activityControlInjected) #Distancia intercuartil
IQR(GPx_activityIGF1injected) #Distancia intercuartil
summary(GPx_activityControlInjected) #Un resumen rápido de todo
summary(GPx_activityIGF1injected) #Un resumen rápido de todo

#Vemos que la media y mediana para control y para IGF son diferentes. ¿Serán significativamente diferentes? ¿Cómo podríamos saberlo?
#Lo mismo ocurre para el desvío y el IQR, donde el desvío en IGF es la mitad del de control. 

#sample_weight
sample_weightControlInjected <- nestlings$sample_weight[nestlings$manipulation=="Control-injected"]#Podemos subsetear y guardar en una nueva variable 
sample_weightIGF1injected    <- nestlings$sample_weight[nestlings$manipulation=="IGF-1-injected"]#Podemos subsetear y guardar en una nueva variable 
mean(sample_weightControlInjected) #Calculamos media
mean(sample_weightIGF1injected) #Calculamos media
median(sample_weightControlInjected) #Calculamos mediana
median(sample_weightIGF1injected) #Calculamos mediana
sd(sample_weightControlInjected) #Calculamos desvío estándar
sd(sample_weightIGF1injected) #Calculamos desvío estándar
IQR(sample_weightControlInjected) #Distancia intercuartil
IQR(sample_weightIGF1injected) #Distancia intercuartil
summary(sample_weightControlInjected) #Un resumen rápido de todo
summary(sample_weightIGF1injected) #Un resumen rápido de todo

#Nuevamente vemos que la media y mediana para control y para IGF son diferentes. ¿Serán significativamente diferentes? ¿Cómo podríamos saberlo?
#Lo mismo ocurre para el desvío y el IQR pero en menor medida que en GPx.


#Problema 4: Realizar un boxplot y un histograma de GPx_activity para cada tratamiento. ¿Existen datos atípicos?
#En caso de existir, retirar esas observaciones y mostrar el criterio utilizado para decidirlo.
#(Ayuda: no hay que retirar solamente el valor de GPx_activity, hay que retirar toda la fila del valor atípico)
#Por ejemplo, supongamos que la observación 100 tiene un GPx_activity atípico, entonces:
#nestlingsSinAtipicos <- nestlings[-100, ] #Es decir, sacamos toda la fila.
#Bonus crack de R: Realizar esos 4 gráficos en un mismo layout, con el boxplot en forma horizontal por debajo
#del histograma correspondiente a cada tratamiento. 
matriz_layout <- matrix(1:4, nrow=2, ncol=2, byrow = F) #Armamos el layout
layout(matriz_layout)

#Usamos las variables que ya habíamos definido antes para graficar, pero para sacar los valores atípicos, vamos a querer hacerlo en el dataframe completo
hist(GPx_activityControlInjected, main = "GPx Control", breaks = 10) #Le ponemos 10 breaks para visualizar mejor la distribución
boxplot(GPx_activityControlInjected, horizontal = T, xlim=c(min(GPx_activityControlInjected), max(GPx_activityControlInjected))) #Para que macheen ambos, hacemos coincidr los límites de x 
hist(GPx_activityIGF1injected, main = "GPx Tratamiento", breaks = 10)
boxplot(GPx_activityIGF1injected, horizontal = T, xlim=c(min(GPx_activityIGF1injected), max(GPx_activityIGF1injected)))
#Tratamiento no parece muy normal. ¿Será significativamente no normal? ¿Cómo podríamos saberlo?
layout(1) #Volvemos al layout original

#Saquemos outliers con el criterio de IQR
iqr    <- IQR(GPx_activityControlInjected)
minimo <- quantile(GPx_activityControlInjected, 0.25) - 1.5*iqr #Calculamos el mínimo para control injected que consideramos no outlier
maximo <- quantile(GPx_activityControlInjected, 0.75) + 1.5*iqr #Calculamos el máximo para control injected que consideramos no outlier
#Pedimos en simultaneo que sean control injected y la actividad sea menor al mínimo o mayor al máximo. Eso cubre todo. Lo hacemos en el original y guardamos
#La fila correspondiente. 
a_remover <- which(nestlings$manipulation == "Control-injected" & (nestlings$GPx_activity < minimo | nestlings$GPx_activity > maximo))

#Saquemos outliers con el criterio de IQR
iqr    <- IQR(GPx_activityIGF1injected)
minimo <- quantile(GPx_activityIGF1injected, 0.25) - 1.5*iqr #Calculamos el mínimo para control injected que consideramos no outlier
maximo <- quantile(GPx_activityIGF1injected, 0.75) + 1.5*iqr #Calculamos el máximo para control injected que consideramos no outlier
#Pedimos en simultaneo que sean IGF injected y la actividad sea menor al mínimo o mayor al máximo. Eso cubre todo. Lo hacemos en el original.
#Se lo agregamos a los que ya queríamos remover
a_remover <- c(a_remover, which(nestlings$manipulation == "IGF-1-injected" & (nestlings$GPx_activity < minimo | nestlings$GPx_activity > maximo)))
a_remover

#Listo, tenemos todas las filas que queremos remover, las sacamos
nestlingsSinOutliers <- nestlings[-a_remover, ]
#Precaución, si se fijan, los rownames quedaron raros al remover estos elementos. 
rownames(nestlingsSinOutliers)
rownames(nestlingsSinOutliers) <- NULL #Con NULL regeneramos los nombres de filas
rownames(nestlingsSinOutliers) #Ahora si

#Seguramente si volvemos a graficar volvamos a encontrar outliers, en general alcanza con remover los primeros que suelen ser los más gruesos.


#Problema 5: Visualizar en un mismo gráfico de boxplot el sample_weight para cada tratamiento. ¿Existen datos atípicos? 
#En caso de existir, retirar esas observaciones y mostrar el criterio utilizado para decidirlo.
#Ayuda, para decirle a un boxplot que grafique una variable 'y' pero separando por la variable 'x', pueden usar
#formulas: boxplot(y ~ x).

#Tenemos que trabajar con el dataset sin outliers de GPx
boxplot(nestlingsSinOutliers$sample_weight ~ nestlingsSinOutliers$manipulation)
#Pareciera haber un outlier para IGF, saquémoslo
#Saquemos outliers con el criterio de IQR
sample_weightIGF1injected <- nestlingsSinOutliers$sample_weight[nestlingsSinOutliers$manipulation == "IGF-1-injected"]
iqr    <- IQR(sample_weightIGF1injected)
minimo <- quantile(sample_weightIGF1injected, 0.25) - 1.5*iqr #Calculamos el mínimo para control injected que consideramos no outlier
maximo <- quantile(sample_weightIGF1injected, 0.75) + 1.5*iqr #Calculamos el máximo para control injected que consideramos no outlier
#Pedimos en simultaneo que sean IGF injected y la actividad sea menor al mínimo o mayor al máximo. Eso cubre todo. Lo hacemos en el original.
#Se lo agregamos a los que ya queríamos remover
a_remover <- which(nestlingsSinOutliers$manipulation == "IGF-1-injected" & (nestlingsSinOutliers$sample_weight < minimo | nestlingsSinOutliers$sample_weight > maximo))
a_remover

#Lo sacamos
nestlingsSinOutliers <- nestlingsSinOutliers[-a_remover, ]

#A partir de acá, uno debería trabajar con nestlingsSinOutliers, pero por la dificultad que tiene, podían trabajar con el original, no había problema.
#Nosotros vamos a hacer una mezcla, trabajar con los originales en una parte y el sinOutliers en otra.
#En datos reales, sin embargo, deberían trabajar sinOutliers.

#Problema 6: La primera columna del dataset es el identificador de los diferentes nidos muestreados. ¿Cuántos polluelos se midieron por nido?
table(nestlings$nest_ID)


#Vemos que se midieron dos por nido en el original. Veamos si eso se mantuvo en el que no tiene outliers
table(nestlingsSinOutliers$nest_ID)
#Vemos que hay varios que no tienen par, para el ejercicio que viene, deberíamos sacarlos porque no va a ser parieado si no!
#Por la dificultad del punto 4, 5 donde hay que remover outliers y queda desbalanceada la paridad en los nidos,
#la idea era que en el 7 usaran directamente el dataframe original, sin complicarse demasiado. 

#Problema 7 (¡difícil!): como puede verse en el problema 6, en cada nido se midieron dos polluelos, de los cuales uno fue sometido al tratamiento control y otro fue inyectado con IGF-1.
#Para poder determinar si existe una diferencia significativa en el peso entre estos dos grupos, realizar un T test. 
#Tener en cuenta que los polluelos de un mismo nido no pueden ser considerados como muestras independientes, por lo cual en el análisis 
#considerarlos muestras pareadas. ¿A qué conclusión se llega?
#Realizar previamente todos los tests necesarios para garantizar que es válido aplicar un t test.
#Ayuda: pasar como parametro paired = TRUE en el t.test
#Ayuda: para el test de homogeneidad de varianza, bartlett.test, es necesario previamente
#agrupar las observaciones en una lista. Si control es una variable con los pesos de los polluelos
#de control y tratamiento es una variable con los pesos de los polluelos tratados, generar una lista de la siguiente
#manera: total <- list(control, tratamiento) y utilizar esa lista en el test.

#Hacemos los tests de homocedasticidad, normalidad y t
total <-list(nestlings$sample_weight[nestlings$manipulation=="Control-injected"], nestlings$sample_weight[nestlings$manipulation=="IGF-1-injected"])
bartlett.test(total)
#No rechazamos homocedasticidad por pvalue > 0.05
#normalidad de cada variable
#Test de Shapiro
shapiro.test(nestlings$sample_weight[nestlings$manipulation=="Control-injected"])
shapiro.test(nestlings$sample_weight[nestlings$manipulation=="IGF-1-injected"])
# No rechazamos normalidad
# t test
t.test(nestlings$sample_weight[nestlings$manipulation=="Control-injected"], nestlings$sample_weight[nestlings$manipulation=="IGF-1-injected"], paired = T)
# Rechazamos la hipótesis nula, por lo que que existen diferencias significativas entre control y tratamiento.

#Problema 8: Realizar un scatter plot entre GPx activity y sample weight ¿Puede observar algún tipo de relación entre estas dos variables?
plot(nestlingsSinOutliers$GPx_activity, nestlingsSinOutliers$sample_weight)
#Pareciera existir una relación lineal decreciente entre ambas

#Problema 9: realizar una regresión lineal donde sample_weight dependa de GPx_activity. ¿Es un buen ajuste? ¿Por qué?
#Ayuda: la función lm permite realizar un ajuste lineal donde 'y' depende de 'x' usando fórmulas: lm(y ~ x, data = misdatos).
#Esta función devuelve un objeto de tipo lm que puede ser pasado a la función summary para que devuelva todos los estadísticos de 
#interés (R2, coeficientes, pvalues, etc): summary(lm(y ~ x, data = misdatos))
#Bonus crack de R: Realizar la misma regresión lineal pero agregando como variable el tratamiento.
#¿Mejora la estimación o el tratamiento no parece afectar la relación?
#Ayuda: una fórmula dónde 'y' depende de dos variables se escribe como y ~ x + z (o y ~ x*z en caso de interacción entre las variables)
ajuste <- lm(sample_weight ~ GPx_activity, nestlingsSinOutliers) #Ajustemos
plot(nestlingsSinOutliers$GPx_activity, nestlingsSinOutliers$sample_weight)
abline(ajuste, col = "red")
summary(ajuste) #Veamos cómo da
#Si bien observamos una relación entre ambas en el scatter plot y el pvalue de GPx_activity nos confirma esa relación, el ajuste no parece ser muy bueno, con un R2 de 0.33. 

#Agreguemos otra variable y después la interacción
ajuste <- lm(sample_weight ~ GPx_activity + manipulation, nestlingsSinOutliers) #Ajustemos
summary(ajuste) #Veamos cómo da
#Practicamente no hay cambios, el pvalue de manipulation parece indicar que no suma nada haberlo agregado

ajuste <- lm(sample_weight ~ GPx_activity*manipulation, nestlingsSinOutliers) #Ajustemos con interacción
summary(ajuste) #Veamos cómo da
#Practicamente no hay cambios, el pvalue de manipulation y de la interacción parece indicar que no suma nada haberlo agregado
#el modelo inicial termina siendo el más adecuado

