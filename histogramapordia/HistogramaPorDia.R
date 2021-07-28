library(readr)
library(dplyr)#manejo de ficheros
library(purrr)
library(tidyr)
library(stringr)
library(lubridate)
library(scales)
library(tidytext)
library(tm)
library(colorspace)
library(sqldf)
carpeta<-"C:/Users/interbarometro/Desktop/ProgramasR/HistogramaPorDia"
carpeta_Bases<-paste(carpeta,"Bases",sep="/")
nombres<-dir(carpeta_Bases)
nombres<-as.data.frame(nombres)

if(dir.exists(paste(carpeta,"Resultados",sep = "/")))
{}else{dir.create(paste(carpeta,"Resultados",sep = "/"))}

for(i in 1:length(nombres[,1]))
{
  archivo_temporal<-paste(carpeta_Bases,toString(nombres$nombres[i]),sep="/")
  nombre<-substr(toString(nombres$nombres[i]),1,(str_length(nombres$nombres[i])-4))
  nombre_carpeta<-paste(carpeta,"Resultados",sep = "/")
  nombre_carpeta<-paste(nombre_carpeta,nombre,sep = "/")
  
  if(dir.exists(nombre_carpeta))
  {}else{dir.create(nombre_carpeta)}
  
  consulta <-read.csv(archivo_temporal,header = TRUE,sep = ",",encoding = "UTF-8")
  
  ####### HISTOGRAMA ###########
  
  histograma <- sqldf(' select  substr(created_at,1,10) FECHA,count(substr(created_at,1,10)) CANTIDAD  from consulta group by substr(created_at,1,10) ORDER BY substr(created_at,1,10) DESC')
  write.csv(histograma,file = paste(nombre_carpeta,"1dia.csv",sep = "/"),row.names=FALSE)
}
