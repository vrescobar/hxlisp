import hxlisp.Parser.*;
import haxe.unit.TestCase;

using TestHelpers;


class TestParser extends haxe.unit.TestCase {
    public function testTokenizer(){
        this.assertTrue(tokenize("").assertArrays([]));
        this.assertTrue(tokenize(" ").assertArrays([]));
        this.assertTrue(tokenize("     ").assertArrays([]));
        this.assertTrue(tokenize("   \n  ").assertArrays([]));
        this.assertTrue(tokenize("  \n\t \t\n  ").assertArrays([]));
        this.assertTrue(tokenize("(").assertArrays(["("]));
        this.assertTrue(tokenize(")").assertArrays([")"]));
        this.assertTrue(tokenize(")  (").assertArrays([")", "("]));
        this.assertTrue(tokenize("()").assertArrays(["(", ")"]));
        this.assertTrue(tokenize("1").assertArrays(["1"]));
        this.assertTrue(tokenize("32").assertArrays(["32"]));
        this.assertTrue(tokenize(" 0 65").assertArrays(["0", "65"]));
        this.assertTrue(tokenize("abc def").assertArrays(["abc", "def"]));
        this.assertTrue(tokenize("isBool? true").assertArrays(["isBool?", "true"]));
        this.assertTrue(tokenize("-> <|> &%").assertArrays(["->", "<|>", "&%"]));
        this.assertTrue(tokenize("(object.method arg1 arg2)").assertArrays(['(', 'object.method', 'arg1', 'arg2', ')']));
        this.assertTrue(tokenize("(abc (def ghi))").assertArrays(["(","abc","(","def","ghi",")", ")"]));
        this.assertTrue(tokenize("(begin (define r 10) (* pi (* r r)))").assertArrays([
                                                                  '(', 'begin', '(', 'define', 'r', '10', ')',
                                                                  '(', '*', 'pi', '(', '*', 'r', 'r', ')', ')', ')']));
    }
    public function testParser() {
        //tokenize(program)
        //['(', 'begin', '(', 'define', 'r', '10', ')', '(', '*', 'pi', '(', '*', 'r', 'r', ')', ')', ')']

        this.assertTrue(parse("").assertArrays([]));
        //this.assertTrue(parse("a").assertArrays(["a"]));
        //this.assertEquals(parse("a"), ["a"]);


    }
}

class TestCaseMain {
    static function main() {
        var r = new haxe.unit.TestRunner();
        r.add(new TestParser());
        r.run();
    }
}