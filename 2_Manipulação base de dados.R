#Abrindo e manipulando uma base de dados no R
rm(list=ls()) #limpa o ambiente de trabalho, ctrl+L faz o mesmo no console

#Abrir a base de dados 
pnadc22 <- readRDS("2024_04_base_dados_pnadc22")

#As vezes a base é muito grande, ou alguns formatos de tabela 
#podem apresentar problemas nas primeiras linhas ou no final 
#Uma maneira prática de conferir isso:
head(pnadc22)
tail(pnadc22)

#Será que todas as colunas estão como deveriam estar? 
summary(pnadc22)

#Antes de começar a fazer qualquer coisa, precisamos corrigir os erros 
#Corrigindo o nome dos níveis de região 
pnadc22.2 <- pnadc22

pnadc22.2$regiao <- recode_factor(pnadc22.2$regiao,
                                  "Nordest_" = "Nordeste",
                                  "Sudes_e" = "Sudeste")
#Sempre cheque suas alterações
table(pnadc22.2$regiao)

#Variáveis numéricas (aplicando uma função em duas colunas)
pnadc22.2[,c("renda_trabalho", "n_domicilio")] <- 
  lapply(pnadc22.2[,c("renda_trabalho", "n_domicilio")], 
         as.numeric )

#Checando
summary(pnadc22.2)

#Vamos usar a mesma lógica para observar em mais detalhes as variáveis 
#Variáveis categóricas
lapply(pnadc22.2[,c("regiao", "situacao_domicilio", "sexo", "cor_raca",
             "nivel_instrucao")], table)

#Variáveis numéricas
lapply(pnadc22.2[,c("idade", "renda_trabalho", "horas_trabalho",
                    "n_domicilio", "renda_per_capita")], summary)

#Repare que o valor da renda per capita está muito alto, 
#isso acontece porque 999999999999 está no lugar de NA

#Vamos aproveitar e corrigir o 'nao_declarado' de cor_raca também 
pnadc22.2$cor_raca <- factor(pnadc22.2$cor_raca, exclude = "nao_declarado")

#Agora vamos substituir os outliers de renda_per_capita para NA
pnadc22.2$renda_per_capita <- ifelse(
  pnadc22.2$renda_per_capita == 999999999999, NA,
  pnadc22.2$renda_per_capita)

#Conferindo novamente 
#Variáveis categóricas
lapply(pnadc22.2[,c("regiao", "situacao_domicilio", "sexo", "cor_raca",
                    "nivel_instrucao")], table)

#Variáveis numéricas
lapply(pnadc22.2[,c("idade", "renda_trabalho", "horas_trabalho",
                    "n_domicilio", "renda_per_capita")], summary)

#Algumas descritivas
#ATENÇÃO - pnadc é uma AMOSTRA, os resultados destas descritivas
#não são as estimativas, mas sim uma descrição da amostra. 

#Média da renda do trabalho no Brasil 
mean(pnadc22.2$renda_trabalho)

#Nem todo mundo tem renda de trabalho, é preciso considerar as NAs
mean(pnadc22.2$renda_trabalho, na.rm = T)

#Mediana (menos sensível aos outliers)
median(pnadc22.2$renda_trabalho, na.rm = T)

#Desvio padrão da mesma variável 
sd(pnadc22.2$renda_trabalho, na.rm = T)

#Também podemos calcular por grupos
media_renda_regiao <- aggregate(renda_trabalho ~ regiao,
                                data = pnadc22.2, 
                                FUN = mean,
                                action = na.omit)
#É possível combinar outras variáveis e usar outras funções 
mediana_r_sexo_regiao <- aggregate(renda_trabalho ~ sexo + regiao,
                                data = pnadc22.2, 
                                FUN = median,
                                action = na.omit)
