# Global Shell Transpiler

Translations: [English](README.md) - [Español](README.es_ES.md)

## About

`gsht` is a shell script transpiler that allows you to divide source code in a modular way within a project,
to later mix the different files implemented in a single file.

## Installation and update

### Installation and update script

To **install** or **update** `gsht`, you can download and run the script manually, or I used the following cURL or Wget 
command:

```bash
curl -L https://github.com/NekoOs/gsht.sh/releases/download/nightly/gsht > gsht
```

```bash
wget https://github.com/NekoOs/gsht.sh/releases/download/nightly/gsht
```

> To use `gsht` globally place the generated file in the binaries directory
> ```bash
> sudo mv gsht /usr/local/bin/
> sudo chmod a+x /usr/local/bin/gsht
> ```

## Use

Imagine a structure like this:

```text
/our-project-path
 ├── sub-folder
 │ └── sub-folder
 │ │ └── file-4.sh
 │ └── file-3.sh
 ├── file-1.sh
 └── file-2.sh
```

Contents of the file `/our-project-path/file-1.sh`

```bash
#!/usr/bin/env bash

echo "file 1 here!"

source ./sub-folder/file-3.sh
```

Contents of the file `/our-project-path/file-2.sh`

```bash
#!/usr/bin/env bash

echo "file 2 here!"
```

Contents of the file `/our-project-path/sub-folder/file-3.sh`

```bash
#!/usr/bin/env bash

echo "file 3 here!"

source ./sub-folder/file-4.sh
```

Contents of the file `/our-project-path/sub-folder/sub-folder/file-4.sh`

```bash
#!/usr/bin/env bash

echo "file 4 here!"

source ../../file-2.sh
```

Run the following:

```bash
gsht /our-project-path/file-1.sh --output = file-1-transpilated
```

> Only the input filename is required `gsht source [--output=target]`.
> If the name of the output file has not been specified, the script will default to a name based on the
> input file, for example above something like this: `/our-current-path/file-1`

The generated content will be:

```bash
#!/usr/bin/env bash

echo "file 1 here!"

echo "file 3 here!"

echo "file 4 here!"

echo "file 2 here!"
```

## Improvements

- Evaluation of imports with calculated path.
  ```bash
  current_dir=$(dirname "${BASH_SOURCE[0]}")
  source "$current_dir/sub-folder/file-4.sh"
  ```

## Tests

```bash
./tests/01.sh # generated file ./bin/test-01-transpilated
```

[1]: https://github.com/NekoOs/gsht.sh