all: README.html $(subst .md,.html,$(wildcard ./themes/*.md))

README.html: README.md plots/plotlypy.html
%.html: %.md
	./bin/revealjs.sh $<

clean:
	rm -f README.html

%.html: %.py
	python3 $<
	html-minifier --collapse-whitespace -o $@.tmp $@
	mv $@.tmp $@
