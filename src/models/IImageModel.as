package models
{
    import flash.display.BitmapData;
    import flash.geom.Rectangle;

    import org.osflash.signals.Signal;

    public interface IImageModel
    {
        function get width():Number;

        function get height():Number;

        function get boundsChanged():Signal;

        function get bounds():Rectangle;

        function get data():BitmapData;

        function get hiddenChanged():Signal;

        function get hidden():Boolean;
    }
}
