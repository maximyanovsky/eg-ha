package controller
{
    import models.CollageModel;

    import org.robotlegs.mvcs.Command;

    public class ResizeCollageCommand extends Command
    {
        [Inject] public var collageModel:CollageModel;

        override public function execute():void
        {
            collageModel.setSize(contextView.stage.stageWidth, contextView.stage.stageHeight - 50);
        }
    }
}
