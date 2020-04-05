# ______________________________________________
#
#           Script da Aula de 04/04/2020
#
# ______________________________________________

#1 Primeiro passo - Mudar o diretório

#2 Baixar o banco de dados
#   Neste caso será um arquivo ".csv"

Municipios<-read.csv("Municipios_SC.csv", sep=";", dec=",", header=T)

#3 buscar o nome das variáveis da base de dados
names(Municipios)

#4 calcular a média para a variável peso
mean(Municipios$População)
mean(Municipios$Área)
mean(Municipios$Densidade)

#5 calcular a mediana para a variável peso
median(Municipios$População)
median(Municipios$Área)
median(Municipios$Densidade)

#6 gerar uma estatística geral da variável peso  
summary(Municipios$População)
summary(Municipios$Área)
summary(Municipios$Densidade)

# Alternativa para o "Run" é "Ctrl + Enter"


#7 Para calcular os percentis
#os valores internos ao vetor c, indicam as proporções dos percentis
quantile(Municipios$População, c(0.05, 0.1, 0.25, 0.5, 0.75, 0.9, 0.95))
quantile(Municipios$Área, c(0.05, 0.1, 0.25, 0.5, 0.75, 0.9, 0.95))
quantile(Municipios$Densidade, c(0.05, 0.1, 0.25, 0.5, 0.75, 0.9, 0.95))

#8 Medidas de dispersão
#Amplitude
max(Municipios$População)
max(Municipios$Área)
max(Municipios$Densidade)
min(Municipios$População)
min(Municipios$Área)
min(Municipios$Densidade)
# Amplitude População
max(Municipios$População)-min(Municipios$População)
# Amplitude Área
max(Municipios$Área)-min(Municipios$Área)
# Amplitude Densidade
max(Municipios$Densidade)-min(Municipios$Densidade)

#Desvio-Padrão
sd(Municipios$População)
sd(Municipios$Área)
sd(Municipios$Densidade)

#Variância
var(Municipios$População)
var(Municipios$Área)
var(Municipios$Densidade)

#Coeficiente de Variância
sd(Municipios$População)/mean(Municipios$População)
sd(Municipios$Área)/mean(Municipios$Área)
sd(Municipios$Densidade)/mean(Municipios$Densidade)

#Existe pacotes que fazem o cálculo geral para todas as Estatísticas

# Baixar o pacote "moments"
install.packages("moments")
library(moments)

#Coeficiente de Assimetria
skewness(Municipios$População)
skewness(Municipios$Área)
skewness(Municipios$Densidade)

#Coeficiente de Curtose
kurtosis(Municipios$População)
kurtosis(Municipios$Área)
kurtosis(Municipios$Densidade)


#Existe pacotes que fazem o cálculo geral para todas as Estatísticas
# é preciso instalar o pacote "fBasics"
# Baixar o Pacote "fBasics"
install.packages("fBasics")

# é preciso instalar o pacote "fBasics"
install.packages("moments")
library(moments)
library(fBasics) 
basicStats(Municipios$População)
basicStats(Municipios$Área)
basicStats(Municipios$Densidade)

#Histogramas
hist(Municipios$População,  breaks = 100, xlab="População", ylab="")
hist(Municipios$Área ,  breaks = 50, xlab="Área", ylab="")
hist(Municipios$Densidade ,  breaks = 500, xlab="Densidade", ylab="")

# Normalização pelo Logaritmo
# Aplicando o log sobre as variáveis de população

ln_Pop=log(Municipios$População)
hist(ln_Pop,  breaks = 10, xlab="População", ylab="")

ln_Area=log(Municipios$Área)
hist(ln_Area,  breaks = 10, xlab="População", ylab="")

ln_Dens=log(Municipios$Densidade)
hist(ln_Dens,  breaks = 10, xlab="População", ylab="")
