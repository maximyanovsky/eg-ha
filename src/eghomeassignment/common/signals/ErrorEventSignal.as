package eghomeassignment.common.signals
{
    import flash.events.ErrorEvent;

    import org.osflash.signals.Signal;

    public class ErrorEventSignal extends Signal
    {
        public function ErrorEventSignal()
        {
            super(ErrorEvent)
        }
    }
}
