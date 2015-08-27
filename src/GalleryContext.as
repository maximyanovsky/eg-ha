package
{
    import flash.display.DisplayObjectContainer;

    import org.osflash.signals.ISignal;
    import org.osflash.signals.natives.NativeSignal;
    import org.robotlegs.base.ContextError;
    import org.robotlegs.base.ContextEvent;
    import org.robotlegs.mvcs.Context;
    import org.robotlegs.mvcs.SignalContext;

    public class GalleryContext extends SignalContext
    {
        public function GalleryContext(contextView:DisplayObjectContainer)
        {
            super (contextView)
        }

        override public function startup():void
        {
            var startupComplete:ISignal = new NativeSignal(this, ContextEvent.STARTUP_COMPLETE);

            signalCommandMap.mapSignal(startupComplete, StartupCommand);

            super.startup();
        }
    }
}
