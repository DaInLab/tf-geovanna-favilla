library(readxl)

worksheet <- read_excel("./dados/covid_19_bauru_mortes.xlsx")

periodo <- worksheet$'data_obito'

png(filename = "./graficos/varperiod-fig1.png")
plot(periodo, main = "Variação Periódica de óbitos",
     xlab = "Óbitos ocorridos", 
     ylab = "Período/dias",
     col=rgb(0.8,0.1,0.1,0.6))
box(lwd=1.5, col='darkgray')
grid(col='pink')

dev.off()
