/**
 * Common properties of panels
 */
public class LevelPanel implements IDrawable{

    int leftX;
    int rightX;

    int topY;
    int bottomY;

    int width;
    int height;

    // level associated with this
    int panelLevel;

    // true means is displayed and clickable
    boolean isActive;

    /**
     * set properties of this
     */
    LevelPanel(int panelLevel, int leftX, int topY, int width, int height, boolean isActive) {
        this.panelLevel = panelLevel;
        this.width = width;
        this.height = height;

        this.leftX = leftX;
        this.rightX = leftX + width;
        
        this.topY = topY;
        this.bottomY = topY + height;

        if(isActive) {
            this.makeActive();
        }
    }

    /**
     * active and add this to game
     */
    void makeActive() {
        this.isActive = true;
        registerMethod("draw", this); // connect this draw() from main draw()
        registerMethod("mouseEvent", this); // connect this mouseEvent() from main mouseEvent()
    }

    /**
     * deactivate and remove this from game
     */
    void makeNotActive() {
        this.isActive = false;
        unregisterMethod("draw", this); // disconnect this draw() from main draw()
        unregisterMethod("mouseEvent", this); // connect this mouseEvent() from main mouseEvent()
    }

    /**
     * runs continuously.; draws rectangle panel using its properties
     */
    void draw() {
        fill(Constants.LEVEL_PANEL_COLOR);
        rect(this.leftX, this.topY, this.width, this.height);

        fill(0);
        textAlign(CENTER, CENTER);
        textSize(Constants.TEXT_SIZE);
        // text(this.panelLevel, this.leftX, this.topY, this.width, this.height);
        text(this.panelLevel, this.leftX, this.topY);
    }

    /**
     * Execute appropriate method (executeWhenClicked) when this panel is clicked
     */
    void mouseEvent(MouseEvent event) {
        if(event.getAction() == MouseEvent.CLICK) {
            if(isMouseIn()) {
                executeWhenClicked();
            }
        }
    }

    /**
     * to execute when this panel is clicked
     */
    void executeWhenClicked() {
        global_level_select_menu.deactivateLevelSelectMenu();
        global_current_active_level = panelLevel;
        global_levels_list.get(global_current_active_level).get().setUpActivateLevel();
    }

   /**
    * return if mouse position inside this panel
    */
    private boolean isMouseIn() {
        return  mouseX > this.leftX && 
                mouseX < this.rightX &&
                mouseY > this.topY &&
                mouseY < this.bottomY;
    }

}
