# Autora: SW
# Mantenedora(s): SW, AF
# Curso BANAVIM
# Sesión 6 (30 de enero)
# Licencia: Data Cívica 2023 ©
# ===========================

# Este script contiene una guía a algunas de las posibles soluciones
# de los ejercicios de la sesión 5 (al final del script sesion-5.R)

# Por favor, intenta hacer los ejercicios por tu cuenta antes de ver
# las soluciones. El código que está aquí son solo algunas de las posibles
# soluciones, y no necesariamente las mejores.

# Paquetes
pacman::p_load(dplyr, data.table, janitor)

# Directorio
dir <- "//Users//sierrawells//git//curso-banavim//datos//"

# EJERCICIOS ====
# 1. Crea un loop que imprima los números del 1 al 10.
for(i in 1:10) {
  print(i)
}

# 2. Tengo el siguiente vector de artistas musicales:
artistas <- c("Dani Flow", "UB40", "Omar Apollo",
              "Kevin Kaarl", "Ana Tijoux", "ABBA")

# Usando un loop, crea un nuevo vector que contenga los nombres de los artistas
# que empiezan con una consonante y, en lugar de cada nombre de los artistas que 
# empiezan con una vocal, pon "empieza con una vocal".
artistas_nuevo <- c()

for (artista in artistas){
  if (substr(artista, 1, 1) %in% c("A", "E", "I", "O", "U")) {
    artistas_nuevo <- c(artistas_nuevo, "empieza con una vocal")
  } else {
    artistas_nuevo <- c(artistas_nuevo, artista)
  }
}

# Pista: puedes utilizar substr() para obtener la primera letra de cada nombre

# Al final artistas_nuevo debe verse así:
c("Dani Flow", "empieza con una vocal", "empieza con una vocal",
  "Kevin Kaarl", "empieza con una vocal", "empieza con una vocal")

# 3. Usando un loop y los índices de los elementos del vector artistas,
#   crea un nuevo vector que contenga los nombres de los artistas
#   y el índice de su posición en el vector original, separados por un guión.
#   Por ejemplo, el primer elemento del nuevo vector debe ser "Dani Flow-1".
artistas_con_indice <- c()

for (i in 1:length(artistas)) {
  artista <- artistas[i]
  artistas_con_indice[i] <- paste0(artista, "-", i)
}

# 4 (desafío). En la matemática, la sucesión de Fibonacci es una sucesión
#  infinita de números que comienza con los números 0 y 1, y a partir
#  de estos, cada término es la suma de los dos anteriores.
#  Por ejemplo, los primeros 10 términos de la sucesión son:
#  0, 1, 1, 2, 3, 5, 8, 13, 21, 34

# Termina el siguiente loop para que el vector fibonacci contenga los primeros
# 10 términos de la sucesión de Fibonacci.

fibonacci <- c(0, 1)
for (i in 1:8) {
  fibonacci[i + 2] <- fibonacci[i] + fibonacci[i + 1]
}

# 5. Crea una función que tome como argumento cualquier vector y devuelva
#     el primer elemento de ese vector.
primer_elemento <- function(vector){
  return(vector[1])
}

# 6. Crea una función que tome como argumento la ruta a una base de datos
#    y imprima el número de filas y columnas de esa base (sin modificar la base).

#   Pruébala con una de las bases de defunciones.

dir <- "//Users//sierrawells//git//curso-banavim//datos//"

num_filas_columnas <- function(ruta){
  base <- fread(ruta)
  print(paste0("filas: ", nrow(base), ", columnas: ", ncol(base)))
}

num_filas_columnas(paste0(dir, "DEFUN15.csv"))

# 7. Crea una función que tome como argumento una base de datos y agregue una
#    columna que se llame pais y que tenga el valor "México" para todas las filas.

#   Lee la base de defunciones para 2015, aplícale la función y guarda el resultado
#   en un nuevo data frame.

agrega_pais <- function(base){
  base$pais <- "México"
  return(base)
}

defunciones_2015 <- fread(paste0(dir, "DEFUN15.csv"))

defunciones_2015_con_pais <- agrega_pais(defunciones_2015)

# Checar que se agregó la columna pais a la base
head(defunciones_2015_con_pais$pais)

# 8. Crea una función que tome como argumento una base de defunciones y que la 
#    filtre para incluir únicamente las defunciones donde ANIO_NACIM (año de nacimiento)
#    sea mayor o igual a 1990.

#   Áplicala a todas las bases de defunciones y junta los resultados en una sola base.

filtrar_anio_nacim <- function(base){
  base_filtrada <- base %>% filter(anio_nacim >= 1990)
  return(base_filtrada)
}

# Se puede aplicar la función a todas las bases con un loop
defun_nombres <- c("DEFUN15.csv", "DEFUN16.csv", "DEFUN17.csv",
                   "DEFUN18.csv", "DEFUN19.csv")

bases_filtradas <- data.frame() # data frame vacío para agregar las bases filtradas

for (nombre in defun_nombres){
  base <- fread(paste0(dir, nombre)) %>% clean_names()
  base_filtrada <- filtrar_anio_nacim(base)
  bases_filtradas <- bind_rows(bases_filtradas, base_filtrada)
  
  print(paste0(nombre, " filtrado y agregado."))
}

# O se puede aplicar la función a todas las bases individualmente:

defun15 <- fread(paste0(dir, "DEFUN15.csv")) %>% clean_names()
defun16 <- fread(paste0(dir, "DEFUN16.csv")) %>% clean_names()
defun17 <- fread(paste0(dir, "DEFUN17.csv")) %>% clean_names()
defun18 <- fread(paste0(dir, "DEFUN18.csv")) %>% clean_names()
defun19 <- fread(paste0(dir, "DEFUN19.csv")) %>% clean_names()

bases_filtradas <- bind_rows(
  defun15 %>% filtrar_anio_nacim(),
  defun16 %>% filtrar_anio_nacim(),
  defun17 %>% filtrar_anio_nacim(),
  defun18 %>% filtrar_anio_nacim(),
  defun19 %>% filtrar_anio_nacim()
) 

# Si usaste las 5 bases de 2015-2019, el resultado debe tener 366,907 filas

# 9. Escribí la siguiente función para convertir millas a kilómetros:
millas_a_km <- function(millas) {
  km <- millas * 1.60934
}

#  Intenta correr el siguiente código para convertir 10 millas a kilómetros:
millas_a_km(10)

# ¿Qué pasa? ¿Cómo lo arreglarías?

# La función no devuelve nada. Para que devuelva el resultado, hay que agregar
# un return() al final de la función:

millas_a_km <- function(millas) {
  km <- millas * 1.60934
  return(km)
}

millas_a_km(10)

# done. ¡Buen trabajo!