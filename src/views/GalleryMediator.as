package views
{
    import controller.IImageViewFactory;
    import controller.signals.SearchFailedSignal;
    import controller.signals.SearchSubmittedSignal;

    import flash.display.DisplayObject;

    import models.ICollageModel;
    import models.IImageModel;

    import org.robotlegs.mvcs.Mediator;

    import views.ui.GalleryView;

    public class GalleryMediator extends Mediator
    {
        [Inject] public var stageResized:StageResizeSignal;
        [Inject] public var searchSubmitted:SearchSubmittedSignal;
        [Inject] public var collage:ICollageModel;
        [Inject] public var imageViewFactory:IImageViewFactory;
        [Inject] public var searchFailedSignal:SearchFailedSignal;

        [Inject] public var view:GalleryView;

        override public function onRegister():void
        {
            stageResized.add(onStageResized);
            view.input.changed.add(onInputChanged);
            view.searchButton.clicked.add(onSearchClick);
            collage.imageAdded.add(onImageAdded);
            searchSubmitted.add(onSearchSubmitted);
            searchFailedSignal.add(onSearchFailed);
            onStageResized();
            onInputChanged();
        }

        private function onSearchFailed(status:String):void
        {
            if (status == SearchFailedSignal.LOADING_ERROR)
            {
                view.setStatus("Loading error :(");
            }
            else if (status == SearchFailedSignal.NO_RESULTS)
            {
                view.setStatus("Nothing found :(");
            }
        }

        private function onSearchSubmitted(value:String):void
        {
            view.setStatus("Searching...");
        }

        private function onImageAdded(image:IImageModel):void
        {
            view.setStatus("");
            var imageView:DisplayObject = imageViewFactory.createView(image)
            view.addImage(imageView);
        }

        private function onSearchClick():void
        {
            searchSubmitted.dispatch(view.input.value);
        }

        private function onInputChanged():void
        {
            view.searchButton.enabled = view.input.value.length > 0;
        }

        private function onStageResized():void
        {
            view.update();
        }
    }
}
