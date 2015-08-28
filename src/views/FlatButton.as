package views
{
    import com.greensock.TweenLite;

    import common.IDisposable;

    import flash.display.DisplayObjectContainer;
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.text.TextField;
    import flash.text.TextFormat;
    import flash.text.TextFormatAlign;

    import org.osflash.signals.Signal;
    import org.osflash.signals.natives.sets.InteractiveObjectSignalSet;

    public class FlatButton extends Sprite implements IDisposable
    {
        private var _clicked:Signal = new Signal();

        private var _signalSet:InteractiveObjectSignalSet;
        private var _container:DisplayObjectContainer;
        private var _width:Number;
        private var _height:Number;
        private var _enabled:Boolean = true;
        private var _back:Sprite;

        public function FlatButton(label:String, width:Number, height:Number)
        {
            _width = width;
            _height = height;
            _container = new Sprite();

            _back = new Sprite();
            updateBackground();

            var tf:TextField = new TextField();
            var format:TextFormat = new TextFormat("Verdana", 16, 0xFFFFFF, true);
            format.align = TextFormatAlign.CENTER;
            tf.defaultTextFormat = format;
            tf.text = label;
            tf.width = width;
            tf.mouseEnabled = false;
            tf.selectable = false;
            tf.x = -width/2;
            tf.y = -height/2;

            _container.addChild(_back);
            _container.addChild(tf);
            addChild(_container);

            _back.buttonMode = true;

            _signalSet = new InteractiveObjectSignalSet(_back);
            _signalSet.mouseOver.add(onMouseOver);
            _signalSet.mouseOut.add(onMouseOut);
            _signalSet.mouseDown.add(onMouseDown);
            _signalSet.mouseUp.add(onMouseUp);
            _signalSet.click.add(onClick);
        }

        private function updateBackground():void
        {
            var color:uint = _enabled ? 0x00BB00 : 0xBBBBBB;
            _back.graphics.beginFill(color);
            _back.graphics.drawRect(-_width/2, -_height/2, _width, _height);
        }

        private function onMouseUp(e:Event):void
        {
            if (!_enabled) return;
            _container.y = 0;
        }

        private function onMouseDown(e:Event):void
        {
            if (!_enabled) return;
            _container.y = 2;
        }

        private function onClick(e:Event):void
        {
            if (!_enabled) return;
            _clicked.dispatch();
        }

        private function onMouseOut(e:Event):void
        {
            if (!_enabled) return;
            TweenLite.to(this, 0.1, {"scaleX": 1, "scaleY": 1});
        }

        private function onMouseOver(e:Event):void
        {
            if (!_enabled) return;
            TweenLite.to(this, 0.1, {"scaleX": 1.05, "scaleY": 1.05});
        }

        public function get clicked():Signal
        {
            return _clicked;
        }

        public function dispose():void
        {
            _signalSet.removeAll();
        }

        public function get enabled():Boolean
        {
            return _enabled;
        }

        public function set enabled(value:Boolean):void
        {
            if (_enabled == value) return;

            _enabled = value;
            if (!_enabled)
            {
                TweenLite.killTweensOf(this);
                _container.y = 0;
                scaleX = scaleY = 1;
                buttonMode = false;
            }
            else
                buttonMode = true;
            updateBackground();
        }
    }
}
