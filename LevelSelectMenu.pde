/**
 * menu to select level to play;
 */
public class LevelSelectMenu extends AMenu {

    /**
     * set properties of this
     */
    public LevelSelectMenu(boolean isActive) {
        super(isActive);
    }

    /**
     * setup and activate this
     */
    @Override
    public void setupActivateMenu() {
        // make this active
        registerMethod("draw", this); // connect this draw() from main draw()

        int leftXPanelPosition = 100;
        int topYPanelPosition = 100;
        for (int i = 1; i < levelsHeightArray.length; i++) {
            if (leftXPanelPosition + Constants.PANEL_SIZE > resourceUtils.levelBackgroundImage.width) {
                leftXPanelPosition = 100;
                topYPanelPosition += (100 + Constants.PANEL_SIZE);
            }

            this.panelsList.add(new LevelSelectMenuPanel(
                i,
                leftXPanelPosition,
                topYPanelPosition,
                Constants.PANEL_SIZE,
                Constants.PANEL_SIZE,
                true
            ));

            leftXPanelPosition += Constants.PANEL_SIZE + 100;
        }

        resourceUtils.loopSong(ESongType.LEVEL_SELECT_MENU);
    }

    /**
     * runs continuously; draws background of this
     */
    @Override
    public void draw() {
        background(resourceUtils.levelBackgroundImage);
    }

}