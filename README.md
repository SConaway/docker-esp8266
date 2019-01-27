# docker-esp8266 [![Build Status](https://travis-ci.com/SConaway/docker-esp8266.svg?branch=master)](https://travis-ci.com/SConaway/docker-esp8266) [![Image Size / Layer Count](https://images.microbadger.com/badges/image/sconaway/docker-esp8266.svg)](https://microbadger.com/images/sconaway/docker-esp8266)

This is a docker toolchain for the ESP8266/8265 chips. It opens bash.

This should open a bash shell: `docker run --name esp_toolchain --rm -ti --mount type=bind,source="$(pwd)",target=/work sconaway/docker-esp8266`. From there, you can run make or whatever command you need.

You can use the host's serial port to connect to programming hardware: `docker run --name esp_toolchain --rm -ti -v /dev/tty.WHATEVER:/dev/tty.WHATEVER --mount type=bind,source="$(pwd)",target=/work sconaway/docker-esp8266`.
