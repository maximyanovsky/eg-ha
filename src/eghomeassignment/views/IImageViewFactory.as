package eghomeassignment.views
{
    import eghomeassignment.models.IImageModel;

    import flash.display.DisplayObject;

    public interface IImageViewFactory
    {
        function createView(image:IImageModel):DisplayObject;
    }
}
