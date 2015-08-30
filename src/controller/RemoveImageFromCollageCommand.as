package controller
{
    import models.CollageModel;
    import models.IImageModel;
    import models.ImageModel;

    public class RemoveImageFromCollageCommand
    {
        [Inject] public var image:IImageModel;
        [Inject] public var collage:CollageModel;

        public function execute():void
        {
            collage.removeImage(ImageModel(image));
        }
    }
}
