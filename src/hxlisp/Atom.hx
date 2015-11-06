package hxlisp;


enum SExpr {
    Number(i:Float);
    Symbol  (s:String);
    Nil;
    List  (ss:Array<SExpr>);
}


class Atom {
    static public function Atom(token:String) {
        return atom(token);
    }
    static public function atom(token:String){
        // Should that allow an unvalid token such a "[" ?
        var maybeFloat = Std.parseFloat(token);
        if (!Math.isNaN(maybeFloat)) {
            return SExpr.Number(maybeFloat);
        }
        // Lists are created explicitly in the parse function
        return SExpr.Symbol(token);
    }
}


/*
// Haxe does not support Pairs by default I think
// ANd that is a work in progress:
typedef SExp = Array<Pair<Atom,SExp>>;
enum Atom {
    Int;
    String;
    Bool;
}
*/