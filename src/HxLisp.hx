package;

import hxlisp.Parser.*;

class HxLisp {
    static function main() {
        var str1 = "(2134684 rulesy)";
        trace('str1: "${tokenize(str1)}"');
    }
}
