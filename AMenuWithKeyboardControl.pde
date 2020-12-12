/**
 * common for menus with keyboard controls
 */
public abstract class AMenuWithKeyboardControl extends AMenu implements IKeyControllable {
    AMenuWithKeyboardControl(boolean initAsActive) {
        super(initAsActive);
    }

    /**
     * set properties of this;
     * sets this to have given offset
     */
    AMenuWithKeyboardControl(int horizontalOffset, boolean initAsActive) {
        super(horizontalOffset, initAsActive);
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
