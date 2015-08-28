package services.search
{
    import org.osflash.signals.Signal;

    import services.search.vos.SearchResultVO;

    public class SignalSearchResult extends Signal
    {
        public function SignalSearchResult()
        {
            super (SearchResultVO);
        }
    }
}
