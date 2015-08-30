package eghomeassignment.services.network
{
    public class NetworkServiceDataFormat
    {
        public static const TEXT:String = "text";
        public static const BINARY:String = "binary";

        public static function isValid(format:String):Boolean
        {
            return format == TEXT || format == BINARY;
        }
    }
}
