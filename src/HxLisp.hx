package;

import hxlisp.Atom;
import hxlisp.Atom.SExp;
import hxlisp.Atom.AtomHelpers.*;
import hxlisp.Parser.*;

class HxLisp {
    static function main() {
        var i = parse("(begin (define r 10) (* pi (* r r)))");
        trace('i: "${i}"');

    }
}
