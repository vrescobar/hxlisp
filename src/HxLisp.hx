package;

import hxlisp.Atom;
import hxlisp.Atom.SExp;
import hxlisp.Atom.AtomHelpers.*;
import hxlisp.Parser.*;

class HxLisp {
    static function main() {
        var str1 = "(2134684 rulesy)";
        var a:SExp = [atom("2"), Atom.List([])];
        var i = 34;
        trace('i: "${i}"');
        for (e in 0...20) { i = e;trace('i: "${i}"'); }
        trace('i2: "${i}"');
    }
}
