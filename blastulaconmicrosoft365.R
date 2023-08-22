#install.packages("blastula")
#install.packages("Microsoft365R")

library(Microsoft365R)
outlb <- get_business_outlook()

library(blastula)
bl_body <- "Hello"


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
      link = "https://twitter.com/OEFAperu",
      variant = "dark_gray"
    ),
    social_link(
      service = "Facebook",
      link = "https://www.facebook.com/oefa.peru",
      variant = "dark_gray"
    ),
    social_link(
      service = "Instagram",
      link = "https://www.instagram.com/somosoefa/",
      variant = "dark_gray"
    ),
    social_link(
      service = "LinkedIn",
      link = "https://www.linkedin.com/company/oefa/",
      variant = "dark_gray"
    ),
    social_link(
      service = "YouTube",
      link = "https://www.youtube.com/user/OEFAperu",
      variant = "dark_gray"
    )
  ),
  block_spacer(),
  block_text(md("Imprime este correo electrónico sólo si es necesario. Cuidar el ambiente es responsabilidad de todos."), align = c("center"))
)

bl_em <- compose_email(
  body = md(bl_body),
  footer = Pie_de_pagina
)
em <-  outlb$create_email(bl_em, subject="Hello from R",
                          to="dguerrero@indecopi.gob.pe")

em$send()
