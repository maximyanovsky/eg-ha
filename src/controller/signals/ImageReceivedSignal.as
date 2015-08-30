package controller.signals
{
    import org.osflash.signals.Signal;

    import services.search.vos.ImageVO;

    public class ImageReceivedSignal extends Signal
    {
        public function ImageReceivedSignal()
        {
            super (ImageVO);
        }
    }
}
