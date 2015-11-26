package hxlisp;

import haxe.io.Eof;
import hxlisp.Environment;
import hxlisp.Eval.*;
import hxlisp.Parser.*;
import hxlisp.SExpr;
import hxlisp.SExpr.SExprUtils.*;

class REPL {
    private var input:Dynamic;
    private var output:Dynamic;
    private var env:Dynamic;

    public function new(input, output) {
        this.output = function(x:String) { return output(' ${x}\n'); };
        this.input = function() {
                            output('hxlisp => ');
                            return input(); };
        this.env = new Environment();
    }
    public function loop() {
        while (true) {
            try {
                var inp:String = this.input();
                if (inp.length == 0) continue;
                var tree:SExpr = mkSexpr(parse(inp));
                var a = SExpr.List(sexpr_values(tree)[0]);
                var program = eval(a, env.std_env);
                this.output(program);
            } catch(eof:Eof) {
                break;
            } catch(error:Dynamic) {
                trace(error);
            }
        }
    }
}
