import Array;
import hxlisp.Atom;


class TestHelper extends haxe.unit.TestCase {
    public function assertArrays(arrA:Array<Dynamic>, arrB:Array<Dynamic>) {
        return this.assertTrue(_assertArrays(arrA, arrB, function(a,b) {return a!=b;}));
    }
    private function _assertArrays(arrA:Array<Dynamic>,arrB:Array<Dynamic>, asserter):Bool {
        if (arrA.length != arrB.length) {
            trace('Both arrays have different size (${arrA.length} and ${arrB.length}):\n${arrA}\n${arrB}');
            return false;
        }
        for (pos in 0...arrA.length) {
            if (Std.is(arrA[pos], Array)) {
                if (!Std.is(arrB[pos], Array)) {
                    trace('Subtype is different at ${pos}:\n' + arrA + "\n" + arrB);
                    return false;
                }
                if (!_assertArrays(arrA[pos], arrB[pos], asserter)) {
                    trace("Nested Arrays differ:\n" + arrA[pos] + "\n" + arrB[pos]);
                    return false;
                }
                continue;
            }
            if (asserter(arrA[pos], arrB[pos])) {
                trace('Arrays differ in position ${pos}:\n'+ arrA + "\n" + arrB);
                return false;
            }
        }
        return true;
    }

    public function assertArrayTypes(original_atom:Array<Atom>, atomArr:Array<Dynamic>){
        return this.assertTrue(_assertArrays(original_atom, atomArr, function(a,b){return enumExtract(a)!=b;}));
    }
    public function assertTypes(original_atom:Atom, bare_type:Dynamic){
        return assertEquals(enumExtract(original_atom), bare_type);
    }
    private function enumExtract(original_atom:Atom):Dynamic{
        return switch original_atom {
            case Atom.Number(n): n;
            case Atom.Symbol(s): s;
            //case Atom.List(l):  assertArrays(l, atom);
        }


    }
}