package hxlisp;


enum SExpr {
    Nil;
    Number (i:Float);
    Symbol (s:String);
    List   (ss:Array<SExpr>);
}


class SExprUtils {
    static public function SExprUtils(token:String) {
        return toSexpr(token);
    }
    static public function toSexpr(token:String){
        // Should that allow an unvalid token such a "[" ?
        var maybeFloat = Std.parseFloat(token);
        if (!Math.isNaN(maybeFloat)) {
            return SExpr.Number(maybeFloat);
        }
        // Lists are created explicitly in the parse function
        return SExpr.Symbol(token);
    }
    static public function sexpr_values(original_atom:SExpr):Dynamic{
        return switch original_atom {
            case SExpr.Nil: false;
            case SExpr.Number(n): n;
            case SExpr.Symbol(s): s;
            case SExpr.List(ss): {
                    // if (ss.length == 0) false // here is maybe a bug
                    [for (sexpr in ss) sexpr_values(sexpr)];
                    };
    }
    }
}