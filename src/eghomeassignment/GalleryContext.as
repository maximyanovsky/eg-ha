package eghomeassignment
{
    import eghomeassignment.controller.AddImageCommand;
    import eghomeassignment.controller.DestroyImageCommand;
    import eghomeassignment.controller.RemoveImageFromCollageCommand;
    import eghomeassignment.controller.ResizeCollageCommand;
    import eghomeassignment.controller.SearchCommand;
    import eghomeassignment.controller.StartupCommand;
    import eghomeassignment.controller.UpdateCollageLayoutCommand;
    import eghomeassignment.controller.signals.ImageReceivedSignal;
    import eghomeassignment.controller.signals.SearchFailedSignal;
    import eghomeassignment.controller.signals.SearchSubmittedSignal;
    import eghomeassignment.models.CollageModel;
    import eghomeassignment.models.ICollageModel;
    import eghomeassignment.services.network.IAssetService;
    import eghomeassignment.services.network.INetworkService;
    import eghomeassignment.services.network.LoaderAssetService;
    import eghomeassignment.services.network.URLLoaderNetworkService;
    import eghomeassignment.services.search.FreeImagesJSONResultParser;
    import eghomeassignment.services.search.FreeImagesSearchService;
    import eghomeassignment.services.search.IImageSearchService;
    import eghomeassignment.services.search.ISearchResultParser;
    import eghomeassignment.views.GalleryMediator;
    import eghomeassignment.views.IImageViewFactory;
    import eghomeassignment.views.ImageViewFactory;
    import eghomeassignment.views.signals.ImageClickedSignal;
    import eghomeassignment.views.signals.ImageViewRemovedSignal;
    import eghomeassignment.views.signals.StageResizeSignal;
    import eghomeassignment.views.ui.GalleryView;

    import flash.display.DisplayObjectContainer;

    import org.osflash.signals.ISignal;
    import org.osflash.signals.natives.NativeSignal;
    import org.robotlegs.base.ContextEvent;
    import org.robotlegs.mvcs.SignalContext;

    public class GalleryContext extends SignalContext
    {
        public function GalleryContext(contextView:DisplayObjectContainer)
        {
            super(contextView)
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
            injector.mapSingleton(SearchFailedSignal);

            mediatorMap.mapView(GalleryView, GalleryMediator);

            signalCommandMap.mapSignal(startupComplete, StartupCommand);
            signalCommandMap.mapSignal(startupComplete, ResizeCollageCommand);
            signalCommandMap.mapSignal(resize, ResizeCollageCommand);
            signalCommandMap.mapSignal(collageModel.resized, UpdateCollageLayoutCommand);
            signalCommandMap.mapSignal(collageModel.imageAdded, UpdateCollageLayoutCommand);
            signalCommandMap.mapSignal(collageModel.imageRemoved, UpdateCollageLayoutCommand);
            signalCommandMap.mapSignalClass(SearchSubmittedSignal, SearchCommand);
            signalCommandMap.mapSignalClass(ImageReceivedSignal, AddImageCommand);
            signalCommandMap.mapSignalClass(ImageViewRemovedSignal, DestroyImageCommand);
            signalCommandMap.mapSignalClass(ImageClickedSignal, RemoveImageFromCollageCommand);

            super.startup();
        }
    }
}
