########################################################
# Clasificación con Maquina de Vectores de Soporte SVM #
# DCT datasets                                         #
########################################################

########################################################
# Bibliotecas
library("gsignal")
library("e1071")
library("caret")
########################################################

########################################################
# Cargar datos 
ruta <- file.path(getwd(),"data") #Ruta hacia los datos
load(file.path(ruta, "datasets_dct.RData"))
########################################################

########################################################
# Cargar y guardar modelos
ruta_modelos <- file.path(getwd(),"models") #Ruta hacia los modelos SVM

## Pavia Uni
load(file.path(ruta_modelos, "pavia_uni_50.RData"))
modelo_puni <- lista_modelos[[3]]

## Pavia right
load(file.path(ruta_modelos, "pavia_right_50.RData"))
modelo_pright <- lista_modelos[[1]]

## Pavia left
load(file.path(ruta_modelos, "pavia_left_50.RData"))
modelo_pleft <- lista_modelos[[2]]
########################################################

########################################################
# Corte de características
crop_features <- function(lista_data, n_clases, crop_p) {
  lista_cropped <- vector("list", length = n_clases)
  clase <- 1
  for(i in 1:n_clases) {
    lista_cropped[[clase]] <- lista_data[[i]][, 1:crop_p]
    clase <- clase + 1
  }
  return(lista_cropped)
}

crop_puni <- 13
crop_pright <- 11
crop_pleft <- 18
crop_puni <- crop_features(pix_puni_dct, length(clases_puni), crop_puni)
crop_pright <- crop_features(pix_pright_dct, length(clases_pright), crop_pright)
crop_pleft <- crop_features(pix_pleft_dct, length(clases_pleft), crop_pleft)
########################################################

########################################################
# Asignación de etiquetas
asignar_etiquetas <- function(lista_data, n_clases, modelo_svm) {
  max_valor <- max(sapply(lista_data, max))
  lista_etiquetas <- vector("list", length = n_clases)
  for(i in 1:n_clases) {
    mat_test <- lista_data[[i]] / max_valor
    pred <- predict(modelo_svm, mat_test)
    #print(unique(pred))
    lista_etiquetas[[i]] <- as.integer(as.character(pred))
  }
  return(lista_etiquetas)
}

lab_puni <- asignar_etiquetas(crop_puni, length(crop_puni), modelo_puni)
lab_pright <- asignar_etiquetas(crop_pright, length(crop_pright), modelo_pright)
lab_pleft <- asignar_etiquetas(crop_pleft, length(crop_pleft), modelo_pleft)
########################################################

########################################################
# Organizar en mapa de clasificación
matriz_imagen <- function(lista_etiquetas, lista_pos, n_clases, gt) {
  dim_mat <- dim(gt)
  imagen <- matrix(as.integer(0), nrow = dim_mat[1], ncol = dim_mat[2])
  for(i in 1:n_clases) {
    lab <- lista_etiquetas[[i]]
    pos <- lista_pos[[i]]
    n_etiquetas <- length(lab)
    for(l in 1:n_etiquetas) {
      imagen[pos[l, 1], pos[l, 2]] <- lab[l]
    }
  }
  return(imagen)
}

img_lab_puni <- matriz_imagen(lab_puni, pos_puni, length(lab_puni), gt_puni)
img_lab_pright <- matriz_imagen(lab_pright, pos_pright, length(lab_pright), gt_pright)
img_lab_pleft <- matriz_imagen(lab_pleft, pos_pleft, length(lab_pleft), gt_pleft)
########################################################

########################################################
# Guardar resultados
save(img_lab_puni, img_lab_pright, img_lab_pleft, file = file.path(ruta,"class_maps.RData"))
########################################################




