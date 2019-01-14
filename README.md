# docker-esp8266

This is a docker toolchain for the ESP8266/8265 chips. It opens bash.

This should open a bash:
````
docker run --rm -ti -v `pwd`:/work /bin/bash
````. From there, you can run make or whatever command you need.
You can use the host's serial port to connect to programming hardware:
````
docker run --rm -ti -v /dev/tty.WHATEVER:/dev/tty.WHATEVER -v `pwd`:/work /bin/bash
````.
