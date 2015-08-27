package services.search
{
    import org.osflash.signals.ISignal;

    public interface IImageSearchService
    {
        /**
         * SearchResultVO dispatched after all the received data is parsed
         */
        function get received():ISignal;

        /**
         * errorID:String dispatched if the search is failed
         */
        function get failed():ISignal;

        /**
         * Request images info by the search keyword
         * @param keyword
         */
        function getResults(keyword:String):void;

        /**
         * Parser for the received data
         * @param value
         */
        function set parser(value:ISearchResultParser):void;
    }
}
