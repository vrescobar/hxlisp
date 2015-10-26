package hxlisp;

import hxlisp.Atom;

class Parser {
    static public function parse(input:String):Array<String>{
        if (input.length == 0) return [];
        return [input];
    }
    static public function read_from_tokens(strtokens:Array<String>):Array<Dynamic> {
        return [1];
    }
    static public function atom(token:String):Atom {
        return Atom.Number(Std.parseInt(token));
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
