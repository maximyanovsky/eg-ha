package eghomeassignment.controller
{
    import eghomeassignment.models.IImageModel;

    public class DestroyImageCommand
    {
        [Inject]
        public var image:IImageModel;

        public function execute():void
        {
            image.data.dispose();
        }
    }
}
