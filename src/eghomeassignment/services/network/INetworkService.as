package eghomeassignment.services.network
{
    import eghomeassignment.common.IDisposable;
    import eghomeassignment.common.signals.ErrorEventSignal;

    import org.osflash.signals.Signal;

    public interface INetworkService extends IDisposable
    {
        function get received():Signal;

        function get failed():ErrorEventSignal;

        function load(path:String, dataFormat:String):void;
    }
}
