package
{
    import org.robotlegs.mvcs.Command;
    import org.robotlegs.mvcs.SignalCommand;

    import services.search.IImageSearchService;
    import services.search.FreeImagesJSONResultParser;
    import services.search.FreeImagesSearchService;
    import services.search.vos.SearchResultVO;

    public class StartupCommand extends SignalCommand
    {
        public function StartupCommand()
        {
            trace("startup");

            var service:IImageSearchService = new FreeImagesSearchService("9203182073775680");
            service.parser = new FreeImagesJSONResultParser();
            service.received.add(onReceived);
            service.getResults("fucking");
        }

        private function onReceived(result:SearchResultVO):void
        {
            trace("op");
        }
    }
}
