package services.search
{
    import flash.events.ErrorEvent;

    import org.osflash.signals.Signal;

    import services.network.INetworkService;

    import common.signals.ErrorEventSignal;

    public class MockNetworkService implements INetworkService
    {
        private var _failed:ErrorEventSignal = new ErrorEventSignal();
        private var _received:Signal = new Signal(String);

        public function get received():Signal
        {
            return _received;
        }

        public function get failed():ErrorEventSignal
        {
            return _failed;
        }

        public function load(path:String)
        {
        }

        public function dispose():void
        {
        }
    }
}
