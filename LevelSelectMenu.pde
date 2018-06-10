/**
 * menu to select level to play;
 */
public class LevelSelectMenu extends AMenu  implements IDrawable {

    /**
     * set properties of this
     */
    LevelSelectMenu(boolean isActive) {
        super(isActive);
    }

    /**
     * setup and activate this
     */
    void setupActivateMenu() {
        // make this active
        this.isActive = true;
        registerMethod("draw", this); // connect this draw() from main draw()
        
        this.panelsList.add(new LevelSelectMenuPanel(
            1,
            100,
            100,
            Constants.PANEL_HEIGHT,
            Constants.PANEL_WIDTH,
            this.isActive
        ));

        this.panelsList.add(new LevelSelectMenuPanel(
            2,
            400,
            100,
            Constants.PANEL_HEIGHT,
            Constants.PANEL_WIDTH,
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
