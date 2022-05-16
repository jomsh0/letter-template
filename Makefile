PUB := _pub

default: index.html fonts.css

pub: $(PUB)/index.html $(PUB)/style.css $(PUB)/fonts.css

# sed -E 's/<\/?del>//g'

index.html: letter.md
	cmark-gfm --smart --unsafe -e strikethrough $< | sed -E 's/<del>[^<]+<\/del>/------/g' > $@

fonts.css: fonts.sh.css fonts/*/stylesheet.css
	esh $< > $@

$(PUB)/%: %
	cp -au $< $@
