FROM alpine:latest

RUN mkdir -p \
        /etc/octoprint/printerProfiles \
        /etc/octoprint/scripts/gcode \
        /opt/octoprint \
 && apk add --no-cache \
        python3 \
        python3-dev \
        py3-pip \
        py3-setuptools \
        # octoprint requirements
        py3-argon2-cffi \
        py3-cffi \ 
        py3-requests \
        py3-six \
        py3-tornado \
 && apk add --no-cache --virtual .build-deps \
        linux-headers \
        build-base \
 && pip install --no-cache-dir --disable-pip-version-check \
        "OctoPrint==1.8.7" \
        "OctoPrint-Setuptools==1.0.3" \
 && pip install --no-cache-dir --disable-pip-version-check \
        "https://github.com/Birkbjo/OctoPrint-Themeify/archive/refs/tags/v1.2.2.tar.gz" \
        "https://github.com/cp2004/OctoPrint-EEPROM-Marlin/archive/refs/tags/3.3.0.tar.gz" \
        "https://github.com/eyal0/OctoPrint-PrintTimeGenius/archive/refs/tags/2.3.0.tar.gz" \
        "https://github.com/jneilliii/OctoPrint-BedLevelVisualizer/archive/refs/tags/1.1.1.tar.gz" \
        "https://github.com/jneilliii/OctoPrint-ConsolidateTempControl/archive/refs/tags/0.1.9.tar.gz" \
        "https://github.com/jneilliii/OctoPrint-CustomBackground/archive/refs/tags/1.0.0.tar.gz" \
        "https://github.com/jneilliii/OctoPrint-UltimakerFormatPackage/archive/refs/tags/1.0.2.tar.gz" \
        "https://github.com/jneilliii/OctoPrint-WideScreen/archive/refs/tags/0.1.4.tar.gz" \
        "https://github.com/OllisGit/OctoPrint-DisplayLayerProgress/archive/refs/tags/1.28.0.tar.gz" \
        "https://github.com/Salandora/octoprint-customControl/archive/refs/tags/0.2.2.tar.gz" \
        "https://github.com/Sebclem/OctoPrint-SimpleEmergencyStop/archive/refs/tags/1.0.5.tar.gz" \
        "https://github.com/tg44/OctoPrint-Prometheus-Exporter/archive/refs/tags/0.2.1.zip" \
 && apk del .build-deps

WORKDIR /etc/octoprint
EXPOSE 5000
CMD [ "octoprint", "serve", "--iknowwhatimdoing", "-b", "/etc/octoprint" ]

ARG BUILD_DATE="Unknown"
ARG SOURCE_COMMIT="Unknown"
LABEL \
    maintainer="" \
    org.opencontainers.image.title="ghcr.io/sgsunder/octoprint-custom-docker" \
    org.opencontainers.image.url="https://github.com/sgsunder/octoprint-custom-docker" \
    org.opencontainers.image.created="${BUILD_DATE}" \
    org.opencontainers.image.source="https://github.com/sgsunder/octoprint-custom-docker" \
    org.opencontainers.image.revision="${SOURCE_COMMIT}" \
    org.opencontainers.image.licenses="MIT"
