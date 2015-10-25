
build: clean
	haxe -cp src/ -main HxLisp -js build/js/hxlisp.js -dce full --no-inline
	node build/js/hxlisp.js
test:
	haxe -cp src/ -cp tests/ -main TestCaseMain -neko build/neko/test.n -dce full #--no-inline
	/usr/local/bin/neko build/neko/test.n
clean:
	rm -rf out/ build/
