/**
 * common for menus
 */
abstract class AMenu {

    // true means displayed
    boolean isActive;
    
    // list of panels in menu
    List<APanel> panelsList;

    /**
     * set properties of this
     */
    AMenu(boolean isActive) {
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
