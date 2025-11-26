FROM python:3.11

# Create and open data path
RUN mkdir -p /opt/fts && chmod 777 /opt/fts && chmod a+w /var/log

# FTS expects this env var
ENV FTS_DATA_PATH="/opt/fts/"

# IMPORTANT: project root, NOT inside FreeTAKServer/
WORKDIR /root/


# Copy package + metadata + startup
COPY FreeTAKServer/ /root/FreeTAKServer/
COPY README.md pyproject.toml docker-run.sh /root/

# Install deps
RUN pip install --upgrade pip \
    && pip install setuptools wheel poetry \
    && pip install --force-reinstall "ruamel.yaml<0.18"

# Install FreeTAKServer in editable mode
# Force cache invalidation for code changes
ARG CACHEBUST=1
RUN pip install --no-build-isolation --editable /root/


# Persistent data volume
VOLUME /opt/fts

# Start FTS
CMD ["/root/docker-run.sh"]
