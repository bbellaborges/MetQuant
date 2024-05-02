#Introdução ao R 

#Tudo no R que não é precedido pelo sinal # é interpretado como objeto, este
#objeto pode ser criado por quem utiliza o R ou ser uma função. 

Olá, Mundo

supersticao <- "Olá, Mundo!"

#podemos executar diretamente no console, ou mandar o R 'imprimir'
supersticao

print(supersticao)

#O R possui uma linguagem 'case sensitive', ou seja, discrimina as letras
#maiúsculas, minísculas e com acentos. Lembre-se de salvar os scripts na 
#codificação -UTF8. 

#O objeto criado pode ser uma unidade, como o exemplo acima, um vetor ou 
#mesmo um banco de dados inteiro. 
unidade <- 2

vetor <- c(3, 4, 5, 8, 23) #A função c (concatenate) é muito utilizada

#Uma vez que meus objetos existam, eu posso fazer operações com eles. 

2 + 2 

unidade + 2

soma <- unidade + 2

unidade*vetor

3^unidade

#Lista de operações básicas 

2 + 2   #soma
3 - 1   #subtração
4 * 5   #multiplicação
12 / 3  #divisão
7 ^ 2   #ao quadrado
0:100   #sequências

#Operadores lógicos usados para comparar
3 == 3  #comparação de igualdade
5 != 0  #comparação de diferenças
2 > 9   #maior do que
1 < 8   #menor do que
5 >= 5  #maior ou igual
4 <= 1  #menor ou igual

#Valores lógicos 

TRUE #logical
T #logical
FALSE #logical
F #logical
NA #logical
NULL #NULL
Inf #numeric
-Inf #numeric

# Os objetos criados podem ter diferentes 'estruturas' 
numeros <- c(4, 6, 2, 34, 4, 2)
nomes <- c("Matheus", "Manuela", "Celi")

# A função str informa qual é o tipo de objeto, class também
str(numeros)
str(nomes)
class(nomes)

# E se misturarmos? 

mix <- c(7000, "salário", 2, "anos")
str(mix)
class(mix)

# O nome disso é coerção

# O objeto pode ser um argumento lógico 

resposta <- numeros != nomes
resposta

# Cada função possui seus argumentos, sempre é possível consultá-los com F1

duascasas <- round(3.34566214667, 2) #valor e número de casas desejadas
duascasas

args(round) #outra forma de consultar os argumentos

# Missing values 
missing <- c(1, 2, NA, 45, 0, 000, NA, 20)
missing

#Repare que NAs não alteram o objeto, indicam ausência
str(missing)

# Também existe o objeto factor, basicamente o mesmo que character, mas 
# ordenável 

tipo_sanguineo <- c("A+", "A-", "B+", "B-", "AB+", "AB-", "O+", "O-")

tipo_sanguineo

class(tipo_sanguineo)

#É possível transformar os objetos por comandos 

tipo_sanguineo <- factor(tipo_sanguineo)

tipo_sanguineo #Neste caso não foi preciso reordenar 

class(tipo_sanguineo)

#Tabulando os dados - os dados também podem ser escritos no formato de 
# dataframe 

Variavel1 <- c("Fulano", "Ciclano", "Beltrano")
Variavel2 <- c(2000, 3500, 1300)
tab <- data.frame(Variavel1,Variavel2)

#O dataframe também é um objeto, algumas funções são úteis para estudá-lo
tab[1,]
tab[,2]
tab[1,1]
tab[1,2]

str(tab)
table(tab) #contagem

table(tab$Variavel1) #contagem da variável 


#Salvando o objeto trabalhado 

saveRDS(tab, "dataframeaula1")

#Para onde foi o arquivo? 
getwd() #encontrar o working directory

setwd() #definir o working directory

#Trabalhar com projetos [File > New Project] resolve muito bem essa questão
#Vamos criar um

meusdados <- readRDS("dataframeaula1")

#Exercício da aula anterior 
#Existem diferentes maneiras de inserir informações manualmente no R
#Vamos aplicar a lógica de vetores 
#Podemos fazer por classe dos pais 
origem_I <- c(25, 12, 10, 7, 3, 2, 2)
origem_II <- c(13, 12, 8, 5, 5, 3, 3)
origem_III <- c(10, 10, 11, 7, 9, 6, 6)
origem_IV <- c(10, 12, 10, 27, 9, 7, 8)
origem_V <- c(13, 14, 13, 12, 17, 12, 10)
origem_VI <- c(16, 22, 26, 24, 31, 42, 35)
origem_VII <- c(12, 17, 23, 18, 27, 28, 37)

#Observe no environment que todos possuem o mesmo comprimento
tabela <- as.data.frame(rbind(origem_I, origem_II, origem_III, origem_IV,
                origem_V, origem_VI, origem_VII))

novos_nomes <- c("destino_I", "destino_II", "destino_III",
                 "destino_IV", "destino_V", "destino_VI",
                 "destino_VII")
#Podemos usar esse vetor para renomear as colunas 
names(tabela) <- novos_nomes

#Podemos comparar a soma das colunas e das linhas na tabela 
total_colunas <- colSums(tabela)
total_colunas

total_linhas <- rowSums(tabela)
total_linhas

#A partir disso, podemos criar uma tabela para cada caso 
#Pelos totais da coluna [destino por origem]
prop_colunas <- tabela/total_colunas*100
#podemos melhorar um pouco a apresentação 
prop_colunas <- round(prop_colunas, 2)

#Pelos totais da linha [origem por destino]
prop_linhas <- tabela/total_linhas*100
#podemos melhorar um pouco a apresentação 
prop_linhas <- round(prop_linhas, 2)

#Vamos conferir se os totais das linhas e colunas 
sum(prop_colunas[,1])

sum(prop_linhas[1,])

#Repare que esta divisão é para fins didáticos, as operações poderiam
#ter sido feitas diretamente. 
prop_linhas2 <- round(tabela/rowSums(tabela), 2)
y <- c(4,5,0,5,1)
sd(y)
ypadrao <- scale(y)
ypadrao
