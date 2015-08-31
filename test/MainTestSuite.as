package
{
    import eghomeassignment.services.search.FreeImagesJSONResultParserTest;
    import eghomeassignment.services.search.FreeImagesSearchServiceTest;

    [RunWith("org.flexunit.runners.Suite")]
    [Suite]
    public class MainTestSuite
    {
        public var extraQuestion:ExtraQuestionTest;
        public var extraTask:ExtraTaskTest;
        public var freeImagesJsonResultParser:FreeImagesJSONResultParserTest;
        public var freeImagesSearchService:FreeImagesSearchServiceTest;
    }
}
