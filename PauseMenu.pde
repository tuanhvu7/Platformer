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
            EPauseMenuButtonType.CONTINUE,
            100 + this.horizontalOffset,    // add offset to account for viewbox
            100,
            Constants.PANEL_WIDTH,
            Constants.PANEL_HEIGHT,
            this.horizontalOffset,
            this.isActive
        ));

        this.panelsList.add(new PauseMenuPanel(
            EPauseMenuButtonType.QUIT,
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
            getLevelBackgroundImage(),
            this.horizontalOffset,  // add offset to account for viewbox
            0,
            getLevelBackgroundImage().width,
            getLevelBackgroundImage().height);
    }
}