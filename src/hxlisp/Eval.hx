package hxlisp;

import hxlisp.Environment.Callable;
import hxlisp.SExpr;
import hxlisp.SExpr.SExprUtils.*;

class Eval {
    public static function eval(expr:SExpr, env:Map<SExpr.SExpr, Dynamic>):Dynamic {
        return switch (expr) {
            case SExpr.List(ss): {
                var func:Callable = env.get(ss[0]);
                var args:Array<Dynamic> = sexpr_values(expr);
                var result:Dynamic = func.func(args.slice(1));
                toSexpr(Std.string(result));

            }
            case SExpr.Symbol(name): Symbol(name);
            default: expr;
        }
    }
    static function func2(func:Dynamic, args:Dynamic) {
        trace(func, args);
    }
}
