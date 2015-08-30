package controller
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
            var subInjector:IInjector = injector.createChild(injector.applicationDomain);
            subInjector.mapValue(IImageModel, picture);
            var view:ImageView = new ImageView();
            subInjector.mapValue(ImageView, view);
            var mediator:ImageMediator = new ImageMediator();
            subInjector.injectInto(mediator);
            mediatorMap.registerMediator(view, mediator);
            return view;
        }
    }
}
