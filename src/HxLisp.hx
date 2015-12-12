package;


//import hxlisp.Environment;
import hxlisp.REPL;
import hxlisp.SExpr;
import Sys;

import sys.io.FileInput;



class HxLisp {
    static function main() {
        //trace(Reflect.getProperty(Environment, "__rtti"));
        var stdin = Sys.stdin();
        var repl = new REPL(stdin.readLine, Sys.print);
        repl.loop();
        stdin.close();
        Sys.println("Bye!");

    }

}






