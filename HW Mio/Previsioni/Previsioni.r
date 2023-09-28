# Installa e carica i pacchetti necessari
install.packages("forecast")
install.packages("dplyr")
library(forecast)
library(dplyr)

# Legge il file CSV
dati <- read.csv("/home/manuel/Scrivania/BigData/HW/HW Mio/job1/job1.csv")

# Converte l'anno e il mese in una colonna di date per una serie temporale
dati$data_ts <- as.Date(paste(dati$anno, dati$mese, "01", sep="-"))

# Ordina i dati in base alla data
dati <- dati %>% arrange(data_ts)

# Crea la serie temporale
serie_temporale <- ts(dati$media_valore, start=c(min(dati$anno), min(dati$mese)), frequency=12)

# Addestra un modello ARIMA
modello_arima <- auto.arima(serie_temporale)

# Effettua la previsione per i prossimi 12 mesi
previsione <- forecast(modello_arima, h=12)

# Visualizza la previsione
plot(previsione)
