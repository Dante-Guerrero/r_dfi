library(Microsoft365R)
odb <- get_business_onedrive()
odb$list_items("Documentos")

list_sharepoint_sites()


odb$create_folder("Documentos/newfolder")

site <- get_sharepoint_site("https://indecopi.sharepoint.com/sites/GrupoTeletrabajoGSF")
