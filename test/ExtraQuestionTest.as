package
{
    public class ExtraQuestionTest
    {
        [Test]
        public function test1():void
        {
            //At first we have an XML node with 5 children nodes. Each one contains attribute 'myVal' and element value 'data'
            var xmlData:XML =
                    <root>
                        <node myVal="1">data</node>
                        <node myVal="2"> data </node>
                        <node myVal="3"> data </node>
                        <node myVal="4"> data </node>
                        <node myVal="5"> data </node>
                    </root>;

            //following code illustrates one of the powerful features in Action Script 3 named "Traversing XML structures"
            // it prints:
            // 1
            // 3
            // 5
            xmlData.children().(@myVal % 2 && trace(@myVal));
            //                ^
            //                |
            //the dot operator here in combination with parentheses operators used to filter XMLListElements with a specific attribute value
            //every time the first filter condition is satisfied (remainder of attribute value divided by 2 not equal to zero),
            //the trace function is called as right-side expression of logical AND operator
        }

        [Test (expects="ReferenceError")]
        public function test2():void
        {
            //so whats wrong with it? Lets imagine that someone added new node to our XML
            var xmlData:XML =
                    <root>
                        <node myVal="1">data</node>
                        <node myVal="2"> data </node>
                        <node myVal="3"> data </node>
                        <node myVal="4"> data </node>
                        <node myVal="5"> data </node>
                        <node > data </node>                        //here
                    </root>;
            xmlData.children().(@myVal % 2 && trace(@myVal));  //throws ReferenceError: Error #1065: Variable myVal is not defined.
        }

        [Test]
        public function test3():void
        {
            var xmlData:XML =
                    <root>
                        <node myVal="1">data</node>
                        <node myVal="2"> data </node>
                        <node myVal="3"> data </node>
                        <node myVal="4"> data </node>
                        <node myVal="5"> data </node>
                        <node > data </node>
                    </root>;

            //to avoid the ReferenceError, we can use attribute(attributeName) method instead of @attributeName
            xmlData.children().(Number(attribute('myVal')) % 2 && trace(attribute('myVal')));
        }
    }
}
