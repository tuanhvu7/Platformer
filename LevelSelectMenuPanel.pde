/**
 * panel in level select menu
 */
public class LevelSelectMenuPanel extends APanel implements IDrawable {

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
        // setup and load level associated with this
        getLevelSelectMenu().deactivateMenu();
        setCurrentActiveLevelNumber(this.panelLevel);
        LevelFactory levelFactory = new LevelFactory();
        setCurrentActiveLevel(levelFactory.getLevel(true, false));
    }
}
