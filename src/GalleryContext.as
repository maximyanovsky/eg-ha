package
{
    import controller.AddImageCommand;
    import controller.IImageViewFactory;
    import controller.ImageViewFactory;
    import controller.ResizeCollageCommand;
    import controller.SearchCommand;
    import controller.signals.ImageReceivedSignal;
    import controller.signals.SearchSubmittedSignal;
    import controller.StartupCommand;
    import controller.UpdateCollageLayoutCommand;

    import flash.display.DisplayObjectContainer;

    import models.CollageModel;
    import models.ICollageModel;

    import org.osflash.signals.ISignal;
    import org.osflash.signals.natives.NativeSignal;
    import org.robotlegs.base.ContextEvent;
    import org.robotlegs.mvcs.SignalContext;

    import services.network.IAssetService;

    import services.network.INetworkService;
    import services.network.LoaderAssetService;
    import services.network.URLLoaderNetworkService;
    import services.search.FreeImagesJSONResultParser;
    import services.search.FreeImagesSearchService;
    import services.search.IImageSearchService;
    import services.search.ISearchResultParser;

    import views.GalleryMediator;

    import views.ui.GalleryView;

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
            var collageModel:CollageModel = new CollageModel();

            injector.mapClass(INetworkService, URLLoaderNetworkService);
            injector.mapClass(IAssetService, LoaderAssetService);
            injector.mapClass(ISearchResultParser, FreeImagesJSONResultParser);
            injector.mapClass(IImageSearchService, FreeImagesSearchService);
            injector.mapValue(StageResizeSignal, resize);
            injector.mapValue(CollageModel, collageModel);
            injector.mapValue(ICollageModel, collageModel);
            injector.mapSingletonOf(IImageViewFactory, ImageViewFactory);

            mediatorMap.mapView(GalleryView, GalleryMediator);

            signalCommandMap.mapSignal(startupComplete, StartupCommand);
            signalCommandMap.mapSignal(startupComplete, ResizeCollageCommand);
            signalCommandMap.mapSignal(resize, ResizeCollageCommand);
            signalCommandMap.mapSignal(collageModel.resized, UpdateCollageLayoutCommand);
            signalCommandMap.mapSignal(collageModel.imageAdded, UpdateCollageLayoutCommand);
            signalCommandMap.mapSignalClass(SearchSubmittedSignal, SearchCommand);
            signalCommandMap.mapSignalClass(ImageReceivedSignal, AddImageCommand);

            super.startup();
        }
    }
}
