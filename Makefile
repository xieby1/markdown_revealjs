README.html: README.md plots/plotlypy.html
	revealjs.sh $<

clean:
	rm -f README.html

%.html: %.py
	python3 $<
	html-minifier --collapse-whitespace -o $@.tmp $@
	mv $@.tmp $@
