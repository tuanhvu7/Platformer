/**
 * panels in pause menu
 */
public class PauseMenuPanel extends APanel {

    // horizontal offset of this due to viewbox
    private final int horizontalOffset;

    // panel type
    private final EPauseMenuButtonType panelType;

    /**
     * set properties of this
     */
    public PauseMenuPanel(EPauseMenuButtonType panelType,
                          int leftX, int topY, int width, int height,
                          int horizontalOffset, boolean isActive) {
        super(panelType.name(), leftX, topY, width, height, isActive);
        this.horizontalOffset = horizontalOffset;
        this.panelType = panelType;
    }

    /**
     * to execute when this panel is clicked
     */
    @Override
    void executeWhenClicked() {
        if (panelType == EPauseMenuButtonType.CONTINUE) {
            resourceUtils.loopSong(ESongType.LEVEL);
            getCurrentActiveLevel().setPaused(false);
            getCurrentActiveLevel().closePauseMenu();

        } else {
            getCurrentActiveLevel().closePauseMenu();
            getCurrentActiveLevel().deactivateLevel();
            setCurrentActiveLevelNumber(0);
            getLevelSelectMenu().setupActivateMenu();
        }

        loop();
    }

    /**
     * return if mouse position inside this panel
     */
    @Override
    boolean isMouseIn() {
        return mouseX > this.leftX - horizontalOffset &&   // subtract offset since mouseX is unaffected by viewbox
            mouseX < this.rightX - horizontalOffset &&  // subtract offset since mouseX is unaffected by viewbox
            mouseY > this.topY &&
            mouseY < this.bottomY;
    }

}