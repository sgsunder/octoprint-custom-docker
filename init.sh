#!/bin/sh
set -e

# Configure user
octoprint -b /etc/octoprint user add --admin --password "${OCTO_PASS}" "${OCTO_USER}"

# Configure application keys
mkdir -p data/appkeys/
python3 - <<'EOSCRIPT'
import os
from yaml import dump
key_data = [
    {"app_key": app_key, "app_id": app_id}
    for app_id, app_key in [
        tuple(value.split(":"))
        for varname, value in os.environ.items()
        if varname.startswith("OCTO_APIKEY_")
    ]
]
if key_data:
    with open("data/appkeys/keys.yaml", "w") as f:
        dump({os.environ["OCTO_USER"]: key_data}, f)
EOSCRIPT

# Start OctoPrint
exec octoprint -b /etc/octoprint serve
