/**
 * Used to display and change player control settings
 */
public class ConfigurePlayerControlPanel extends APanel implements IKeyControllable {
    // player control type linked to this
    private final EConfigurablePlayerControls configurablePlayerControlType;

    /**
     * set properties of this
     */
    public ConfigurePlayerControlPanel(EConfigurablePlayerControls configurableControlPanelText,
                                    int leftX, int topY, int width, int height, boolean isActive) {
        super(Constants.DEFAULT_PANEL_COLOR, "", leftX, topY, width, height, isActive);
        this.configurablePlayerControlType = configurableControlPanelText;
        switch (this.configurablePlayerControlType) {
            case UP:
                this.panelText = this.createFormattedPanelText(playerControlSettings.getPlayerUp());
                break;
            case DOWN:
                this.panelText = this.createFormattedPanelText(playerControlSettings.getPlayerDown());
                break;
            case LEFT:
                this.panelText = this.createFormattedPanelText(playerControlSettings.getPlayerLeft());
                break;
            case RIGHT:
                this.panelText = this.createFormattedPanelText(playerControlSettings.getPlayerRight());
                break;
            default:
                break;
        }
    }

    @Override
    void executeWhenClicked() {
        getChangePlayerControlMenu().resetPanelsColorAndUnregisterKeyEvent();
        this.panelColor = Constants.ALTERNATE_PANEL_COLOR;
        registerMethod(EProcessingMethods.KEY_EVENT.toString(), this);
    }

    /**
     * deactivate and remove this from game
     */
    @Override
    public void makeNotActive() {
        unregisterMethod(EProcessingMethods.DRAW.toString(), this); // disconnect this draw() from main draw()
        unregisterMethod(EProcessingMethods.MOUSE_EVENT.toString(), this); // disconnect this mouseEvent() from main mouseEvent()
        unregisterMethod(EProcessingMethods.KEY_EVENT.toString(), this); // disconnect this keyEvent() from main keyEvent()
    }

    /**
     * handle panel keypress controls
     */
    @Override
    public void keyEvent(KeyEvent keyEvent) {
        if (keyEvent.getAction() == KeyEvent.PRESS) {
            int keyCode = Character.toLowerCase(keyEvent.getKeyCode());
            // check valid input is given (not a reserved or already-taken keyCode)
            if (!reservedControlUtils.isKeyCodeReserved(keyCode) && playerControlSettings.isKeyCodeAvailable(keyCode)) {
                switch (this.configurablePlayerControlType) {
                    case UP:
                        playerControlSettings.setPlayerUp(keyCode);
                        break;
                    case DOWN:
                        playerControlSettings.setPlayerDown(keyCode);
                        break;
                    case LEFT:
                        playerControlSettings.setPlayerLeft(keyCode);
                        break;
                    case RIGHT:
                        playerControlSettings.setPlayerRight(keyCode);
                        break;
                    default:
                        break;
                }
                this.panelText = this.createFormattedPanelText(keyCode);
            }

            // unselect panel after key is inputted; to avoid registerMethod again
            this.resetColorAndUnregisterKeyEvent();
        }
    }

    /**
     * set this to have default panel color and unregister keyEvent
     */
    public void resetColorAndUnregisterKeyEvent() {
        this.panelColor = Constants.DEFAULT_PANEL_COLOR;
        unregisterMethod(EProcessingMethods.KEY_EVENT.toString(), this); // disconnect this keyEvent() from main keyEvent()
    }

    /**
     * @return formatted panel text that contains player control type and player control key
     */
    private String createFormattedPanelText(int playerControlKey) {
        String playerControlKeyStr = (char) playerControlKey + "";
        // to handle display of up, down, left, right arrows text
        switch (playerControlKey) {
            case java.awt.event.KeyEvent.VK_UP:
                playerControlKeyStr = "UP";
                break;
            case java.awt.event.KeyEvent.VK_DOWN:
                playerControlKeyStr = "DOWN";
                break;
            case java.awt.event.KeyEvent.VK_LEFT:
                playerControlKeyStr = "LEFT";
                break;
            case java.awt.event.KeyEvent.VK_RIGHT:
                playerControlKeyStr = "RIGHT";
                break;
        }

        return this.configurablePlayerControlType.toString() + ": " + playerControlKeyStr;
    }
}
