/**
 * menu to select level to play;
 */
public class LevelSelectMenu extends AMenuWithKeyboardControl {

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
        registerMethod(EProcessingMethods.DRAW.toString(), this); // connect this draw() from main draw()
        registerMethod(EProcessingMethods.KEY_EVENT.toString(), this); // connect this keyEvent() from main keyEvent()

        int leftXPanelPosition = 100;
        int topYPanelPosition = 100;
        for (int i = 1; i < levelsHeightArray.length; i++) {
            if (leftXPanelPosition + Constants.PANEL_SIZE > resourceUtils.defaultMenuImage.width) {
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

        resourceUtils.loopSong(ESongType.OUT_OF_LEVEL_MENU);
    }

    /**
     * runs continuously; draws background of this
     */
    @Override
    public void draw() {
        background(resourceUtils.defaultMenuImage);
    }


    /**
     * handle keypress
     */
    @Override
    public void keyEvent(KeyEvent keyEvent) {
        if (keyEvent.getAction() == KeyEvent.PRESS) {
            String keyPressed = keyEvent.getKey() + "";
            if (EReservedControlKeys.c.toString().equalsIgnoreCase(keyPressed)) {  // toggle checkpoint start
                for (APanel curPanel : this.panelsList) {
                    ((LevelSelectMenuPanel) curPanel).toggleLoadLevelFromCheckpoint();
                }
            } else if (EReservedControlKeys.u.toString().equalsIgnoreCase(keyPressed)) {   // switch to user control menu
                getLevelSelectMenu().deactivateMenu();
                getChangePlayerControlMenu().setupActivateMenu();
            }
        }
    }

}
