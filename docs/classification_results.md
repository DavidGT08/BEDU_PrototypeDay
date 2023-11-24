classification_results
================
Equipo 5
2023-11-17

``` r
library(ggplot2)
```

## Resultados de la clasificación

Este script muestra los resultados de la validación k-fold para los sets
de datos. Estos resultados se encuentran en la carpeta /models que se
encuentra debajo de la carpeta principal del proyecto.

``` r
ruta <- file.path("..","..","models") #Une los elementos del directorio
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

## Pavia University

Estos son los resultados de 5 iteraciones k-fold con una división de 50%
de entrenamiento.

``` r
load(file.path(ruta,"pavia_uni_50.RData"))
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

![](classification_results_files/figure-gfm/Pavia%20University-1.png)<!-- -->

``` r
oa_mean <- sprintf("%.4f", mean(metricas$ov_acc))
oa_sd <- sprintf("%.4f", sd(metricas$ov_acc))
kappa_mean <- sprintf("%.4f", mean(metricas$kappa))
print(paste("Overall Accuracy promedio:", oa_mean))
```

    ## [1] "Overall Accuracy promedio: 0.9038"

``` r
print(paste("Overall Accuracy desviación estándar:", oa_sd))
```

    ## [1] "Overall Accuracy desviación estándar: 0.0014"

``` r
print(paste("Kappa promedio:", kappa_mean))
```

    ## [1] "Kappa promedio: 0.8708"

## Pavia Right

Estos son los resultados de 5 iteraciones k-fold con una división de 50%
de entrenamiento.

``` r
load(file.path(ruta,"pavia_right_50.RData"))
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

![](classification_results_files/figure-gfm/Pavia%20Right-1.png)<!-- -->

``` r
oa_mean <- sprintf("%.4f", mean(metricas$ov_acc))
oa_sd <- sprintf("%.4f", sd(metricas$ov_acc))
kappa_mean <- sprintf("%.4f", mean(metricas$kappa))
print(paste("Overall Accuracy promedio:", oa_mean))
```

    ## [1] "Overall Accuracy promedio: 0.9857"

``` r
print(paste("Overall Accuracy desviación estándar:", oa_sd))
```

    ## [1] "Overall Accuracy desviación estándar: 0.0007"

``` r
print(paste("Kappa promedio:", kappa_mean))
```

    ## [1] "Kappa promedio: 0.9754"

## Pavia Left

Estos son los resultados de 5 iteraciones k-fold con una división de 50%
de entrenamiento.

``` r
load(file.path(ruta,"pavia_left_50.RData"))
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

![](classification_results_files/figure-gfm/Pavia%20Left-1.png)<!-- -->

``` r
oa_mean <- sprintf("%.4f", mean(metricas$ov_acc))
oa_sd <- sprintf("%.4f", sd(metricas$ov_acc))
kappa_mean <- sprintf("%.4f", mean(metricas$kappa))
print(paste("Overall Accuracy promedio:", oa_mean))
```

    ## [1] "Overall Accuracy promedio: 0.9964"

``` r
print(paste("Overall Accuracy desviación estándar:", oa_sd))
```

    ## [1] "Overall Accuracy desviación estándar: 0.0003"

``` r
print(paste("Kappa promedio:", kappa_mean))
```

    ## [1] "Kappa promedio: 0.9824"
