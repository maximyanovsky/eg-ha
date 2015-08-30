package views
{
    import flash.display.DisplayObject;

    import models.IImageModel;

    public interface IImageViewFactory
    {
        function createView(image:IImageModel):DisplayObject;
    }
}
