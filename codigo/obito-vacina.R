library(readxl)
library(dplyr)

worksheet <- read_excel("./dados/covid_19_bauru_mortes.xlsx")

doses_vacina <- worksheet$'doses_vacina'

doses_true <- worksheet %>% filter(doses_vacina=='TRUE')

total_obito <- count(worksheet, "doses_vacina")

#total_true <- count(doses_true, "doses_vacina")

total_true <- count(doses_true, "doses_true")

total_nao_vacinados <- total_obito[2] - total_true[2]

dados <- as.numeric(c(total_obito[2], total_nao_vacinados, total_true[2]))

nomes <- names(dados) <- c("Total", "Não Vacinados", "Vacinados")

png(filename = "./graficos/obitos-vacinas.png", width = 900, height = 500)
barplot(as.vector(dados), main="Óbitos - Vacinados e Não Vacinados", 
        xlab="Quantidade de óbitos", 
        xlim=range(pretty(c(5, dados))), 
        cex.names = 0.8, 
        names.arg = nomes,
        xaxs = "i", 
        col=rgb(0.8,0.1,0.1,0.6), 
        space=0.05, 
        horiz=TRUE)
box(lwd=1.5, col='darkgray')
grid(col='pink')
dev.off()
