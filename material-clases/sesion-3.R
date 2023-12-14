# Autora: SW
# Mantenedora(s): SW, AF
# Curso BANAVIM
# Sesión 3 (19 de enero)
# Licencia: Data Cívica 2023 ©
# ===========================

# TEMAS DE ESTA SESIÓN: =====
# Importación de bases de datos
# Funciones básicas para conocer bases de datos
# Manejo de bases con R base

# 1. IMPORTACIÓN DE BASES DE DATOS ====
# En la sesión anterior, creamos un data frame de forma manual:
mi_df <- data.frame(
  estado = c("CDMX", "Tabasco", "Zacatecas"),
  puestos_de_elotes = c(1000, 500, 400),
  tortas_de_tamal = c(TRUE, FALSE, FALSE)
)

# Sin embargo, casi siempre vamos a querer trabajar con bases de datos
# ya existentes.

# Para hacer esto, vamos a necesitar la ruta ("path") del archivo en tu computadora,
# es decir dónde está guardado el archivo.

# Para obtener la ruta de un archivo...
# En Mac: haz click derecho el archivo, luego presiona "Option"
# y luego "Copiar 'archivo' como ruta de acceso"

# En Windows: presiona "Shift", luego haz click derecho en el archivo
# y luego "Copiar como ruta de acceso"

# Se debe ver algo así:
"/Users/sierrawells/git/curso-banavim/base-datos.csv"

# Para empezar a trabajar con una base de datos existente,
# primero crea una carpeta en tu computadora para este curso y guarda ahí
# este script y la base de datos que se puede descargar en el siguiente link:
# https://drive.google.com/file/d/1poWIIuDHGFTRcjxDvXu64xPzc88LZkfj/view?usp=drive_link

# En mi caso, mi carpeta se llama "git/curso-banavim/datos/" y la ruta a la base es:
"/Users/sierrawells/git/curso-banavim/datos/homicidios_2022.csv"

# Para importar la base de datos, usamos la función read.csv()
homicidios_2022 <- read.csv("//Users//sierrawells//git//curso-banavim//datos//homicidios_2022.csv")
# OJO: en Windows, la ruta se escribe con doble barra diagonal (//) en lugar de una (/)
#      en Mac, la ruta se puede escribir con una sola barrad diagonal (/) o con doble (//)

# La ruta que acabamos de usar es la ruta absoluta, es decir, la ruta completa.
# Pero también podemos simplificar la ruta especificando su ubicación relativa
# a la carpeta (que también se llama directorio) en la que estamos trabajando.

directorio_curso <- "//Users//sierrawells//git//curso-banavim//"
homicidios_2022 <- read.csv(paste0(directorio_curso, "datos//homicidios_2022.csv"))

# "datos//homicidios_2022.csv" es un ejemplo de una ruta relativa.
# Puede ser útil usar rutas relativas cuando estás trabajando con varias bases de datos
# dentro de un mismo directorio o cuando estás trabajando con otras personas
# que no tienen el mismo directorio de inicio (ej. "/Users/sierrawells/") que tú.

# PARA RESUMIR:
# 1. Una ruta absoluta es la ruta completa de un archivo
#   (incluye el directorio de inicio)
# 2. Una ruta relativa es la ruta de un archivo relativa a otro directorio
#   (no incluye el directorio de inicio)
# 3. Para leer una base de datos en formato .csv, usa la función read.csv()
#   con la ruta absoluto o relativa del archivo

# 2. FUNCIONES BÁSICAS PARA CONOCER BASES DE DATOS ====
# Nombres de las columnas:
names(homicidios_2022)

# Número de columnas:
ncol(homicidios_2022)

# Número de filas:
nrow(homicidios_2022)

# Tipo de valores en cada columna
str(homicidios_2022)

# Primeras filas de la base de datos
head(homicidios_2022)
head(homicidios_2022, 10) # Para ver las primeras 10 filas

# Resumen de las columnas (principalmente útil para columnas numéricas y lógicas)
summary(homicidios_2022)

# Distribución y cruces de variables
table(homicidios_2022$entidad) # número de homicidios en cada entidad
table(homicidios_2022$entidad, homicidios_2022$sexo) # número de homicidios en cada entidad, por sexo

# OJO: la anotación $ se usa para acceder a una columna específica de un data frame
#       (ej. base$columna)

# Para ver la documentación de una base de datos, puedes escribir "?" antes del nombre de la función
?names

# 3. MANEJO DE BASES CON R BASE ====

#------------------------#
# 1) Cambiar nombres     #
#------------------------#
nombres_originales <- names(homicidios_2022)

names(homicidios_2022)
names(homicidios_2022) <- c("estado", "sexo_victima", "edad_victima", "edo_civil",
                            "autoadscrip_indig")
names(homicidios_2022)

# También podemos cambiar un nombre específico a la vez
names(homicidios_2022)[1] 

names(homicidios_2022)[1] <- "nombre_entidad"
names(homicidios_2022)

names(homicidios_2022) <- nombres_originales # Restaurar nombres originales

#---------------------------------#
# 2) Quitar columnas o renglones  #          
#---------------------------------#

# Para seleccionar renglones 30,000 - 32,841 y columnas 3 a 5
tempo <- homicidios_2022[30000:32841, 3:5] # A la izquierda renglones, a la derecha columnas
# OJO: la anotación 3:5 crea un vector con todos los números enteros entre 3 y 5
#       o sea, 3, 4 y 5

# Alternativamente:
tempo <- homicidios_2022[30000:nrow(homicidios_2022), 3:ncol(homicidios_2022)]

# Podemos conservear todas las filas o todas las columnas
# Todas las filas, pero solo las primeras 3 columnas:
tempo <- homicidios_2022[ ,1:3] 
# Todas las columnas, pero solo las últimas 1000 filas:
tempo <- homicidios_2022[31841:nrow(homicidios_2022), ]

#--------------------------------#
# 3) Crear y editar variables)   #                    
#--------------------------------#

homicidios_2022$pais <- "México"
homicidios_2022$year <- 2022

# Podemos modificar una variable ya existente
homicidios_2022$entidad <- tolower(homicidios_2022$entidad) # Cambia a minúsculas

#-------------------------#
# 4) Eliminar variables   #                        
#-------------------------#

# Imaginemos que queremos quitar la cuarta columna (estado_civil)
homicidios_sin_edo_civil <- homicidios_2022[ ,c(1:3, 5:ncol(homicidios_2022))]
homicidios_sin_edo_civil <- homicidios_2022[ ,-c(4)]

#----------------------#
# 5) Filtrar variables #                             
#----------------------#

# Estos son los operadores que utiliza R: ==, != , |, <, >, <=, >=, %in%
# == : "igual a"
# != : "diferente de" ("no igual a")
# | : "o" (por lo menos una de las condiciones se cumple)
# & : "y" (todas las condiciones se cumplen)
# < : "menor que"
# > : "mayor que"
# <= : "menor o igual que"
# >= : "mayor o igual que"
# %in% : "está en" (el valor de la variable está en el vector)

# Homicidios (filas) de mujeres
tempo  <- homicidios_2022[homicidios_2022$sexo == "mujer",]

# Homicidios en todos los estados menos Jalisco
tempo  <- homicidios_2022[homicidios_2022$entidad != "jalisco",]

# Homicidios de mujeres en Colima
tempo  <- homicidios_2022[homicidios_2022$sexo == "mujer" & homicidios_2022$entidad == "colima",]

# Homicidios en Colima o Jalisco
tempo  <- homicidios_2022[homicidios_2022$entidad == "colima" | homicidios_2022$entidad == "jalisco",]

# Homicidios de personas menores de 18 años
tempo  <- homicidios_2022[homicidios_2022$edad < 18,]

# Homicidios de personas mayores de 60 años
tempo  <- homicidios_2022[homicidios_2022$edad > 60,]

# Homicidios de personas entre 20 y 30 años (incluyendo 20 y 30)
tempo  <- homicidios_2022[homicidios_2022$edad >= 20 & homicidios_2022$edad <= 30,]

# Homicidios de personas solteras o viudas
tempo  <- homicidios_2022[homicidios_2022$estado_civil %in% c("soltero", "viudo"),]

# Muy bien, hasta aquí hemos usado exclusivamente lenguaje nativo de R
# En la siguiente sesión aprenderemos a usar funciones avanzadas de un paquete nuevo

# EJERCICIOS =====
# 1. Baja la siguiente base de datos de homicidios entre 2000 y 2018 según tipo de arma
# https://drive.google.com/file/d/1koHMCqpMqhzJ8xoEIZYRgailWSvzOkW2/view?usp=drive_link
# Guarda la base en el directorio (carpeta) que creaste para este script y la otra base,
# cárgala en R y guárdala como el objeto homicidios_tipoarma.

# 2. Digamos que guardé la base anterior en la siguiente ruta absoluta:
#   "C:/Users/Usuario/Desktop/curso_r/homicidios_tipoarma.csv"
#    Defino mi directorio de trabajo como:
     directorio_trab <- "C:/Users/Usuario/Desktop/curso_r/"
#    La quiero cargar en R usando la ruta relativa, entonces empiezo con el siguiente código:
     homicidios_tipoarma <- read.csv(paste0(directorio_trab, algo))
#   ¿Qué le debería poner en lugar de "algo"?
     
# 3. Tengo una base de datos guardada en la misma ruta absoluta que en el ejercicio 2.
#   La quiero cargar en R usando la ruta relativa, entonces uso el siguiente código:
    read.csv("curso_r/homicidios_tipoarma.csv")

#   Es probable que este código me dé un error. ¿Por qué?

# 4. ¿Cuántas filas y columnas tiene la base de datos homicidios_tipoarma?
#    ¿Cuáles son los nombres de las columnas?
#   ¿De qué clase son los valores en cada una de las columnas?
    
# 5. Cambia el nombre de la columna "ent" de homcidios_tipoarma a "entidad".
    
# 6. Cambia la columna "year" a una columna tipo texto (character)
#   usando la función as.character().
    
# 7. Quita la columna "cve_ent" de la base homicidios_tipoarma.

# 8. Crea una nueva columna llamada "continente" que tenga el valor
#   "América del Norte" para todas las filas.
    
# 9. Crea un nuevo data frame que contenga solo las filas para homicidios
#    en Guerrero entre los años 2010 y 2015.
    
# 10. Crea un nuevo data frame que contenga solo las filas para homicidios
#     cometidos con arma de fuego o arma blanca
#     (fíjate en las letras minúsculas vs. mayúsculas de los valores de "subtipo").

# 11. Crea un nuevo data frame que contenga homicidios con cualquier subtipo
#     que no sea "No Especificado".

# fin. ¡Eso es todo por hoy!    