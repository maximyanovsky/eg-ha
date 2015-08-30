package services.search
{
    import org.osflash.signals.Signal;

    import services.search.vos.SearchResultVO;

    public class SearchResultVOSignal extends Signal
    {
        public function SearchResultVOSignal()
        {
            super (SearchResultVO);
        }
    }
}
