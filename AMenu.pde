/**
 * common for menus
 */
public abstract class AMenu implements IDrawable {

    // horizontal offset of this from viewbox
    final int horizontalOffset;

    // list of panels in menu
    final List<APanel> panelsList;

    /**
     * set properties of this;
     * sets this if have no offset
     */
    AMenu(boolean initAsActive) {
        this.horizontalOffset = 0;
        this.panelsList = new ArrayList<APanel>();
        if (initAsActive) {
            this.setupActivateMenu();
        }
    }

    /**
     * set properties of this;
     * sets this to have given offset
     */
    AMenu(int horizontalOffset, boolean initAsActive) {
        this.horizontalOffset = horizontalOffset;
        this.panelsList = new ArrayList<APanel>();
        if (initAsActive) {
            this.setupActivateMenu();
        }
    }

    /**
     * activate and setup this; to override in extended classes
     */
    abstract void setupActivateMenu();

    /**
     * deactivate this
     */
    public void deactivateMenu() {
        for (APanel curPanel : this.panelsList) {
            curPanel.makeNotActive();
        }

        this.panelsList.clear();
        // make this not active
        unregisterMethod(EProcessingMethods.DRAW.toString(), this); // disconnect this draw() from main draw()
    }

}
