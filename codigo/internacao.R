library(readxl)
library(dplyr)

worksheet <- read_excel("./dados/covid_19_bauru_mortes.xlsx")

data_tp_privado <- worksheet %>% filter(tipo_hosp=="privado")
data_tp_publico <- worksheet %>% filter(tipo_hosp=="público")

entrada_pv <- data_tp_privado$'inicio_sintoma'
obito_pv <- data_tp_privado$'data_obito'

entrada_pb <- data_tp_publico$'inicio_sintoma'
obito_pb <- data_tp_publico$'data_obito'
#####################################
trocaNegativo <- function(x) {
  x[x < 0] <- 0
  x
}

#privada
diff_dias_pv <- difftime(as.Date(obito_pv), as.Date(entrada_pv), units = "days")

dias_pv <- na.omit(diff_dias_pv)

dados_pv <- c(trocaNegativo(dias_pv))

media_pv <- mean(dados_pv)

#Publica
diff_dias_pb <- difftime(as.Date(obito_pb), as.Date(entrada_pb), units = "days")

dias_pb <- na.omit(diff_dias_pb)

dados_pb <- c(trocaNegativo(dias_pb))

media_pb <- mean(dados_pb)

paste("Hospedagem Pública (Dias de Permanênica)")
dados_pb
paste("Hospedagem Privada (Dias de Permanênica)")
dados_pv

paste("Média permanência em Hospedagem Pública em dias: ", media_pb)
paste("Média permanência em Hospedagem Privada em dias: ", media_pv)

######################################
dados <- c(media_pb, media_pv)
nomes <- names(dados) <- c("Público", "Privado")

png(filename = "./graficos/internacao-fig1.png", width = 1000, height = 600)
barplot(as.vector(dados), main="Permanência por tipo de Hospedagem", 
        ylab="Tipos de Hospedagem", xlab="Qtd. Média de Óbitos", 
        names.arg = nomes, 
        xlim=range(pretty(c(3, dados))), 
        cex.names = 0.8, 
        xaxs = "i", 
        col=rgb(0.8,0.1,0.1,0.6), 
        space=0.05, 
        horiz=TRUE)
box(lwd=1.5, col='darkgray')
grid(col='pink')
dev.off()
