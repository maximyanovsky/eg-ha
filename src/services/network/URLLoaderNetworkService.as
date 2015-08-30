package services.network
{
    import flash.events.Event;
    import flash.net.URLLoader;
    import flash.net.URLLoaderDataFormat;
    import flash.net.URLRequest;

    import org.osflash.signals.Signal;
    import org.osflash.signals.natives.sets.URLLoaderSignalSet;

    import common.signals.ErrorEventSignal;

    public class URLLoaderNetworkService implements INetworkService
    {
        private var _urlLoader:URLLoader;
        private var _signalSet:URLLoaderSignalSet;
        private var _received:Signal;
        private var _failed:ErrorEventSignal;

        public function URLLoaderNetworkService()
        {
            _urlLoader = new URLLoader();
            _signalSet = new URLLoaderSignalSet(_urlLoader);

            _received = new Signal();
            _failed = new ErrorEventSignal();

            _signalSet.complete.add(onComplete);
            _signalSet.ioError.add(_failed.dispatch);
            _signalSet.securityError.add(_failed.dispatch);
        }

        private function onComplete(e:Event):void
        {
            _received.dispatch(_urlLoader.data);
        }

        public function get received():Signal
        {
            return _received;
        }

        public function get failed():ErrorEventSignal
        {
            return _failed;
        }

        public function load(url:String, dataFormat:String)
        {
            if (!NetworkServiceDataFormat.isValid(dataFormat))
                throw new ArgumentError("invalid data format " + dataFormat);

            _urlLoader.dataFormat = dataFormat;
            _urlLoader.load(new URLRequest(url));
        }

        public function dispose():void
        {
            _signalSet.removeAll();
        }
    }
}
