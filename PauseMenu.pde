/**
 * pause menu
 */
public class PauseMenu extends AMenu implements IDrawable {

    /**
     * set properties of this
     */
    PauseMenu(boolean isActive) {
        super(isActive);
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
            100,
            100,
            Constants.LEVEL_PANEL_HEIGHT,
            Constants.LEVEL_PANEL_WIDTH,
            this.isActive
        ));

        this.panelsList.add(new PauseMenuPanel(
            PauseMenuButtonType.Quit,
            400,
            100,
            Constants.LEVEL_PANEL_HEIGHT,
            Constants.LEVEL_PANEL_WIDTH,
            this.isActive
        ));
    }

    /**
     * runs continuously; draws background of this
     */
    void draw() {
        image(
            global_background_image, 
            0, 
            0, 
            global_background_image.width, 
            global_background_image.height);
    }
}