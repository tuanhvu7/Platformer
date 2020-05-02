/**
 * Menu to change player controls
 */
public class ConfigurePlayerControlMenu extends AMenuWithKeyboardControl {

    /**
     * set properties of this
     */
    public ConfigurePlayerControlMenu(boolean isActive) {
        super(isActive);
    }

    /**
     * setup and activate this
     */
    @Override
    public void setupActivateMenu() {
        // make this active
        registerMethod(EProcessingMethods.DRAW.toString(), this); // connect this draw() from main draw()
        registerMethod(EProcessingMethods.KEY_EVENT.toString(), this); // connect this draw() from main draw()
        int leftXPanelPosition = 100;
        int topYPanelPosition = 100;
        for (EConfigurablePlayerControls curConfigurablePlayerControls : EConfigurablePlayerControls.values()) {
            if (leftXPanelPosition + Constants.PANEL_SIZE > resourceUtils.defaultMenuImage.width) {
                leftXPanelPosition = 100;
                topYPanelPosition += (100 + Constants.PANEL_SIZE);
            }

            this.panelsList.add(new ConfigurePlayerControlPanel(
                curConfigurablePlayerControls,
                leftXPanelPosition,
                topYPanelPosition,
                Constants.PANEL_SIZE,
                Constants.PANEL_SIZE,
                true
            ));

            leftXPanelPosition += Constants.PANEL_SIZE + 100;
            resourceUtils.loopSong(ESongType.OUT_OF_LEVEL_MENU);
        }
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
    public void keyEvent(KeyEvent keyEvent) {
        if (keyEvent.getAction() == KeyEvent.PRESS) {
            String keyPressed = keyEvent.getKey() + "";
            if (EReservedControlKeys.u.toString().equalsIgnoreCase(keyPressed)) {   // switch to level select
                this.deactivateMenu();
                getLevelSelectMenu().setupActivateMenu();
            }
        }
    }

    /**
     * reset all of this' panel colors and unregister from all of this' panel keyEvent
     */
    public void resetPanelsColorAndUnregisterKeyEvent() {
        for (APanel curPanel : this.panelsList) {
            ((ConfigurePlayerControlPanel) curPanel).resetColorAndUnregisterKeyEvent();
        }
    }
}
