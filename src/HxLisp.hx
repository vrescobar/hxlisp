package;


import hxlisp.SExpr;
import hxlisp.SExpr;
import hxlisp.Environment;
import hxlisp.Eval.*;
import hxlisp.Parser.*;
import hxlisp.SExpr.SExprUtils.*;






class HxLisp {
    static function main() {
        //var i = parse("(begin (define r 10) (* pi (* r r)))");
        var env = new Environment();
        var tree:SExpr = mkSexpr(parse("(/ 1 2)"));
        var a = SExpr.List(sexpr_values(tree)[0]);
        var program = eval(a, env.std_env);
        trace('${tree} -> ${program}');
    }

}






