package views
{
    import common.IDisposable;

    import flash.display.Sprite;

    public class GalleryView extends Sprite implements IDisposable
    {
        public static const BUTTON_WIDTH:Number = 150;
        public static const BUTTON_HEIGHT:Number = 30;
        public static const GAP:Number = 10;

        private var _searchButton:FlatButton;
        private var _input:FlatInput;

        public function GalleryView()
        {
            _searchButton = new FlatButton("search", BUTTON_WIDTH, BUTTON_HEIGHT);
            _input = new FlatInput("Type keyword...");
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
    }
}
