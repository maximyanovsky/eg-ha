package eghomeassignment.controller
{
    import eghomeassignment.views.ui.GalleryView;

    import flash.display.StageAlign;
    import flash.display.StageScaleMode;

    import org.robotlegs.mvcs.SignalCommand;

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
