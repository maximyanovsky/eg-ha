package eghomeassignment.views.components
{
    import eghomeassignment.common.IDisposable;

    import flash.display.Sprite;
    import flash.events.Event;
    import flash.text.TextField;
    import flash.text.TextFieldType;
    import flash.text.TextFormat;
    import flash.text.TextFormatAlign;

    import mx.utils.StringUtil;

    import org.osflash.signals.Signal;
    import org.osflash.signals.natives.sets.TextFieldSignalSet;

    public class FlatInput extends Sprite implements IDisposable
    {
        private var _changed:Signal = new Signal();

        private var _background:Sprite;
        private var _tf:TextField;
        private var _hintTf:TextField;
        private var _set:TextFieldSignalSet;

        public function FlatInput(hint:String)
        {
            _background = new Sprite();

            _hintTf = new TextField();

            _tf = new TextField();
            _tf.x = _hintTf.x = 10;

            var format:TextFormat = new TextFormat("Verdana", 16, 0x0, false);
            format.align = TextFormatAlign.LEFT;
            _tf.defaultTextFormat = _hintTf.defaultTextFormat = format;
            _tf.type = TextFieldType.INPUT;
            _hintTf.mouseEnabled = false;
            _hintTf.text = hint;

            addChild(_background);
            addChild(_tf);
            addChild(_hintTf);

            _set = new TextFieldSignalSet(_tf);
            _set.change.add(onChange);
            _set.focusIn.add(onFocusIn);
            _set.focusOut.add(onFocusOut);
        }

        private function onFocusOut(e:Event):void
        {
            _hintTf.visible = value.length == 0;
        }

        private function onFocusIn(e:Event):void
        {
            _hintTf.visible = false;
        }

        private function onChange(e:Event):void
        {
            _changed.dispatch();
        }

        public function setSize(width:Number, height:Number):void
        {
            _background.graphics.clear();
            _background.graphics.beginFill(0xFFFFFF);
            _background.graphics.drawRect(0, 0, width, height);

            _tf.width = _hintTf.width = width;
            _tf.height = _hintTf.height = height;
        }

        public function get value():String
        {
            return StringUtil.trim(_tf.text);
        }

        public function dispose():void
        {
            _set.removeAll();
        }

        public function get changed():Signal
        {
            return _changed;
        }
    }
}
