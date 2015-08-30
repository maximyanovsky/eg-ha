package eghomeassignment.services.network
{
    import eghomeassignment.common.signals.BitmapdataSignal;
    import eghomeassignment.common.signals.ErrorEventSignal;

    import flash.display.Bitmap;
    import flash.display.Loader;
    import flash.events.ErrorEvent;
    import flash.events.Event;
    import flash.utils.ByteArray;

    import org.osflash.signals.natives.sets.LoaderInfoSignalSet;

    public class LoaderAssetService implements IAssetService
    {
        [Inject]
        public var networkService:INetworkService;

        private var _received:BitmapdataSignal;
        private var _failed:ErrorEventSignal;
        private var _loaderInfoSet:LoaderInfoSignalSet;
        private var _loader:Loader;

        [PostConstruct]
        public function _postConstruct():void
        {
            _received = new BitmapdataSignal();
            _failed = new ErrorEventSignal();
            networkService.received.add(onReceived);
            networkService.failed.add(_failed.dispatch);
        }

        private function onReceived(data:ByteArray):void
        {
            _loader = new Loader();
            _loaderInfoSet = new LoaderInfoSignalSet(_loader.contentLoaderInfo);
            _loaderInfoSet.complete.add(onBytesLoaded);
            _loaderInfoSet.ioError.add(_failed.dispatch);
            try
            {
                _loader.loadBytes(data);
            } catch (e:Error)
            {
                _failed.dispatch(new ErrorEvent(e.name, false, false, e.message, e.errorID));
            }
        }

        private function onBytesLoaded(e:Event):void
        {
            _received.dispatch(Bitmap(_loader.content).bitmapData);
        }

        public function load(url:String)
        {
            networkService.load(url, NetworkServiceDataFormat.BINARY);
        }

        public function get received():BitmapdataSignal
        {
            return _received;
        }

        public function get failed():ErrorEventSignal
        {
            return _failed;
        }

        public function dispose():void
        {
            if (_loaderInfoSet)
            {
                _loaderInfoSet.removeAll();
            }
            networkService.dispose();
        }
    }
}
