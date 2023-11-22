get_indices_kfold
================
Equipo 5
2023-11-14

## Selección de índices para K-Fold de 5 iteraciones

Con fines de reproducibilidad, se realiza una selección aleatoria de los
pixeles que se utilizan para elegir el punto de corte de los
coeficientes de la DCT y como ingesta para el entrenamiento de la SVM.
Se utiliza el p% de los pixeles para el entrenamiento y el resto para
prueba.

``` r
generar_indices_aleatorios <- function(vector_dim_clases, porcentaje, k) {
  n_clases <- length(vector_dim_clases)
  lista_matrices_indices <- vector("list", length = n_clases)
  for(i in 1:n_clases) {
    if(vector_dim_clases[i] != 0) {
      num_indices <- round(vector_dim_clases[i] * porcentaje)
      matriz_indices <- sample(1:vector_dim_clases[i], num_indices, replace = FALSE)
      for(j in 2:k) {
        matriz_indices <- cbind(matriz_indices, sample(1:vector_dim_clases[i], num_indices, replace = FALSE))
      }
      lista_matrices_indices[[i]] <- matriz_indices
    } else {
      print(paste("No existen elementos en la clase",i))
    }
  }
  return(lista_matrices_indices)
}
```

## Obtener cantidad de pixeles por clase por set de datos

El directorio de trabajo debe estar dado en
/ruta/hacia/carpeta/BEDU_PrototypeDay. Entonces, es necesario revisar el
directorio de trabajo actual con getwd() y, si es necesario, cambiarlo
con setwd(). Ejemplo: setwd(“~/documents/proyecto/BEDU_PrototypeDay”).

``` r
ruta <- file.path("..","..","data")
archivo_dim <- file.path(ruta,"dim_datasets.csv");
```

Se lee el archivo “dim_datasets.csv” de la carpeta “data”:

``` r
dim_datasets <- read.csv(archivo_dim) #Lee el csv
print(dim_datasets)
```

    ##             X   V1   V2   V3   V4   V5    V6   V7   V8   V9   V10   V11
    ## 1   pavia_uni 3064 6631 3682 1330  947 18649 5029 2099 1345     0     0
    ## 2 pavia_right 6508 7585 2140 7287 2165  2905 6549    0    0  3122 65278
    ## 3  pavia_left 1090 1663  545    0  698   185   35    0    0 39704   693

Los parámetros para el k-fold son los siguientes:

``` r
porcentaje <- 0.5 #Porcentaje para entrenamiento
k <- 5 #Número de iteraciones del k-fold
p <- "50" #Identificador de archivo: "indices_p.RData"
```

## Guardar los índices seleccionados por set de datos

Los índices generados para cada set de datos son guardados en la carpeta
“kfold_indices” (bajo la carpeta “data”) con el nombre
“indices_p.RData”, donde “p” es el identificador del esquema de
clasificación.

``` r
nombre_carpeta = file.path(ruta,paste0("kfold_indices"))
if(file.exists(nombre_carpeta)) {
  print(paste("Los datos se guardarán en", nombre_carpeta))
} else {
  dir.create(nombre_carpeta)
  print(paste("Se creó la carpeta", nombre_carpeta, "para guardar los archivos"))
}
```

    ## [1] "Se creó la carpeta ../../data/kfold_indices para guardar los archivos"

### Pavia Uni

``` r
vector_dim_clases <- unname(unlist(dim_datasets[1,2:ncol(dim_datasets[1,])]))
ind_puni <- generar_indices_aleatorios(vector_dim_clases, porcentaje, k) 
```

    ## [1] "No existen elementos en la clase 10"
    ## [1] "No existen elementos en la clase 11"

### Pavia Right

``` r
vector_dim_clases <- unname(unlist(dim_datasets[2,2:ncol(dim_datasets[2,])]))
ind_pright <- generar_indices_aleatorios(vector_dim_clases, porcentaje, k)
```

    ## [1] "No existen elementos en la clase 8"
    ## [1] "No existen elementos en la clase 9"

### Pavia Left

``` r
vector_dim_clases <- unname(unlist(dim_datasets[3,2:ncol(dim_datasets[3,])]))
ind_pleft <- generar_indices_aleatorios(vector_dim_clases, porcentaje, k)
```

    ## [1] "No existen elementos en la clase 4"
    ## [1] "No existen elementos en la clase 8"
    ## [1] "No existen elementos en la clase 9"

### Guardar estructuras

``` r
save(ind_puni, ind_pright, ind_pleft, file = file.path(nombre_carpeta,paste0("indices_",p,".RData")))
```
