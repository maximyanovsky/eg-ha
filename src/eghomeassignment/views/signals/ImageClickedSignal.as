package eghomeassignment.views.signals
{
    import eghomeassignment.models.IImageModel;

    import org.osflash.signals.Signal;

    public class ImageClickedSignal extends Signal
    {
        public function ImageClickedSignal()
        {
            super(IImageModel);
        }
    }
}
