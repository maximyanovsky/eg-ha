package eghomeassignment.utils
{
    public class PackUtils
    {
        public static function findOptimalRowHeight(width:Number, height:Number, items:*):Number
        {
            var step:uint = Math.ceil(height/100);
            var bestRowHeight:Number = step;
            var result:PackResult = new PackResult();
            for (var rowHeight:Number = bestRowHeight; rowHeight < height; rowHeight += step)
            {
                result = getPackResult(width, height, rowHeight, items, result);
                if (result.status == PackResult.STATUS_UNFIT)
                    return bestRowHeight;
                else
                    bestRowHeight = rowHeight;
            }
            return bestRowHeight;
        }

        private static function getPackResult(width:Number, height:Number, rowHeight:Number, items:*, outResult:PackResult = null):PackResult
        {
            var retval:PackResult = outResult || new PackResult();
            var fit:Vector.<Boolean> = new Vector.<Boolean>(items.length, true);
            var rowCount:int = height / rowHeight;
            var i:int;

            retval.unfitspace = 0;
            retval.whitespace = 0;
            for (var rowIndex:int = 0; rowIndex < rowCount; rowIndex++)
            {
                var rowFreeSpace:Number = width;
                for (i = 0; i < items.length; ++i)
                {
                    if (fit[i]) continue;

                    var pic:IPackable = items[i];
                    var picWidth:Number = rowHeight * pic.aspectRatio;
                    if (picWidth <= rowFreeSpace)
                    {
                        rowFreeSpace -= picWidth;
                        fit[i] = true;
                    }
                }
                retval.whitespace += rowFreeSpace;
            }
            for (i = 0; i < items.length; ++i)
                if (!fit[i]) retval.unfitspace += items[i].aspectRatio * rowHeight;

            if (retval.unfitspace > 0)
                retval.status = PackResult.STATUS_UNFIT;
            else
                retval.status = PackResult.STATUS_FIT;
            return retval;
        }
    }
}
