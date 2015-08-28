package services.search
{
    import flash.events.Event;

    import mockolate.mock;
    import mockolate.partial;
    import mockolate.prepare;
    import mockolate.received;

    import org.flexunit.assertThat;
    import org.flexunit.async.Async;
    import org.hamcrest.object.equalTo;
    import org.hamcrest.text.containsString;
    import org.swiftsuspenders.Injector;

    import services.network.INetworkService;
    import services.search.vos.SearchResultVO;

    public class FreeImagesSearchServiceTest
    {
        [Before(async, timeout=5000)]
        public function prepareMockolates():void
        {
            Async.proceedOnEvent(this,
                    prepare(MockNetworkService, MockImagesParser),
                    Event.COMPLETE);
        }

        [Test]
        public function shouldLoadDataAndPassItToParserThenDispatchReceived():void
        {
            var injector:Injector = new Injector();
            var networkService:MockNetworkService = partial(MockNetworkService);
            var parser:MockImagesParser = partial(MockImagesParser);

            injector.mapValue(INetworkService, networkService);
            injector.mapValue(ISearchResultParser, parser);
            injector.mapClass(IImageSearchService, FreeImagesSearchService);

            var service:IImageSearchService = injector.getInstance(IImageSearchService);

            const KEYWORD:String = "some keyword";
            const DATA:String = "some data";

            mock(networkService).method("load").args(containsString(KEYWORD)).calls(function():void{
               networkService.received.dispatch(DATA);
            });
            var testResult:SearchResultVO = new SearchResultVO();
            mock(parser).method("parse").args(equalTo(DATA)).returns(testResult);

            var givenResult:SearchResultVO;
            service.received.add(function(result:SearchResultVO):void
            {
                givenResult = result;
            });

            service.getResults(KEYWORD);

            assertThat(networkService, received().method("load"));
            assertThat(parser, received().method("parse").arg(equalTo(DATA)));
            assertThat(testResult, equalTo(givenResult));
        }
    }
}
