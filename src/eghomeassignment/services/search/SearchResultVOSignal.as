package eghomeassignment.services.search
{
    import eghomeassignment.services.search.vos.SearchResultVO;

    import org.osflash.signals.Signal;

    public class SearchResultVOSignal extends Signal
    {
        public function SearchResultVOSignal()
        {
            super(SearchResultVO);
        }
    }
}
