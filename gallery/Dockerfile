FROM python:3.13-slim

# note: a single RUN to avoid too many image layers being produced
RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install git apt-utils -y --no-install-recommends\
    && git config --global user.email "censura@kactlabs.github.com" \
    && git config --global user.name "Gallery/Censura" \
    && rm -rf /var/lib/apt/lists/*

COPY gallery.py /
ENTRYPOINT ["python", "/gallery.py"]
