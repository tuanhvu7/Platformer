/**
 * Common for panels
 */
abstract class APanel implements IDrawable {

    protected int leftX;
    protected int rightX;

    protected int topY;
    protected int bottomY;

    protected int width;
    protected int height;

    protected String panelText;

    // true means is displayed and clickable
    protected boolean isActive;

    /**
     * set properties of this
     */
    APanel(String panelText, int leftX, int topY, int width, int height, boolean isActive) {
        this.panelText = panelText;
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
     * runs continuously; draws rectangle panel using this properties
     */
    void draw() {
        fill(Constants.PANEL_COLOR);
        rect(this.leftX, this.topY, this.width, this.height);

        fill(0);
        textAlign(CENTER, CENTER);
        textSize(Constants.TEXT_SIZE);
        text(this.panelText + "", this.leftX, this.topY, this.width, this.height);
    }

    /**
     * Execute appropriate method (executeWhenClicked) when this is clicked
     */
    void mouseEvent(MouseEvent event) {
        if(event.getAction() == MouseEvent.CLICK) {
            if(isMouseIn()) {
                executeWhenClicked();
            }
        }
    }

    /**
     * to execute when this panel is clicked; to override in extended classes
     */
    void executeWhenClicked() { }

   /**
    * return if mouse position inside this panel
    */
    protected boolean isMouseIn() {
        return  mouseX > this.leftX && 
                mouseX < this.rightX &&
                mouseY > this.topY &&
                mouseY < this.bottomY;
    }

}
