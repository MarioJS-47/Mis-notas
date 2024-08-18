%load_ext rpy2.ipython

%%R
install.packages("ggplot2")

%%R
install.packages("reshape2")

# Cargar la librería necesaria
library(ggplot2)

%%R
# Definir los datos
dataS <- data.frame(
  "id" = as.character(c("HC", "HI", "HT", "HTP", "U6E", "UI6E", "UCHE", "UITI", "UIFH", "UTC6E")),
  "2015" = c(44.9, 39.2, 93.5, 43.7, 51.3, 57.4, 51.3, 12.8, 29.1, 71.5),
  "2016" = c(45.6, 47, 93.1, 52.1, 47, 59.5, 52.2, 14.7, 20.5, 73.6),
  "2017" = c(45.4, 50.9, 93.2, 49.5, 45.3, 63.9, 46.8, 20.4, 16.7, 72.2),
  "2018" = c(44.9, 52.9, 92.9, 47.3, 45, 65.8, 46.7, 23.7, 13.4, 73.5),
  "2019" = c(44.3, 56.4, 92.5, 45.9, 43, 70.1, 44.6, 27.2, 10.7, 75.1)
)

# Definir el factor de suavizamiento
alpha <- 0.5

# Función para aplicar suavizamiento exponencial
s_exponencial <- function(series, alpha) {
  S <- numeric(length(series))
  S[1] <- series[1]
  for (t in 2:length(series)) {
    S[t] <- alpha * series[t] + (1 - alpha) * S[t - 1]
  }
  return(S)
}

# Aplicar suavizamiento exponencial para cada fila
for (i in 1:nrow(dataS)) {
  series <- as.numeric(dataS[i, 2:6])
  s_suavizadas <- s_exponencial(series, alpha)
  dataS[i, "2020"] <- s_suavizadas[length(s_suavizadas)]
}

# Imprimir el dataframe con los valores pronosticados para 2020
print(dataS)

# Crear gráficos de líneas de crecimiento
dfMelt <- reshape2::melt(dataS, id.vars = "id")
ggplot(dfMelt, aes(x = variable, y = value, color = Clave, group = Clave)) +
  geom_line() +
  geom_point() +
  labs(title = "Crecimiento de valores desde 2015 hasta 2020", x = "Año", y = "Valor") +
  theme_minimal()
