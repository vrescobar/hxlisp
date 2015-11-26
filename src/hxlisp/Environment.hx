package hxlisp;

import haxe.io.Eof;
import hxlisp.SExpr.SExpr.*;
import hxlisp.SExpr;
using hxlisp.SExpr;
import Math;

class Environment{
    public var std_env:Map<SExpr.SExpr, Dynamic>;
    public function new() {
        var env:Map<SExpr, Dynamic> = new Map();

        env.set(Symbol("quote"), function(x):SExpr { return x.toSexpr();});
        /*env.set(atom("atom"), function(x:String):Dynamic { return if (Std.is(x,Atom)) x else [];});
        // eq
        // car
        // cdr
        // cons
        // cond

        // define
        // lambda
        // let*/

        env.set(Symbol("+"), function(x,y) { return x+y;});
        env.set(Symbol("-"), function(x,y) { return x-y;});
        env.set(Symbol("*"), function(x,y) { return x*y;});
        env.set(Symbol("/"), function(x,y) { return x/y;});

        env.set(Symbol(">"), function(x,y) { return x>y;});
        env.set(Symbol("<"), function(x,y) { return x<y;});
        env.set(Symbol("="), function(x,y) { return x == y;});
        env.set(Symbol(">="), function(x,y) { return x>=y;});
        env.set(Symbol("<="), function(x,y) { return x<=y;});
        env.set(Symbol("exit"), function(x,y) { throw Eof;});

        env.set(Symbol("abs"), Math.abs);
        /*env.set(atom("append"), function(x,y) { return x.concat(y);}); //TODO: arrays?
        env.set(atom("apply"), function(func,args) { return Reflect.callMethod(d, func,args);});
        env.set(atom("begin"), function(x:Array<Dynamic>) { return x[x.length -1];});
        env.set(atom("car"), function(x) { return x[0];});
        env.set(atom("cdr"), function(x) { return x.slice(1);});
        env.set(atom("cons"), function(x,y) { return [x].push(y);});
        env.set(atom("eq?"), function(x,y) { return x == y;}); //TODO: arrays?
        env.set(atom("equal?"), function(x,y) { return x == y;}); //TODO: arrays?
        env.set(atom("lenght"), function(x) { return x.length;});
        //env.set(atom("list"), function(x):SExp { return mklist(x);}); //TODO: 'list':    lambda *x: list(x),
        env.set(atom("list?"), function(x) { return Std.is(x,SExp);});
//        'map':     map,
//        'max':     max,
//        'min':     min,
//        'not':     op.not_,
        env.set(atom("number?"), function(x) { return Std.is(x,Atom.Number);});
        env.set(atom("null?"), function(x) { return Std.is(x,Atom.Nil);});
        env.set(atom("null?"), function(x) { return Std.is(x,Atom.Symbol);});
        //env.set(atom("procedure?"), function(x) { return Std.is(x,Callable);});
//        'procedure?': callable,
//        'round':   round,*/
        this.std_env = env;

    }

    public function stdenv(f):Dynamic
    {
        if (!this.std_env.exists(f)) throw "Function not defined";
        return this.std_env.get(f);
    }
}

