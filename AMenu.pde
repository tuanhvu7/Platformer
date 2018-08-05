/**
 * common for menus
 */
public abstract class AMenu {

    // horizontal offset of this from viewbox
    final int horizontalOffset;

    // true means displayed
    boolean isActive;

    // list of panels in menu
    final List<APanel> panelsList;

    /**
     * set properties of this;
     * sets this if have no offset
     */
    AMenu(boolean isActive) {
        this.horizontalOffset = 0;
        this.panelsList = new ArrayList<APanel>();
        if (isActive) {
            this.setupActivateMenu();
        }
    }

    /**
     * set properties of this;
     * sets this to have given offset
     */
    AMenu(int horizontalOffset, boolean isActive) {
        this.horizontalOffset = horizontalOffset;
        this.panelsList = new ArrayList<APanel>();
        if (isActive) {
            this.setupActivateMenu();
        }
    }

    /**
     * activate and setup this; to override in extended classes
     */
    void setupActivateMenu() {
    }

    /**
     * deactivate this
     */
    public void deactivateMenu() {
        for (APanel curPanel : this.panelsList) {
            curPanel.makeNotActive();
        }

        this.panelsList.clear();
        // make this not active
        this.isActive = false;
        unregisterMethod("draw", this); // disconnect this draw() from main draw()
    }

}
