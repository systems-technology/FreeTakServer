FROM python:3.11

# Create and open data path
RUN mkdir -p /opt/fts && chmod 777 /opt/fts && chmod a+w /var/log

# Correct environment variable syntax
ENV FTS_DATA_PATH="/opt/fts/"

# Move to project directory inside container
WORKDIR /root/FreeTAKServer

# Copy Python package + metadata + startup script
COPY FreeTAKServer/ /root/FreeTAKServer/
COPY README.md pyproject.toml docker-run.sh /root/

# Install dependencies
RUN pip install --upgrade pip \
    && pip install setuptools wheel poetry \
    && pip install --force-reinstall "ruamel.yaml<0.18"

# Install FTS in editable mode
RUN pip install --no-build-isolation --editable /root/

# Persistent volume for DB and configs
VOLUME /opt/fts

# Start FTS
CMD ["/root/docker-run.sh"]
