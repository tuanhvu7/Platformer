/**
 * common for rectangular collectables
 */
public class ACollectable implements IDrawable {

    // position and dimensions
    protected int leftX;
    protected int topY;
    protected int width;
    protected int height;
    protected boolean isActive;

    protected int blockLineThickness;

    /**
     * set properties of this;
     * sets this to affect all characters and be visible
     */
    ACollectable(int leftX, int topY, int width, int height, int blockLineThickness, boolean isActive) {
        
        this.leftX = leftX;
        this.topY = topY;
        this.width = width;
        this.height = height;

        this.blockLineThickness = blockLineThickness;

        if(isActive) {
            this.makeActive();
        }
    }

    /**
     * runs continuously
     */
    public void draw() {
        this.show();
        this.checkHandleContactWithPlayer();
    }

    /**
     * active and add this to game
     */
    void makeActive() {
        this.isActive = true;
        registerMethod("draw", this); // connect this draw() from main draw()
    }

    /**
     * deactivate and remove this from game
     */
    void makeNotActive() {
        this.isActive = false;
        unregisterMethod("draw", this); // disconnect this draw() from main draw()
    }

    /**
     * display collectable;
     * to override in extended classes
     */
    void show() { }

    /**
     * check and handle contact with player;
     * to override in extended classes
     */
    protected void checkHandleContactWithPlayer() { }

    /**
     * true means this contact with player
     */
    protected boolean contactWithPlayer() {
        // TODO: encapsulate
        boolean playerInHorizontalRange = 
            (getCurrentActivePlayer().pos.x  + (getCurrentActivePlayer().diameter / 2) >= this.leftX) &&
            (getCurrentActivePlayer().pos.x  - (getCurrentActivePlayer().diameter / 2) <= this.leftX + this.width);

        boolean playerInVerticalRange = 
            (getCurrentActivePlayer().pos.y  + (getCurrentActivePlayer().diameter / 2) >= this.topY) &&
            (getCurrentActivePlayer().pos.y  - (getCurrentActivePlayer().diameter / 2) <= this.topY + this.height);;


        return playerInHorizontalRange && playerInVerticalRange;
    }

}