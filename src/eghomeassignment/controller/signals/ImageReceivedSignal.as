package eghomeassignment.controller.signals
{
    import eghomeassignment.services.search.vos.ImageVO;

    import org.osflash.signals.Signal;

    public class ImageReceivedSignal extends Signal
    {
        public function ImageReceivedSignal()
        {
            super(ImageVO);
        }
    }
}
