FROM alpine:latest

ARG PUID=1000
ARG PGID=1000
RUN mkdir -p /etc/octoprint/uploads /etc/octoprint/generated \
 && apk add --no-cache \
 		linux-headers \
		build-base \
 		python3 \
		python3-dev \
 		py3-requests \
 		py3-six \
 		py3-setuptools \
 		py3-pip \
 && addgroup -g ${PGID} app \
 && adduser -SDH -h /etc/octoprint -g '' -G app -u ${PUID} app \
 && mkdir -p /opt/octoprint \
 && chown -R app:app /etc/octoprint /opt/octoprint

USER app
WORKDIR /etc/octoprint

COPY --chown=app:app init.sh /usr/local/bin/init

ARG OCTOPRINT_VERSION=1.8.6
RUN python3 -m venv /opt/octoprint \
 && /opt/octoprint/bin/pip install --no-cache-dir --disable-pip-version-check \
 		"OctoPrint==${OCTOPRINT_VERSION}" \
		OctoPrint-Setuptools \
 && /opt/octoprint/bin/pip install --no-cache-dir --disable-pip-version-check \
        "https://github.com/Birkbjo/OctoPrint-Themeify/archive/refs/tags/v1.2.2.tar.gz" \
        "https://github.com/cp2004/OctoPrint-EEPROM-Marlin/archive/refs/tags/3.2.0.tar.gz" \
        "https://github.com/eyal0/OctoPrint-PrintTimeGenius/archive/refs/tags/2.3.0.tar.gz" \
		"https://github.com/jneilliii/OctoPrint-BedLevelVisualizer/archive/refs/tags/1.1.1.tar.gz" \
        "https://github.com/jneilliii/OctoPrint-ConsolidateTempControl/archive/refs/tags/0.1.9.tar.gz" \
        "https://github.com/jneilliii/OctoPrint-CustomBackground/archive/refs/tags/1.0.0.tar.gz" \
        "https://github.com/jneilliii/OctoPrint-UltimakerFormatPackage/archive/refs/tags/1.0.2.tar.gz" \
        "https://github.com/jneilliii/OctoPrint-WideScreen/archive/refs/tags/0.1.4.tar.gz" \
        "https://github.com/OllisGit/OctoPrint-DisplayLayerProgress/archive/refs/tags/1.28.0.tar.gz" \
        "https://github.com/Salandora/octoprint-customControl/archive/refs/tags/0.2.2.tar.gz" \
        "https://github.com/Sebclem/OctoPrint-SimpleEmergencyStop/archive/refs/tags/1.0.5.tar.gz" \
 && mkdir -p printerProfiles scripts/gcode
# "https://github.com/hellerbarde/OctoPrint-Network-Printing/archive/refs/tags/v0.1.0.tar.gz"

EXPOSE 5000
CMD [ "/usr/local/bin/init" ]
