package hxlisp;

import hxlisp.SExpr;
import hxlisp.SExpr.SExprUtils.*;

class Eval {
    public static function eval(expr:SExpr, env:Map<SExpr.SExpr, Dynamic>):Dynamic {
        return switch (expr) {
            /*case SExpr.Nil: false;
            case SExpr.Number(n): n;
            case SExpr.Symbol(s): s;*/
            //case SExpr.List(ss): env.get(ss[0])(ss.slice(1))
            case SExpr.List(ss): {
                var func = env.get(ss[0]);
                var first = sexpr_values(ss[1]);
                var second = sexpr_values(ss[2]);
                var result = func(first, second);
                toSexpr(Std.string(result));

            }
            default: expr;
        }
    }
}
