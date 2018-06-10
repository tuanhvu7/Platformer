/**
 * common for menus
 */
abstract class AMenu {

    // horizontal offset of this from viewbox
    protected int horizontalOffset;

    // true means displayed
    protected boolean isActive;
    
    // list of panels in menu
    protected List<APanel> panelsList;

    /**
     * set properties of this;
     * sets this is have no offsetted
     */
    AMenu(boolean isActive) {
        this.horizontalOffset = 0;
        this.panelsList = new ArrayList<APanel>();
        if(isActive) {
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
        if(isActive) {
            this.setupActivateMenu();
        }
    }

    /**
     * activate and setup this; to override in extended classes
     */
    void setupActivateMenu() { }

    /**
     * deactiviate this
     */
    void deactivateMenu() {
        for(APanel curPanel : this.panelsList) {
            curPanel.makeNotActive();
        }
        
        // make this not active
        this.isActive = false;
        unregisterMethod("draw", this); // disconnect this draw() from main draw()
    }

}
