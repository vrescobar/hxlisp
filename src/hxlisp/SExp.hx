package hxlisp;

// Haxe does not support Pairs by default I think
enum Pair<A,B> {
    A;
    B;
}

 // ANd that is a work in progress:
typedef SExp = Array<Pair<Atom,SExp>>;
enum Atom {
    Int;
    String;
    Bool;
}
