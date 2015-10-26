package hxlisp;

enum Atom {
    Number(n:Float);
    Symbol(s:String);
    List(l:Array<Atom>);
}

class AtomHelper {
    static public function atom(token:String):Atom {
        return Atom.Number(Std.parseInt(token));
    }
}


abstract Number(Float) {
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