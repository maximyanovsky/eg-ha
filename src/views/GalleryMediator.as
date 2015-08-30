package views
{
    import controller.IImageViewFactory;
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

        [Inject] public var view:GalleryView;

        override public function onRegister():void
        {
            stageResized.add(onStageResized);
            view.input.changed.add(onInputChanged);
            view.searchButton.clicked.add(onSearchClick);
            collage.imageAdded.add(onImageAdded);
            onStageResized();
            onInputChanged();
        }

        private function onImageAdded(image:IImageModel):void
        {
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
