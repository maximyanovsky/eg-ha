package eghomeassignment.utils
{
    internal class PackResult
    {
        public static const STATUS_FIT:String = "fit";
        public static const STATUS_UNFIT:String = "unfit";

        public var status:String;
        public var whitespace:Number = 0;
        public var unfitspace:Number = 0;

        public function toString():String
        {
            return status + "(white: " + whitespace + ", unfit: " + unfitspace + ")";
        }
    }
}
