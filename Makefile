
build: clean
	haxe -cp src/ -main HxLisp -js build/js/hxlisp.js -dce full #--no-inline
	node build/js/hxlisp.js
test:
	haxe -cp src/ -cp tests/ -main TestCaseMain -neko build/neko/test.n -dce full #--no-inline
	/usr/local/bin/neko build/neko/test.n
test-all:
	haxe -cp src/ -cp tests/ -main TestCaseMain -neko build/neko/test.n -dce full #--no-inline
	/usr/local/bin/neko build/neko/test.n
	haxe -cp src/ -cp tests/ -main TestCaseMain -java build/java/ -dce full #--no-inline
	java -jar build/java/TestCaseMain.jar
	haxe -cp src/ -cp tests/ -main TestCaseMain -cpp build/cpp/ -dce full #--no-inline
	./build/cpp/TestCaseMain
clean:
	rm -rf out/ build/
