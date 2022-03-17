library(readxl)

worksheet <- read_excel("./dados/covid_19_bauru_mortes.xlsx")

data <- worksheet$'idade'

table <- data.frame(t(table(data)))[,-1]
table$data <- as.numeric(levels(table$data))
table <- table %>% 
  mutate(Fr = 100*Freq/sum(Freq),
         Fac = cumsum(Freq),
         Xi.Fi = data*Freq)
View(table)
print(table)

png(filename = "./graficos/idade-fig1.png", width = 1000, height = 600)
hist(data, main = "Distribuição de óbitos por faixa etária", 
     xlab="Idades", ylab="Óbitos", 
     col=rgb(0.8,0.1,0.1,0.6))
box(lwd=1.5, col='darkgray')
grid(col='pink')

dev.off()
