.PHONY: all clean

all: hdstuck.user.js

hdstuck.user.js: header.js fullscreen.js
	cat $^ > $@

%.js: %.ls
	lsc -c "$<"

clean:
	-rm hdstuck.user.js
	-rm fullscreen.js
