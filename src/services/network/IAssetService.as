package services.network
{
    import common.IDisposable;
    import common.signals.BitmapdataSignal;
    import common.signals.ErrorEventSignal;

    public interface IAssetService extends IDisposable
    {
        function load(url:String);
        function get received():BitmapdataSignal;
        function get failed():ErrorEventSignal;
    }
}
