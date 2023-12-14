# Autora: SW
# Mantenedora(s): SW, AF
# Curso BANAVIM
# Sesión 5 (26 de enero)
# Licencia: Data Cívica 2023 ©
# ===========================

# TEMAS DE ESTA SESIÓN: =====
# Más sobre paquetes
# dplyr: 
# - pipas
# - case_when()
# - group_by() y summarise() para colapsar bases de datos

# 1. MÁS SOBRE PAQUETES ====
# Al inicio de cada script, es buena práctica cargar todos los paquetes que vamos a usar.
library(dplyr)

# Otra forma de cargar paquetes es con la función p_load() del paquete pacman.
install.packages("pacman") # sólo tienes que correr esto una vez

# p_load() instala los paquetes que no tengas instalados y carga todos los paquetes que le indiques.
pacman::p_load(dplyr, janitor)
# Puede tomar el lugar de install.packages() y library() al inicio de tu script.

# En esta sesión vamos a ocupar la siguiente base de datos de todas las defunciones
# en México en 2022:
# https://drive.google.com/file/d/1o3b3YBtlxyG9ZK7GK8ZLTbPBdMrsuaUc/view?usp=sharing

# La documentación que usamos para limpiar esta base de datos, se puede encontrar aquí:
# https://drive.google.com/file/d/1tqFbOeDZOLu3Neo9vwZ94P0KQ575khxs/view?usp=sharing

defunciones_22_crudo <- read.csv("//Users//sierrawells//git//curso-banavim//datos//DEFUN22.csv")
# Esta base es más grande que las otras que hemos usado, así que puede tardar un poco en cargar.

names(defunciones_22_crudo)
# Los nombres de las columnas están en mayúsculas.
# Para cambiar los nombres a minúscula (y para quitar espacios en los nombres),
# podemos usar la función clean_names() del paquete janitor que instalamos y cargamos arriba.

defunciones_22 <- clean_names(defunciones_22_crudo)

# 2. DPLYR: PIPAS =====
# En la sesión anterior, vimos que se pueden modificar data frames de la siguiente forma:
defunciones_22 <- select(defunciones_22,
                         c(ent_ocurr, sexo, edad, escolarida, tipo_defun))

# dplyr nos permite hacer esta misma operación pero de una forma más fácil de leer
# usando pipas (pipes): %>% 
defunciones_22 <- defunciones_22 %>%
  select(c(ent_ocurr, sexo, edad, escolarida, tipo_defun))

# La pipa toma el objeto que está a la izquierda y lo pasa como primer argumento
# a la función que está a la derecha.

# Para escribir una pipa, presiona Command + Shift + M (Mac) o 
# Ctrl + Shift + M (Windows/Linux).

# 3. DPLYR: case_when() =====
# Hemos visto que podemos crear variables que son iguales para todas las filas de un data frame.
# Por ejemplo:
defunciones_22 <- defunciones_22 %>%
  mutate(pais = "México")

# Sin embargo, a veces queremos crear variables que dependen de otras variables.
# Una forma de hacer esto con R base es con ifelse().
defunciones_22 <- defunciones_22 %>% 
  mutate(homicidio = ifelse(tipo_defun == 2, # una prueba
                            TRUE, # valor si la prueba es verdadera
                            FALSE)) # valor si la prueba es falsa

table(defunciones_22$homicidio)

# ifelse() es útil si sólo hay dos posibilidades para la nueva variable.
# Pero si hay más de dos posibilidades, ifelse() se vuelve muy complicado.
# En estos casos, podemos usar case_when() de dplyr.

defunciones_22 <- defunciones_22 %>% 
  mutate(
    escolarida = case_when(
      # prueba ~ valor si la prueba es verdadera
      escolarida == 1 ~ "Sin escolaridad",
      escolarida == 2 ~ "Preescolar",
      escolarida %in% 3:4 ~ "Primaria",
      escolarida == 5:6 ~ "Secundaria",
      escolarida == 7:8 ~ "Preparatoria o bachillerato",
      escolarida == 9:10 ~ "Licenciatura o posgrado",
      # si ninguna de las pruebas es verdadera, entonces el valor es NA
      TRUE ~ NA_character_),
    edad = case_when(
      edad <= 4000 ~ 0,
      edad > 4000 & edad <= 4120 ~ edad - 4000,
      T ~ NA_real_),
    sexo = case_when(
      sexo == 1 ~ "hombre",
      sexo == 2 ~ "mujer",
      TRUE ~ NA_character_))

table(defunciones_22$tipo_defun, useNA = "ifany")

# 4. DPLYR: group_by() y summarise() =====
# En defunciones_22, cada fila representa una defunción.
# Pero a veces queremos resumir los datos por grupos.
# Para hacer esto, podemos usar group_by() y summarise().

# Por ejemplo, podemos calcular el número de defunciones por escolaridad.
defunciones_por_escol <- defunciones_22 %>%
  filter(!is.na(escolarida)) %>% # quitamos las filas con escolaridad NA
  group_by(escolarida) %>%
  summarise(total = n()) # n() nos da el número de filas en cada grupo

# (Aquí se ve cómo las pipas nos dejan realizar varias operaciones en un data frame
# en un solo "párrafo" de código)

# Por escolaridad y sexo:
defunciones_por_escol_sexo <- defunciones_22 %>%
  filter(!is.na(escolarida) & !is.na(sexo)) %>%
  group_by(escolarida, sexo) %>%
  summarise(total = n())

# A veces nos interesa sumar totales para resumir a niveles menos específicos
# Para revertir defunciones_por_escol_sexo a defunciones_por_escol, podemos usar sum():
defunciones_por_escol <- defunciones_por_escol_sexo %>%
  group_by(escolarida) %>%
  summarise(total_escolaridad = sum(total))

# Si queremos saber qué porcentaje de homicidios son de hombres vs. mujeres, por escolaridad:
homicidios_perc_muj_por_escol <- defunciones_22 %>%
  filter(!is.na(escolarida) & !is.na(sexo) & homicidio == TRUE) %>%
  group_by(escolarida) %>%
  summarise(perc_mujer = round(100 * mean(sexo == "mujer"), 1),
            perc_hombre = round(100 * mean(sexo == "hombre"), 1))

# Arriba se ve que se pueden crear varias variables en un solo summarise().

# group_by() también se puede usar con mutate() para crear variables
# sin elimnar filas o otras columnas.
# Otra forma de ver el porcentaje de homicidios que son hombres vs. mujeres, por escolaridad:
homicidios_perc_sexo_por_escol <- defunciones_22 %>%
  filter(!is.na(escolarida) & !is.na(sexo) & homicidio == TRUE) %>%
  group_by(escolarida, sexo) %>%
  summarise(total_por_sexo = n()) %>% 
  group_by(escolarida) %>% 
  mutate(porcentaje_por_sexo = round(100 * total_por_sexo / sum(total_por_sexo), 1))
  
# Si queremos saber la edad al fallecer en promedio por sexo:
edad_fallec_por_escolaridad <- defunciones_22 %>%
  filter(!is.na(sexo) & !is.na(edad)) %>%
  group_by(sexo) %>%
  summarise(edad_prom = round(mean(edad), 1))

# EJERCICIOS =====
# 1 - 3: Escribe las siguientes operaciones de otra forma, usando pipas:

# 1.
tempo <- select(defunciones_22, c(sexo, edad, tipo_defun))
# 2.
tempo <- filter(defunciones_22, !is.na(escolarida))
# 3.
tempo <- clean_names(defunciones_22_crudo)

# 4. Usando pipas y en un sólo "párrafo" de código, crea un nuevo data frame
# que es el resultado de realizar las siguientes operaciones a defunciones_22:
# - Filtrar por edad no NA y sexo no NA
# - Crear una nueva columna llamada menor_de_edad que tome el valor TRUE si la edad es menor a 18
#   y FALSE si la edad es mayor o igual a 18
# - Agrupar por menor_de_edad y sexo
# - Resumir por el número de fallecimientos en cada grupo

# 5. Haz lo mismo que en el ejercicio 4, pero ahora resume por el número de homicidios
#    (en lugar de fallecimientos en general) en cada grupo.

# 6. Crea un nuevo data frame que agrupa por la columna escolaridad de defunciones_22 y 
#     resume con dos columnas: una con el porcentaje de fallecimientos que
#     son homicidios en cada grupo y otra con el total de fallecimientos en cada grupo.

# 7. Crea un nuevo data frame que resuma defunciones_22 por qué porcentaje
#     de fallecimientos son de personas de cada nivel de escolaridad, en cada entidad (ent_ocurr).
#    (Por ejemplo, en cada entidad, ¿qué porcentaje de fallecimientos
#     fueron de personas sin escolaridad? ¿Con escolaridad de primaria, secundaria, etc.?)

# 8 & 9: Carga la base homicidio_tipoarma que bajamos en los ejercicios de la sesión 3.
# Para los siguientes ejercicios, usaremos esta base.

# 8. Carga la base geog_abrevs que bajamos en los ejercicios de la sesión 4.
#   Crea un nuevo data frame que agrupe homicidio_tipoarma por entidad (ent)
#   y calcule el total de homicidios en cada entidad.
#   En el mismo párrafo, usando pipas, agrega las abreviaciones de las entidades a
#   homicidio_tipoarma. (Pista: usa sum() y después una función de join)

# 9. Crea un nuevo data frame que agrupe homicidio_tipoarma por year y calcule
#     el porcentaje de homicidios que son con arma de fuego en cada año.
#     (Puedes crear dos data frames intermedios y cruzarlos al final, si se te hace más fácil.)


# done. ¡Buen trabajo!
