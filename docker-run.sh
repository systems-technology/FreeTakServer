#!/bin/bash

# Generate FTS config if missing
if [[ ! -f "/opt/fts/FTSConfig.yaml" ]]; then
    python -c "from FreeTAKServer.core.configuration.configuration_wizard import autogenerate_config; autogenerate_config()"
fi

# Start FreeTAKServer service
python -m FreeTAKServer.controllers.services.FTS
