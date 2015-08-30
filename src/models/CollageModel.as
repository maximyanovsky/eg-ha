package models
{
    import org.osflash.signals.Signal;

    public class CollageModel implements ICollageModel
    {
        private var _resized:Signal;
        private var _imageAdded:ImageSignal;

        private var _images:Vector.<ImageModel>;
        private var _width:Number;
        private var _height:Number;
        private var _aspectRatio:Number;

        public function CollageModel()
        {
            _images = new Vector.<ImageModel>();
            _resized = new Signal();
            _imageAdded = new ImageSignal();
        }

        public function setSize(width:Number, height:Number):void
        {
            _width = width;
            _height = height;
            _aspectRatio = _width/_height;
            _resized.dispatch();
        }

        public function get images():Vector.<ImageModel>
        {
            return _images;
        }

        public function addImage(image:ImageModel):void
        {
            _images.push(image);
            trace("image added " + image);
            _imageAdded.dispatch(image);
        }

        public function removeImage(image:ImageModel):void
        {
            var index:int = _images.indexOf(image);
            if (index == -1)
                throw new ArgumentError("invalid image");
            _images.splice(index, 1);
            trace("image removed " + image);
            image.removedFromCollage.dispatch();
        }

        public function removeAllImages():void
        {
            for each (var image:ImageModel in _images.concat())
                removeImage(image);
        }

        public function get resized():Signal
        {
            return _resized;
        }

        public function get width():Number
        {
            return _width;
        }

        public function get height():Number
        {
            return _height;
        }

        public function get imageAdded():ImageSignal
        {
            return _imageAdded;
        }
    }
}