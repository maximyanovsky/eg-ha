package eghomeassignment.services.search
{
    import eghomeassignment.services.search.vos.SearchResultVO;

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
