/**
 * common for menus with keyboard controls
 */
public abstract class AMenuWithKeyboardControl extends AMenu {
    AMenuWithKeyboardControl(boolean isActive) {
        super(isActive);
    }

    /**
     * set properties of this;
     * sets this to have given offset
     */
    AMenuWithKeyboardControl(int horizontalOffset, boolean isActive) {
        super(horizontalOffset, isActive);
    }

    /**
     * deactivate this
     */
    @Override
    public void deactivateMenu() {
        for (APanel curPanel : this.panelsList) {
            curPanel.makeNotActive();
        }

        this.panelsList.clear();
        // make this not active
       unregisterMethod(EProcessingMethods.DRAW.toString(), this); // disconnect this draw() from main draw()
       unregisterMethod(EProcessingMethods.KEY_EVENT.toString(), this); // disconnect this keyEvent() from main keyEvent()
    }
}
