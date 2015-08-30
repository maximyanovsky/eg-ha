package views
{
    import flash.events.MouseEvent;

    import views.signals.ImageClickedSignal;
    import views.signals.ImageViewRemovedSignal;

    import models.IImageModel;

    import org.robotlegs.mvcs.Mediator;

    import views.ui.ImageView;

    public class ImageMediator extends Mediator
    {
        [Inject] public var image:IImageModel;
        [Inject] public var view:ImageView;
        [Inject] public var imageRemoved:ImageViewRemovedSignal;
        [Inject] public var imageClicked:ImageClickedSignal;

        override public function onRegister():void
        {
            view.setBitmapData(image.data);
            view.clicked.add(onViewClicked);

            image.boundsChanged.add(onBoundsChanged);
            image.hiddenChanged.add(onHiddenChanged);
            image.removedFromCollage.add(onRemovedFromCollage);

            onHiddenChanged();
            if (image.bounds)
                onBoundsChanged();
        }

        private function onViewClicked(e:MouseEvent):void
        {
            imageClicked.dispatch(image);
        }

        private function onRemovedFromCollage():void
        {
            view.clicked.remove(onViewClicked);
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
            view.dispose();
            super.preRemove();
        }
    }
}
