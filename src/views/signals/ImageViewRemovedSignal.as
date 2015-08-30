package views.signals
{
    import models.IImageModel;

    import org.osflash.signals.Signal;

    public class ImageViewRemovedSignal extends Signal
    {
        public function ImageViewRemovedSignal()
        {
            super (IImageModel);
        }
    }
}
