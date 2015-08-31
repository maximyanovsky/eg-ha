package eghomeassignment.services.network
{
    import eghomeassignment.common.IDisposable;
    import eghomeassignment.common.signals.BitmapdataSignal;
    import eghomeassignment.common.signals.ErrorEventSignal;

    public interface IAssetService extends IDisposable
    {
        function load(url:String):void;

        function get received():BitmapdataSignal;

        function get failed():ErrorEventSignal;
    }
}
