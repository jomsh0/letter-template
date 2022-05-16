PUB := github.io

default: index.html fonts.css

# sed -E 's/<\/?del>//g'

index.html: letter.md
	cmark-gfm --smart --unsafe -e strikethrough $< | sed -E 's/<del>[^<]+<\/del>/------/g' > $@


fonts.css: fonts.sh.css fonts/*/stylesheet.css
	esh $< > $@

