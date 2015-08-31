package eghomeassignment.services.search
{
    import eghomeassignment.common.signals.ErrorEventSignal;

    import org.osflash.signals.Signal;

    import eghomeassignment.services.network.INetworkService;

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

        public function load(path:String, dataFormat:String):void
        {
        }

        public function dispose():void
        {
        }
    }
}
