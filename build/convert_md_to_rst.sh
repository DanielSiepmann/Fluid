#!/bin/bash

set -e

PROJECT_ROOT="$(dirname $( cd "$(dirname "$0")" ; pwd -P ))"
find "$PROJECT_ROOT/Documentation" -type f -not -name 'Index.rst' -name '*.rst' -delete 

for file in $PROJECT_ROOT/Documentation/*.md
do
    echo "converting $file"
    rstFileName=${file/%md/rst}
    pandoc -o $rstFileName $file
done
