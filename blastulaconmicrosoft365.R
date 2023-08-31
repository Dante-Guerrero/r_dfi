#install.packages("blastula")
#install.packages("Microsoft365R")

library(Microsoft365R)
outlb <- get_business_outlook()

library(blastula)

boton_tablero <- add_cta_button(
  url = "https://datastudio.google.com/u/2/reporting/c4f5072f-9976-473e-99d9-9f2ba13296bd/page/5u4sC",
  text = "Tablero de control"
)

bl_body <- c("Hello", md(c(boton_tablero)),"Bye")

Arriba <- add_image(
  file = "proto1-semaforizacion.png",
  width = 1000,
  align = c("left"))

Cabecera <- md(Arriba)


Logo_Oefa <- add_image(
  file = "https://i.imgur.com/S69grUT.png",
  width = 280)
Pie_de_pagina <- blocks(
  md(Logo_Oefa),
  block_text(md("Calle De La Prosa 104, San Borja, Lima - 15034 Perú"), align = c("center")),
  block_text(md("Teléfono: 2247800, Anexo 5701"), align = c("center")),
  block_text("www.indecopi.gob.pe", align = c("center")),
  block_text(md("**Síguenos** en nuestras redes sociales"), align = c("center")),
  block_social_links(
    social_link(
      service = "Twitter",
      link = "https://twitter.com/IndecopiOficial",
      variant = "dark_gray"
    ),
    social_link(
      service = "Facebook",
      link = "https://www.facebook.com/IndecopiOficial",
      variant = "dark_gray"
    ),
    social_link(
      service = "Instagram",
      link = "https://www.instagram.com/indecopioficial/",
      variant = "dark_gray"
    ),
    social_link(
      service = "LinkedIn",
      link = "https://www.linkedin.com/company/indecopi/",
      variant = "dark_gray"
    ),
    social_link(
      service = "YouTube",
      link = "https://www.youtube.com/@IndecopiOficial",
      variant = "dark_gray"
    )
  ),
  block_spacer(),
  block_text(md("Imprime este correo electrónico sólo si es necesario. Cuidar el ambiente es responsabilidad de todos."), align = c("center"))
)

bl_em <- compose_email(
  header= Cabecera,
  body = md(bl_body),
  footer = Pie_de_pagina
)
em <-  outlb$create_email(bl_em, subject="Hello from R",
                          to="dguerrero@indecopi.gob.pe")

em$send()


