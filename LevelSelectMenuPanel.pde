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
        registerMethod("draw", this); // connect this draw() from main draw()
        registerMethod("mouseEvent", this); // connect this mouseEvent() from main mouseEvent()
        registerMethod("keyEvent", this); // connect this keyEvent() from main keyEvent()
    }

    /**
     * deactivate and remove this from game
     */
    @Override
    public void makeNotActive() {
        unregisterMethod("draw", this); // disconnect this draw() from main draw()
        unregisterMethod("mouseEvent", this); // connect this mouseEvent() from main mouseEvent()
        unregisterMethod("keyEvent", this); // connect this keyEvent() from main keyEvent()
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
     * handle panel keypress controls
     */
    public void keyEvent(KeyEvent keyEvent) {
        if (keyEvent.getAction() == KeyEvent.PRESS) {
            String keyPressed = keyEvent.getKey() + "";
            if ("c".equalsIgnoreCase(keyPressed)) {
                this.loadLevelFromCheckpoint = !this.loadLevelFromCheckpoint;
                if (this.loadLevelFromCheckpoint) {
                    this.panelColor = Constants.LEVEL_CHECKPOINT_LOAD_PANEL_COLOR;
                } else {
                    this.panelColor = Constants.DEFAULT_PANEL_COLOR;
                }
            }
        }
    }
}
