package eghomeassignment.models
{
    import eghomeassignment.models.signals.ImageSignal;

    public interface ICollageModel
    {
        function get imageAdded():ImageSignal;

        function get imageRemoved():ImageSignal;
    }
}
