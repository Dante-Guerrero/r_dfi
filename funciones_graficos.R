##################################
#                                #
#  Funciones para gráficos en R  #
#                                #
##################################

# Colores de Indecopi (variables globales, para usarlas dentro de las funciones)

granate <<- '#c21453' 
naranja <<- '#ea8714' 
amarillo_anarajando <<- '#f3b425' 
gris <<- '#848484' 
hueso <<- '#f3efe7'

escala_indecopi <<- c(granate, naranja, amarillo_anarajando, gris, hueso) 

# Gráfico de barras simple

gbarras <- function(df, a="", b="", titulo="", subtitulo="") {
  
  x <- pull(df, names(df)[1])
  y <- pull(df, names(df)[2])
  data <- data.frame(x, y)

  plot_gbarras <- ggplot(data, aes(x=x, y=y)) + 
    geom_bar(stat = "identity", color="black", fill=amarillo_anarajando)+
    xlab(a) +
    ylab(b) +
    labs(title = titulo, subtitle = subtitulo) 
  
  return(plot_gbarras)
  
    }

gbarras(df_r)
gbarras(df_r, "juan", "sofia")
gbarras(df_r, titulo = "GRÁFICO 1", subtitulo = "Plazo promedio de atención")

# Gráfico de barras horizontales

barras_h <- function(df){
  x <- pull(df, names(df)[1])
  y <- pull(df, names(df)[2])
  data <- data.frame(x, y)
  
  ggplot(df_r, aes(x=Revisor, y=media_plazo)) + 
    geom_bar(stat = "identity") +
    coord_flip()
  }
  


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
