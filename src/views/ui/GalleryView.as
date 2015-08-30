package views.ui
{
    import common.IDisposable;

    import flash.display.DisplayObject;
    import flash.display.DisplayObjectContainer;

    import flash.display.Sprite;
    import flash.text.TextField;
    import flash.text.TextFormat;
    import flash.text.TextFormatAlign;

    import views.components.FlatButton;

    import views.components.FlatInput;

    public class GalleryView extends Sprite implements IDisposable
    {
        public static const BUTTON_WIDTH:Number = 150;
        public static const BUTTON_HEIGHT:Number = 30;
        public static const GAP:Number = 10;

        private var _searchButton:FlatButton;
        private var _input:FlatInput;
        private var _imageContainer:DisplayObjectContainer;
        private var _statusTf:TextField;

        public function GalleryView()
        {
            _imageContainer = new Sprite();
            _searchButton = new FlatButton("search", BUTTON_WIDTH, BUTTON_HEIGHT);
            _input = new FlatInput("Type keyword...");

            _statusTf = new TextField();
            var format:TextFormat = new TextFormat("Verdana", 16, 0x0, false);
            format.align = TextFormatAlign.CENTER;
            _statusTf.defaultTextFormat = format;
            _statusTf.mouseEnabled = false;
        }

        public function update():void
        {
            graphics.clear();
            graphics.beginFill(0x0);
            graphics.drawRect(0, 0, stage.stageWidth, BUTTON_HEIGHT + 2 * GAP);


            addChild(_searchButton);
            _searchButton.x = stage.stageWidth - BUTTON_WIDTH/2 - GAP;
            _searchButton.y = GAP + BUTTON_HEIGHT/2;

            addChild(_input);
            _input.x = GAP;
            _input.y = GAP;
            _input.setSize(stage.stageWidth - 3 * GAP - BUTTON_WIDTH, BUTTON_HEIGHT);

            addChild(_imageContainer);
            _imageContainer.y = GAP * 2 +BUTTON_HEIGHT

            addChild(_statusTf);
            _statusTf.width = stage.stageWidth;
            _statusTf.y = stage.stageHeight/2;
        }

        public function setStatus(text:String):void
        {
            _statusTf.text = text;
        }

        public function get searchButton():FlatButton
        {
            return _searchButton;
        }

        public function get input():FlatInput
        {
            return _input;
        }

        public function dispose():void
        {
            _searchButton.dispose();
            _input.dispose();
        }

        public function addImage(imageView:DisplayObject):void
        {
            _imageContainer.addChild(imageView);
        }
    }
}
