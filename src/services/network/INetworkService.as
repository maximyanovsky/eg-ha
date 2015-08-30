package services.network
{
    import common.IDisposable;

    import org.osflash.signals.Signal;

    import common.signals.ErrorEventSignal;

    public interface INetworkService extends IDisposable
    {
        function get received():Signal;

        function get failed():ErrorEventSignal;

        function load(path:String, dataFormat:String);
    }
}
