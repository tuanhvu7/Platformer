/**
 * panel in level select menu
 */
public class LevelSelectMenuPanel extends APanel {

    // level associated with this
    private final int panelLevel;

    /**
     * set properties of this
     */
    public LevelSelectMenuPanel(int panelLevel, int leftX, int topY, int width, int height, boolean isActive) {
        super(panelLevel + "", leftX, topY, width, height, isActive);
        this.panelLevel = panelLevel;
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
        setCurrentActiveLevel(levelFactory.getLevel(true, false));
    }
}
