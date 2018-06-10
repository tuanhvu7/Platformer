/**
 * pause menu
 */
public class PauseMenu extends AMenu implements IDrawable {

    /**
     * set properties of this
     */
    PauseMenu(int horizontalOffset, boolean isActive) {
        super(horizontalOffset, isActive);
    }

    /**
     * setup and activate this
     */
    void setupActivateMenu() {
        // make this active
        this.isActive = true;
        registerMethod("draw", this); // connect this draw() from main draw()
        
        this.panelsList.add(new PauseMenuPanel(
            PauseMenuButtonType.Continue,
            100 + this.horizontalOffset,    // add offset to account for viewbox
            100,
            Constants.PANEL_HEIGHT,
            Constants.PANEL_WIDTH,
            this.horizontalOffset,
            this.isActive
        ));

        this.panelsList.add(new PauseMenuPanel(
            PauseMenuButtonType.Quit,
            400 + this.horizontalOffset,    // add offset to account for viewbox
            100,
            Constants.PANEL_HEIGHT,
            Constants.PANEL_WIDTH,
            this.horizontalOffset,
            this.isActive
        ));
    }

    /**
     * runs continuously; draws background of this
     */
    void draw() {
        image(
            global_background_image, 
            0 + this.horizontalOffset,  // add offset to account for viewbox 
            0, 
            global_background_image.width, 
            global_background_image.height);
    }
}
