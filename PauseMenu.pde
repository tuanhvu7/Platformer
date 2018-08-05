/**
 * pause menu
 */
public class PauseMenu extends AMenu implements IDrawable {

    /**
     * set properties of this
     */
    public PauseMenu(int horizontalOffset, boolean isActive) {
        super(horizontalOffset, isActive);
    }

    /**
     * setup and activate this
     */
    @Override
    public void setupActivateMenu() {
        // make this active
        this.isActive = true;
        registerMethod("draw", this); // connect this draw() from main draw()

        this.panelsList.add(new PauseMenuPanel(
            EPauseMenuButtonType.Continue,
            100 + this.horizontalOffset,    // add offset to account for viewbox
            100,
            Constants.PANEL_WIDTH,
            Constants.PANEL_HEIGHT,
            this.horizontalOffset,
            this.isActive
        ));

        this.panelsList.add(new PauseMenuPanel(
            EPauseMenuButtonType.Quit,
            400 + this.horizontalOffset,    // add offset to account for viewbox
            100,
            Constants.PANEL_WIDTH,
            Constants.PANEL_HEIGHT,
            this.horizontalOffset,
            this.isActive
        ));
    }

    /**
     * runs continuously; draws background of this
     */
    @Override
    public void draw() {
        image(
            global_background_image,
            this.horizontalOffset,  // add offset to account for viewbox
            0,
            global_background_image.width,
            global_background_image.height);
    }
}