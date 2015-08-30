package views.ui
{
    import com.greensock.TweenLite;
    import com.greensock.easing.Linear;

    import common.IDisposable;

    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.display.Sprite;
    import flash.events.MouseEvent;
    import flash.geom.Rectangle;

    import org.osflash.signals.Signal;
    import org.osflash.signals.natives.sets.InteractiveObjectSignalSet;

    public class ImageView extends Sprite implements IDisposable
    {
        private var _clicked:Signal;
        private var _bitmap:Bitmap;
        private var _moveTween:TweenLite;
        private var _visibleTween:TweenLite;
        private var _visible:Boolean;
        private var _signalSet:InteractiveObjectSignalSet;
        public function ImageView()
        {
            _bitmap = new Bitmap();
            addChild(_bitmap);

            _clicked = new Signal(MouseEvent);
            _signalSet = new InteractiveObjectSignalSet(this);
            _signalSet.click.add(_clicked.dispatch);

            alpha = 0;
            mouseEnabled = false;
            mouseChildren = false;
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

                mouseEnabled = _visible;
                mouseChildren = _visible;
            }
            else
            {
                if (callback)
                    callback();
            }
        }

        public function get clicked():Signal
        {
            return _clicked;
        }

        public function dispose():void
        {
            _clicked.removeAll();
            _signalSet.removeAll();
        }
    }
}
