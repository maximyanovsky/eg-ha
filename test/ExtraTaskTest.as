package
{
    import org.hamcrest.assertThat;
    import org.hamcrest.collection.array;

    public class ExtraTaskTest
    {
        private static function extraTask(a:Array, b:Array):Array
        {
            var retval:Array = [];
            var sortingOrder:int = findSortOrder(a) || findSortOrder(b);

            if (sortingOrder == 0)
            {
                //if all elements of A are equal and all elements of B are equal too
                //then we cannot choose sort order of the resulting array, so let it be ascending
                sortingOrder = 1;
            }
            var aLength:int = a.length;
            var bLength:int = b.length;
            var index:int = 0;
            var aIndex:int = 0;
            var bIndex:int = 0;

            while (aIndex < aLength && bIndex < bLength)
            {
                if (a[aIndex] == b[bIndex])
                {
                    retval[index++] = a[aIndex++];
                    retval[index++] = b[bIndex++];
                }
                else
                {
                    if (a[aIndex] < b[bIndex])
                        retval[index++] = sortingOrder > 0 ? a[aIndex++] : b[bIndex++];
                    else
                        retval[index++] = sortingOrder < 0 ? a[aIndex++] : b[bIndex++];
                }
            }
            while (aIndex < aLength) retval[index++] = a[aIndex++];
            while (bIndex < bLength) retval[index++] = b[bIndex++];
            return retval;
        }

        /**
         * Finds sort order of given array
         * @param a
         * @return -1 desc, +1 asc, 0 unknown
         */
        [Inline]
        private static function findSortOrder(a:Array):int
        {
            var lastAValue:int;
            var l:int = a.length;
            lastAValue = a[0];
            for (var i:int = 1; i < l; ++i)
            {
                if (a[i] > lastAValue)
                {
                    return 1;
                }
                else if (a[i] < lastAValue)
                {
                    return -1;
                }
                else
                    lastAValue = a[i];
            }
            return 0;
        }


        [Test]
        public function shouldReturnPredefinedValue():void
        {
            var tests:Array = [
                {
                    a: [],
                    b: [],
                    result: []
                },
                {
                    a: [1],
                    b: [],
                    result: [1]
                },
                {
                    a: [1],
                    b: [1],
                    result: [1, 1]
                },
                {
                    a: [1],
                    b: [2],
                    result: [1, 2]
                },
                {
                    a: [1, 2],
                    b: [2],
                    result: [1, 2, 2]
                },
                {
                    a: [1, 2],
                    b: [2],
                    result: [1, 2, 2]
                },
                {
                    a: [1, 1, 1, 100, 101, 102],
                    b: [0, 2, 2, 99, 103],
                    result: [0, 1, 1, 1, 2, 2, 99, 100, 101, 102, 103]
                },
                {
                    a: [1, 102],
                    b: [103],
                    result: [1, 102, 103]
                }
            ];


            for (var i:int = 0; i < tests.length; i++)
            {
                var test:Object = tests[i];
                var result:Array = extraTask(test.a, test.b);
                assertThat("test " + i, result, array.apply(null, test.result));
            }
        }

        [Test]
        public function syntheticTestBigArrays():void
        {
            syntheticTest(1000, int.MAX_VALUE)
        }

        [Test]
        public function syntheticTestSmallArrays():void
        {
            syntheticTest(10, 10)
        }

        private function syntheticTest(maxArrayLength:int, maxArrayValue:int):void
        {
            function randomArray(length:int, maxValue:int):Array
            {
                var retval:Array = [];
                while (retval.length < length)
                    retval.push(int((Math.random() * 2 - 1) * maxValue ));
                return retval;
            }

            for (var i:int = 0; i < 1000; i++)
            {
                var sort:int = Math.random() > 0.5 ? Array.NUMERIC | Array.DESCENDING : Array.NUMERIC;

                var a:Array = randomArray(int(Math.random() * maxArrayLength), maxArrayValue);
                var b:Array = randomArray(int(Math.random() * maxArrayLength), maxArrayValue);

                if (findSortOrder(a) == 0 && findSortOrder(b) == 0)
                    sort = Array.NUMERIC;

                var result:Array = a.concat(b);

                a.sort(sort);
                b.sort(sort);
                result.sort(sort);

                assertThat("test " + i, extraTask(a, b), array.apply(null, result));
            }
        }

    }
}
