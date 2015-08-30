package controller
{
    import flash.display.StageAlign;
    import flash.display.StageScaleMode;

    import org.robotlegs.mvcs.SignalCommand;

    import views.ui.GalleryView;

    public class StartupCommand extends SignalCommand
    {
        override public function execute():void
        {
            contextView.stage.scaleMode = StageScaleMode.NO_SCALE;
            contextView.stage.align = StageAlign.TOP_LEFT;
            contextView.addChild(new GalleryView());
        }
    }
}
