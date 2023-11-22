divide_train_and_test
================
Equipo 5
2023-11-15

## División de sets de entrenamiento y prueba.

Este script divide los datos en conjuntos de entrenamiento y prueba de
acuerdo con los índices guardados en /data/kfold_indices

``` r
guardar_train_test <- function(lista_pixeles, lista_indices, lista_clases, k, max_clases) {
  n_clases <- length(lista_clases)
  lista_kfold <- vector("list", length = max_clases)
  for(i in 1:n_clases) {
    matriz_clase <- lista_pixeles[[i]]
    matriz_indices <- lista_indices[[lista_clases[i]]]
    lista_pixeles_tr <- vector("list", length = k)
    lista_pixeles_ts <- vector("list", length = k)
    
    for(j in 1:k) {
      print(paste("Procesando conjunto",j,"de",k,"de la clase",lista_clases[i]))
      
      # Selecciona los conjuntos
      lista_pixeles_tr[[j]] <- matriz_clase[matriz_indices[,j], , drop = FALSE]
      lista_pixeles_ts[[j]] <- matriz_clase[-matriz_indices[,j], , drop = FALSE]
    }
    lista_kfold[[lista_clases[i]]] = list("train" = lista_pixeles_tr, "test" = lista_pixeles_ts)
    print("----------------------------------------")
  }
  return(lista_kfold)
}
```

## Lectura y escritura de las matrices de clases

Se leen las matrices de Pavia University, Pavia Right y Pavia Left en la
carpeta ./clean_data.

El directorio de trabajo debe estar dado en
/ruta/hacia/carpeta/BEDU_PrototypeDay. Entonces, es necesario revisar el
directorio de trabajo actual con getwd() y, si es necesario, cambiarlo
con setwd(). Ejemplo: setwd(“~/documents/proyecto/BEDU_PrototypeDay”).

``` r
ruta <- file.path("..","..","data") #Ruta hacia la carpeta data
load(file.path(ruta,"datasets_dct.RData"))
```

Los indices están en una carpeta denominada kfold_indices y se
diferencia por el porcentaje utilizado para el entrenamiento, entonces
se componen los siguientes nombres de archivos:

``` r
p <- "50" #Identificador de archivo: "indices_p.RData"
k <- 5 #K-fold iteraciones
max_clases <- 11 #Total de clases en los datos
carpeta_indices = "kfold_indices"
archivo_indices <- file.path(ruta, carpeta_indices, paste0("indices_",p,".RData"))
load(archivo_indices)
```

Adicionalmente, se crea una carpeta para guardar los conjuntos de datos.

``` r
carpeta_conjuntos = file.path(ruta,"train_test")
if(file.exists(carpeta_conjuntos)) {
  print(paste("Los datos se guardarán en", carpeta_conjuntos))
} else {
  dir.create(carpeta_conjuntos)
  print(paste("Se creó la carpeta", carpeta_conjuntos, "para guardar los archivos"))
}
```

    ## [1] "Se creó la carpeta ../../data/train_test para guardar los archivos"

``` r
archivo_tr_ts <- file.path(carpeta_conjuntos, paste0("tr_ts_",p,".RData"))
```

### Pavia Uni

``` r
kfold_puni <- guardar_train_test(pix_puni_dct, ind_puni, clases_puni, k, max_clases)
```

    ## [1] "Procesando conjunto 1 de 5 de la clase 1"
    ## [1] "Procesando conjunto 2 de 5 de la clase 1"
    ## [1] "Procesando conjunto 3 de 5 de la clase 1"
    ## [1] "Procesando conjunto 4 de 5 de la clase 1"
    ## [1] "Procesando conjunto 5 de 5 de la clase 1"
    ## [1] "----------------------------------------"
    ## [1] "Procesando conjunto 1 de 5 de la clase 2"
    ## [1] "Procesando conjunto 2 de 5 de la clase 2"
    ## [1] "Procesando conjunto 3 de 5 de la clase 2"
    ## [1] "Procesando conjunto 4 de 5 de la clase 2"
    ## [1] "Procesando conjunto 5 de 5 de la clase 2"
    ## [1] "----------------------------------------"
    ## [1] "Procesando conjunto 1 de 5 de la clase 3"
    ## [1] "Procesando conjunto 2 de 5 de la clase 3"
    ## [1] "Procesando conjunto 3 de 5 de la clase 3"
    ## [1] "Procesando conjunto 4 de 5 de la clase 3"
    ## [1] "Procesando conjunto 5 de 5 de la clase 3"
    ## [1] "----------------------------------------"
    ## [1] "Procesando conjunto 1 de 5 de la clase 4"
    ## [1] "Procesando conjunto 2 de 5 de la clase 4"
    ## [1] "Procesando conjunto 3 de 5 de la clase 4"
    ## [1] "Procesando conjunto 4 de 5 de la clase 4"
    ## [1] "Procesando conjunto 5 de 5 de la clase 4"
    ## [1] "----------------------------------------"
    ## [1] "Procesando conjunto 1 de 5 de la clase 5"
    ## [1] "Procesando conjunto 2 de 5 de la clase 5"
    ## [1] "Procesando conjunto 3 de 5 de la clase 5"
    ## [1] "Procesando conjunto 4 de 5 de la clase 5"
    ## [1] "Procesando conjunto 5 de 5 de la clase 5"
    ## [1] "----------------------------------------"
    ## [1] "Procesando conjunto 1 de 5 de la clase 6"
    ## [1] "Procesando conjunto 2 de 5 de la clase 6"
    ## [1] "Procesando conjunto 3 de 5 de la clase 6"
    ## [1] "Procesando conjunto 4 de 5 de la clase 6"
    ## [1] "Procesando conjunto 5 de 5 de la clase 6"
    ## [1] "----------------------------------------"
    ## [1] "Procesando conjunto 1 de 5 de la clase 7"
    ## [1] "Procesando conjunto 2 de 5 de la clase 7"
    ## [1] "Procesando conjunto 3 de 5 de la clase 7"
    ## [1] "Procesando conjunto 4 de 5 de la clase 7"
    ## [1] "Procesando conjunto 5 de 5 de la clase 7"
    ## [1] "----------------------------------------"
    ## [1] "Procesando conjunto 1 de 5 de la clase 8"
    ## [1] "Procesando conjunto 2 de 5 de la clase 8"
    ## [1] "Procesando conjunto 3 de 5 de la clase 8"
    ## [1] "Procesando conjunto 4 de 5 de la clase 8"
    ## [1] "Procesando conjunto 5 de 5 de la clase 8"
    ## [1] "----------------------------------------"
    ## [1] "Procesando conjunto 1 de 5 de la clase 9"
    ## [1] "Procesando conjunto 2 de 5 de la clase 9"
    ## [1] "Procesando conjunto 3 de 5 de la clase 9"
    ## [1] "Procesando conjunto 4 de 5 de la clase 9"
    ## [1] "Procesando conjunto 5 de 5 de la clase 9"
    ## [1] "----------------------------------------"

### Pavia Right

``` r
kfold_pright <- guardar_train_test(pix_pright_dct, ind_pright, clases_pright, k, max_clases)
```

    ## [1] "Procesando conjunto 1 de 5 de la clase 1"
    ## [1] "Procesando conjunto 2 de 5 de la clase 1"
    ## [1] "Procesando conjunto 3 de 5 de la clase 1"
    ## [1] "Procesando conjunto 4 de 5 de la clase 1"
    ## [1] "Procesando conjunto 5 de 5 de la clase 1"
    ## [1] "----------------------------------------"
    ## [1] "Procesando conjunto 1 de 5 de la clase 2"
    ## [1] "Procesando conjunto 2 de 5 de la clase 2"
    ## [1] "Procesando conjunto 3 de 5 de la clase 2"
    ## [1] "Procesando conjunto 4 de 5 de la clase 2"
    ## [1] "Procesando conjunto 5 de 5 de la clase 2"
    ## [1] "----------------------------------------"
    ## [1] "Procesando conjunto 1 de 5 de la clase 3"
    ## [1] "Procesando conjunto 2 de 5 de la clase 3"
    ## [1] "Procesando conjunto 3 de 5 de la clase 3"
    ## [1] "Procesando conjunto 4 de 5 de la clase 3"
    ## [1] "Procesando conjunto 5 de 5 de la clase 3"
    ## [1] "----------------------------------------"
    ## [1] "Procesando conjunto 1 de 5 de la clase 4"
    ## [1] "Procesando conjunto 2 de 5 de la clase 4"
    ## [1] "Procesando conjunto 3 de 5 de la clase 4"
    ## [1] "Procesando conjunto 4 de 5 de la clase 4"
    ## [1] "Procesando conjunto 5 de 5 de la clase 4"
    ## [1] "----------------------------------------"
    ## [1] "Procesando conjunto 1 de 5 de la clase 5"
    ## [1] "Procesando conjunto 2 de 5 de la clase 5"
    ## [1] "Procesando conjunto 3 de 5 de la clase 5"
    ## [1] "Procesando conjunto 4 de 5 de la clase 5"
    ## [1] "Procesando conjunto 5 de 5 de la clase 5"
    ## [1] "----------------------------------------"
    ## [1] "Procesando conjunto 1 de 5 de la clase 6"
    ## [1] "Procesando conjunto 2 de 5 de la clase 6"
    ## [1] "Procesando conjunto 3 de 5 de la clase 6"
    ## [1] "Procesando conjunto 4 de 5 de la clase 6"
    ## [1] "Procesando conjunto 5 de 5 de la clase 6"
    ## [1] "----------------------------------------"
    ## [1] "Procesando conjunto 1 de 5 de la clase 7"
    ## [1] "Procesando conjunto 2 de 5 de la clase 7"
    ## [1] "Procesando conjunto 3 de 5 de la clase 7"
    ## [1] "Procesando conjunto 4 de 5 de la clase 7"
    ## [1] "Procesando conjunto 5 de 5 de la clase 7"
    ## [1] "----------------------------------------"
    ## [1] "Procesando conjunto 1 de 5 de la clase 10"
    ## [1] "Procesando conjunto 2 de 5 de la clase 10"
    ## [1] "Procesando conjunto 3 de 5 de la clase 10"
    ## [1] "Procesando conjunto 4 de 5 de la clase 10"
    ## [1] "Procesando conjunto 5 de 5 de la clase 10"
    ## [1] "----------------------------------------"
    ## [1] "Procesando conjunto 1 de 5 de la clase 11"
    ## [1] "Procesando conjunto 2 de 5 de la clase 11"
    ## [1] "Procesando conjunto 3 de 5 de la clase 11"
    ## [1] "Procesando conjunto 4 de 5 de la clase 11"
    ## [1] "Procesando conjunto 5 de 5 de la clase 11"
    ## [1] "----------------------------------------"

### Pavia Left

``` r
kfold_pleft <- guardar_train_test(pix_pleft_dct, ind_pleft, clases_pleft, k, max_clases)
```

    ## [1] "Procesando conjunto 1 de 5 de la clase 1"
    ## [1] "Procesando conjunto 2 de 5 de la clase 1"
    ## [1] "Procesando conjunto 3 de 5 de la clase 1"
    ## [1] "Procesando conjunto 4 de 5 de la clase 1"
    ## [1] "Procesando conjunto 5 de 5 de la clase 1"
    ## [1] "----------------------------------------"
    ## [1] "Procesando conjunto 1 de 5 de la clase 2"
    ## [1] "Procesando conjunto 2 de 5 de la clase 2"
    ## [1] "Procesando conjunto 3 de 5 de la clase 2"
    ## [1] "Procesando conjunto 4 de 5 de la clase 2"
    ## [1] "Procesando conjunto 5 de 5 de la clase 2"
    ## [1] "----------------------------------------"
    ## [1] "Procesando conjunto 1 de 5 de la clase 3"
    ## [1] "Procesando conjunto 2 de 5 de la clase 3"
    ## [1] "Procesando conjunto 3 de 5 de la clase 3"
    ## [1] "Procesando conjunto 4 de 5 de la clase 3"
    ## [1] "Procesando conjunto 5 de 5 de la clase 3"
    ## [1] "----------------------------------------"
    ## [1] "Procesando conjunto 1 de 5 de la clase 5"
    ## [1] "Procesando conjunto 2 de 5 de la clase 5"
    ## [1] "Procesando conjunto 3 de 5 de la clase 5"
    ## [1] "Procesando conjunto 4 de 5 de la clase 5"
    ## [1] "Procesando conjunto 5 de 5 de la clase 5"
    ## [1] "----------------------------------------"
    ## [1] "Procesando conjunto 1 de 5 de la clase 6"
    ## [1] "Procesando conjunto 2 de 5 de la clase 6"
    ## [1] "Procesando conjunto 3 de 5 de la clase 6"
    ## [1] "Procesando conjunto 4 de 5 de la clase 6"
    ## [1] "Procesando conjunto 5 de 5 de la clase 6"
    ## [1] "----------------------------------------"
    ## [1] "Procesando conjunto 1 de 5 de la clase 7"
    ## [1] "Procesando conjunto 2 de 5 de la clase 7"
    ## [1] "Procesando conjunto 3 de 5 de la clase 7"
    ## [1] "Procesando conjunto 4 de 5 de la clase 7"
    ## [1] "Procesando conjunto 5 de 5 de la clase 7"
    ## [1] "----------------------------------------"
    ## [1] "Procesando conjunto 1 de 5 de la clase 10"
    ## [1] "Procesando conjunto 2 de 5 de la clase 10"
    ## [1] "Procesando conjunto 3 de 5 de la clase 10"
    ## [1] "Procesando conjunto 4 de 5 de la clase 10"
    ## [1] "Procesando conjunto 5 de 5 de la clase 10"
    ## [1] "----------------------------------------"
    ## [1] "Procesando conjunto 1 de 5 de la clase 11"
    ## [1] "Procesando conjunto 2 de 5 de la clase 11"
    ## [1] "Procesando conjunto 3 de 5 de la clase 11"
    ## [1] "Procesando conjunto 4 de 5 de la clase 11"
    ## [1] "Procesando conjunto 5 de 5 de la clase 11"
    ## [1] "----------------------------------------"

## Guardar conjuntos

``` r
save(kfold_puni, clases_puni, kfold_pright, clases_pright, kfold_pleft, clases_pleft, file = archivo_tr_ts)
```
