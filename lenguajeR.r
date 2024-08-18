# Cargar la librería necesaria
library(ggplot2)

# Definir los datos
dfUVEG <- data.frame(
  "Clave" = as.character(c("HC", "HI", "HT", "HTP", "U6E", "UI6E", "UCHE", "UITI", "UIFH", "UTC6E")),
  "A.2015" = c(44.9, 39.2, 93.5, 43.7, 51.3, 57.4, 51.3, 12.8, 29.1, 71.5),
  "A.2016" = c(45.6, 47, 93.1, 52.1, 47, 59.5, 52.2, 14.7, 20.5, 73.6),
  "A.2017" = c(45.4, 50.9, 93.2, 49.5, 45.3, 63.9, 46.8, 20.4, 16.7, 72.2),
  "A.2018" = c(44.9, 52.9, 92.9, 47.3, 45, 65.8, 46.7, 23.7, 13.4, 73.5),
  "A.2019" = c(44.3, 56.4, 92.5, 45.9, 43, 70.1, 44.6, 27.2, 10.7, 75.1)
)

# Definir el factor de suavizamiento
alpha <- 0.5

# Función para aplicar suavizamiento exponencial
suavizamiento_exponencial <- function(series, alpha) {
  S <- numeric(length(series))
  S[1] <- series[1]
  for (t in 2:length(series)) {
    S[t] <- alpha * series[t] + (1 - alpha) * S[t - 1]
  }
  return(S)
}

# Aplicar suavizamiento exponencial para cada fila
for (i in 1:nrow(dfUVEG)) {
  series <- as.numeric(dfUVEG[i, 2:6])
  serie_suavizadas <- suavizamiento_exponencial(series, alpha)
  dfUVEG[i, "A.2020"] <- serie_suavizadas[length(serie_suavizadas)]
}

# Imprimir el dataframe con los valores pronosticados para 2020
print(dfUVEG)

# Crear gráficos de líneas de crecimiento
dfMelt <- reshape2::melt(dfUVEG, id.vars = "Clave")
ggplot(dfMelt, aes(x = variable, y = value, color = Clave, group = Clave)) +
  geom_line() +
  geom_point() +
  labs(title = "Crecimiento de valores desde 2015 hasta 2020", x = "Año", y = "Valor") +
  theme_minimal()
