package eghomeassignment.controller
{
    import eghomeassignment.models.CollageModel;
    import eghomeassignment.models.IImageModel;
    import eghomeassignment.models.ImageModel;

    public class RemoveImageFromCollageCommand
    {
        [Inject]
        public var image:IImageModel;
        [Inject]
        public var collage:CollageModel;

        public function execute():void
        {
            collage.removeImage(ImageModel(image));
        }
    }
}
