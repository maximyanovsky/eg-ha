package eghomeassignment.controller
{
    import eghomeassignment.common.IDisposable;
    import eghomeassignment.controller.signals.ImageReceivedSignal;
    import eghomeassignment.controller.signals.SearchFailedSignal;
    import eghomeassignment.controller.signals.SearchSubmittedSignal;
    import eghomeassignment.models.CollageModel;
    import eghomeassignment.services.search.IImageSearchService;
    import eghomeassignment.services.search.vos.ImageVO;
    import eghomeassignment.services.search.vos.SearchResultVO;

    import org.robotlegs.mvcs.SignalCommand;

    public class SearchCommand extends SignalCommand implements IDisposable
    {
        [Inject]
        public var searchService:IImageSearchService;
        [Inject]
        public var collage:CollageModel;
        [Inject]
        public var keyword:String;
        [Inject]
        public var imageReceivedSignal:ImageReceivedSignal;
        [Inject]
        public var searchSubmittedSignal:SearchSubmittedSignal;
        [Inject]
        public var searchFailedSignal:SearchFailedSignal;

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
            {
                searchFailedSignal.dispatch(SearchFailedSignal.NO_RESULTS);
            }
            else
            {
                for each (var image:ImageVO in result.images)
                {
                    imageReceivedSignal.dispatch(image);
                }
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
