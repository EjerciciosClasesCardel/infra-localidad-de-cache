# Localidad de caché y false sharing

Infraestructuras Paralelas y Distribuidas
Escuela de Ingeniería de Sistemas y Computación, Universidad del Valle
Carlos Andrés Delgado Saavedra

Dos programas que hacen exactamente la misma cuenta de dos maneras distintas.
En los dos casos el resultado es idéntico y el tiempo no, y la explicación está
en cómo viajan los datos entre la memoria y la caché.

## Parte 1: recorrer una matriz

`matriz.cpp` guarda una matriz de 2048 por 2048 en un solo vector, fila tras
fila: el elemento de la fila `i` y la columna `j` está en la posición
`i * N + j`. Hay que completar dos funciones que sumen todos los elementos:

- `por_filas`: recorre fila por fila.
- `por_columnas`: recorre columna por columna.

```bash
make matriz
```

La salida queda también en `matriz.txt`. Las dos sumas tienen que dar
`2048 * 2048`; si una da otra cosa, el recorrido dejó elementos por fuera.

## Parte 2: false sharing

`falso_compartir.cpp` lanza cuatro hilos que incrementan su propio contador
cincuenta millones de veces. Hay que escribir dos versiones:

- `pegados`: los cuatro contadores viven en posiciones contiguas del vector.
- `separados`: cada contador queda en su propia línea de caché. Una línea son
  64 bytes y un `long` ocupa 8, así que basta con dejar ocho posiciones entre
  contador y contador.

```bash
make falso
```

Ninguna de las dos versiones necesita cerrojos: cada hilo escribe en su propia
posición. La diferencia de tiempo no viene de la corrección sino del protocolo
de coherencia entre núcleos.

## Qué revisa el flujo de Actions

Que las cuatro sumas den el valor correcto y que el recorrido por columnas no
salga más rápido que el de filas. Los tiempos quedan impresos en el registro de
la ejecución.

## Lo que hay que poder explicar

Cuánto más lento resultó el recorrido por columnas y por qué, con la línea de
caché en la explicación. Cuánto costó tener los contadores pegados, y por qué
separarlos arregla algo que no era un error de programación. Si en su máquina
la diferencia es menor que en el servidor, vale la pena mirar el tamaño de la
caché de su procesador.
