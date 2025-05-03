all: README.html $(subst .md,.html,$(shell find ./themes/ -name "index.md"))

README.html: README.md plots/plotlypy.html
%.html: %.md
	./bin/revealjs.sh $<

clean:
	rm -f README.html

%.html: %.py
	python3 $<
	html-minifier --collapse-whitespace -o $@.tmp $@
	mv $@.tmp $@
