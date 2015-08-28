package services.search
{
    import services.search.vos.SearchResultVO;

    public class MockImagesParser implements ISearchResultParser
    {
        public function MockImagesParser()
        {
        }

        public function parse(data:String):SearchResultVO
        {
            return null;
        }
    }
}
