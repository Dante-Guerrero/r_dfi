############
# Muestreo #
############

tamanno_muestra_2 <- function(p,c,e,N){
  no=(p*(1-p))/((e/qnorm((1-c)/2))^2)
  n_o=ceiling(no)
  nf=n_o/(1+(n_o/N))
  n_f=ceiling(nf)
  return(n_f)
}

tamanno_muestra_2(0.5, 0.95, 0.03, 3000000)

z <- 1.96
p <- 0.5
e <- 0.03
N <- 3000000


m <- (((z^2)*p*(1-p))/e^2)/(1+((z^2)*(p*(1-p))/((e^2)*N)))
print(m)

tamanno_muestra <- function(N, z=1.96, p=0.5, e=0.03){
  m <- (((z^2)*p*(1-p))/e^2)/(1+((z^2)*(p*(1-p))/((e^2)*N)))
  return(m)
}

tamanno_muestra(10000)
