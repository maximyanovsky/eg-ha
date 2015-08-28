package common.signals
{
    import flash.events.ErrorEvent;

    import org.osflash.signals.Signal;

    public class SignalErrorEvent extends Signal
    {
        public function SignalErrorEvent()
        {
            super (ErrorEvent)
        }
    }
}
