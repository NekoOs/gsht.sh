# Global Shell Transpiler

[![Language](https://img.shields.io/badge/Made%20with-Bash-1f425f.svg)](https://www.gnu.org/software/bash/)
[![GitHub Release](https://img.shields.io/github/release/NekoOs/gsht.sh)](https://gitHub.com/NekoOs/gsht.sh/releases/latest)
[![Github Build Action](https://github.com/NekoOs/gsht.sh/actions/workflows/tags.yml/badge.svg)](https://github.com/NekoOs/gsht.sh/actions/workflows/tags.yml)
[![Github Draft Action](https://github.com/NekoOs/gsht.sh/actions/workflows/draft.yml/badge.svg)](https://github.com/NekoOs/gsht.sh/actions/workflows/draft.yml)
[![Github Issues](https://img.shields.io/github/issues/NekoOs/gsht.sh)](https://github.com/NekoOs/gsht.sh/issues)
[![Github Version Download](https://img.shields.io/github/downloads/NekoOs/gsht.sh/total)](https://github.com/NekoOs/gsht.sh/releases)

Traducciones: [English](README.md) - [Español](README.es_ES.md)

## Acerca de

`gsht` es un transpilador de shell script que permite dividir el código fuente de forma modular dentro de un proyecto, 
para luego mezclar los diferentes ficheros implementados en un único fichero.

## Instalación y actualización

### Script de instalación y actualización

Para **instalar** o **actualizar** `gsht`, puede descargar y ejecutar el script manualmente, o usé el siguiente comando 
cURL o Wget:

```bash
curl -L https://github.com/NekoOs/gsht.sh/releases/download/v0.1.0/gsht > gsht
```
```bash
wget https://github.com/NekoOs/gsht.sh/releases/download/v0.1.0/gsht
```

> Para usar `gsht` de forma global coloque el fichero generado en el directorio de binarios
> ```bash
> sudo mv gsht /usr/local/bin/
> sudo chmod a+x /usr/local/bin/gsht
> ```

## Uso

Imagine una estructura así:

```text
/our-project-path
 ├── sub-folder
 │  └── sub-folder
 │  │   └── file-4.sh
 │  └── file-3.sh
 ├── file-1.sh
 └── file-2.sh   
```

Contenido del fichero `/our-project-path/file-1.sh`

```bash
#!/usr/bin/env bash

echo "file 1 here!"

source ./sub-folder/file-3.sh 
```

Contenido del fichero `/our-project-path/file-2.sh`

```bash
#!/usr/bin/env bash

echo "file 2 here!" 
```

Contenido del fichero `/our-project-path/sub-folder/file-3.sh`

```bash
#!/usr/bin/env bash

echo "file 3 here!"

source ./sub-folder/file-4.sh
```

Contenido del fichero `/our-project-path/sub-folder/sub-folder/file-4.sh`

```bash
#!/usr/bin/env bash

echo "file 4 here!"

source ../../file-2.sh 
```

Ejecute lo siguiente:

```sh
gsht /our-project-path/file-1.sh --output=file-1-transpilated
```

> Solo el nombre de fichero de entrada es obligatorio `gsht source [--output=target]`.
> Si no se ha especificado el nombre del fichero de salida, el script asumirá por defecto un nombre en función del 
> fichero de entrada, para ejemplo anterior algo así: `/our-current-path/file-1` 

El contenido generado será:

```bash
#!/usr/bin/env bash

echo "file 1 here!"

echo "file 3 here!"

echo "file 4 here!"

echo "file 2 here!"
```

# Observación de cambios en los activos

`gsht` ofrece la opción `watch` que continuará ejecutándose en su terminal y observará todos los archivos 
re-transpilando automáticamente:

```bash
gsht --watch --input source --output target
```


## Mejoras

- Evaluación de importaciones con path calculado.
  ```bash
  current_dir=$(dirname "${BASH_SOURCE[0]}")
  source "$current_dir/sub-folder/file.sh"
  ```

## Pruebas

```bash
./tests/01.sh # generated file ./bin/test-01-transpilated
```

[1]: https://github.com/NekoOs/gsht.sh
[2]: https://github.com/NekoOs/gsht.sh/blob/master/install.sh
