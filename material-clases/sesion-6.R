# Autora: SW
# Mantenedora(s): SW, AF
# Curso BANAVIM
# Sesión 6 (30 de enero)
# Licencia: Data Cívica 2023 ©
# ===========================

# Cargar paquetes ====
pacman::p_load(dplyr, data.table, janitor)

# TEMAS DE ESTA SESIÓN: =====
# Loops
# Condicionales (if, else)
# Funciones

# LOOPS =====
# Bajemos las 5 bases de datos de defunciones de 2015 a 2019, que se pueden
# encontrar en esta carpeta:
# https://drive.google.com/drive/folders/19NumS0BRHPNkkfjIcR88j1S8yYFRZmH8

dir <- "//Users//sierrawells//git//curso-banavim//datos//"
# fread es una función del paquete data.table que lee archivos de una forma más rápida
defun15 <- fread(paste0(dir, "DEFUN15.csv")) 
defun16 <- fread(paste0(dir, "DEFUN16.csv"))
defun17 <- fread(paste0(dir, "DEFUN17.csv"))
defun18 <- fread(paste0(dir, "DEFUN18.csv"))
defun19 <- fread(paste0(dir, "DEFUN19.csv"))

# Al revisarlas podemos ver que tienen la misma estructura e incluso los mismos nombres
str(defun15)
str(defun16)
str(defun17)
str(defun18)
str(defun19)

# Imaginemos que aplico esta serie de cambios a la primera base

defun15 <- defun15 %>% 
  clean_names() %>% 
  mutate(across(.cols = c("ent_regis", "ent_ocurr"),
                .fns = ~str_pad(string = ., width = 2, side = "left", pad = "0"))) %>% 
  # str_pad es una función del paquete stringr que en este caso agrega ceros a la izquierda
  # de ent_regis y ent_ocurr para que todos los valores tengan la misma longitud
  mutate(across(.cols = c("mun_regis", "mun_ocurr"),
                .fns = ~str_pad(string = ., width = 3, side = "left", pad = "0"))) %>% 
  mutate(inegi = paste0(ent_ocurr, mun_ocurr)) %>% 
  filter(presunto == 2,  anio_ocur %in% 2015:2019) %>%
  select(inegi, ent_regis, mun_regis, ent_ocurr, mun_ocurr, anio_ocur, anio_regis,
         sexo)

# Muy bien, pero supongamos que quiero aplicar los mismos cambios a las otras bases
# y guardarlas en una sola base de datos
# ¿Cómo le haría?
# Podría hacer un "loop" (una misma secuencia de acciones que quiero aplicar a distintas bases)

defun_nombres <- c("DEFUN15.csv", "DEFUN16.csv", "DEFUN17.csv",
             "DEFUN18.csv", "DEFUN19.csv") # primero guardamos en un vector los
                                           # nombres de las bases que abriremos

defun15_19 <- data.frame() # después necesitamos abrir un lugar vacío donde podamos almacenar
                          # nuestros resultados


for(nombre in defun_nombres) {
  
  # En cada iteración, leemos la base de datos con el nombre de esa interación
  tempo <- fread(paste0(dir, nombre)) 
  
  # Aplicamos los cambios a la base guardada como "data"
  tempo <- tempo %>% 
    clean_names() %>% 
    mutate(across(.cols = c("ent_regis", "ent_ocurr"),
                  .fns = ~str_pad(string = ., width = 2, side = "left", pad = "0"))) %>% 
    # str_pad es una función del paquete stringr que en este caso agrega ceros a la izquierda
    # de ent_regis y ent_ocurr para que todos los valores tengan la misma longitud
    mutate(across(.cols = c("mun_regis", "mun_ocurr"),
                  .fns = ~str_pad(string = ., width = 3, side = "left", pad = "0"))) %>% 
    mutate(inegi = paste0(ent_ocurr, mun_ocurr)) %>% 
    filter(presunto == 2,  anio_ocur %in% 2015:2019) %>%
    select(inegi, ent_regis, mun_regis, ent_ocurr, mun_ocurr, anio_ocur, anio_regis,
           sexo)
  
  defun15_19 <- bind_rows(defun15_19, tempo) # guardamos el resultado en la base vacía que creamos
  # (bind_rows es una función de dplyr que agrega un data frame a otro como nuevas filas)
  
  print(paste0(nombre, " agregado."))
}

# Los loops también pueden utilizar los índices de un vector (o lista) para iterar.
# El índice es el número que se refiere a la posición de un elemento en un vector (o lista).

frutas <- c("ciruela", "tuna", "plátano", "rambután", "maracuyá", "pitaya")

for(i in 1:length(frutas)) {
  print(paste0("El índice de la fruta ", frutas[i], " es ", i))
}

# Como se ve arriba, un elemento de un vector se puede acceder con su índice de la siguiente forma:
# vector[indice]
frutas[3]

# Repitamos el ejercicio anterior, pero ahora utilizando los índices de la lista de nombres
# de las bases de datos

defun15_19 <- data.frame() # vaciamos la base de datos donde guardaremos los resultados

for(i in 1:length(defun_nombres)) {
  
  # Aquí nos referimos al nombre que nos interesa con el índice i
  tempo <- fread(paste0(dir, defun_nombres[i])) 
  
  tempo <- tempo %>% 
    clean_names() %>% 
    mutate(across(.cols = c("ent_regis", "ent_ocurr"),
                  .fns = ~str_pad(string = ., width = 2, side = "left", pad = "0"))) %>% 
    mutate(across(.cols = c("mun_regis", "mun_ocurr"),
                  .fns = ~str_pad(string = ., width = 3, side = "left", pad = "0"))) %>% 
    mutate(inegi = paste0(ent_ocurr, mun_ocurr)) %>% 
    filter(presunto == 2,  anio_ocur %in% 2015:2019) %>%
    select(inegi, ent_regis, mun_regis, ent_ocurr, mun_ocurr, anio_ocur, anio_regis,
           sexo)
  
  defun15_19 <- bind_rows(defun15_19, tempo) # guardamos el resultado en la base vacía
  
  print(paste0(nombre, " agregado."))
}

# CONDICIONALES ====
# A veces queremos realizar una operación sólo si se cumple una condición

# En estos casos, podemos utilizar condicionales (if, else)
# que generalmente toman la siguiente forma:
# if(condición) {
#   operación
# } else {
#   operación
# }
# (la parte del else es opcional)

# Por ejemplo, si queremos determinar si un número es negativo o positivo:
numeros <- -5:5

# Con puros if
for(numero in numeros){
  if (numero < 0) {
    print(paste0(numero, " es negativo"))
  }
  if (numero == 0) {
    print(paste0(numero, " es igual a 0."))
  }
  if (numero > 0){
    print(paste0(numero, " es positivo"))
  }
}

# Con if y else
for (numero in numeros) {
  if (numero < 0) {
    print(paste0(numero, " es negativo"))
  } else {
    print(paste0(numero, " no es negativo"))
  }
}

for (numero in numeros) {
  if (numero < 0) {
    print(paste0(numero, " es negativo"))
  } else if (numero == 0) {
    print(paste0(numero, " es igual a 0."))
  } else {
    print(paste0(numero, " es positivo"))
  }
}

# FUNCIONES ====
# Hasta ahora hemos utilizado muchas funciones, pero no hemos creado ninguna
# En R, puedes crear tu propia función con la siguiente sintaxis:

# nombre_función <- function(argumentos) {
#   operaciones
#   return(resultado)
# }

converter_f_a_c <- function(fahrenheit) {
  celsius <- (fahrenheit - 32) * 5/9
  return(celsius)
}

letras_como_bob_esponja <- function(texto) {
  nchar_texto <- nchar(texto)

  for (i in 1:nchar_texto) {
    if (i %% 2 == 0) { # para índices pares
      substr(texto, i, i) <- toupper(substr(texto, i, i))
    } else { # para índices no pares
      substr(texto, i, i) <- tolower(substr(texto, i, i))
    }
  }
  return(texto)
}

# Podemos también crear una función para simplicar
# los cambios que hicimos a las bases de datos de defunciones

# Tomamos como argumento el nombre de la base de datos
leer_y_limpiar_defun <- function(nombre){
 
  # La leemos
  tempo <- fread(paste0(dir, nombre)) 
  
  # La limpiamos
  tempo <- tempo %>% 
    clean_names() %>% 
    mutate(across(.cols = c("ent_regis", "ent_ocurr"),
                  .fns = ~str_pad(string = ., width = 2, side = "left", pad = "0"))) %>% 
    mutate(across(.cols = c("mun_regis", "mun_ocurr"),
                  .fns = ~str_pad(string = ., width = 3, side = "left", pad = "0"))) %>% 
    mutate(inegi = paste0(ent_ocurr, mun_ocurr)) %>% 
    filter(presunto == 2,  anio_ocur %in% 2015:2019) %>%
    select(inegi, ent_regis, mun_regis, ent_ocurr, mun_ocurr, anio_ocur, anio_regis,
           sexo)
  
  # Devolvemos el resultado
  return(tempo)
}

defun15 <- leer_y_limpiar_defun("DEFUN15.csv")

# EJERCICIOS ====
# 1. Crea un loop que imprima los números del 1 al 10.

# 2. Tengo el siguiente vector de artistas musicales:
artistas <- c("Dani Flow", "UB40", "Omar Apollo",
              "Kevin Kaarl", "Ana Tijoux", "ABBA")

# Usando un loop, crea un nuevo vector que contenga los nombres de los artistas
# que empiezan con una consonante y, en lugar de cada nombre de los artistas que 
# empiezan con una vocal, pon "empieza con una vocal".
artistas_nuevo <- c()
# Tu loop aquí

# Pista: puedes utilizar substr() para obtener la primera letra de cada nombre

# Al final artistas_nuevo debe verse así:
c("Dani Flow", "empieza con una vocal", "empieza con una vocal",
  "Kevin Kaarl", "empieza con una vocal", "empieza con una vocal")

# 3. Usando un loop y los índices de los elementos del vector artistas,
#   crea un nuevo vector que contenga los nombres de los artistas
#   y el índice de su posición en el vector original, separados por un guión.
#   Por ejemplo, el primer elemento del nuevo vector debe ser "Dani Flow-1".

# 4 (desafío). En la matemática, la sucesión de Fibonacci es una sucesión
#  infinita de números que comienza con los números 0 y 1, y a partir
#  de estos, cada término es la suma de los dos anteriores.
#  Por ejemplo, los primeros 10 términos de la sucesión son:
#  0, 1, 1, 2, 3, 5, 8, 13, 21, 34

# Termina el siguiente loop para que el vector fibonacci contenga los primeros
# 10 términos de la sucesión de Fibonacci.

fibonacci <- c(0, 1)
for (i in 1:8) {
  fibonacci["un índice"] <- fibonacci["otro índice"] + fibonacci["otro índice"]
}

# 5. Crea una función que tome como argumento cualquier vector y devuelva
#     el primer elemento de ese vector.

# 6. Crea una función que tome como argumento la ruta a una base de datos
#    y imprima el número de filas y columnas de esa base (sin modificar la base).

#   Pruébala con una de las bases de defunciones.

# 7. Crea una función que tome como argumento una base de datos y agregue una
#    columna que se llame pais y que tenga el valor "México" para todas las filas.

#   Lee la base de defunciones para 2015, aplícale la función y guarda el resultado
#   en un nuevo data frame.

# 8. Crea una función que tome como argumento una base de defunciones y que la 
#    filtre para incluir únicamente las defunciones donde ANIO_NACIM (año de nacimiento)
#    sea mayor o igual a 1990.

#   Áplicala a todas las bases de defunciones y junta los resultados en una sola base.

# 9. Escribí la siguiente función para convertir millas a kilómetros:
millas_a_km <- function(millas) {
  km <- millas * 1.60934
}

#  Intenta correr el siguiente código para convertir 10 millas a kilómetros:
millas_a_km(10)

# ¿Qué pasa? ¿Cómo lo arreglarías?

# done. ¡Buen trabajo!



# done.