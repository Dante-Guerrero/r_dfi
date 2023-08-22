##################################
#                                #
#  Funciones para gráficos en R  #
#                                #
##################################

# Gráfico de barras simple

gbarras <- function(df, a="", b="", titulo="", subtitulo="") {
  
  
  x <- pull(df, names(df)[1])
  y <- pull(df, names(df)[2])
  data <- data.frame(x, y)

  plot_gbarras <- ggplot(data, aes(x=x, y=y)) + 
    geom_bar(stat = "identity")+
    xlab(a)+
    ylab(b)+
    labs(title = titulo, subtitle = subtitulo)
  
  return(plot_gbarras)
  
    }


gbarras(df_r)
gbarras(df_r, "juan", "sofia")
gbarras(df_r, titulo = "GRÁFICO 1", subtitulo = "Plazo promedio de atención")

