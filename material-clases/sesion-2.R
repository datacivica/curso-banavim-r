# Autora: SW
# Mantenedora(s): SW, AF
# Curso BANAVIM
# Sesión 2 (16 de enero)
# Licencia: Data Cívica 2023 ©
# ===========================

# Antes de empezar:
# Si en una linea ves un "#" quiere decir que esa linea 
# (o el resto de esa línea) es un comentario.
# Puedes crear tus propios comentarios escribiendo "#" en una nueva linea
# y escribiendo el texto de tu comentario.

# Para "correr" (o ejecutar) una línea de código, puedes hacer
# click en la linea y luego presionar "Ctrl + Enter" en tu teclado

# TEMAS DE ESTA SESIÓN: =====
# Tipos de objetos en R
# Ambiente de trabajo en R
# Abrir las tablas en R

# 1. OBJETOS (VALORES) ====
# Los objetos son la forma de guardar valores en R usando un nombre
# Para crear un objeto, escribe el nombre que le quieres dar, luego "<-"
# y luego el valor que quieres guardar

# Por ejemplo, si corro el siguiente código:
mi_numero_favorito <- 5
# R me va a guardar el valor 5 en el objeto mi_numero_favorito

# Pruébalo corriendo la siguiente línea de código:
mi_numero_favorito

# Puedo usar mi nuevo objeto en operaciones:
mi_numero_favorito + 1
# Y guardar el resultado de estas operactiones en otro objeto:
mi_primera_suma <- mi_numero_favorito + 1
mi_primera_multiplicacion <- mi_numero_favorito * 2
# A ver cómo nos salieron nuestras operaciones:
mi_primera_suma
mi_primera_multiplicacion

# 5 es un ejemplo de un tipo de valor que se llama "entero" o "integer" en inglés,
# ya que es un número entero (no tiene decimales).
# Pero también puedes guardar número con decimales en objetos:
mi_numero_con_decimales <- 5.5
# En R, los números con decimales con se llaman "numéricos" o "numeric" en inglés.

# También puedes guardar otros tipos de valores en objetos, como texto:
mi_palabra_favorita <- "elote"
mi_frase_favorita <- "A la vuelta venden elotes"
# Si quieres cambiar el valor de un objeto, puedes volver a usar "<-" con el mismo nombre
mi_frase_favorita <- "A la vuelta venden esquites"

# Por último, se pueden guardar en objetos los valores lógicos,
# es decir los valores "verdadero" y "falso":
me_gustan_los_elotes <- TRUE # verdadero
me_gustan_los_esquites <- T # verdadero
me_gusta_el_menudo <- FALSE # falso
me_gusta_el_atun <- F # falso

# Puedes checar las clases de los objetos que has creado usando la función "class()"
class(mi_palabra_favorita)

# También puedes usar las siguientes funciones, que devuelven TRUE o FALSE,
# dependiendo de si el objeto es de la clase que se indica:
is.character(mi_palabra_favorita)
is.numeric(mi_palabra_favorita)

# En algunos casos, puedes convertir un objeto de una clase a otra.
# El ejemplo más común de esto es con los números:
numero_como_texto <- as.character(mi_numero_favorito) # expresa el número como texto
numero_como_numerico <- as.numeric(numero_como_texto) # expresa el número como númerico de nuevo

# PARA RESUMIR, existen las siguientes clases de valores en R:
# Integer: números enteros
# Numeric: números que pueden contener decimales
# Character: texto
# Logical: verdadero o falso

# Regresaremos al tema de los objetos en breve, pero primero vamos a ver un poco más
# sobre el espacio donde se guardan estos valores en R: el ambiente de trabajo.

# 2. AMBIENTE DE TRABAJO ====
# ¿Cómo se acuerda R de los objetos que guardamos?
# Los guarda en un espacio que se llama el "ambiente de trabajo" o "environment" en inglés.
# Puedes ver el ambiente de trabajo en la pestaña "Environment" en de RStudio
# (normalmente está en la parte superior derecha de la pantalla).

# Cuando abres RStudio por la primera vez o reinicias la aplicación,
# el ambiente de trabajo está vacío.
# Sin embargo, como ya hemos creado algunos objetos,
# deberías poder ver en el ambiente de trabajo tanto el nombre que les asignamos
# como el valor que corresponde a cada nombre.

# Generalmente, es una buena práctica limpiar el ambiente de trabajo cuando empiezas a trabajar
# en un nuevo proyecto o script (un archivo de código, como el que estás leyendo ahora).

# Para borrar un objeto del ambiente de trabajo, puedes usar la función "rm()"
rm(mi_frase_favorita)

# Si quieres borrar todos los objetos del ambiente de trabajo,
# puedes reiniciar RStudio o usar la siguiente función: rm(list = ls())

# 3. OBJETOS (VECTORES, LISTAS Y DATA FRAMES) ====
# Los objetos que hemos guardado hasta ahora son ejemplos de variables,
# ya que son objetos que contienen un solo elemento
# (un solo número, un solo texto, un solo valor lógico, etc.).

# Pero también existen objetos en R que contienen más de un solo elemento.
# Por ejemplo, puedes guardar varios números en un solo objeto usando un "vector".
# Para crear un vector, usa la función "c()" y escribe los valores que quieres guardar
mi_vector_de_enteros <- c(2, -1, 3, 5, 87324)

# O puedes también crear un vector de textos:
mi_vector_de_textos <- c("elote", "esquite", "atole", "agua de jamaica")

# O de valores lógicos
mi_vector_de_logicos <- c(TRUE, FALSE)

# Un vector debe contener valores de una sola clase
# (por ejemplo, puros números o puros textos)

# Si quieres crear un objeto que contenga varios valores de diferentes clases,
# (por ejemplo, números Y textos), puedes usar una "lista".
# Para crear una lista, se usa la función "list()":
mi_primera_lista <- list(1, "elote", TRUE)

# Por último, un "data frame" (literalmente "marco de datos") es un objeto
# que junta varios vectores en una tabla.
# Para crear un data frame, se usa la función "data.frame()".
mi_df <- data.frame(
  estado = c("CDMX", "Tabasco", "Zacatecas"),
  puestos_de_elotes = c(1000, 500, 400),
  tortas_de_tamal = c(TRUE, FALSE, FALSE)
)

# Para ver todo el contenido de un data frame, puedes usar la función "View()"
# o hacer click en el nombre del data frame en el ambiente de trabajo.
View(mi_df)

# Como se puede ver, los data frames tratan cada vector como una columna, 
# y cada elemento del vector como una fila.
# Por esta razón, cada vector (o columna) del data frame
# debe tener el mismo número de elementos.

# Cuando estamos trabajando con bases de datos,
# normalmente usamos data frames para guardarlas.

# A veces, en un data frame, o otros tipos de objetos,
# encontrarás el valor "NA" en una celda. Por ejemplo:
mi_df_con_na <- data.frame(
  estado = c("CDMX", "Tabasco", "Zacatecas"),
  puestos_de_esquites = c(1000, 500, NA),
  tortas_de_chilaquiles = c(TRUE, NA, FALSE)
)

# "NA" significa "not available" o "no disponible". En otras palabras,
# no se conoce el valor de esa columna para esa fila.

# EJERCICIOS ====
# 1. Crea una variable que contenga tu tipo preferido de chilaquiles.

# 2. Crea una variable numérica.
#     Réstale 10 y guarda el resultado en otra variable que se llama "resultado".
#     Divide resultado por 3.

# 3. Crea una variable que contenga un valor lógico.

# 4. Guarda tu número de la suerte en una variable que se llama "numero_suerte_num".
#     Guarda ese mismo número, pero entre comillas (i.e. "5")
#     en otra variable que se llama "numero_suerte_texto".
#     ¿Cuál es la clase de cada una de las variables?
#     ¿Qué pasa si intentas sumar 1 a cada una de las variables?

# 5. Convierte el objeto "numero_suerte_texto" en un número.
#    ¿Qué pasa si intentas sumarle 1 ahora?

# 6. Cuando creamos objetos, es importante asignarles nombres que indiquen
#    qué tipo de información contienen y que no sean demasiado largos.
#    ¿Cuál sería un buen nombre para un objeto que contiene el número de
#    feminicidios en Nuevo León en 2020?  
#    ¿Cuál sería un ejemplo de un nombre que no indique bien el contenido del objeto?

# 7. ¿Qué pasa si intentas crear un objeto que se llama "2años"? ¿"2anios"?
#    ¿"dos_anios"? ¿"dos anios"? ¿"anios_2"?
#    ¿Por qué?

# 8. Crea un objeto y luego bórralo del ambiente de trabajo.

# 9. Crea un vector que se llama "mi_cumple" que contenga los números de
#     tu día, mes y año de nacimiento.

# 10. Crea un vector que se llama "mi_nombre" que contenga un texto para cada uno
#     de tus nombres y apellidos.

# 11. Crea una lista que contenga tu edad, tu lugar de nacimiento, y un valor NA.

# 12. ¿Cuál es la diferencia entre una lista y un vector?

# 13. Crea un data frame que se llama "mis_compas" que tenga una columna que
#   corresponde a los nombres de por lo menos 5 familiares o amigues,
#   y otra columna que corresponde al número de mascotas que tienen.

# 14. Abre el data frame "mis_compas" para ver todo su contenido.

# Para ver las soluciones, ve el archvio soluciones-2.R

# fin. ¡Buen trabajo! :D