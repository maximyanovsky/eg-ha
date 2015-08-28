package
{
    import org.robotlegs.mvcs.Mediator;

    import views.GalleryView;

    public class GalleryMediator extends Mediator
    {
        [Inject] public var stageResized:StageResizeSignal;
        [Inject] public var searchSubmitted:SearchSubmittedSignal;

        [Inject] public var view:GalleryView;

        override public function onRegister():void
        {
            stageResized.add(onStageResized);
            view.input.changed.add(onInputChanged);
            view.searchButton.clicked.add(onSearchClick);

            onStageResized();
            onInputChanged();
        }

        private function onSearchClick():void
        {
            searchSubmitted.dispatch(view.input.value);
        }

        private function onInputChanged():void
        {
            view.searchButton.enabled = view.input.value.length > 0;
        }

        private function onStageResized():void
        {
            view.update();
        }
    }
}
