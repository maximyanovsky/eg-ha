package services.search
{
    import services.search.vos.ImageVO;
    import services.search.vos.SearchResultVO;

    /**
     * Implementation of SearchResultParser to parse JSON data from free images API
     */
    public class FreeImagesJSONResultParser implements ISearchResultParser
    {
        public function parse(rawData:String):SearchResultVO
        {
            var data:Object = JSON.parse(rawData);

            var result:SearchResultVO = new SearchResultVO();
            result.images = new Vector.<ImageVO>();

            for each (var sourceData:Object in data["sources"])
            {
                for each (var imgData:Object in sourceData["result"])
                {
                    var img:ImageVO = new ImageVO();
                    img.url = imgData["preview_url"];
                    result.images.push(img);
                }
            }
            return result;
        }
    }
}
