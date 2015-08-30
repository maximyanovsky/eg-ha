package views
{
    import controller.signals.ImageViewRemovedSignal;

    import models.IImageModel;

    import org.robotlegs.mvcs.Mediator;

    import views.ui.ImageView;

    public class ImageMediator extends Mediator
    {
        [Inject] public var image:IImageModel;
        [Inject] public var view:ImageView;
        [Inject] public var imageRemoved:ImageViewRemovedSignal;

        override public function onRegister():void
        {
            view.setBitmapData(image.data);

            image.boundsChanged.add(onBoundsChanged);
            image.hiddenChanged.add(onHiddenChanged);
            image.removedFromCollage.add(onRemovedFromCollage);
            onHiddenChanged();
            if (image.bounds)
                onBoundsChanged();
        }

        private function onRemovedFromCollage():void
        {
            view.setVisible(false, onHideComplete);
        }

        private function onHideComplete():void
        {
            imageRemoved.dispatch(image);
            view.parent.removeChild(view);
        }

        private function onHiddenChanged():void
        {
            view.setVisible(!image.hidden);
        }

        private function onBoundsChanged():void
        {
            view.setBounds(image.bounds);
        }

        override public function preRemove():void
        {
            image.boundsChanged.removeAll();
            image.hiddenChanged.removeAll();
            image.removedFromCollage.removeAll();
            super.preRemove();
        }
    }
}
