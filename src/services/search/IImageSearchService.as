package services.search
{
    import common.IDisposable;

    import org.osflash.signals.ISignal;

    import common.signals.SignalString;

    public interface IImageSearchService extends IDisposable
    {
        /**
         * dispatched after all the received data is parsed
         */
        function get received():SignalSearchResult;

        /**
         * error description dispatched if the search is failed
         */
        function get failed():SignalString;

        /**
         * Request images info by the search keyword
         * @param keyword
         */
        function getResults(keyword:String):void;
    }
}
