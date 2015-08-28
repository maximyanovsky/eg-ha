package
{
    import org.robotlegs.mvcs.SignalCommand;

    import services.search.IImageSearchService;
    import services.search.vos.SearchResultVO;

    public class StartupCommand extends SignalCommand
    {
        [Inject] public var _searchService:IImageSearchService;

        override public function execute():void
        {
            _searchService.received.add(onReceived);
            _searchService.getResults("fairytail");
        }

        private function onReceived(result:SearchResultVO):void
        {
            trace("op");
        }
    }
}
