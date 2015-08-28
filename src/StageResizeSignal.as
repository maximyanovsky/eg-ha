package
{
    import flash.display.Stage;
    import flash.events.Event;

    import org.osflash.signals.Signal;
    import org.osflash.signals.natives.NativeSignal;

    public class StageResizeSignal extends Signal
    {
        public function StageResizeSignal(stage:Stage)
        {
            var nativeSignal:NativeSignal = new NativeSignal(stage, Event.RESIZE);
            nativeSignal.add(onResize);
            super ();
        }

        private function onResize(e:Event):void
        {
            dispatch();
        }
    }
}
