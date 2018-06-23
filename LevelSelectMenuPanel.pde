/**
 * panel in level select menu
 */
public class LevelSelectMenuPanel extends APanel implements IDrawable {

    // level associated with this
    int panelLevel;

    /**
     * set properties of this
     */
    LevelSelectMenuPanel(int panelLevel, int leftX, int topY, int width, int height, boolean isActive) {
        super(panelLevel + "", leftX, topY, width, height, isActive);
        this.panelLevel = panelLevel;
    }

    /**
     * to execute when this panel is clicked
     */
    void executeWhenClicked() {
        // setup and load level associated with this
        global_level_select_menu.deactivateMenu();
        global_current_active_level = panelLevel;
        global_levels_list.get(global_current_active_level).get().setUpActivateLevel();
    }
}
