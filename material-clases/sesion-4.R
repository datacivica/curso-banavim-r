# Autora: SW
# Mantenedora(s): SW, AF
# Curso BANAVIM
# Sesión 4 (23 de enero)
# Licencia: Data Cívica 2023 ©
# ===========================

# TEMAS DE ESTA SESIÓN: =====
# Los paquetes en R
# Limpieza de bases con dplyr: select, filter, rename, mutate
# Cruce entre bases de datos: joins

# 1. Los paquetes en R ====
# Hasta ahora, hemos utilizado funciones que vienen incluidas en R base,
# es decir, que vienen con la instalación de R.

# Sin embargo, hay muchas otras funciones que no vienen incluidas en R base
# y que se pueden instalar por separado. Estas funciones vienen en "paquetes".

# Para instalar un paquete de funciones, usamos la función install.packages()
install.packages("dplyr") # el nombre del paquete se escribe entre comillas

# Para utilizar las funciones en este paquete, después de bajarlo,
# lo tenemos que cargar en nuestra sesión de R con la función library()
library(dplyr)

# Cada vez que abres una nueva sesión de R, tienes que volver a cargar los paquetes.
# Es una buena práctica cargar todos los paquetes que necesitas en un script
# al inicio del archivo.

# 2. Limpieza de bases con dplyr ====
# En la sesión anterior, vimos cómo podemos usar R base para modificar bases de datos
# (ej. para seleccionar columnas, filtrar filas, etc.)

# Sin embargo, hay un paquete que nos facilita mucho la vida para hacer estas tareas:
# dplyr.

# Carguemos la misma base de homicidios_2022 que usamos en la sesión anterior:
homicidios_2022 <- read.csv("//Users//sierrawells//git//curso-banavim//datos//homicidios_2022.csv")

#----------------------------#
#  Cambiar nombres: rename() #
#----------------------------#

tempo <- rename(homicidios_2022, # nombre de data frame
                edo_civil = estado_civil, # nombre nuevo = nombre viejo
                entidad_ocurr = entidad)

#--------------------------------------- #
# Seleccionar/quitar columnas: select()  #
#--------------------------------------- #

# Para seleccionar las columnas que sí quieres:
tempo <- select(homicidios_2022, c(1:4)) # Podemos hacerlo por posición de la columna
tempo <- select(homicidios_2022, c(entidad:estado_civil)) # O podemos hacerlo por nombres

# Para quitar las columnas que no quieres, usa el signo menos (-)
tempo <- select(homicidios_2022, -c(4:5))
tempo <- select(homicidios_2022, -c(estado_civil, indigena))

#----------------------------------- #
# Crear y editar variables: mutate() #                    
#----------------------------------- #

homicidios_2022 <- mutate(homicidios_2022,
                          pais  = "méxico", # nueva variable
                
                          categ_edad = # nueva variable
                            ifelse(edad < 18, # prueba lógica
                                   "menor de edad", # si es verdadera
                                   "mayor de edad"), # si es falsa
                
                          entidad = tolower(entidad) # editar variable existente
                          ) 

#------------------------ #
# Filtrar bases: filter() #                    
#------------------------ #

# En la sesión anterior vimos cómo filtrar bases de datos para solo incluir
# las filas donde las variables cumplan con ciertas condiciones.

# Lo mismo se puede hacer con dplyr usando filter()
# (generalmente de una forma más fácil de leer y escribir)

# Homicidios de mujeres
tempo  <- filter(homicidios_2022, sexo == "mujer")

# Homicidios en todos los estados menos Jalisco
tempo  <- filter(homicidios_2022, entidad != "jalisco")

# Homicidios de mujeres en Colima
tempo  <- filter(homicidios_2022, sexo == "mujer" & entidad == "colima")

# Homicidios en Colima o Jalisco
tempo <- filter(homicidios_2022, entidad == "colima" | entidad == "jalisco")

# Homicidios de personas menores de 18 años
tempo  <- filter(homicidios_2022, edad < 18)

# Homicidios de personas mayores de 60 años
tempo <- filter(homicidios_2022, edad > 60)

# Homicidios de personas entre 20 y 30 años (incluyendo 20 y 30)
tempo  <- filter(homicidios_2022, edad >= 20 & edad <= 30)

# Homicidios de personas solteras o viudas
tempo  <- filter(homicidios_2022, estado_civil %in% c("soltero", "viudo"))

# 3. CRUCES ENTRE BASES: JOINS ====
# Digamos que queremos agregar a nuestra base de datos de homicidios
# la población de cada estado para poder (eventualmente) calcular tasas de homicidios.

# Para hacer esto, vamos a tener que hacer un cruce entre dos bases de datos.
# dplyr nos permite hacer esto con las funciones de join.

# Hay cuatro tipos de funciones de join: left_join, right_join, inner_join, full_join
# Para demostrar la diferencia, vamos a crear una base de datos de prueba:
edades <- data.frame(nombre = c("Sierra", "Emilia", "Marigu"),
                edad = c(23, 24, 28))

mascotas <- data.frame(nombre = c("Sierra", "Marigu", "Carlos"),
                       num_mascotas = c(0, 1, 3))

# En este ejemplo, aunque sabemos la edad y número de mascotas de Sierra y Marigu,
# no sabemos la edad de Carlos ni el número de mascotas de Emilia.

# left_join() mantiene todas las filas de la base de la izquierda (edades)
left <- left_join(edades, mascotas, by = "nombre") # no aparece Carlos ya que no aparece en edades

# right_join() mantiene todas las filas de la base de la derecha (mascotas)
right <- right_join(edades, mascotas, by = "nombre") # no aparece Emilia ya que no aparece en mascotas

# inner_join() mantiene solo las filas que aparecen en ambas bases
inner <- inner_join(edades, mascotas, by = "nombre") # solo aparecen Sierra y Marigu

# full_join() mantiene todas las filas de ambas bases
full <- full_join(edades, mascotas, by = "nombre") # aparecen las 4 personas

# Para hacer un join de la población con la de los homicidios,
# necesitamos una base de datos que tenga la población de cada estado.
# Esta base se puede bajar en el siguiente enlace:
# https://drive.google.com/file/d/1JjSWFqn88i5x8Sh5tI0ykSsH7sWbnzSb/view?usp=sharing

# Carguemos la base de datos de población:
# (esta es la ruta en mi computadora, tendrás que cambiarla a la tuya)
poblacion <- read.csv("//Users//sierrawells//git//curso-banavim//datos//poblacion_2020.csv")

# Para agregar la población a la base de homicidios, vamos a usar left_join():
names(poblacion)
names(homicidios_2022)
homicidios_2022_pob <- left_join(homicidios_2022, poblacion, by = c("entidad" = "estado"))

# También se pueden hacer joins con más de una variable, por ejemplo por estado Y sexo:
# Para hacer esto, primero baja la siguiente base de población por estado y sexo:
# https://drive.google.com/file/d/1ceLvynjmMtnkhoRLSRAQ1OpVUxGdl8za/view?usp=sharing

poblacion_sexo <- read.csv("//Users//sierrawells//git//curso-banavim//datos//poblacion_sexo_2020.csv")
homicidios_2022_pob_sexo <- left_join(homicidios_2022, poblacion_sexo, by = c("entidad" = "estado",
                                                                         "sexo"))

# PARA RESUMIR:
# left_join() mantiene todas las filas de la base de la izquierda
# right_join() mantiene todas las filas de la base de la derecha
# inner_join() mantiene solo las filas que aparecen en ambas bases
# full_join() mantiene todas las filas que aparecen en por lo menos alguna de las bases
# by especifica la(s) variable(s) por la(s) que se cruzan las bases

# EJERCICIOS =====
# 1. Instala el paquete "tidyr" y cárgalo.

# Para los ejercicios 2-8, vamos a usar la base de homicidios_tipoarma
# que usamos en la sesión anterior. Para cada uno de estos ejercicios,
# usa una función de dplyr en lugar de R base.

# 2. Cambia el nombre de la columna "ent" de homcidios_tipo_arma a "entidad".

# 3. Cambia la columna "year" a una columna tipo texto (character)
#   usando la función as.character().

# 4. Quita la columna "cve_ent" de la base homicidios_tipoarma.

# 5. Crea una nueva columna llamada "continente" que tenga el valor
#   "América del Norte" para todas las filas.

# 6. Crea un nuevo data frame que contenga solo las filas para homicidios
#    en Guerrero entre los años 2010 y 2015.

# 7. Crea un nuevo data frame que contenga solo las filas para homicidios
#     cometidos con arma de fuego o arma blanca
#     (fíjate en las letras minúsculas vs. mayúsculas de los valores de "subtipo").

# 8. Crea un nuevo data frame que contenga homicidios con cualquier subtipo
#     que no sea "No Especificado".

# 9. Cruza homicidios_tipoarma con la siguiente base de abreviaciones de estados
#    para que cada estado en homicidios_tipoarma tenga su abreviación:
# https://drive.google.com/file/d/1wc6r0wV1AaWC39JhaqmHKOrD-HOkNsnz/view?usp=sharing

# 10. Digamos que tenemos las siguientes bases de datos:
pais_de_nacimiento <- data.frame(nombre = c("Sierra", "Mari", "Tushig", "Emilia"),
                                 nacimiento = c("EE.UU.", "Brasil", "Mongolia", "México"))

pais_de_residencia <- data.frame(nombre = c("Sierra", "Sabina", "Tushig", "Josúe"),
                                 residencia = c("México", "México", "EE.UU.", "Brasil"))

# Usando alguna función de join, crea una base de datos que
# a) agregue el país de residencia de cada persona que aparece en la base de nacimiento
# b) agregue el país de nacimiento de cada persona que aparece en la base de residencia
# c) agregue el país de residencia y nacimiento de cada persona que aparece en alguna de las dos bases
# d) agregue el país de residencia y nacimiento de cada persona que aparece en ambas bases

# 11. Tenemos las siguientes bases de datos:
personas <- data.frame(nombre = c("Sierra", "Luca", "Jasper", "Carlos"),
                       edad = c("mayor de edad", "menor de edad", "menor de edad", "mayor de edad"),
                       genero = c("mujer", "mujer", "hombre", "hombre"))

categorias_edad <- data.frame(edad = c(rep("mayor de edad", 2), rep("menor de edad", 2)),
                              genero = c(rep(c("hombre", "mujer"), 2)),
                               categoria = c("hombre adulto", "mujer adulta", "niño", "niña"))

# Las categorías de edad dependen tanto de la edad como del género.
# Agrega las categorías de edad para cada persona en la base de personas.

# done. ¡Eso es todo por hoy!