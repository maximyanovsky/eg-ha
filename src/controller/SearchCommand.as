package controller
{
    import controller.signals.ImageReceivedSignal;

    import models.CollageModel;

    import org.robotlegs.mvcs.SignalCommand;

    import services.search.IImageSearchService;
    import services.search.vos.ImageVO;
    import services.search.vos.SearchResultVO;

    public class SearchCommand extends SignalCommand
    {
        [Inject] public var searchService:IImageSearchService;
        [Inject] public var collage:CollageModel;
        [Inject] public var keyword:String;
        [Inject] public var imageReceivedSignal:ImageReceivedSignal;

        override public function execute():void
        {
            searchService.received.add(onReceived);
            searchService.getResults(keyword);
        }

        private function onReceived(result:SearchResultVO):void
        {
            for each (var image:ImageVO in result.images)
                imageReceivedSignal.dispatch(image);
        }
    }
}
