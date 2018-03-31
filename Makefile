.PHONY: all clean

export PATH:=$(abspath node_modules/.bin):$(PATH)

NM = node_modules/.bin/lsc


all: hdstuck.user.js

hdstuck.user.js: header.js fullscreen.js
	cat $^ > $@

%.js: %.ls $(NM)
	lsc -c "$<"

clean:
	-rm hdstuck.user.js
	-rm fullscreen.js

$(NM):
	npm install
