package hxlisp;

import hxlisp.Atom;
import hxlisp.Atom.AtomHelpers.*;

typedef Parse_result = { captured:Int, contents:Array<Dynamic> };

class Parser {
    static public function parse(input:String):Array<String>{
        if (input.length == 0) return [];
        return [input];
    }
    static public function read_from_tokens(strtokens:Array<String>):Array<Dynamic>{
        var read_t:Array<Dynamic> = [];
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
                read_t.push(atom(elem));
                pos += 1;
            }
        }
        return read_t;
    }

    static private function read_nested(strtokens:Array<String>, ?init_pos:Int=0):Parse_result{
        var read_t:Array<Dynamic> = [];
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

    inline static function isSeparator(str:String) {
        var regex = ~/^[()]{1}/u;
        return if (!regex.match(str)) 0; else regex.matchedPos().len;
    }
    inline static function trailSpace(str:String){
        var regex = ~/^[\n\t ]+/u;
        return if (!regex.match(str)) 0; else regex.matchedPos().len;
    }
    inline static function isNumber(str:String):Int {
        var regex = ~/^[0-9]+/u;
        return if (!regex.match(str)) 0; else regex.matchedPos().len;
    }
    inline static function isSymbol(str:String):Int {
        var regex = ~/^[a-z-A-Z0-9?\-*-><|>&%.]+/u;
        return if (!regex.match(str)) 0; else regex.matchedPos().len;
    }
    public static function tokenize(input:String):Array<String> {
        var tokens = [];
        if (input.length == 0) return [];
        if (trailSpace(input)>0) {
            var tmp = tokenize(input.substr(1));
            return tokens.concat(tmp);
        }
        var separator = isSeparator(input);
        if (separator>0) {
            var tmp = tokenize(input.substr(separator));
            return tokens.concat([input.substr(0,separator)]).concat(tmp);
        }
        var number = isNumber(input);
        if (number>0) {
            return tokens.concat([input.substr(0,number)]).concat(tokenize(input.substr(number)));
        }
        var symbol = isSymbol(input);
        if (symbol>0) {
            return tokens.concat([input.substr(0,symbol)]).concat(tokenize(input.substr(symbol)));
        }
        throw 'Don\'t know how to parse that element: ${input.substr(0,15)}...';
        return []; // type system requires it
    }
}
