import hxlisp.Parser.*;
import hxlisp.Atom;
import hxlisp.Atom.AtomHelpers.*;
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
    public function testAtomFloats() {
        this.assertTypes(atom("0"), 0);
        this.assertTypes(atom("14"), 14);
        this.assertTypes(atom("0.32"), 0.32);
        this.assertTypes(atom("-990.3123000002"), -990.3123000002);
    }
    public function testAtomStrings() {
        this.assertTypes(atom("a"), "a");
        this.assertTypes(atom("blablabla!"), "blablabla!");
        this.assertTypes(atom("Int->Float"), "Int->Float");


    }
}

class TestCaseMain {
    static function main() {
        var r = new haxe.unit.TestRunner();
        r.add(new TestParser());
        r.run();
    }
}