/**
 * panels in pause menu
 */
public class PauseMenuPanel extends APanel implements IDrawable {

    // panel type
    PauseMenuButtonType panelType;

    /**
     * set properties of this
     */
    PauseMenuPanel(PauseMenuButtonType panelType, int leftX, int topY, int width, int height, boolean isActive) {
        super(panelType.name(), leftX, topY, width, height, isActive);
        this.panelType = panelType;
    }

    /**
     * to execute when this panel is clicked
     */
    void executeWhenClicked() {
        if(panelType == PauseMenuButtonType.Continue) {
            loadLevelSong();
            loopSong();
            global_levels_list.get(global_current_active_level).get().closePauseMenu();
            global_levels_list.get(global_current_active_level).get().isPaused = false; // TODO: encapsulate
        
        } else {
            global_levels_list.get(global_current_active_level).get().isPaused = false; // TODO: encapsulate
            global_levels_list.get(global_current_active_level).get().closePauseMenu();
            global_levels_list.get(global_current_active_level).get().deactivateLevel();
            global_current_active_level = 0;
            global_level_select_menu.setupActivateMenu();
        }

        loop();
    }

}
