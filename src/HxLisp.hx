package;


import hxlisp.Environment;
/*import hxlisp.Symbol;
import hxlisp.Symbol.SymbolHelpers.*;
import hxlisp.Parser.*;
*/





class HxLisp {
    static function main() {
        //var i = parse("(begin (define r 10) (* pi (* r r)))");
        //trace('i: "${i}"');
        var env = new Environment();

        //trace('list? ${isList(a)}');
//(a (b c) d)
        trace(List([ Symbol("a")
        , List([ Symbol("b")
        , Symbol("c")
        ])
        , Symbol("d")
        ]));

//(add 5 10 15)
        var a:SExpr = List([ Symbol("add")
        , Number(5)
        , Number(10)
        , Number(15)]);
        for (el in switch (a) {
            case List(ss): ss;
            default: [];
        }) {
            trace ("elem: " + el);
        }

//(cdr (cons 10 (cons 5 nil)))
        trace(List([ Symbol("cdr")
        , List([ Symbol("cons")
        , Number(10)
        , List([ Symbol("cons")
        , Number(15)
        , Symbol("nil")])])]));


    }

}






