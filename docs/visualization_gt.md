visualization_GT
================
Equipo 5
2023-11-20

## Bibliotecas

Este código requiere de la biblioteca magick:
<https://cran.r-project.org/web/packages/magick/vignettes/intro.html#Installing_magick>

``` r
#pacman::p_load(magick) #Opción con pacman
library(magick)
```

    ## Linking to ImageMagick 6.9.12.93
    ## Enabled features: cairo, fontconfig, freetype, heic, lcms, pango, raw, rsvg, webp
    ## Disabled features: fftw, ghostscript, x11

## Leer matrices Ground Truth (GT)

Se leen las matrices de Pavia University, Pavia Right y Pavia Left en la
carpeta /data.

El directorio de trabajo debe estar dado en
/ruta/hacia/carpeta/BEDU_PrototypeDay. Entonces, es necesario revisar el
directorio de trabajo actual con getwd() y, si es necesario, cambiarlo
con setwd(). Ejemplo: setwd(“~/documents/proyecto/BEDU_PrototypeDay”).

``` r
archivo_datasets <- file.path("..","..","data","datasets.RData");
```

Se leen los datasets

``` r
load(archivo_datasets)
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

![](visualization_gt_files/figure-gfm/graficar%20paleta-1.png)<!-- -->

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

Posteriormente, se grafica cada set de datos y se guardan sus imágenes
en formato png.

### Pavia University

``` r
mapas <- graficar_mapa_clasificacion(gt_puni, colores)
image_write(mapas$magick, path = "./class_maps/pavia_uni_gt.png", format = "png")
print(mapas$magick)
```

    ##   format width height colorspace matte filesize density
    ## 1    PNG   340    610       sRGB  TRUE        0   72x72

![](visualization_gt_files/figure-gfm/graficar%20Pavia%20University-1.png)<!-- -->

### Pavia Right

``` r
mapas <- graficar_mapa_clasificacion(gt_pright, colores)
image_write(mapas$magick, path = "./class_maps/pavia_right_gt.png", format = "png")
print(mapas$magick)
```

    ##   format width height colorspace matte filesize density
    ## 1    PNG   492   1096       sRGB  TRUE        0   72x72

![](visualization_gt_files/figure-gfm/graficar%20Pavia%20Right-1.png)<!-- -->

### Pavia Left

``` r
mapas <- graficar_mapa_clasificacion(gt_pleft, colores)
image_write(mapas$magick, path = "./class_maps/pavia_left_gt.png", format = "png")
print(mapas$magick)
```

    ##   format width height colorspace matte filesize density
    ## 1    PNG   223   1096       sRGB  TRUE        0   72x72

![](visualization_gt_files/figure-gfm/graficar%20Pavia%20Left-1.png)<!-- -->
