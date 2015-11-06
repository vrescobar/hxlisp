package hxlisp;

import hxlisp.Atom;
import hxlisp.Atom.Atom.*;

typedef Parse_result = { captured:Int, contents:Dynamic };

class Parser {
    static public function parse(input:String):Dynamic{
        if (input.length == 0) return [];
        return read_from_tokens(tokenize(input));
    }
    static public function read_from_tokens(strtokens:Array<String>):Dynamic{
        var read_t:Dynamic = [];
        var pos = 0;
        while (pos < strtokens.length) {
            var elem = strtokens[pos];
            if (elem == ")") { // premature closing
                throw "Error, found a closing parenthesis when none was open";

            }
            if (elem == "(") {
                pos += 1;
                var nt = read_nested(strtokens, pos);
                pos += nt.captured; // Do not repeat what already made other one
                read_t.push(nt.contents);
                continue;
            } else {
                // Should tokens be here allowed? for a REPL I think so
                read_t.push(atom(elem));
                pos += 1;
            }
        }
        return read_t;
    }

    static private function read_nested(strtokens:Array<String>, ?init_pos:Int=0):Parse_result{
        var read_t:Dynamic = [];
        var pos = init_pos;
        while (pos < strtokens.length) {
            var elem = strtokens[pos];
            pos += 1;
            if (elem == ")") {
                break; // we finished the nest
            }
            if (elem == "(") {
                var nt = read_nested(strtokens, pos);
                pos += nt.captured;
                read_t.push(nt.contents);
                continue;
            } else {
                read_t.push(atom(elem));
            }
        }
        return { captured: pos - init_pos, contents: read_t };
    }
    inline static function new_rule(reg:EReg): String -> Int {
        return function (str:String):Int {
            return if (!reg.match(str)) 0; else reg.matchedPos().len;
        }
    }

    public static function tokenize(input:String):Array<String> {
        var tokens = [];
        var isSeparator = new_rule(~/^[()]{1}/u);
        var isSymbol = new_rule(~/^[a-z-A-Z0-9?\-*-><|>&%.]+/u);
        var trailSpace = new_rule(~/^[\n\t ]+/u);
        var isNumber = new_rule(~/^[0-9]+/u);

        if (input.length == 0) return [];
        if (trailSpace(input)>0) {
            return tokens.concat(tokenize(input.substr(1)));
        }

        for (rule_catcher in [isSeparator, isNumber, isSymbol]) {
            var chars_catched = rule_catcher(input);
            if (chars_catched>0) {
                return tokens.concat([input.substr(0,chars_catched)]).concat(tokenize(input.substr(chars_catched)));
            }
        }
        throw 'Don\'t know how to parse that element: ${input.substr(0,15)}...';
        return []; // type system requires it
    }
}
