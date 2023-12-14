# Autora: SW
# Mantenedora(s): SW, AF
# Curso BANAVIM
# Ejercicios sesión 4 (23 de enero)
# Licencia: Data Cívica 2023 ©
# ===========================

# Este script contiene una guía a algunas de las posibles soluciones
# de los ejercicios de la sesión 4 (al final del script sesion-4.R)

# Por favor, intenta hacer los ejercicios por tu cuenta antes de ver
# las soluciones. El código que está aquí son solo algunas de las posibles
# soluciones, y no necesariamente las mejores.

# EJERCICIOS =====
# 1. Instala el paquete "tidyr" y cárgalo.
install.packages("tidyr")
library(tidyr)

# Para los ejercicios 2-8, vamos a usar la base de homicidios_tipoarma
# que usamos en la sesión anterior. Para cada uno de estos ejercicios,
# usa una función de dplyr en lugar de R base.
homicidios_tipoarma <- read.csv("//Users//sierrawells//git//curso-banavim//datos//homicidio_tipoarma.csv")

# 2. Cambia el nombre de la columna "ent" de homcidios_tipo_arma a "entidad".
homicidios_tipoarma <- rename(homicidios_tipoarma, entidad = ent)

# 3. Cambia la columna "year" a una columna tipo texto (character)
#   usando la función as.character().
homicidios_tipoarma <- mutate(homicidios_tipoarma, year = as.character(year))

# 4. Quita la columna "cve_ent" de la base homicidios_tipo_arma.
homicidios_tipoarma <- select(homicidios_tipoarma, -cve_ent)

# 5. Crea una nueva columna llamada "continente" que tenga el valor
#   "América del Norte" para todas las filas.
homicidios_tipoarma <- mutate(homicidios_tipoarma, continente = "América del Norte")

# 6. Crea un nuevo data frame que contenga solo las filas para homicidios
#    en Guerrero entre los años 2010 y 2015.
homicidios_gro_2010_15 <- filter(homicidios_tipoarma,
                                 entidad == "Guerrero" & year %in% 2010:2015)

# 7. Crea un nuevo data frame que contenga solo las filas para homicidios
#     cometidos con arma de fuego o arma blanca
homs_arma_fuego_blanca <- filter(homicidios_tipoarma,
                                 subtipo %in% c("Con Arma Blanca", "Con Arma De Fuego"))

# 8. Crea un nuevo data frame que contenga homicidios con cualquier subtipo
#     que no sea "No Especificado".
homicidios_no_especificados <- filter(homicidios_tipoarma, subtipo != "No Especificado")

# 9. Cruza homicidios_tipo_arma con la siguiente base de abreviaciones de estados
#    para que cada estado en homicidios_tipo_arma tenga su abreviación:
# https://drive.google.com/file/d/1OR-nVEalFhA8UWd39KYJQnrYGhq1EMpK/view?usp=sharing
abrevs <- read.csv("//Users//sierrawells//git//curso-banavim//datos//geog_abrevs.csv")

homicidios_tipo_arma_abrevs <- left_join(homicidios_tipoarma, abrevs,
                                         by = c("entidad" = "nom_ent"))

# 10. Digamos que tenemos las siguientes bases de datos:
pais_de_nacimiento <- data.frame(nombre = c("Sierra", "Mari", "Tushig", "Emilia"),
                                 nacimiento = c("EE.UU.", "Brasil", "Mongolia", "México"))

pais_de_residencia <- data.frame(nombre = c("Sierra", "Sabina", "Tushig", "Josúe"),
                                 residencia = c("México", "México", "EE.UU.", "Brasil"))

# Usando alguna función de join, crea una base de datos que
# a) agregue el país de residencia de las personas que aparecen en la base de nacimiento
tempo <- left_join(pais_de_nacimiento, pais_de_residencia, by = "nombre") # O
tempo <- right_join(pais_de_residencia, pais_de_nacimiento, by = "nombre")
# b) agregue el país de nacimiento de las personas que aparecen en la base de residencia
tempo <- left_join(pais_de_residencia, pais_de_nacimiento, by = "nombre") # O
tempo <- right_join(pais_de_nacimiento, pais_de_residencia, by = "nombre")
# c) agregue el país de residencia y nacimiento de las personas que aparecen en alguna de las dos bases
tempo <- full_join(pais_de_nacimiento, pais_de_residencia, by = "nombre")
# d) agregue el país de residencia y nacimiento de las personas que aparecen en ambas bases
tempo <- inner_join(pais_de_nacimiento, pais_de_residencia, by = "nombre")

# 11. Tenemos las siguientes bases de datos:
personas <- data.frame(nombre = c("Sierra", "Luca", "Jasper", "Carlos"),
                       edad = c("mayor de edad", "menor de edad", "menor de edad", "mayor de edad"),
                       genero = c("mujer", "mujer", "hombre", "hombre"))

categorias_edad <- data.frame(edad = c(rep("mayor de edad", 2), rep("menor de edad", 2)),
                              genero = c(rep(c("hombre", "mujer"), 2)),
                              categoria = c("hombre adulto", "mujer adulta", "niño", "niña"))

# Las categorías de edad dependen tanto de la edad como del género.
# Agrega las categorías de edad para cada persona en la base de personas.
personas <- left_join(personas, categorias_edad, by = c("edad", "genero"))

# done. ¡Eso es todo por hoy!