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

#Problema 2: Calcular cuántas observaciones hay de Control y cuántas de IGF.¿Los datos están
#balanceados (cantidades similares de observaciones de ambos tipos)?

#Problema 3: Calcular media, mediana, desvío estándar y distancia inter cuartil para GPx_activity
#y sample_weight. Realizar esta descripción para cada tratamiento por separado.
#¿Las medidas de centralidad son similares para cada tratamiento y para cada atributo? ¿Y las de 
#dispersión? 

#Problema 4: Realizar un boxplot y un histograma de GPx_activity para cada tratamiento. ¿Existen datos atípicos?
#En caso de existir, retirar esas observaciones y mostrar el criterio utilizado para decidirlo.
#(Ayuda: no hay que retirar solamente el valor de GPx_activity, hay que retirar toda la fila del valor atípico)
#Por ejemplo, supongamos que la observación 100 tiene un GPx_activity atípico, entonces:
#nestlingsSinAtipicos <- nestlings[-100, ] #Es decir, sacamos toda la fila.
#Bonus crack de R: Realizar esos 4 gráficos en un mismo layout, con el boxplot en forma horizontal por debajo
#del histograma correspondiente a cada tratamiento. 

#Problema 5: Visualizar en un mismo gráfico de boxplot el sample_weight para cada tratamiento. ¿Existen datos atípicos? 
#En caso de existir, retirar esas observaciones y mostrar el criterio utilizado para decidirlo.
#Ayuda, para decirle a un boxplot que grafique una variable 'y' pero separando por la variable 'x', pueden usar
#formulas: boxplot(y ~ x).

#Problema 6: La primera columna del dataset es el identificador de los diferentes nidos muestreados. ¿Cuántos polluelos se midieron por nido?

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

#Problema 8: Realizar un scatter plot entre GPx activity y sample weight ¿Puede observar algún tipo de relación entre estas dos variables?

#Problema 9: realizar una regresión lineal donde sample_weight dependa de GPx_activity. ¿Es un buen ajuste? ¿Por qué?
#Ayuda: la función lm permite realizar un ajuste lineal donde 'y' depende de 'x' usando fórmulas: lm(y ~ x, data = misdatos).
#Esta función devuelve un objeto de tipo lm que puede ser pasado a la función summary para que devuelva todos los estadísticos de 
#interés (R2, coeficientes, pvalues, etc): summary(lm(y ~ x, data = misdatos))
#Bonus crack de R: Realizar la misma regresión lineal pero agregando como variable el tratamiento.
#¿Mejora la estimación o el tratamiento no parece afectar la relación?
#Ayuda: una fórmula dónde 'y' depende de dos variables se escribe como y ~ x + z (o y ~ x*z en caso de interacción entre las variables)