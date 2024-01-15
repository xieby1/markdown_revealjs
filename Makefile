README.html: README.md
	revealjs.sh $<

clean:
	rm -f README.html
