########################
# Librerías utilizadas #
########################

# Para utilizar las librerías de R, es importante instalar los siguientes programas (para ejecutar, quitar el signo "#")

#install.packages("Microsoft365R")
#install.packages("readxl")
#install.packages("dplyr")
#install.packages("ggplot2")

# Sólo es necesario realizar el paso anterior 1 vez. En adelante, bastará con cargar las librerías así:

library(Microsoft365R) # La documentación puede encontrarse aquí: https://github.com/Azure/Microsoft365R 
library(readxl)
library(dplyr)
library(ggplot2)

######################################## 
# Descargar la información actualizada # 
######################################## 

list_sharepoint_sites()

site <- get_sharepoint_site("Grupo Teletrabajo GSF") # Accede al Sharepoint (la primera vez pedirá usuario y clave, hay que tramitar permiso de administrador con OTI)
drv <- site$get_drive('Documentos') # Dentro del Sharepoint, accede a la carpeta "Documentos"
drv$download_file("Bases y supervisiones/Bases de datos/2023/BBDD - Base Expedientes DFI 2023.xlsx", dest="bd_exp_2023.xlsx") # Descarga la BD seleccionada
df <- read_xlsx("bd_exp_2023.xlsx", sheet = "BBDD", skip=1) # Genera un objeto en R con la información del archivo en excel
as.data.frame(df) # Convierte el objeto en un dataframe 
rm(drv, site) # Quitamos los objetos innecesarios del ambiente de trabajo

###########################################################
# Guardado y cargado de objetos en el ambiente de trabajo #
###########################################################

save(df, file="bd_exp_2023.RData") # Guardar el objeto "df" en un archivo .RData (obsérvese el peso del archivo excel en comparación)
rm(df) # Eliminamos el objeto "df" del ambiente de trabajo
load("bd_exp_2023.RData") # Cargamos el objeto "df" desde el archivo .RData

#############################
# Eliminar archivos desde R #
#############################

file.remove("bd_exp_2023.xlsx", "bd_exp_2023.RData") # Elimina los archivos listados

#########################
# Explorar el dataframe #
#########################

class(df) # Permite verificar el tipo de objeto

# Acceso a información básica

dim(df) # Obtiene el número de filas y columnas
nrow(df) # Obtiene el número de filas (observaciones)
ncol(df) # Obtiene el número de columnas (variables)
names(df) # Obtiene los nombres de las columnas del dataframe 
str(df) # Muestra nombres de las columnas junto con el tipo de dato que almacenan
summary(df) # Muestra un resumen de la información de cada columna
summary(df$GRUPO_ESTANDARIZADO) #Es posible aplicar summary para una o varias columnas seleccionadas

table(df$Revisor) # Muestra un conteo de los valores de una columna
prop.table(table(df$Revisor)) # Muestra la información de table

# Uso de dplyr

f1 <- filter(df, Revisor == "Ivette Sánchez") # Filtra columnas por sus valores (ver el nuevo objeto en el ambiente)
f2 <- df %>% filter(Revisor == "Ivette Sánchez") # Igual al anterior, el signo %>% se denomina pipe y se introduce con el atajo "ctrl + shift + m"

a1 <- df %>% arrange(GRUPO_ESTANDARIZADO) # Cambia el orden de las filas (en este caso, en orden alfabético ascendente)
a2 <- df %>% arrange(desc(GRUPO_ESTANDARIZADO)) # También cambia el orden (en este caso, en orden alfabético descendente)

s1 <- df %>% select('N° de Expediente', Revisor, GRUPO_ESTANDARIZADO, RUC) # Selecciona columnas por sus nombres
sn <- df %>% rename(expediente = 'N° de Expediente', jefe_de_equipo = Revisor, grupo = GRUPO_ESTANDARIZADO, ruc = RUC) # Cambia los nombres de las columnas indicadas


m1 <- s1 %>% mutate(dato_aleatorio = as.numeric(df$RUC) / 2) # Crea nuevas columnas (puede ser en función de la información que se tiene en otra columna)

r1 <- df %>% summarise(media_plazo = mean(df$'Plazo para la tramitación (meses)', na.rm = TRUE)) # Agrupa y resume valores múltiples

# Uso de as.numeric

str(df$RUC) # Observar que RUC contiene datos del tipo "chr", es decir tipo texto.
df2 <- df %>% mutate(RUC = as.numeric(df$RUC)) # Como el RUC es un número, puede ser formateado como tal
str(df2$RUC) # Ahora el RUC de df2 es un dato tipo "num"

# Uso de group by

df <- df %>% rename(plazo = 'Plazo para la tramitación (meses)') # Es importante cambiar el nombre de la columna (caso contrario puede presentar errores)
                                                                 # Es útil poner nombres sencillos en las columnas, evitar espacios y caracteres especiales

df_r <- df %>% 
  group_by(Revisor) %>% # Define la variable que será utilizada para agrupar los datos
  summarise(media_plazo = mean(plazo, na.rm = TRUE)) # Proporciona la media por agrupamiento

#################
# Gráficos en R # 
################# Esta sección se inspira de la web: https://r-graph-gallery.com/

# Gráfico de barras simple

ggplot(df_r, aes(x=Revisor, y=media_plazo)) + 
  geom_bar(stat = "identity")

# Gráfico de barras horizontales

ggplot(df_r, aes(x=Revisor, y=media_plazo)) + 
  geom_bar(stat = "identity") +
  coord_flip()

# Gráfico de pie

ggplot(df_r, aes(x="", y=media_plazo, fill=Revisor)) +
  geom_bar(stat="identity", width=1, color="white") +
  coord_polar("y", start=0) +
  theme_void()

# Chupetines horizontales

ggplot(df_r, aes(x=Revisor, y=media_plazo)) +
  geom_segment( aes(x=Revisor, xend=Revisor, y=0, yend=media_plazo), color="skyblue") +
  geom_point( color="blue", size=4, alpha=0.6) +
  theme_light() +
  coord_flip() +
  theme(
    panel.grid.major.y = element_blank(),
    panel.border = element_blank(),
    axis.ticks.y = element_blank()
  )


install.packages('tinytex')
tinytex::install_tinytex()









