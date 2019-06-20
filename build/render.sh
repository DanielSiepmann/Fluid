#!/bin/bash

# This should become the bash script within Bamboo
# Used to generate documentation for docs.typo3.org

set -x
set -e

find Documentation -type f -not -name 'Index.rst' -name '*.rst' -delete

docker run \
    -v $(pwd):/PROJECT \
    -v $(pwd)/DocumentationResult:/RESULT \
    --rm \
    --entrypoint bash \
    t3docs/render-documentation:v1.6.11-html \
    -c "
        set -e;
        /PROJECT/build/convert_md_to_rst.sh;
        /ALL/Menu/mainmenu.sh makehtml -c replace_static_in_html 1;
        chown ${HOST_UID} -R /PROJECT /RESULT;
    "
