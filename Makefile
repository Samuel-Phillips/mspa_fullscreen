export PATH := $(PATH):$(abspath node_modules/.bin)
.PHONY: all clean

all: hdstuck.user.js

hdstuck.user.js: header.js bundle.js
	cat $^ > $@

bundle.js: fullscreen.js $(wildcard site_specific/*.js) site_specific.js
	rollup $< --format iife --output $@

site_specific.js: build_site_specific.sh $(wildcard site_specific/*.ls)
	./$< > $@

%.js: %.ls
	lsc -cp $< > $@

clean:
	-rm hdstuck.user.js
	-rm fullscreen.js
	-rm bundle.js
	-rm $(wildcard site_specific/*.js)
