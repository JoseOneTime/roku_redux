BIN = node_modules/.bin

.PHONY: all run test clean

all: scraper/js/index.js

scraper/js/%.js: scraper/coffee/%.coffee
	$(BIN)/coffee -co $(@D) $<

run: scraper/js/index.js
	node $<

test:
	$(BIN)/jasmine-node --coffee --verbose spec

clean:
	rm -f scraper/js/*
