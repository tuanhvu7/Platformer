/**
 * panels in pause menu
 */
public class PauseMenuPanel extends APanel implements IDrawable {

    // horizontal offset of this due to viewbox
    int horizontalOffset;

    // panel type
    PauseMenuButtonType panelType;

    /**
     * set properties of this
     */
    PauseMenuPanel(PauseMenuButtonType panelType,
                    int leftX, int topY, int width, int height,
                    int horizontalOffset, boolean isActive) {
        super(panelType.name(), leftX, topY, width, height, isActive);
        this.horizontalOffset = horizontalOffset;
        this.panelType = panelType;
    }

    /**
     * to execute when this panel is clicked
     */
    void executeWhenClicked() {
        if(panelType == PauseMenuButtonType.Continue) {
            loopSong(ESongType.Level);
            global_current_active_level.get().isPaused = false; // TODO: encapsulate
            global_current_active_level.get().closePauseMenu();
        
        } else {
            global_current_active_level.get().isPaused = false; // TODO: encapsulate
            global_current_active_level.get().closePauseMenu();
            global_current_active_level.get().deactivateLevel();
            global_current_active_level_number = 0;
            global_level_select_menu.setupActivateMenu();
        }

        loop();
    }

   /**
    * return if mouse position inside this panel
    */
    protected boolean isMouseIn() {
        return  mouseX > this.leftX - horizontalOffset &&   // subtract offset since mouseX is unaffected by viewbox
                mouseX < this.rightX - horizontalOffset &&  // subtract offset since mouseX is unaffected by viewbox
                mouseY > this.topY &&
                mouseY < this.bottomY;
    }

}
