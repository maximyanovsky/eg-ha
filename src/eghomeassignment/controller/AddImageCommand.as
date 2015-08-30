package eghomeassignment.controller
{
    import eghomeassignment.common.IDisposable;
    import eghomeassignment.controller.signals.SearchSubmittedSignal;
    import eghomeassignment.models.CollageModel;
    import eghomeassignment.models.ImageModel;
    import eghomeassignment.services.network.IAssetService;
    import eghomeassignment.services.search.vos.ImageVO;

    import flash.display.BitmapData;

    import org.robotlegs.mvcs.Command;

    public class AddImageCommand extends Command implements IDisposable
    {
        [Inject]
        public var image:ImageVO;
        [Inject]
        public var assetService:IAssetService;
        [Inject]
        public var collage:CollageModel;
        [Inject]
        public var searchSubmitted:SearchSubmittedSignal;

        override public function execute():void
        {
            assetService.received.add(onReceived);
            searchSubmitted.add(onNewSearchSubmitted);
            assetService.load(image.url);
        }

        private function onNewSearchSubmitted(value:String):void
        {
            dispose();
        }

        private function onReceived(data:BitmapData):void
        {
            var picture:ImageModel = new ImageModel(data.width, data.height);
            picture.setData(data);
            collage.addImage(picture);
            dispose();
        }

        public function dispose():void
        {
            assetService.received.removeAll();
            searchSubmitted.remove(onNewSearchSubmitted);
            assetService.dispose();
        }
    }
}
