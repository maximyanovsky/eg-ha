package services.network
{
    import common.IDisposable;

    import org.osflash.signals.Signal;

    import common.signals.SignalErrorEvent;

    public interface INetworkService extends IDisposable
    {
        function get received():Signal;

        function get failed():SignalErrorEvent;

        function load(path:String);
    }
}
