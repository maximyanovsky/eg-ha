package eghomeassignment.services.search
{
    import eghomeassignment.common.IDisposable;
    import eghomeassignment.common.signals.StringSignal;

    public interface IImageSearchService extends IDisposable
    {
        /**
         * dispatched after all the received data is parsed
         */
        function get received():SearchResultVOSignal;

        /**
         * error description dispatched if the search is failed
         */
        function get failed():StringSignal;

        /**
         * Request images info by the search keyword
         * @param keyword
         */
        function getResults(keyword:String):void;
    }
}
