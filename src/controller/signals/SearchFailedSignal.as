package controller.signals
{
    import org.osflash.signals.Signal;

    public class SearchFailedSignal extends Signal
    {
        public static const NO_RESULTS:String = "no_results";
        public static const LOADING_ERROR:String = "loading_error";

        public function SearchFailedSignal()
        {
            super (String);
        }
    }
}
