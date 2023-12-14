# Autora: SW
# Mantenedora(s): SW, AF
# Curso BANAVIM
# Ejercicios sesión 3 (19 de enero)
# Licencia: Data Cívica 2023 ©
# ===========================

# Este script contiene una guía a algunas de las posibles soluciones
# de los ejercicios de la sesión 3 (al final del script sesion-3.R)

# Por favor, intenta hacer los ejercicios por tu cuenta antes de ver
# las soluciones. El código que está aquí son solo algunas de las posibles
# soluciones, y no necesariamente las mejores.

# EJERCICIOS =====
# 1. Baja la siguiente base de datos de homicidios entre 2000 y 2018 según tipo de arma
# https://drive.google.com/file/d/1koHMCqpMqhzJ8xoEIZYRgailWSvzOkW2/view?usp=drive_link
# Guarda la base en el directorio (carpeta) que creaste para este script y la otra base,
# cárgala en R y guárdala como el objeto homicidios_tipo_arma.
homicidios_tipo_arma <- read.csv("~/git/curso-banavim/datos/homicidio_tipoarma.csv")
# OJO: "~" es otra forma de referirse al directorio de inicio
# En mi caso "~" reemplaza "/Users/sierrawells/".

# 2. Digamos que guardé la base anterior en la siguiente ruta absoluta:
"C:/Users/Usuario/Desktop/curso_r/homicidios_tipo_arma.csv"
#    Defino mi directorio de trabajo como:
directorio_trab <- "C:/Users/Usuario/Desktop/curso_r/"
#    La quiero cargar en R usando la ruta relativa, entonces empiezo con el siguiente código:
homicidios_tipo_arma <- read.csv(paste0(directorio_trab, algo))
#   ¿Qué le debería poner en lugar de "algo"?
homicidios_tipo_arma <- read.csv(paste0(directorio_trab, "homicidios_tipo_arma.csv"))

# 3. Tengo una base de datos guardada en la misma ruta absoluta que en el ejercicio 2.
#   La quiero cargar en R usando la ruta relativa, entonces uso el siguiente código:
read.csv("curso_r/homicidios_tipo_arma.csv")

#   Es probable que este código me dé un error. ¿Por qué?
#   No he definido mi directorio de trabajo. Para asegurarnos de que R siempre busque
#   en el directorio correcto, es buena práctica definir el directorio de trabajo
#   como hicimos en el ejercicio 2.

# 4. ¿Cuántas filas y columnas tiene la base de datos homicidios_tipo_arma?
#    ¿Cuáles son los nombres de las columnas?
#   ¿De qué clase son los valores en cada una de las columnas?
nrow(homicidios_tipo_arma) # 2944
ncol(homicidios_tipo_arma) # 8
names(homicidios_tipo_arma)
str(homicidios_tipo_arma)

# 5. Cambia el nombre de la columna "ent" de homcidios_tipo_arma a "entidad".
names(homicidios_tipo_arma)[3] <- "entidad"

# 6. Cambia la columna "year" a una columna tipo texto (character)
#   usando la función as.character().
homicidios_tipo_arma$year <- as.character(homicidios_tipo_arma$year)
str(homicidios_tipo_arma) # para verificar el cambio

# 7. Quita la columna "cve_ent" de la base homicidios_tipo_arma.
homicidios_tipo_arma <- homicidios_tipo_arma[, -2]

# 8. Crea una nueva columna llamada "continente" que tenga el valor
#   "América del Norte" para todas las filas.
homicidios_tipo_arma$continente <- "América del Norte"

# 9. Crea un nuevo data frame que contenga solo las filas para homicidios
#    en Guerrero entre los años 2010 y 2015.
homicidios_gro_2010_15 <- homicidios_tipo_arma[homicidios_tipo_arma$entidad == "Guerrero" &
                                            homicidios_tipo_arma$year %in% 2010:2015, ]

# 10. Crea un nuevo data frame que contenga solo las filas para homicidios
#     cometidos con arma de fuego o arma blanca
homs_arma_fuego_blanca <- homicidios_tipo_arma[homicidios_tipo_arma$subtipo == "Con Arma Blanca" |
                                                 homicidios_tipo_arma$subtipo == "Con Arma De Fuego", ]

# 11. Crea un nuevo data frame que contenga homicidios con cualquier subtipo
#     que no sea "No Especificado".
homicidios_especificado <- homicidios_tipo_arma[homicidios_tipo_arma$subtipo != "No Especificado", ]

# fin. ¡Eso es todo por hoy!