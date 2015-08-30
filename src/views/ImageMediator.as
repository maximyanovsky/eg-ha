package views
{
    import models.IImageModel;

    import org.robotlegs.mvcs.Mediator;

    import views.ui.ImageView;

    public class ImageMediator extends Mediator
    {
        [Inject] public var image:IImageModel;
        [Inject] public var view:ImageView;

        override public function onRegister():void
        {
            view.setBitmapData(image.data);

            image.boundsChanged.add(onBoundsChanged);
            image.hiddenChanged.add(onHiddenChanged);
            onHiddenChanged();
            if (image.bounds)
                onBoundsChanged();
        }

        private function onHiddenChanged():void
        {
            view.setVisible(!image.hidden);
        }

        private function onBoundsChanged():void
        {
            view.setBounds(image.bounds);
        }
    }
}
