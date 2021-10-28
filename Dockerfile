FROM alpine:latest

ARG PUID=1000
ARG PGID=1000

RUN mkdir -p /etc/octoprint/uploads /etc/octoprint/generated \
 && apk add --no-cache \
 		linux-headers \
 		python3 \
 		py3-requests \
 		py3-six \
 		py3-setuptools \
 		py3-pip \
 && addgroup -g ${PGID} app \
 && adduser -SDH -h /etc/octoprint -g '' -G app -u ${PUID} app \
 && chown -R app:app /etc/octoprint

RUN apk add --no-cache --virtual .build-deps \
 		build-base \
 		python3-dev \
 && pip3 install --no-cache-dir --disable-pip-version-check OctoPrint \
 && pip3 install --no-cache-dir --disable-pip-version-check \
		https://github.com/birkbjo/OctoPrint-Themeify/archive/master.zip \
		https://github.com/cp2004/OctoPrint-EEPROM-Marlin/archive/master.zip \
		https://github.com/eyal0/OctoPrint-PrintTimeGenius/archive/master.zip \
		https://github.com/jneilliii/OctoPrint-ConsolidateTempControl/archive/master.zip \
		https://github.com/jneilliii/OctoPrint-CustomBackground/archive/master.zip \
		https://github.com/jneilliii/OctoPrint-UltimakerFormatPackage/archive/master.zip \
		https://github.com/jneilliii/OctoPrint-WideScreen/archive/master.zip \
 && apk del .build-deps

COPY --chown=app:app config/ /etc/octoprint/

WORKDIR /etc/octoprint
USER app
VOLUME ["/etc/octoprint/uploads", "/etc/octoprint/generated"]
EXPOSE 5000
CMD ["/etc/octoprint/init"]
