import hxlisp.SExpr;
import hxlisp.Environment;
import hxlisp.Parser.*;
import hxlisp.SExpr.SExprUtils.*;
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
    public function test_parse() {
        this.assertArrayTypes(parse(""), []);
        this.assertArrayTypes(parse("(begin (define r 10) (* pi (* r r)))"), [['begin', ['define', 'r', 10], ['*', 'pi', ['*', 'r', 'r']]]]);
    }
    public function testReader() {
        this.assertArrayTypes(read_from_tokens([]), []);
        this.assertArrayTypes(read_from_tokens(["1"]), [1]);
        this.assertArrayTypes(read_from_tokens(["0.15"]), [0.15]);
        this.assertArrayTypes(read_from_tokens(["1", "2"]), [1, 2]);
        this.assertArrayTypes(read_from_tokens(["-1.44", "9"]), [-1.44, 9]);
        this.assertArrayTypes(read_from_tokens(["(", ")"]), [[]]);
        this.assertArrayTypes(read_from_tokens(["(", "3", ")"]), [[3]]);
        this.assertArrayTypes(read_from_tokens(["(", ")","(", ")"]), [[],[]]);
        this.assertArrayTypes(read_from_tokens(["(","def","i","0", ")","(", ")"]), [["def", "i", 0],[]]);
        this.assertArrayTypes(read_from_tokens(["(", "(", ")", ")"]), [[[]]]);
        this.assertArrayTypes(read_from_tokens(["(", "(", "(", ")", ")", ")"]), [[[[]]]]);
        this.assertArrayTypes(read_from_tokens(["(", "(", "(", "a", ")", ")", ")"]), [[[["a"]]]]);
        this.assertArrayTypes(read_from_tokens(["(", "1", "(", "(", "a", ")", ")", ")"]), [[1,[["a"]]]]);
        this.assertArrayTypes(read_from_tokens(["-1.44", "9", "(", "0.001", "3", ")"]), [-1.44, 9, [0.001, 3]]);
    }
    public function testAtomFloats() {
        this.assertTypes(toSexpr("0"), 0);
        this.assertTypes(toSexpr("14"), 14);
        this.assertTypes(toSexpr("0.32"), 0.32);
        this.assertTypes(toSexpr("-990.3123000002"), -990.3123000002);
    }
    public function testAtomStrings() {
        this.assertTypes(toSexpr("a"), "a");
        this.assertTypes(toSexpr("blablabla!"), "blablabla!");
        this.assertTypes(toSexpr("Int->Float"), "Int->Float");
    }
}

class TestSExpr extends TestHelper {
    public function test_Enum2Symbol(){
        var List = SExpr.List;
        this.assertArrays(sexpr_values(List([])), []);
        this.assertArrays(sexpr_values(List([List([])])), [[]]);
        this.assertArrays(sexpr_values(List([Symbol("add"), Number(5), Number(10), Number(15)])),
                          ["add", 5, 10, 15]);
        this.assertArrays(sexpr_values(List([Symbol("a"), List([ Symbol("b"), Symbol("c")]), Symbol("d")])),
                          ["a", ["b", "c"], "d"]);

        this.assertArrays(sexpr_values(List([Symbol("cdr"), List([Symbol("cons"), Number(10), List([ Symbol("cons"), Number(15), Nil])])])),
                                       ["cdr", ["cons", 10, ["cons", 15, false]]]);
    }
}
class TestRoots extends TestHelper {

    public function testBasics(){
        var env = new Environment();
        this.assertTrue(true);
        //this.assertEquals(Std.string(env.stdenv(toSexpr("quote"))("a")), Std.string(toSexpr("a")));
        //this.assertTypes(env.stdenv(toSexpr("quote"))("abc") , "abc");
        //this.assertTypes(env.stdenv(toSexpr("quote"))("abc") , "abc");
    }
}

class TestCaseMain {
    static function main() {
        var r = new haxe.unit.TestRunner();
        r.add(new TestParser());
        r.add(new TestRoots());
        r.add(new TestSExpr());
        r.run();
    }
}