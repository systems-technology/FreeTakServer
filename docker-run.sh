#!/bin/bash

# Fix potential line ending issues if edited on Windows
# This is a safety measure
sed -i 's/\r$//' "$0"

# Generate FTS config if missing
if [[ ! -f "/opt/fts/FTSConfig.yaml" ]]; then
    python -c "from FreeTAKServer.core.configuration.configuration_wizard import autogenerate_config; autogenerate_config()"
fi

# Start FreeTAKServer service
python -m FreeTAKServer.controllers.services.FTS
