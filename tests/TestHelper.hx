import Array;
import hxlisp.SExpr;
import hxlisp.SExpr.SExprUtils.*;



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

    public function assertArrayTypes(original_atom:Array<Dynamic>, atomArr:Array<Dynamic>){
        return this.assertTrue(_assertArrays(original_atom, atomArr, function(a,b){return sexpr_values(a)!=b;}));
    }
    public function assertTypes(original_atom:SExpr, bare_type:Dynamic){
        return this.assertEquals(sexpr_values(original_atom), bare_type);
    }
}