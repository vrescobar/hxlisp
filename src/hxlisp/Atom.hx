package hxlisp;

typedef SExp = Array<Dynamic> // I believe that should be Array<Atom>
enum Atom {
    Number(n:Float);
    Symbol(s:String);
    List(l:SExp);
}

class AtomHelpers {
    static public function atom(token:String):Atom {
        // Should that allow an unvalid token such a "[" ?
        var maybeFloat = Std.parseFloat(token);
        if (!Math.isNaN(maybeFloat)) {
            return Atom.Number(maybeFloat);
        }

        // Lists are created explicitly in the parse function
        return Atom.Symbol(token);
    }
}

/*enum SExp {
    Atom;
    Sexp;
}*/

/*abstract toNumber(Float) {
    inline public function new(x:String){
        var maybeInt = Std.parseInt(x);
        if (Std.is(maybeInt, Int)) {
            this = maybeInt;
        } else {
            var maybeFloat = Std.parseFloat(x);
            if (Std.is(maybeFloat, Float)) {
                this = maybeFloat;
            }
            throw('Cannot parse Number: "${x}"');
        }

    }
}*/


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