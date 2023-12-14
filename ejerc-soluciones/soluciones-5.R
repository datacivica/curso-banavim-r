# Autora: SW
# Mantenedora(s): SW, AF
# Curso BANAVIM
# Ejercicios sesión 5 (26 de enero)
# Licencia: Data Cívica 2023 ©
# ===========================

# Este script contiene una guía a algunas de las posibles soluciones
# de los ejercicios de la sesión 5 (al final del script sesion-5.R)

# Por favor, intenta hacer los ejercicios por tu cuenta antes de ver
# las soluciones. El código que está aquí son solo algunas de las posibles
# soluciones, y no necesariamente las mejores.

# EJERCICIOS =====
# 1 - 3: Escribe las siguientes operaciones de otra forma, usando pipas:

# 1.
tempo <- select(defunciones_22, c(sexo, edad, tipo_defun))

tempo <- defunciones_22 %>%
  select(c(sexo, edad, tipo_defun))

# 2.
tempo <- filter(defunciones_22, !is.na(escolarida))

tempo <- defunciones_22 %>%
  filter(!is.na(escolarida))

# 3.
tempo <- clean_names(defunciones_22_crudo)

tempo <- defunciones_22_crudo %>%
  clean_names()

# 4. Usando pipas y en un sólo "párrafo" de código, crea un nuevo data frame
# que es el resultado de realizar las siguientes operaciones a defunciones_22:
# - Filtrar por edad no NA y sexo no NA
# - Crear una nueva columna llamada menor_de_edad que tome el valor TRUE si la edad es menor a 18
#   y FALSE si la edad es mayor o igual a 18
# - Agrupar por menor_de_edad y sexo
# - Resumir por el número de fallecimientos en cada grupo

defun_por_edad_sexo <- defunciones_22 %>%
  filter(!is.na(edad) & !is.na(sexo)) %>%
  mutate(menor_de_edad = ifelse(edad < 18, TRUE, FALSE)) %>%
  group_by(menor_de_edad, sexo) %>%
  summarise(fallecimientos = n())

# 5. Haz lo mismo que en el ejercicio 4, pero ahora resume por el número de homicidios
#    (en lugar de fallecimientos en general) en cada grupo.
homicidios_por_edad_sexo <- defunciones_22 %>%
  filter(!is.na(edad) & !is.na(sexo)) %>%
  mutate(menor_de_edad = ifelse(edad < 18, TRUE, FALSE)) %>%
  group_by(menor_de_edad, sexo) %>%
  summarise(homicidios = sum(homicidio == TRUE))

# Otra forma de hacer lo mismo:
homicidios_por_edad_sexo <- defunciones_22 %>%
  filter(!is.na(edad) & !is.na(sexo) & homicidio == T) %>%
  mutate(menor_de_edad = ifelse(edad < 18, TRUE, FALSE)) %>%
  group_by(menor_de_edad, sexo) %>%
  summarise(homicidios = n())

# 6. Crea un nuevo data frame que agrupa por la columna escolaridad y 
#     resume con dos columnas: una con el porcentaje de fallecimientos que
#     son homicidios en cada grupo y otra con el total de fallecimientos en cada grupo.
fallecimientos_escolaridad <- defunciones_22 %>%
  group_by(escolarida) %>%
  summarise(porcentaje_homicidios = sum(homicidio == TRUE) / n(),
            total_fallecimientos = n())

# Otra forma:
fallecimientos_escolaridad <- defunciones_22 %>%
  group_by(escolarida) %>%
  summarise(porcentaje_homicidios = mean(homicidio == TRUE),
            total_fallecimientos = n())

# 7. Crea un nuevo data frame que resuma defunciones_22 por qué porcentaje
#     de fallecimientos son de personas de cada nivel de escolaridad, en cada entidad.
#    (Por ejemplo, en cada entidad, ¿qué porcentaje de fallecimientos
#     fueron de personas sin escolaridad? ¿Con escolaridad de primaria, secundaria, etc.?)
fallecimientos_esc_ent <- defunciones_22 %>%
  group_by(ent_ocurr, escolarida) %>%
  summarize(
    # Total de defunciones para cada escolaridad en cada entidad
    total_esc_entidad = n()) %>% 
  group_by(ent_ocurr) %>% 
  mutate(
    # Total de defunciones en cada entidad (de cualquier escolaridad)
    total_entidad = sum(total_esc_entidad),
    perc_esc_entidad = round(100 * total_esc_entidad /total_entidad, 2)
  )

# 8 & 9: Carga la base homicidio_tipoarma que bajamos en los ejercicios de la sesión 3.
# Para los siguientes ejercicios, usaremos esta base.
homicidio_tipoarma <- read.csv("//Users//sierrawells//git//curso-banavim//datos//homicidio_tipoarma.csv")

# 8. Carga la base geog_abrevs que bajamos en los ejercicios de la sesión 4.
#   Crea un nuevo data frame que agrupe homicidio_tipoarma por entidad (ent)
#   y calcule el total de homicidios en cada entidad.
#   En el mismo párrafo, usando pipas, agrega las abreviaciones de las entidades a
#   homicidio_tipoarma. (Pista: usa sum() y después una función de join)
geog_abrevs <- read.csv("//Users//sierrawells//git//curso-banavim//datos//geog_abrevs.csv")

homicidios_por_entidad <- homicidio_tipoarma %>%
  group_by(ent) %>%
  summarise(total_homicidios = sum(total)) %>%
  left_join(geog_abrevs, by = c("ent" = "nom_ent"))

# 9. Crea un nuevo data frame que agrupe homicidio_tipoarma por year y calcule
#     el porcentaje de homicidios que son con arma de fuego en cada año.
#     (Puedes crear dos data frames intermedios y cruzarlos al final, si se te hace más fácil.)
total_homicidios_por_anio <- homicidio_tipoarma %>%
  group_by(year) %>%
  summarise(total_homicidios = sum(total))

total_arma_fuego_por_anio <- homicidio_tipoarma %>%
  filter(subtipo == "Con Arma De Fuego") %>% 
  group_by(year) %>%
  summarise(total_arma_fuego = sum(total))

porc_arma_fuego_por_anio <- total_homicidios_por_anio %>%
  left_join(total_arma_fuego_por_anio, by = "year") %>%
  mutate(porc_arma_fuego = round(100 * total_arma_fuego / total_homicidios, 1))

# done. ¡Buen trabajo!