package services.search
{
    import org.flexunit.asserts.assertEquals;
    import org.flexunit.asserts.assertNotNull;

    import services.search.vos.SearchResultVO;

    public class FreeImagesJSONResultParserTest
    {
        private var _parser:FreeImagesJSONResultParser;

        [Before]
        public function beforeEach():void
        {
            _parser = new FreeImagesJSONResultParser();
        }

        [Test]
        public function shouldReturnValidResult():void
        {
            var result:SearchResultVO = _parser.parse(JSON.stringify(
                    {
                        "sources":[
                            {
                                "result": [{ "preview_url": "url1" }, { "preview_url": "url2" }]
                            },
                            {
                                "result": [{ "preview_url": "url3" }]
                            }
                        ]
                    }));
            assertNotNull(result);
            assertNotNull(result.images);
            assertEquals(3, result.images.length);
            assertEquals("url1", result.images[0].url);
            assertEquals("url2", result.images[1].url);
            assertEquals("url3", result.images[2].url);
        }

        [Test (expects="services.search.ParserError")]
        public function shouldThrowErrorIfDataIsNull():void
        {
            _parser.parse(null);
        }

        [Test (expects="services.search.ParserError")]
        public function shouldThrowErrorIfDataIsInvalidJson():void
        {
            _parser.parse("{ 'this json : 'is invalid'}");
        }

        [Test (expects="services.search.ParserError")]
        public function shouldThrowErrorIfSourcesNotProvided():void
        {
            _parser.parse(JSON.stringify({"sourcez":[]}));
        }

        [Test (expects="services.search.ParserError")]
        public function shouldThrowErrorIfSourcesIsInvalid():void
        {
            _parser.parse(JSON.stringify({"sources":{}}));
        }

        [Test (expects="services.search.ParserError")]
        public function shouldThrowErrorIfSourceIsNotAHash():void
        {
            _parser.parse(JSON.stringify({"sources":[1]}));
        }

        [Test (expects="services.search.ParserError")]
        public function shouldThrowErrorIfResultNotprovided():void
        {
            _parser.parse(JSON.stringify({"sources":[{}]}));
        }

        [Test (expects="services.search.ParserError")]
        public function shouldThrowErrorIfResultIsNotAHah():void
        {
            _parser.parse(JSON.stringify({"sources":[{"result":2}]}));
        }

        [Test (expects="services.search.ParserError")]
        public function shouldThrowErrorIfResultIsNull():void
        {
            _parser.parse(JSON.stringify({"sources":[{"result":null}]}));
        }
    }
}
