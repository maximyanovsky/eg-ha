package
{
    import eghomeassignment.GalleryContext;

    import flash.display.Sprite;

    import org.robotlegs.core.IContext;

    [SWF(width="800", height="600", frameRate="30", backgroundColor="#FFFFFF")]
    public class EvolutionGaming extends Sprite
    {
        public function EvolutionGaming()
        {
            var context:IContext = new GalleryContext(this);
        }
    }
}
