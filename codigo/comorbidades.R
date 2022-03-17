library(readxl)
library(stringr)
library(dplyr)

worksheet <- read_excel("./dados/covid_19_bauru_mortes.xlsx")

comorbidades <- c(worksheet$'comorbidade')

cmb <- na.omit(comorbidades)

qtde_comorbidades <- length(cmb)
asma <- length(na.omit(str_match(cmb, "asma")))
obesidade <- length(na.omit(str_match(cmb, "obesidade")))
cardiopatia <- length(na.omit(str_match(cmb, "cardiopatia")))
diabetes <- length(na.omit(str_match(cmb, "diabetes")))
pneumonia <- length(na.omit(str_match(cmb, "pneumonia")))
hipertensao <- length(na.omit(str_match(cmb, "hipertensão")))
cancer <- length(na.omit(str_match(cmb, "câncer")))
avc <- length(na.omit(str_match(cmb, "AVC")))
cardiovascular <- length(na.omit(str_match(cmb, "cardiovascular")))
cronica <- length(na.omit(str_match(cmb, "crônica")))

dados <- c(qtde_comorbidades, asma, obesidade, cardiopatia, diabetes, pneumonia,
           hipertensao, cancer, avc, cardiovascular, cronica)
titulo <- c("Total", "Asma", "Obesidade","Cardiopatia", "Diabetes", "Pneumonia", "Hipertensão",
            "Câncer", "AVC", "Cardiovascular", "Crônicas")

png(filename = "./graficos/comorbidade-fig1.png", width = 1000, height = 600)
barplot(as.vector(dados), 
        main = "Comorbidades Associadas",
        xlab="Óbitos", ylab="Comorbidades", 
        names.arg = titulo,  
        xlim=range(pretty(c(0, dados))), 
        cex.names = 0.8, 
        xaxs = "i", 
        col=rgb(0.8,0.1,0.1,0.6), 
        space=0.05, 
        horiz=TRUE,
        )
box(lwd=1.5, col='darkgray')
grid(col='pink')

dev.off()