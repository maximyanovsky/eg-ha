package
{
    import flash.display.DisplayObjectContainer;

    import org.osflash.signals.ISignal;
    import org.osflash.signals.natives.NativeSignal;
    import org.robotlegs.base.ContextError;
    import org.robotlegs.base.ContextEvent;
    import org.robotlegs.mvcs.Context;
    import org.robotlegs.mvcs.SignalContext;

    import services.network.INetworkService;
    import services.network.URLLoaderNetworkService;
    import services.search.FreeImagesJSONResultParser;
    import services.search.FreeImagesSearchService;
    import services.search.IImageSearchService;
    import services.search.ISearchResultParser;

    public class GalleryContext extends SignalContext
    {
        public function GalleryContext(contextView:DisplayObjectContainer)
        {
            super (contextView)
        }

        override public function startup():void
        {
            var startupComplete:ISignal = new NativeSignal(this, ContextEvent.STARTUP_COMPLETE);
            injector.mapClass(INetworkService, URLLoaderNetworkService);
            injector.mapClass(ISearchResultParser, FreeImagesJSONResultParser);
            injector.mapClass(IImageSearchService, FreeImagesSearchService);
            signalCommandMap.mapSignal(startupComplete, StartupCommand);
            super.startup();
        }
    }
}
