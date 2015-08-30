package eghomeassignment.controller
{
    import eghomeassignment.models.CollageModel;
    import eghomeassignment.models.ImageModel;

    import flash.geom.Rectangle;

    public class UpdateCollageLayoutCommand
    {
        [Inject]
        public var collageModel:CollageModel;

        public function execute():void
        {
            var width:Number = collageModel.width;
            var height:Number = collageModel.height;

            var rowHeight:Number = 150;
            if (height > rowHeight * 2)
            {
                rowHeight = height / Math.floor(height / rowHeight);
            }
            else
            {
                rowHeight = height;
            }

            var rowCount:int = height / rowHeight;

            var images:Vector.<ImageModel> = collageModel.images.concat();
            images.sort(sortOnWidthAndHidden);

            for (var rowIndex:int = 0; rowIndex < rowCount; rowIndex++)
            {
                var rowFreeSpace:Number = width;
                for (var i:int = 0; i < images.length; ++i)
                {
                    var pic:ImageModel = images[i];
                    if (!pic) continue;
                    var picWidth:Number = rowHeight * pic.aspectRatio;
                    if (picWidth <= rowFreeSpace)
                    {
                        pic.setHidden(false);
                        var bounds:Rectangle = new Rectangle();
                        bounds.x = collageModel.width - rowFreeSpace;
                        bounds.y = rowIndex * rowHeight;

                        bounds.height = rowHeight;
                        bounds.width = picWidth;
                        pic.setBounds(bounds);

                        rowFreeSpace -= picWidth;
                        images[i] = null;
                    }
                }
            }

            for (var i:int = 0; i < images.length; ++i)
            {
                var pic:ImageModel = images[i];
                if (pic)
                {
                    pic.setHidden(true);
                }
            }
        }

        public static function sortOnWidthAndHidden(a:ImageModel, b:ImageModel):int
        {
            if (!a.hidden && b.hidden)
            {
                return -1;
            }

            if (a.width > b.width)
            {
                return -1;
            }
            else if (a.width == b.width)
            {
                return 0;
            }
            else
            {
                return 1;
            }
        }
    }
}
