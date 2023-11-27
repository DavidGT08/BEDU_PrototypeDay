# Este análisis se realizó localmente para apoyar al análisis de correlación cruzada utilizado
# para validad la semejanza de las clases de los diferentes datasets.

# Para replicarlo, es necesario descargar las bases de datos desde:
# https://github.com/BeatrizPaulina/RosisDataCsv/raw/main
# Adicionalmente, se debe agregar la ruta hacia estos datos en el path_local_a_archivos:

path_local_a_archivos <- "path_local_a_archivos" #ruta a la carpeta de los datos descargados.

#Pavia Left

setwd(file.path(path_local_a_archivos,"pavia_left"))

classes <- list(1,2,3,4,5,6,8,9)
df<- NULL

for (class in classes){
  column_name = class
  path = paste0("pavia_left_class_",class,".csv")
  file <- read.csv(path,header=FALSE)
  class <- colMeans(file)
  sd <- apply(file,2,sd)
  df <- rbind(df,class,sd)
}
  
write.csv(df, file.path(path_local_a_archivos,"pavia_left_avgStd.csv"), row.names=FALSE)


#Pavia Right

setwd(file.path(path_local_a_archivos,"pavia_right/"))

classes <- list(1,2,3,4,5,6,8,9)
df2<- NULL

for (class in classes){
  column_name = class
  path = paste0("pavia_right_class_",class,".csv")
  file <- read.csv(path,header=FALSE)
  class <- colMeans(file)
  sd <- apply(file,2,sd)
  df2 <- rbind(df2,class,sd)
}

write.csv(df2, file.path(path_local_a_archivos,"pavia_right_avgStd.csv"), row.names=FALSE)


#Pavia Uni
setwd(file.path(path_local_a_archivos,"pavia_uni/"))

classes_uni <- list(1,2,3,4,5,6,7,8,9)
df3<- NULL

for (class in classes_uni){
  column_name = class
  path = paste0("pavia_uni_class_",class,".csv")
  file <- read.csv(path,header=FALSE)
  class <- colMeans(file)
  sd <- apply(file,2,sd)
  df3 <- rbind(df3,class,sd)
}

write.csv(df3, file.path(path_local_a_archivos,"pavia_uni_avgStd.csv"), row.names=FALSE)



