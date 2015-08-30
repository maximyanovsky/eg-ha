package models
{
    import flash.display.BitmapData;
    import flash.geom.Rectangle;

    import org.osflash.signals.Signal;

    public class ImageModel implements IImageModel
    {
        private var _boundsChanged:Signal;
        private var _hiddenChanged:Signal;

        private var _width:Number;
        private var _height:Number;
        private var _aspectRatio:Number;
        private var _bounds:Rectangle;
        private var _data:BitmapData;
        private var _hidden:Boolean = true;

        public function ImageModel(width:Number, height:Number)
        {
            _width = width;
            _height = height;
            _aspectRatio = width/height;
            _boundsChanged = new Signal();
            _hiddenChanged = new Signal();
        }

        public function get width():Number
        {
            return _width;
        }

        public function get height():Number
        {
            return _height;
        }

        public function setData(data:BitmapData):void
        {
            _data = data;
        }

        public function setBounds(bounds:Rectangle):void
        {
            _bounds = bounds;
            _boundsChanged.dispatch();
        }

        public function get boundsChanged():Signal
        {
            return _boundsChanged;
        }

        public function get bounds():Rectangle
        {
            return _bounds;
        }

        public function get aspectRatio():Number
        {
            return _aspectRatio;
        }

        public function get data():BitmapData
        {
            return _data;
        }

        public function setHidden(value:Boolean):void
        {
            if (_hidden != value)
            {
                _hidden = value;
                _hiddenChanged.dispatch();
            }
        }

        public function get hiddenChanged():Signal
        {
            return _hiddenChanged;
        }

        public function get hidden():Boolean
        {
            return _hidden;
        }
    }
}
