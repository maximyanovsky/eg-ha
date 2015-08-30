package controller
{
    import controller.UpdateCollageLayoutCommand;

    import models.CollageModel;
    import models.ImageModel;

    import org.flexunit.assertThat;
    import org.hamcrest.number.between;
    import org.hamcrest.object.equalTo;

    import org.swiftsuspenders.Injector;

    public class UpdateCollageLayoutCommandTest
    {
        private var _collage:CollageModel;

        private var _cmd:UpdateCollageLayoutCommand;

        [Before]
        public function beforeEach():void
        {
            var injector:Injector = new Injector();
            _collage = new CollageModel();
            injector.mapValue(CollageModel, _collage);
            injector.mapClass(UpdateCollageLayoutCommand, UpdateCollageLayoutCommand);
            _cmd = new UpdateCollageLayoutCommand();
            injector.injectInto(_cmd);
        }

        [Test]
        public function shouldFitOneToOne():void
        {
            _collage.setSize(1, 1);
            var picture:ImageModel = new ImageModel(1, 1);
            _collage.addImage(picture);
            _cmd.execute();

            assertThat(picture.bounds.x, equalTo(0));
            assertThat(picture.bounds.y, equalTo(0));
            assertThat(picture.bounds.width, equalTo(1));
            assertThat(picture.bounds.height, equalTo(1));
        }

        [Test]
        public function shouldScaleSmallerToOne():void
        {
            _collage.setSize(1, 1);
            var picture:ImageModel = new ImageModel(0.5, 0.5);
            _collage.addImage(picture);
            _cmd.execute();

            assertThat(picture.bounds.x, equalTo(0));
            assertThat(picture.bounds.y, equalTo(0));
            assertThat(picture.bounds.width, equalTo(1));
            assertThat(picture.bounds.height, equalTo(1));
        }
    }
}
