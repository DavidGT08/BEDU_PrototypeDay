save_features_dct
================
Equipo 5
2023-11-14

## Bibliotecas

Es necesaria la biblioteca “gsignal” para ejecutar el código de este
documento. Si no se tiene instalada, se requiere ejecutar
install.packages(“gsignal”).

``` r
library(gsignal)
```

    ## 
    ## Attaching package: 'gsignal'

    ## The following objects are masked from 'package:stats':
    ## 
    ##     filter, gaussian, poly

## Características a partir de la Transformada Discreta de Coseno (DCT)

Las imágenes híper-espectrales contienen una gran cantidad de bandas por
pixel, donde cada banda puede ser utilizada como una característica en
la entrada de un clasificador. En este proyecto se emplea la máquina de
vectores de soporte (SVM) para la asignación de etiquetas a los pixeles.
Para simplificar la tarea del clasificador, se opta por una reducción de
características por medio de una transformación de los datos con DCT
para, posteriormente, realizar una selección de las que entran a la SVM.

La función para transformar los datos se muestra a continuación:

``` r
datos_a_DCT <- function(matriz_datos) {
  #Obtiene dimensiones (renglones: pixeles, columnas: bandas)
  dim_datos <- dim(matriz_datos)
  n_cols <- dim_datos[2]
  
  #Transforma los datos a DCT y divide entre el número de bandas
  matriz_DCT <- t(apply(X = matriz_datos, MARGIN = 1, FUN = function(x) dct(x)/n_cols))
  matriz_DCT[is.nan(matriz_DCT)] <- 0
  return(matriz_DCT)
}
```

Como los archivos de las imágenes se encuentran guardados en formato
.csv separados por clase, es necesario iterar todos los archivos para
lograr la transformación completa del set de datos.

``` r
guardar_clases_DCT <- function(lista_pixeles, lista_clases, max_clases) {
  n_clases <- length(lista_clases)
  vector_dim_clases <- numeric(max_clases)
  lista_pixeles_dct <- vector("list", length = n_clases)
  for(i in 1:n_clases) {
    lista_pixeles_dct[[i]] <- datos_a_DCT(lista_pixeles[[i]]) #Transforma a DCT
    dim_datos <- dim(lista_pixeles[[i]])
    dim_dct <- dim(lista_pixeles_dct[[i]])
    print(paste("Transformados", dim_dct[1], "pixeles de", dim_datos[1], "en la clase", lista_clases[i]))
    vector_dim_clases[lista_clases[i]] <- dim_dct[1]
  }
  return(list("pix_dct" = lista_pixeles_dct, "dim_clases" = vector_dim_clases))
}
```

## Lectura y escritura de las matrices de clases

Se leen las matrices de Pavia University, Pavia Right y Pavia Left en la
carpeta ./data.

El directorio de trabajo debe estar dado en
/ruta/hacia/carpeta/BEDU_PrototypeDay. Entonces, es necesario revisar el
directorio de trabajo actual con getwd() y, si es necesario, cambiarlo
con setwd(). Ejemplo: setwd(“~/documents/proyecto/BEDU_PrototypeDay”).

``` r
ruta_data <- file.path("..","..","data")
archivo_datasets <- file.path(ruta_data,"datasets.RData");
load(archivo_datasets)
max_clases <- 11
```

## Transformar datos

Se transforman los sets de datos a DCT.

### Pavia Uni

Se transforman los datos de Pavia University.

``` r
result <- guardar_clases_DCT(pix_puni, clases_puni, max_clases)
```

    ## [1] "Transformados 3064 pixeles de 3064 en la clase 1"
    ## [1] "Transformados 6631 pixeles de 6631 en la clase 2"
    ## [1] "Transformados 3682 pixeles de 3682 en la clase 3"
    ## [1] "Transformados 1330 pixeles de 1330 en la clase 4"
    ## [1] "Transformados 947 pixeles de 947 en la clase 5"
    ## [1] "Transformados 18649 pixeles de 18649 en la clase 6"
    ## [1] "Transformados 5029 pixeles de 5029 en la clase 7"
    ## [1] "Transformados 2099 pixeles de 2099 en la clase 8"
    ## [1] "Transformados 1345 pixeles de 1345 en la clase 9"

``` r
pix_puni_dct <- result$pix_dct
pavia_uni <- result$dim_clases
```

### Pavia Right

Se transforman los datos de Pavia Right.

``` r
result <- guardar_clases_DCT(pix_pright, clases_pright, max_clases)
```

    ## [1] "Transformados 6508 pixeles de 6508 en la clase 1"
    ## [1] "Transformados 7585 pixeles de 7585 en la clase 2"
    ## [1] "Transformados 2140 pixeles de 2140 en la clase 3"
    ## [1] "Transformados 7287 pixeles de 7287 en la clase 4"
    ## [1] "Transformados 2165 pixeles de 2165 en la clase 5"
    ## [1] "Transformados 2905 pixeles de 2905 en la clase 6"
    ## [1] "Transformados 6549 pixeles de 6549 en la clase 7"
    ## [1] "Transformados 3122 pixeles de 3122 en la clase 10"
    ## [1] "Transformados 65278 pixeles de 65278 en la clase 11"

``` r
pix_pright_dct <- result$pix_dct
pavia_right <- result$dim_clase
```

### Pavia Left

Se transforman los datos de Pavia Left.

``` r
result <- guardar_clases_DCT(pix_pleft, clases_pleft, max_clases)
```

    ## [1] "Transformados 1090 pixeles de 1090 en la clase 1"
    ## [1] "Transformados 1663 pixeles de 1663 en la clase 2"
    ## [1] "Transformados 545 pixeles de 545 en la clase 3"
    ## [1] "Transformados 698 pixeles de 698 en la clase 5"
    ## [1] "Transformados 185 pixeles de 185 en la clase 6"
    ## [1] "Transformados 35 pixeles de 35 en la clase 7"
    ## [1] "Transformados 39704 pixeles de 39704 en la clase 10"
    ## [1] "Transformados 693 pixeles de 693 en la clase 11"

``` r
pix_pleft_dct <- result$pix_dct
pavia_left <- result$dim_clase
```

### Guardar la cantidad de pixeles por clase

Se guarda una matriz que contiene la cantidad de pixeles por clase.

``` r
dim_datasets <- rbind(pavia_uni, pavia_right, pavia_left)
write.csv(dim_datasets, file = file.path(ruta_data, "dim_datasets.csv"))
print(dim_datasets)
```

    ##             [,1] [,2] [,3] [,4] [,5]  [,6] [,7] [,8] [,9] [,10] [,11]
    ## pavia_uni   3064 6631 3682 1330  947 18649 5029 2099 1345     0     0
    ## pavia_right 6508 7585 2140 7287 2165  2905 6549    0    0  3122 65278
    ## pavia_left  1090 1663  545    0  698   185   35    0    0 39704   693

### Guardar estructuras

Se guardan las estructuras de los datasets transformados.

``` r
save(clases_puni, pix_puni_dct, pos_puni, gt_puni, clases_pright, pix_pright_dct, pos_pright, gt_pright, clases_pleft, pix_pleft_dct, pos_pleft, gt_pleft, file = file.path(ruta_data, "datasets_dct.RData"))
```
