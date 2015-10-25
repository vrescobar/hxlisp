class TestHelpers {
    static public function assertArrays(arrA:Array<Dynamic>,arrB:Array<Dynamic>):Bool {
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
                if (!assertArrays(arrA[pos], arrB[pos])) {
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
}