dados <- readRDS("2024_04_base_dados_pnadc22.RData")
summary(dados)

#1. Corrija os nomes das regiões.
install.packages("dplyr")

# Loading package
library(dplyr)

pnadc22 <- readRDS("2024_04_base_dados_pnadc22.RData")

pnadc22$regiao <- recode_factor(pnadc22$regiao,
                                  "Nordest_" = "Nordeste",
                                  "Sudes_e" = "Sudeste")

#conferindo
summary(pnadc22)
#OU
table(pnadc22$regiao)

#2. Transformem ‘nao_declarado’ em NA

pnadc22$cor_raca <- recode_factor(pnadc22$cor_raca, "nao_declarado" = "NA")

#conferindo
summary(pnadc22)
#OU
table(pnadc22$cor_raca)

#3. Calculem a média, mediana e desvio padrão de: renda_trabalho, n_domicilio,
#horas_trabalho e renda_per_capita.

#Média da renda do trabalho no Brasil 
mean(pnadc22$renda_trabalho)

#Nem todo mundo tem renda de trabalho, é preciso considerar as NAs
mean(pnadc22$renda_trabalho, na.rm = T)

#Mediana (menos sensível aos outliers)
median(pnadc22$renda_trabalho, na.rm = T)

#Desvio padrão da mesma variável 
sd(pnadc22$renda_trabalho, na.rm = T)
#############
#Média da n_domicilio 
mean(pnadc22$n_domicilio)

#é preciso considerar as NAs
mean(pnadc22$n_domicilio, na.rm = T)

#Mediana (menos sensível aos outliers)
median(pnadc22$n_domicilio, na.rm = T)

#Desvio padrão da mesma variável 
sd(pnadc22$n_domicilio, na.rm = T)

##################
#Média das horas d trabalho no Brasil 
mean(pnadc22$horas_trabalho)

#Nem todo mundo tem renda de trabalho, é preciso considerar as NAs
mean(pnadc22$horas_trabalho, na.rm = T)

#Mediana (menos sensível aos outliers)
median(pnadc22$horas_trabalho, na.rm = T)

#Desvio padrão da mesma variável 
sd(pnadc22$horas_trabalho, na.rm = T)
##############
#Média da renda per capta no Brasil 
mean(pnadc22$renda_per_capita)

# é preciso considerar as NAs
mean(pnadc22$renda_per_capita, na.rm = T)

#Mediana (menos sensível aos outliers)
median(pnadc22$renda_per_capita, na.rm = T)

#Desvio padrão da mesma variável 
sd(pnadc22$renda_per_capita, na.rm = T)

#4. Calcule a média de renda_trabalho por nível_instrucao.
media_renda_instrucao <- aggregate(renda_trabalho ~ nivel_instrucao,
                                data = pnadc22, 
                                FUN = mean,
                                action = na.omit)
