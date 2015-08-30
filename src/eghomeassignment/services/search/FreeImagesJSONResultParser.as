package eghomeassignment.services.search
{
    import eghomeassignment.services.search.vos.ImageVO;
    import eghomeassignment.services.search.vos.SearchResultVO;

    /**
     * Implementation of SearchResultParser to parse JSON data from free images API
     */
    public class FreeImagesJSONResultParser implements ISearchResultParser
    {
        public function parse(rawData:String):SearchResultVO
        {
            if (!rawData) throw new ParserError("invalid data");

            var data:Object;
            try
            {
                data = JSON.parse(rawData);
            } catch (e:Error)
            {
                throw new ParserError("invalid json")
            }

            var retval:SearchResultVO = new SearchResultVO();
            retval.images = new Vector.<ImageVO>();

            var sources:Array = data["sources"] as Array;
            if (!sources) throw new ParserError("invalid sources");

            for each (var sourceData:Object in sources)
            {
                if (typeof sourceData != "object") throw new ParserError("invalid source");
                var results:Array = sourceData["result"] as Array;

                if (!results) throw new ParserError("invalid result for source " + sourceData["source_name"]);

                for each (var imgData:Object in results)
                {
                    var img:ImageVO = new ImageVO();
                    img.url = getString(imgData, "preview_url");
                    retval.images.push(img);
                }
            }
            return retval;
        }

        private static function getString(source:Object, property:String):String
        {
            if (!source || !source.hasOwnProperty(property)) throw new ParserError("invalid image " + property);
            return source[property];
        }
    }
}
