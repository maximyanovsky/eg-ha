package views.ui
{
    import com.greensock.TweenLite;
    import com.greensock.easing.Linear;

    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.display.Sprite;
    import flash.geom.Rectangle;

    public class ImageView extends Sprite
    {
        private var _bitmap:Bitmap;
        private var _moveTween:TweenLite;
        private var _visibleTween:TweenLite;
        private var _visible:Boolean;
        public function ImageView()
        {
            _bitmap = new Bitmap();
            addChild(_bitmap);
            alpha = 0;
        }

        public function setBitmapData(bdata:BitmapData):void
        {
            _bitmap.bitmapData = bdata;
        }

        public function setBounds(bounds:Rectangle):void
        {
            if (_moveTween)
                _moveTween.invalidate();
           // _moveTween = TweenLite.to(this, 0.5, {x: bounds.x, y: bounds.y, width: bounds.width, height: bounds.height});
            x = bounds.x;
            y = bounds.y;
            width = bounds.width;
            height = bounds.height;
        }

        public function setVisible(value:Boolean, callback:Function = null):void
        {
            if (_visible != value)
            {
                _visible = value;
                if (_visibleTween)
                    _visibleTween.invalidate();
                _visibleTween = TweenLite.to(this, 0.5, {alpha: _visible ? 1.0 : 0, ease: Linear.ease, onComplete: callback});
            }
            else
            {
                if (callback)
                    callback();
            }
        }
    }
}
