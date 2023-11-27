correlacion_cruzada
================
Equipo 5
2023-11-26

# Correlación cruzada

Vamos a realizar un análisis de correlación, usando las señales medias
de cada clase. La idea es hacer la correlación entre los dataset
*Pavia_university* y *Pavia_right.* Recordemos que cada clase tiene una
etiqueta diferente en los datasets.

(Revisar la tabla de correspondencia entre clase-etiqueta por dataset)

### Leer csv

El directorio de trabajo debe estar dado en
/ruta/hacia/carpeta/BEDU_PrototypeDay. Entonces, es necesario revisar el
directorio de trabajo actual con getwd() y, si es necesario, cambiarlo
con setwd(). Ejemplo: setwd(“~/documents/proyecto/BEDU_PrototypeDay”).

``` r
df <- read.csv(file.path("..","..","data","cross_correlation_by_classes.csv"))
```

### Selección de los pares de columnas correspondientes

Convertimos cada columna en un vector para posteriormente, pasarselo a
la función que calcula la correlación.

``` r
asphalt_uni <- df$asphalt_uni
asphalt_right <- df$asphalt_right

meadows_uni <- df$meadows_uni
meadows_right <- df$meadows_right

trees_uni <- df$trees_uni
trees_right <- df$trees_right

bare.soil_uni <- df$bare.soil_uni
bare.soil_right <- df$bare.soil_right

bitumen_uni <- df$bitumen_uni
bitumen_right <- df$bitumen_right

self.blocking.bricks_uni <- df$self.blocking.bricks_uni
self.blocking.bricks_right <- df$self.blocking.bricks_right
```

### Calcular la correlación cruzada por clase en cada uno de sus lags y su gráfica

Se puede observar que las clases de los diferentes datasets se
encuentran altamente correlacionadas, por lo que es posible hacer una
homologación de las observaciones de los datasets para conformar una
sola biblioteca de clases.

#### Asphalt

``` r
print(ccf(asphalt_uni, asphalt_right))
```

![](correlacion_cruzada_files/figure-gfm/calculate%20cross%20correlation%20of%20asphalt-1.png)<!-- -->

    ## 
    ## Autocorrelations of series 'X', by lag
    ## 
    ##   -17   -16   -15   -14   -13   -12   -11   -10    -9    -8    -7    -6    -5 
    ## 0.478 0.510 0.542 0.574 0.607 0.639 0.670 0.699 0.728 0.759 0.788 0.813 0.837 
    ##    -4    -3    -2    -1     0     1     2     3     4     5     6     7     8 
    ## 0.861 0.894 0.939 0.979 0.994 0.961 0.919 0.878 0.845 0.815 0.785 0.752 0.716 
    ##     9    10    11    12    13    14    15    16    17 
    ## 0.682 0.650 0.617 0.582 0.548 0.516 0.483 0.450 0.417

#### Meadows

``` r
print(ccf(meadows_uni, meadows_right))
```

![](correlacion_cruzada_files/figure-gfm/calculate%20cross%20correlation%20of%20meadows-1.png)<!-- -->

    ## 
    ## Autocorrelations of series 'X', by lag
    ## 
    ##   -17   -16   -15   -14   -13   -12   -11   -10    -9    -8    -7    -6    -5 
    ## 0.441 0.482 0.523 0.563 0.604 0.644 0.683 0.722 0.759 0.795 0.829 0.861 0.890 
    ##    -4    -3    -2    -1     0     1     2     3     4     5     6     7     8 
    ## 0.917 0.940 0.961 0.977 0.990 0.969 0.944 0.915 0.884 0.849 0.813 0.774 0.733 
    ##     9    10    11    12    13    14    15    16    17 
    ## 0.691 0.648 0.604 0.560 0.515 0.470 0.425 0.379 0.335

#### Trees

``` r
print(ccf(trees_uni, trees_right))
```

![](correlacion_cruzada_files/figure-gfm/calculate%20cross%20correlation%20of%20trees-1.png)<!-- -->

    ## 
    ## Autocorrelations of series 'X', by lag
    ## 
    ##   -17   -16   -15   -14   -13   -12   -11   -10    -9    -8    -7    -6    -5 
    ## 0.360 0.407 0.455 0.503 0.550 0.597 0.643 0.688 0.731 0.773 0.813 0.850 0.884 
    ##    -4    -3    -2    -1     0     1     2     3     4     5     6     7     8 
    ## 0.915 0.942 0.965 0.984 1.000 0.981 0.959 0.932 0.902 0.869 0.832 0.793 0.752 
    ##     9    10    11    12    13    14    15    16    17 
    ## 0.708 0.664 0.618 0.572 0.525 0.478 0.430 0.383 0.336

#### Bare-soil

``` r
print(ccf(bare.soil_uni, bare.soil_right))
```

![](correlacion_cruzada_files/figure-gfm/calculate%20cross%20correlation%20of%20bare-soil-1.png)<!-- -->

    ## 
    ## Autocorrelations of series 'X', by lag
    ## 
    ##   -17   -16   -15   -14   -13   -12   -11   -10    -9    -8    -7    -6    -5 
    ## 0.356 0.392 0.429 0.465 0.502 0.539 0.576 0.613 0.650 0.686 0.722 0.757 0.791 
    ##    -4    -3    -2    -1     0     1     2     3     4     5     6     7     8 
    ## 0.825 0.859 0.893 0.926 0.957 0.947 0.932 0.914 0.895 0.875 0.853 0.830 0.805 
    ##     9    10    11    12    13    14    15    16    17 
    ## 0.779 0.753 0.726 0.698 0.670 0.641 0.612 0.583 0.555

#### Bitumen

``` r
print(ccf(bitumen_uni, bitumen_right))
```

![](correlacion_cruzada_files/figure-gfm/calculate%20cross%20correlation%20of%20bitumen-1.png)<!-- -->

    ## 
    ## Autocorrelations of series 'X', by lag
    ## 
    ##   -17   -16   -15   -14   -13   -12   -11   -10    -9    -8    -7    -6    -5 
    ## 0.667 0.682 0.697 0.710 0.721 0.732 0.742 0.750 0.757 0.762 0.767 0.770 0.771 
    ##    -4    -3    -2    -1     0     1     2     3     4     5     6     7     8 
    ## 0.772 0.774 0.777 0.774 0.762 0.704 0.644 0.588 0.538 0.493 0.450 0.410 0.371 
    ##     9    10    11    12    13    14    15    16    17 
    ## 0.333 0.299 0.266 0.235 0.205 0.179 0.154 0.131 0.109

#### Self-blocking-bricks

``` r
print(ccf(self.blocking.bricks_uni, self.blocking.bricks_right))
```

![](correlacion_cruzada_files/figure-gfm/calculate%20cross%20correlation%20of%20Self-blocking-bricks-1.png)<!-- -->

    ## 
    ## Autocorrelations of series 'X', by lag
    ## 
    ##   -17   -16   -15   -14   -13   -12   -11   -10    -9    -8    -7    -6    -5 
    ## 0.322 0.359 0.397 0.435 0.473 0.512 0.550 0.587 0.625 0.663 0.702 0.740 0.778 
    ##    -4    -3    -2    -1     0     1     2     3     4     5     6     7     8 
    ## 0.817 0.858 0.903 0.946 0.987 0.956 0.923 0.889 0.858 0.831 0.802 0.773 0.741 
    ##     9    10    11    12    13    14    15    16    17 
    ## 0.708 0.674 0.643 0.609 0.575 0.541 0.507 0.474 0.441
