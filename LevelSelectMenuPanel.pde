/**
 * panel in level select menu
 */
public class LevelSelectMenuPanel extends APanel {

    // level associated with this
    private final int panelLevel;

    // true means load level from checkpoint
    private boolean loadLevelFromCheckpoint;

    /**
     * set properties of this
     */
    public LevelSelectMenuPanel(int panelLevel, int leftX, int topY, int width, int height, boolean isActive) {
        super(Constants.DEFAULT_PANEL_COLOR, panelLevel + "", leftX, topY, width, height, isActive);
        this.panelLevel = panelLevel;
        this.loadLevelFromCheckpoint = false;
    }

    /**
     * active and add this to game
     */
    @Override
    void makeActive() {
        registerMethod(EProcessingMethods.DRAW.toString(), this); // connect this draw() from main draw()
        registerMethod(EProcessingMethods.MOUSE_EVENT.toString(), this); // connect this mouseEvent() from main mouseEvent()
    }

    /**
     * deactivate and remove this from game
     */
    @Override
    public void makeNotActive() {
        unregisterMethod(EProcessingMethods.DRAW.toString(), this); // disconnect this draw() from main draw()
        unregisterMethod(EProcessingMethods.MOUSE_EVENT.toString(), this); // disconnect this mouseEvent() from main mouseEvent()
    }

    
    /**
     * to execute when this panel is clicked
     */
    @Override
    void executeWhenClicked() {
        getLevelSelectMenu().deactivateMenu();
        resourceUtils.stopSong();
        // setup and load level associated with this
        setCurrentActiveLevelNumber(this.panelLevel);
        LevelFactory levelFactory = new LevelFactory();
        setCurrentActiveLevel(levelFactory.getLevel(true, this.loadLevelFromCheckpoint));
    }

    /**
     * toggle loadLevelFromCheckpoint
     */
    public void toggleLoadLevelFromCheckpoint() {
        this.loadLevelFromCheckpoint = !this.loadLevelFromCheckpoint;
        if (this.loadLevelFromCheckpoint) {
            this.panelColor = Constants.ALTERNATE_PANEL_COLOR;
        } else {
            this.panelColor = Constants.DEFAULT_PANEL_COLOR;
        }
    }
}
