package services.search
{
    import flash.errors.IllegalOperationError;
    import flash.events.Event;
    import flash.events.IOErrorEvent;
    import flash.events.SecurityErrorEvent;
    import flash.net.URLLoader;
    import flash.net.URLRequest;

    import org.osflash.signals.ISignal;
    import org.osflash.signals.Signal;
    import org.osflash.signals.natives.sets.URLLoaderSignalSet;

    import services.search.vos.SearchResultVO;

    /**
     * Service for receiving images info from freeimages.pictures API
     */
    public class FreeImagesSearchService implements IImageSearchService, IDisposable
    {
        private static const API_URL:String = "http://freeimages.pictures/api/user/";

        private var _received:Signal;
        private var _failed:Signal;

        private var _loader:URLLoader;
        private var _apiKey:String;
        private var _parser:ISearchResultParser;
        private var _format:String;

        private var _signalSet:URLLoaderSignalSet;

        /**
         * Constructor
         * @param apiKey API Key
         * @param format format of data provided to parser
         */
        public function FreeImagesSearchService(apiKey:String, format:String = "json")
        {
            _apiKey = apiKey;
            _format = format;

            _loader = new URLLoader();
            _signalSet = new URLLoaderSignalSet(_loader);
            _received = new Signal(SearchResultVO);
            _failed = new Signal(Error);
        }

        public function getResults(keyword:String):void
        {
            if (!keyword)
                throw new ArgumentError("keyword must be set");
            if (!_parser)
                throw new IllegalOperationError("parser must be set");


            _signalSet.complete.addOnce(onComplete);
            _signalSet.ioError.add(onIoError);
            _signalSet.securityError.add(onSecurityError);

            var url:String = API_URL + _apiKey + "/?keyword=" + keyword + "&sources=flickr&format=" + _format;
            _loader.load(new URLRequest(url));
        }

        public function set parser(value:ISearchResultParser):void
        {
            if (!value)
                throw new ArgumentError("invalid parser");

            _parser = value;
        }

        public function get received():ISignal
        {
            return _received;
        }

        public function get failed():ISignal
        {
            return _failed;
        }

        public function dispose():void
        {
            _signalSet.removeAll();
        }

        private function onSecurityError(e:SecurityErrorEvent):void
        {
            _failed.dispatch(e.errorID)
        }

        private function onIoError(e:IOErrorEvent):void
        {
            _failed.dispatch(e.errorID);
        }

        private function onComplete(e:Event):void
        {
            var result:SearchResultVO = _parser.parse(_loader.data);
            _received.dispatch(result);
        }
    }
}
