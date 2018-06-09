/**
 * menu to select level to play;
 */
public class LevelSelectMenu implements IDrawable {

    // true means this is displayed
    boolean isActive;

    // list of level panels
    List<LevelPanel> levelPanelsList;

    /**
     * set properties of this
     */
    LevelSelectMenu(boolean isActive) {
        this.levelPanelsList = new ArrayList<LevelPanel>();
        if(isActive) {
            this.setupActivateLevelSelectMenu();
        }
    }

    /**
     * setup and activate this
     */
    void setupActivateLevelSelectMenu() {
        // make this active
        this.isActive = true;
        registerMethod("draw", this); // connect this draw() from main draw()
        
        this.levelPanelsList.add(new LevelPanel(
            1,
            100,
            100,
            Constants.LEVEL_PANEL_HEIGHT,
            Constants.LEVEL_PANEL_WIDTH,
            this.isActive
        ));

        this.levelPanelsList.add(new LevelPanel(
            2,
            400,
            100,
            Constants.LEVEL_PANEL_HEIGHT,
            Constants.LEVEL_PANEL_WIDTH,
            this.isActive
        ));
    }

    /**
     * deactiviate this
     */
    void deactivateLevelSelectMenu() {
        for(LevelPanel curLevelPanel : this.levelPanelsList) {
            curLevelPanel.makeNotActive();
        }
        
        // make level not active
        this.isActive = false;
        unregisterMethod("draw", this); // disconnect this draw() from main draw()
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
