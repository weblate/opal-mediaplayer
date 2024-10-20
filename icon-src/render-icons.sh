#!/bin/bash
#
# This file is part of Opal and has been released into the public domain.
# SPDX-License-Identifier: CC0-1.0
# SPDX-FileCopyrightText: 2021-2023 Mirian Margiani
#
# See https://github.com/Pretty-SFOS/opal/blob/main/snippets/opal-render-icons.md
# for documentation.
#
# @@@ keep this line: based on template v1.0.0
#
c__FOR_RENDER_LIB__="1.0.0"

# Run this script from the same directory where your icon sources are located,
# e.g. <app>/icon-src.

source ../../opal/snippets/opal-render-icons.sh || {
    echo && printf -- "%s\n" \
        "Failed to source library functions. Make sure the main" \
        "Opal repository is cloned next to this module's directory (../opal)." \
        "" "Run this:"
    printf -- "\t%s\n" \
        "cd $(dirname "$(pwd)")" \
        "git clone https://github.com/Pretty-SFOS/opal opal"
    exit 128
}

cFORCE=false

for i in raw/*.svg; do
    if [[ "$i" -nt "${i#raw/}" ]]; then
        scour "$i" > "${i#raw/}"
    fi
done

cNAME="theme icons"
cITEMS=(icon-m-{cast,forward,rewind,play,pause})
cRESOLUTIONS=(112)
cTARGETS=(../Opal/MediaPlayer/private/images)
render_batch

# audio.rawr requires Glaxnimate for exporting so we skip it here

for i in ../Opal/MediaPlayer/private/images/*.{png,gif}; do
    cat <<-EOF > "$i.license"
	SPDX-FileCopyrightText: Mirian Margiani
	SPDX-License-Identifier: CC-BY-SA-4.0
	EOF
done
