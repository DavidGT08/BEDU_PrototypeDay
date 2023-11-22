classification_results
================
Equipo 5
2023-11-17

``` r
library(ggplot2)
library(magick)
```

    ## Linking to ImageMagick 6.9.12.93
    ## Enabled features: cairo, fontconfig, freetype, heic, lcms, pango, raw, rsvg, webp
    ## Disabled features: fftw, ghostscript, x11

## Resultados de la clasificación

Este script muestra los resultados de la validación k-fold para los sets
de datos. Estos resultados se encuentran en la carpeta /models que se
encuentra debajo de la carpeta principal del proyecto.

``` r
ruta <- file.path("..","..","models") #Une los elementos del directorio
archivo_datasets <- file.path("..","..","data","class_maps_binded_1.RData");
load(archivo_datasets)
```

## Funciones para obtener las métricas guardadas

``` r
obtener_metricas <- function(lista_cm_ts) {
  n_kfold <- length(lista_cm_ts)
  oa_vector <- numeric()
  kappa_vector <- numeric()
  for(i in 1:n_kfold) {
    oa_vector <- c(oa_vector, as.double(lista_cm_ts[[i]]$overall[1]))
    kappa_vector <- c(kappa_vector, as.double(lista_cm_ts[[i]]$overall[2]))
  }
  metricas <- data.frame("k_fold" = 1:n_kfold, "ov_acc" = oa_vector, "kappa" = kappa_vector)
  return(metricas)
}
```

## Graficar las imágenes GT

El mapa GT es similar a un mapa de clasificación. Necesita de una paleta
de colores para asignar un color específico a cada clase. Las clases
consideradas se presentan a continuación:

|        **Clase**         | **Etiqueta** |
|:------------------------:|:------------:|
|        **Trees**         |      1       |
|       **Asphalt**        |      2       |
| **Self-Blocking Bricks** |      3       |
|       **Bitumen**        |      4       |
|       **Shadows**        |      5       |
|       **Meadows**        |      6       |
|      **Bare soil**       |      7       |
|        **Gravel**        |      8       |
| **Painted metal sheets** |      9       |
|        **Tiles**         |      10      |
|        **Water**         |      11      |

Para estas clases se utiliza la siguiente paleta:

``` r
#Valores RGB para los colores por clase
colores <- matrix(c(
  0, 0, 0,       # Background (Clase 0)
  46, 139, 87,   # Clase 1
  0, 0, 255,     # Clase 2
  255, 128, 0,   # Clase 3
  210, 180, 140, # Clase 4
  255, 0, 255,   # Clase 5
  102, 0, 204,   # Clase 6
  153, 76, 0,    # Clase 7
  0, 255, 0,     # Clase 8
  128, 128, 0,   # Clase 9
  0, 51, 102,    # Clase 10
  100, 149, 237  # Clase 11
), ncol = 3, byrow = TRUE)
```

Esta paleta se aprecia gráficamente de la siguiente forma:

``` r
#Acomodar los colores en paleta
paleta_rgb <- rgb(colores[, 1], colores[, 2], colores[, 3], maxColorValue = 255)

#Crear el gráfico de barras con los colores por clase
barplot(rep(1, 12), col = paleta_rgb, names.arg = 0:11, main = "Paleta de Colores por Clase",
        xlab = "Clases", ylab = "", cex.names = 0.8, border = NA, axes = FALSE)
```

![](classification_results_binded_files/figure-gfm/graficar%20paleta-1.png)<!-- -->

Luego, se define la función “graficar_mapa_clasificacion” para generar
una imagen RGB a partir del mapa ground truth.

``` r
graficar_mapa_clasificacion <- function(mapa, colores) {
  #Obtener dimensiones
  dim_mapa <- dim(mapa)
  n_rows <- dim_mapa[1]
  n_cols <- dim_mapa[2]
  
  #Crear imagen RGB
  img_mapa <- array(0, dim = c(n_rows, n_cols, 3))
  for(rw in 1:n_rows) {
    for(cl in 1:n_cols) {
      img_mapa[rw, cl, ] = colores[mapa[rw, cl] + 1, ]
    }
  }
  
  #Graficar mapa
  img_mapa_raster <- as.raster(img_mapa, max = 255)
  img_mapa_magick <- magick::image_read(img_mapa_raster)
  #print(img_mapa_magick) #En el viewer y el documento Knit
  #plot(img_mapa_raster) #En la vista "Visual"
  return(list(raster = img_mapa_raster, magick = img_mapa_magick))
}
```

## Binded datasets

Estos son los resultados de 5 iteraciones k-fold con una división de 50%
de entrenamiento.

``` r
load(file.path(ruta,"binded_50_1.RData"))
metricas <- obtener_metricas(lista_cm_ts)
ggplot(metricas) +
  aes(x = k_fold, y = ov_acc) +
  geom_line(colour = "#440154") +
  labs(
    x = "Iteraciones k-fold",
    y = "Overall Accuracy",
    title = "Overall Accuracy"
  ) +
  theme_minimal()
```

![](classification_results_binded_files/figure-gfm/Binded%20datasets%20OA-1.png)<!-- -->

``` r
oa_mean <- sprintf("%.4f", mean(metricas$ov_acc))
oa_sd <- sprintf("%.4f", sd(metricas$ov_acc))
kappa_mean <- sprintf("%.4f", mean(metricas$kappa))
print(paste("Overall Accuracy promedio:", oa_mean))
```

    ## [1] "Overall Accuracy promedio: 0.9609"

``` r
print(paste("Overall Accuracy desviación estándar:", oa_sd))
```

    ## [1] "Overall Accuracy desviación estándar: 0.0008"

``` r
print(paste("Kappa promedio:", kappa_mean))
```

    ## [1] "Kappa promedio: 0.9511"

El detalle de resultados de la iteración 5 se muestran a continuación:

``` r
print(lista_cm_ts[[5]])
```

    ## $positive
    ## NULL
    ## 
    ## $table
    ##           Reference
    ## Prediction     1     2     3     4     5     6     7     8     9    10    11
    ##         1   5096     1     0     0     2   150    11     0     0     0     0
    ##         2      0  7598    91   768     3     0     0    33     0    45     0
    ##         3      0   125  2750   144     0     2    90   347     0    14     0
    ##         4      0   162   123  3365     0     0     2    17     0     5     0
    ##         5      0     0     0     0  1899     0     0     0     0     1     0
    ##         6    231     8    12     2     0 10368   584     9     0     0     0
    ##         7      4     9   134     9     0   351  5118     1     0    11     0
    ##         8      0    26    65    13     0     0     0   641     0     1     0
    ##         9      0     0     0     0     0     0     0     0   673     0     0
    ##         10     0    10     9     7     0     0     2     1     0 21336     0
    ##         11     0     0     0     0     1     0     0     0     0     0 32986
    ## 
    ## $overall
    ##       Accuracy          Kappa  AccuracyLower  AccuracyUpper   AccuracyNull 
    ##      0.9619131      0.9523584      0.9606796      0.9631185      0.3455262 
    ## AccuracyPValue  McnemarPValue 
    ##      0.0000000            NaN 
    ## 
    ## $byClass
    ##           Sensitivity Specificity Pos Pred Value Neg Pred Value Precision
    ## Class: 1    0.9559182   0.9981805      0.9688213      0.9973949 0.9688213
    ## Class: 2    0.9570475   0.9892605      0.8899040      0.9960772 0.8899040
    ## Class: 3    0.8636935   0.9921762      0.7920507      0.9952823 0.7920507
    ## Class: 4    0.7811049   0.9966103      0.9158955      0.9897268 0.9158955
    ## Class: 5    0.9968504   0.9999893      0.9994737      0.9999359 0.9994737
    ## Class: 6    0.9537301   0.9899994      0.9245586      0.9940298 0.9245586
    ## Class: 7    0.8813501   0.9942114      0.9079297      0.9923299 0.9079297
    ## Class: 8    0.6110582   0.9988879      0.8592493      0.9956926 0.8592493
    ## Class: 9    1.0000000   1.0000000      1.0000000      1.0000000 1.0000000
    ## Class: 10   0.9964041   0.9996084      0.9986426      0.9989609 0.9986426
    ## Class: 11   1.0000000   0.9999840      0.9999697      1.0000000 0.9999697
    ##              Recall        F1 Prevalence Detection Rate Detection Prevalence
    ## Class: 1  0.9559182 0.9623265 0.05584187    0.053380261           0.05509815
    ## Class: 2  0.9570475 0.9222553 0.08316050    0.079588545           0.08943498
    ## Class: 3  0.8636935 0.8263221 0.03335219    0.028806067           0.03636897
    ## Class: 4  0.7811049 0.8431471 0.04512601    0.035248151           0.03848491
    ## Class: 5  0.9968504 0.9981603 0.01995475    0.019891899           0.01990237
    ## Class: 6  0.9537301 0.9389178 0.11387300    0.108604110           0.11746590
    ## Class: 7  0.8813501 0.8944425 0.06082794    0.053610710           0.05904720
    ## Class: 8  0.6110582 0.7142061 0.01098821    0.006714432           0.00781430
    ## Class: 9  1.0000000 1.0000000 0.00704963    0.007049630           0.00704963
    ## Class: 10 0.9964041 0.9975221 0.22429975    0.223493181           0.22379695
    ## Class: 11 1.0000000 0.9999848 0.34552616    0.345526156           0.34553663
    ##           Balanced Accuracy
    ## Class: 1          0.9770494
    ## Class: 2          0.9731540
    ## Class: 3          0.9279348
    ## Class: 4          0.8888576
    ## Class: 5          0.9984199
    ## Class: 6          0.9718648
    ## Class: 7          0.9377807
    ## Class: 8          0.8049730
    ## Class: 9          1.0000000
    ## Class: 10         0.9980062
    ## Class: 11         0.9999920
    ## 
    ## $mode
    ## [1] "sens_spec"
    ## 
    ## $dots
    ## list()
    ## 
    ## attr(,"class")
    ## [1] "confusionMatrix"

Posteriormente, se grafica cada set de datos y se guardan sus imágenes
en formato png.

### Pavia University

Resultado de clasificación utilizando pixeles de los 3 datasets para
entrenar.

``` r
mapas <- graficar_mapa_clasificacion(img_lab_puni, colores)
image_write(mapas$magick, path = "./class_maps/pavia_uni_class_map_binded.png", format = "png")
print(mapas$magick)
```

    ## # A tibble: 1 × 7
    ##   format width height colorspace matte filesize density
    ##   <chr>  <int>  <int> <chr>      <lgl>    <int> <chr>  
    ## 1 PNG      340    610 sRGB       TRUE         0 72x72

![](classification_results_binded_files/figure-gfm/graficar%20Pavia%20University-1.png)<!-- -->

### Pavia Right

Resultado de clasificación utilizando pixeles de los 3 datasets para
entrenar.

``` r
mapas <- graficar_mapa_clasificacion(img_lab_pright, colores)
image_write(mapas$magick, path = "./class_maps/pavia_right_class_map_binded.png", format = "png")
print(mapas$magick)
```

    ## # A tibble: 1 × 7
    ##   format width height colorspace matte filesize density
    ##   <chr>  <int>  <int> <chr>      <lgl>    <int> <chr>  
    ## 1 PNG      492   1096 sRGB       TRUE         0 72x72

![](classification_results_binded_files/figure-gfm/graficar%20Pavia%20Right-1.png)<!-- -->

### Pavia Left

Resultado de clasificación utilizando pixeles de los 3 datasets para
entrenar.

``` r
mapas <- graficar_mapa_clasificacion(img_lab_pleft, colores)
image_write(mapas$magick, path = "./class_maps/pavia_left_class_map_binded.png", format = "png")
print(mapas$magick)
```

    ## # A tibble: 1 × 7
    ##   format width height colorspace matte filesize density
    ##   <chr>  <int>  <int> <chr>      <lgl>    <int> <chr>  
    ## 1 PNG      223   1096 sRGB       TRUE         0 72x72

![](classification_results_binded_files/figure-gfm/graficar%20Pavia%20Left-1.png)<!-- -->
