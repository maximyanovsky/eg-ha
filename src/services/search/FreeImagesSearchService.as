package services.search
{
    import flash.events.ErrorEvent;

    import services.network.INetworkService;
    import services.network.NetworkServiceDataFormat;
    import services.search.vos.SearchResultVO;

    import common.signals.StringSignal;

    /**
     * Service for receiving images info from freeimages.pictures API
     */
    public class FreeImagesSearchService implements IImageSearchService
    {
        [Inject] public var _networkService:INetworkService;
        [Inject] public var _parser:ISearchResultParser;

        private static const API_URL:String = "http://freeimages.pictures/api/user";
        private static const API_KEY:String = "9203182073775680";
        private static const FORMAT:String = "json";

        private var _received:SearchResultVOSignal;
        private var _failed:StringSignal;

        public function FreeImagesSearchService()
        {
            _received = new SearchResultVOSignal();
            _failed = new StringSignal();
        }

        public function getResults(keyword:String):void
        {
            if (!keyword)
                throw new ArgumentError("keyword must be set");

            _networkService.received.add(onComplete);
            _networkService.failed.add(onFailed);

            var url:String = API_URL + "/" + API_KEY + "/?keyword=" + keyword + "&sources=flickr|wikimedia|pixabay|morguefile|google|openclipart&format=" + FORMAT;
            _networkService.load(url, NetworkServiceDataFormat.TEXT);
        }

        public function get received():SearchResultVOSignal
        {
            return _received;
        }

        public function get failed():StringSignal
        {
            return _failed;
        }

        private function onComplete(rawData:String):void
        {
            var result:SearchResultVO;
            try
            {
                var data:String = rawData;
                result = _parser.parse(data);
                _received.dispatch(result);
            }
            catch (e:ParserError)
            {
                _failed.dispatch(e.message)
            }
        }

        private function onFailed(e:ErrorEvent):void
        {
            _failed.dispatch(e.text);
        }

        public function dispose():void
        {
            _networkService.dispose();
        }
    }
}
