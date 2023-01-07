#!/bin/sh
set -e

# Configure user
octoprint --iknowwhatimdoing -b /etc/octoprint \
    user add --admin --password "${OCTO_PASS}" "${OCTO_USER}"

# Generate GCODE scripts
python - <<'EOSCRIPT'
from yaml import safe_load as loader
try:
    with open('scripts.yaml', 'r') as f:
        for name, val in loader(f).items():
            with open(f'scripts/gcode/{name}', 'w') as g:
                g.write(val)
except FileNotFoundError:
    pass
EOSCRIPT

# Start OctoPrint
exec octoprint serve --iknowwhatimdoing -b /etc/octoprint
