cpp:
	# haxe -cp src/ -main HxLisp -D static_link -cpp build/cpp/hxlisp -lib hxcpp -dce full
	haxe -cp src/ -main HxLisp -cpp build/cpp/hxlisp -lib hxcpp -dce full
	./build/cpp/hxlisp/HxLisp

neko:
	# haxe -cp src/ -main HxLisp -D static_link -cpp build/cpp/hxlisp -lib hxcpp -dce full
	haxe -cp src/ -main HxLisp -neko build/neko/hxlisp.n -dce full
	neko ./build/neko/hxlisp.n

test:
	haxe -cp src/ -cp tests/ -main TestCaseMain -neko build/neko/test.n -dce full #--no-inline
	/usr/local/bin/neko build/neko/test.n
test-all:
	haxe -cp src/ -cp tests/ -main TestCaseMain -neko build/neko/test.n -dce full #--no-inline
	/usr/local/bin/neko build/neko/test.n
	#haxe -cp src/ -cp tests/ -main TestCaseMain -java build/java/ -dce full #--no-inline
	#java -jar build/java/TestCaseMain.jar
	haxe -cp src/ -cp tests/ -main TestCaseMain -cpp build/cpp/ -dce full #--no-inline
	./build/cpp/TestCaseMain
clean:
	rm -rf out/ build/
