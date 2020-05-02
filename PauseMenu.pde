/**
 * pause menu
 */
public class PauseMenu extends AMenu {

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
        registerMethod(EProcessingMethods.DRAW.toString(), this); // connect this draw() from main draw()

        this.panelsList.add(new PauseMenuPanel(
            EPauseMenuButtonType.CONTINUE,
            100 + this.horizontalOffset,    // add offset to account for viewbox
            100,
            Constants.PANEL_SIZE,
            Constants.PANEL_SIZE,
            this.horizontalOffset,
            true
        ));

        this.panelsList.add(new PauseMenuPanel(
            EPauseMenuButtonType.QUIT,
            400 + this.horizontalOffset,    // add offset to account for viewbox
            100,
            Constants.PANEL_SIZE,
            Constants.PANEL_SIZE,
            this.horizontalOffset,
            true
        ));
    }

    /**
     * runs continuously; draws background of this
     */
    @Override
    public void draw() { }
}