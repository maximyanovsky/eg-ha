package controller
{
    import flash.display.BitmapData;
    import flash.display.DisplayObject;

    import models.CollageModel;

    import models.ImageModel;

    import org.robotlegs.mvcs.Command;

    import services.network.IAssetService;
    import services.search.vos.ImageVO;

    public class AddImageCommand extends Command
    {
        [Inject] public var image:ImageVO;
        [Inject] public var assetService:IAssetService;
        [Inject] public var collage:CollageModel;

        override public function execute():void
        {
            assetService.received.add(onReceived);
            assetService.load(image.url);
        }

        private function onReceived(data:BitmapData):void
        {
            var picture:ImageModel = new ImageModel(data.width, data.height);
            picture.setData(data);
            collage.addImage(picture);
            trace("add image");
        }
    }
}
