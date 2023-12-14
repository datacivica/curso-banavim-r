# Autora: SW
# Mantenedora(s): SW, AF
# Curso BANAVIM
# Ejercicios sesión 2 (16 de enero)
# Licencia: Data Cívica 2023 ©
# ===========================

# Este script contiene una guía a algunas de las posibles soluciones
# de los ejercicios de la sesión 2 (al final del script sesion-2.R)

# Por favor, intenta hacer los ejercicios por tu cuenta antes de ver
# las soluciones. El código que está aquí son solo algunas de las posibles
# soluciones, y no necesariamente las mejores.

# EJERCICIOS ====
# 1. Crea una variable que contenga tu tipo preferido de chilaquiles.
chilaquiles_pref <- "verdes crujientes"

# 2. Crea una variable numérica.
#     Réstale 10 y guarda el resultado en otra variable que se llama "resultado".
#     Divide resultado por 3.
var_numerica <- 100
resultado <- var_numerica - 10
resultado / 3

# 3. Crea una variable que contenga un valor lógico.
var_logica <- FALSE # debe ser uno de los siguientes valores: TRUE, FALSE, T o F

# 4. Guarda tu número de la suerte en una variable que se llama "numero_suerte_num".
#     Guarda ese mismo número, pero entre comillas (i.e. "5")
#     en otra variable que se llama "numero_suerte_texto".
#     ¿Cuál es la clase de cada una de las variables?
#     ¿Qué pasa si intentas sumar 1 a cada una de las variables?
numero_suerte_num <- 5
numero_suerte_texto <- "5"
class(numero_suerte_num) # numeric
class(numero_suerte_texto) # character
numero_suerte_num + 1 # 6
numero_suerte_texto + 1 # Error (no se puede sumar un número a un texto)


# 5. Convierte el objeto "numero_suerte_texto" en un número.
#    ¿Qué pasa si intentas sumarle 1 ahora?
numero_suerte_texto <- as.numeric(numero_suerte_texto)
numero_suerte_texto + 1 # 6

# 6. Cuando creamos objetos, es importante asignarles nombres que indiquen
#    qué tipo de información contienen y que no sean demasiado largos.
#    ¿Cuál sería un buen nombre para un objeto que contiene el número de
#    feminicidios en Nuevo León en 2020?  
#    ¿Cuál sería un ejemplo de un nombre que no indique bien el contenido del objeto?

#    Posibles buenos nombres: feminicidios_nl_2020, feminicidios_2020_nl, num_fcidios_nl_2020
#    Posibles malos nombres: fnl20 (no se entiende qué significa)
#.                           feminicidios_en_nuevo_leon_en_el_anio_2020 (muy largo)

# 7. ¿Qué pasa si intentas crear un objeto que se llama "2años"? ¿"2anios"?
#    ¿"dos_anios"? ¿"dos anios"? ¿"anios_2"?
#    ¿Por qué?
2años <- "prueba" # Error
2anios <- "prueba" # Error
dos_anios <- "prueba" # Guarda el objeto exitosamente
dos anios <- "prueba" # Error
anios_2 <- "prueba" # Guarda el objeto exitosamente

# No se pueden usar tildes en los nombres de los objetos.
# No se pueden usar números al principio de un nombre de objeto.
# No se pueden usar espacios en los nombres de los objetos.

# 8. Crea un objeto y luego bórralo del ambiente de trabajo.
objeto <- "En Cuemanco venden plantas bien chidas."

# 9. Crea un vector que se llama "mi_cumple" que contenga los números de
#     tu día, mes y año de nacimiento.
mi_cumple <- c(11, 5, 2000)

# 10. Crea un vector que se llama "mi_nombre" que contenga un texto para cada uno
#     de tus nombres y apellidos.
mi_nombre <- c("Sierra", "Forssell", "Wells")

# 11. Crea una lista que contenga tu edad, tu lugar de nacimiento, y un valor NA.
mi_lista <- list(23, "el gabacho", NA)

# 12. ¿Cuál es la diferencia entre una lista y un vector?
# Un vector debe contener valores de una sola clase (numérico, texto, lógico, etc.).
# Una lista puede contener varios tipos de datos. (números Y textos, etc.)

# 13. Crea un data frame que se llama "mis_compas" que tenga una columna que
#   corresponde a los nombres de por lo menos 5 familiares o amigues,
#   y otra columna que corresponde al número de mascotas que tienen.
mis_compas <- data.frame(
  nombre = c("Marigu", "Carlos", "Sabina", "Emilia", "Karen"),
  mascotas = c(1, 3, 3, 2, 0)
)

# 14. Abre el data frame "mis_compas" para ver todo su contenido.
View(mis_compas)

# fin. ¡Buen trabajo! :D