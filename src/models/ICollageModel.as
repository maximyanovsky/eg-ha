package models
{
    public interface ICollageModel
    {
        function get imageAdded():ImageSignal;

        function get imageRemoved():ImageSignal;
    }
}
