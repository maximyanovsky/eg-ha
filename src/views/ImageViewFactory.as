package views
{
    import flash.display.DisplayObject;

    import models.IImageModel;

    import org.robotlegs.core.IInjector;
    import org.robotlegs.core.IMediatorMap;

    import views.ImageMediator;
    import views.ui.ImageView;

    public class ImageViewFactory implements IImageViewFactory
    {
        [Inject] public var injector:IInjector;
        [Inject] public var mediatorMap:IMediatorMap;

        public function createView(picture:IImageModel):DisplayObject
        {
            injector.mapValue(IImageModel, picture);
            var view:ImageView = new ImageView();
            injector.mapValue(ImageView, view);
            var mediator:ImageMediator = new ImageMediator();
            injector.injectInto(mediator);
            injector.unmap(IImageModel);
            injector.unmap(ImageView);
            mediatorMap.registerMediator(view, mediator);
            return view;
        }
    }
}
