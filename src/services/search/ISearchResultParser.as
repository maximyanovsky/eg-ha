package services.search
{
    import services.search.vos.SearchResultVO;

    public interface ISearchResultParser
    {
        /**
         * Parse data received from remote service
         * @param data
         * @return search result value object
         * @throws ParserError
         */
        function parse(data:String):SearchResultVO;
    }
}
