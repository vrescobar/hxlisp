import hxlisp.Parser.*;
import hxlisp.Types;

import haxe.unit.TestCase;

import TestHelper;


class TestParser extends TestHelper {
    public function testTokenizer(){
        this.assertArrays(tokenize(""), []);
        this.assertArrays(tokenize(" "), []);
        this.assertArrays(tokenize("     "), []);
        this.assertArrays(tokenize("   \n  "), []);
        this.assertArrays(tokenize("  \n\t \t\n  "), []);
        this.assertArrays(tokenize("("), ["("]);
        this.assertArrays(tokenize(")"), [")"]);
        this.assertArrays(tokenize(")  ("), [")", "("]);
        this.assertArrays(tokenize("()"), ["(", ")"]);
        this.assertArrays(tokenize("1"), ["1"]);
        this.assertArrays(tokenize("32"), ["32"]);
        this.assertArrays(tokenize(" 0 65"), ["0", "65"]);
        this.assertArrays(tokenize("abc def"), ["abc", "def"]);
        this.assertArrays(tokenize("isBool? true"), ["isBool?", "true"]);
        this.assertArrays(tokenize("-> <|> &%"), ["->", "<|>", "&%"]);
        this.assertArrays(tokenize("(object.method arg1 arg2)"), ['(', 'object.method', 'arg1', 'arg2', ')']);
        this.assertArrays(tokenize("(abc (def ghi))"), ["(","abc","(","def","ghi",")", ")"]);
        this.assertArrays(tokenize("(begin (define r 10) (* pi (* r r)))"), [
                                                                  '(', 'begin', '(', 'define', 'r', '10', ')',
                                                                  '(', '*', 'pi', '(', '*', 'r', 'r', ')', ')', ')']);
    }
    public function testAtomizer() {
        this.assertEquals(atom("0"), Atom.Number(0));
        //this.assertEquals(atom("14"), Atom.Number(14));
        //this.assertEquals(atom("a"), Atom.Symbol("a"));
        //this.assertTrue(parse("a", ["a"]));
        //this.assertEquals(parse("a"), ["a"]));


    }
}

class TestCaseMain {
    static function main() {
        var r = new haxe.unit.TestRunner();
        r.add(new TestParser());
        r.run();
    }
}