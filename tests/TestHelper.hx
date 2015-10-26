import hxlisp.Atom;


class TestHelper extends haxe.unit.TestCase {
    public function assertArrays(arrA:Array<Dynamic>, arrB:Array<Dynamic>) {
        return this.assertTrue(_assertArrays(arrA, arrB));
    }
    private function _assertArrays(arrA:Array<Dynamic>,arrB:Array<Dynamic>):Bool {
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
                if (!_assertArrays(arrA[pos], arrB[pos])) {
                    trace("Nested Arrays differ:\n" + arrA[pos] + "\n" + arrB[pos]);
                    return false;
                }
                continue;
            }
            if (arrA[pos]!= arrB[pos]) {
                trace('Arrays differ in position ${pos}:\n'+ arrA + "\n" + arrB);
                return false;
            }
        }
        return true;
    }

    public function assertTypes(original_atom:Atom, atom:Dynamic){
        switch original_atom {
            case Atom.Number(n): assertEquals(n,atom);
            case Atom.Symbol(s):  assertEquals(s, atom);
            //case Atom.List(l):  assertArrays(l, atom);
        }

    }
}