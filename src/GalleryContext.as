package
{
    import controller.ResizeCommand;
    import controller.SearchCommand;
    import controller.StartupCommand;

    import flash.display.DisplayObjectContainer;
    import flash.events.Event;

    import org.osflash.signals.ISignal;
    import org.osflash.signals.natives.NativeSignal;
    import org.osflash.signals.natives.sets.StageSignalSet;
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

    import views.GalleryView;

    public class GalleryContext extends SignalContext
    {
        public function GalleryContext(contextView:DisplayObjectContainer)
        {
            super (contextView)
        }

        override public function startup():void
        {
            var startupComplete:ISignal = new NativeSignal(this, ContextEvent.STARTUP_COMPLETE);
            var resize:ISignal = new StageResizeSignal(contextView.stage);

            injector.mapClass(INetworkService, URLLoaderNetworkService);
            injector.mapClass(ISearchResultParser, FreeImagesJSONResultParser);
            injector.mapClass(IImageSearchService, FreeImagesSearchService);
            injector.mapValue(StageResizeSignal, resize);

            mediatorMap.mapView(GalleryView, GalleryMediator);

            signalCommandMap.mapSignal(startupComplete, StartupCommand);
            signalCommandMap.mapSignal(resize, ResizeCommand);
            signalCommandMap.mapSignalClass(SearchSubmittedSignal, SearchCommand);
            super.startup();
        }
    }
}
