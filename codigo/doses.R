library(readxl)
library(dplyr)

worksheet <- read_excel("./dados/covid_19_bauru_mortes.xlsx", 
                        col_types = c("date", "text", "numeric", 
                                      "date","text","text", "date", "numeric")
                        )

doses_vacina = c()
i = j = 1
while (i <= nrow(worksheet)) {
  if(!is.na(worksheet$'doses_vacina'[i])) {
    doses_vacina [j] = worksheet$'doses_vacina'[i]
    j = j + 1
  }
  i = i + 1
}
morte_vacinados <- table(doses_vacina)
morte_vacinados
#doses_vacina
#  0  1  2  3 
# 18  5 66 51 

total_obito <- sum(morte_vacinados)
morte_vacinados[5] = total_obito
names(morte_vacinados) = c(0, 1, 2, 3, "Óbitos")

limite_y = max((unname(morte_vacinados)))
barplot(as.vector(morte_vacinados),
        main = "Figura x. Óbitos por número de doses de vacina",
        ylab = "Número de Óbitos Ocorridos", ylim = c(0,limite_y),
        xlab = "Número de doses de vacina",
        names.arg = names(morte_vacinados))


