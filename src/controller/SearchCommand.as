package controller
{
    import common.IDisposable;

    import controller.signals.ImageReceivedSignal;
    import controller.signals.SearchFailedSignal;
    import controller.signals.SearchSubmittedSignal;

    import models.CollageModel;

    import org.robotlegs.mvcs.SignalCommand;

    import services.search.IImageSearchService;
    import services.search.vos.ImageVO;
    import services.search.vos.SearchResultVO;

    public class SearchCommand extends SignalCommand implements IDisposable
    {
        [Inject] public var searchService:IImageSearchService;
        [Inject] public var collage:CollageModel;
        [Inject] public var keyword:String;
        [Inject] public var imageReceivedSignal:ImageReceivedSignal;
        [Inject] public var searchSubmittedSignal:SearchSubmittedSignal;
        [Inject] public var searchFailedSignal:SearchFailedSignal;

        override public function execute():void
        {
            collage.removeAllImages();
            searchService.received.add(onReceived);
            searchService.failed.add(onFailed);
            searchSubmittedSignal.add(onNewSearchSubmitted);
            searchService.getResults(keyword);
        }

        private function onFailed(str:String):void
        {
            searchFailedSignal.dispatch(SearchFailedSignal.LOADING_ERROR);
        }

        private function onNewSearchSubmitted(value:String):void
        {
            dispose();
        }

        private function onReceived(result:SearchResultVO):void
        {
            if (result.images.length == 0)
                searchFailedSignal.dispatch(SearchFailedSignal.NO_RESULTS);
            else
            {
                for each (var image:ImageVO in result.images)
                    imageReceivedSignal.dispatch(image);
            }

            dispose();
        }

        public function dispose():void
        {
            searchService.received.remove(onReceived);
            searchSubmittedSignal.remove(onNewSearchSubmitted);
            searchService.dispose();
        }
    }
}
