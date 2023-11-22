########################################################
# Clasificación con Maquina de Vectores de Soporte SVM #
# Pavia Right                                          #
########################################################

########################################################
# Bibliotecas

library("e1071")
library("caret")

########################################################

########################################################
# Rutas y nombres base

#setwd("~/BEDU_PrototypeDay/") #Colocar la ruta hacia el proyecto
ruta <- file.path(getwd(),"data") #Ruta hacia data
carpeta_conjuntos <- file.path(ruta,"train_test_sam")
nombre_archivo <- "tr_ts_sam_50_1.RData" #Archivo con los datos para clasificar

load(file.path(carpeta_conjuntos,nombre_archivo))

lista_kfold <- kfold_pright_sam
data_set <- "pavia_right_50"

carpeta_modelos <- file.path(getwd(),"models")
nombre_guardar <- paste0(file.path(carpeta_modelos,data_set),".RData")

########################################################

########################################################
# Inicialización de estructuras

n_kfold <- 5
lista_modelos <- vector("list", length = n_kfold)
lista_tr_time <- vector("list", length = n_kfold)
lista_pred_tr <- vector("list", length = n_kfold)
lista_pred_ts <- vector("list", length = n_kfold)
lista_cm_tr <- vector("list", length = n_kfold)
lista_cm_ts <- vector("list", length = n_kfold)

########################################################

########################################################
# Entrenamiento de las iteraciones k-fold

for(k in 1:n_kfold) {
  
  matriz_train <-  lista_kfold[[k]]$mat_train
  labels_train <-  factor(lista_kfold[[k]]$lab_train)
  
  max_value <- max(matriz_train)
  matriz_train <- matriz_train / max_value
  
  matriz_test <-  lista_kfold[[k]]$mat_test
  labels_test <-  factor(lista_kfold[[k]]$lab_test)
  
  matriz_test <- matriz_test / max_value
  
  print("----------------------------")
  print(paste("--Entrenando iteración", k))
  tiempo_inicio <- system.time({
    modelo_svm <- svm(matriz_train, labels_train, type = "C-classification", kernel = "radial")
  })
  tiempo_total <- tiempo_inicio["elapsed"]
  print(paste("Tiempo total:", tiempo_total, "segundos"))
  
  print("Etiquetando observaciones tr")
  pred_tr <- predict(modelo_svm, matriz_train)
  cm_tr <- confusionMatrix(pred_tr,labels_train)
  print("Etiquetando observaciones ts")
  pred_ts <- predict(modelo_svm, matriz_test)
  cm_ts <- confusionMatrix(pred_ts,labels_test)
  
  print("Organizando archivos")
  lista_modelos[[k]] <- modelo_svm
  lista_tr_time[[k]] <- tiempo_total
  lista_pred_tr[[k]] <- pred_tr
  lista_pred_ts[[k]] <- pred_ts
  lista_cm_tr[[k]] <- cm_tr
  lista_cm_ts[[k]] <- cm_ts
  print("----------------------------")
}

########################################################

########################################################
# Guardar resultados

print("Guardando archivos")
save(lista_modelos, lista_tr_time, lista_pred_tr, lista_pred_ts, lista_cm_tr, lista_cm_ts, file = nombre_guardar)

########################################################