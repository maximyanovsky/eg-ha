package controller
{
    import org.robotlegs.mvcs.SignalCommand;

    import services.search.IImageSearchService;
    import services.search.vos.SearchResultVO;

    public class SearchCommand extends SignalCommand
    {
        [Inject] public var searchService:IImageSearchService;
        [Inject] public var keyword:String;

        override public function execute():void
        {
            searchService.received.add(onReceived);
            searchService.getResults(keyword);
        }

        private function onReceived(result:SearchResultVO):void
        {

        }
    }
}
