/**
 * checkpoint
 */
public class Checkpoint implements IDrawable {

    // position and dimensions
    private int leftX;
    private int topY;
    private int width;
    private int height;
    private boolean isActive;

    private int blockLineThickness;

    /**
     * set properties of this;
     * sets this to affect all characters and be visible
     */
    Checkpoint(int leftX, int topY, int width, int height, int blockLineThickness, boolean isActive) {
        
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
     * display block
     */
    void show() {
        fill(Constants.CHECKPOINT_BLOCK_COLOR);
        strokeWeight(this.blockLineThickness);
        rect(this.leftX, this.topY, this.width, this.height);
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
     *  check and handle contact with player
     */
    private void checkHandleContactWithPlayer() {
        if(getCurrentActivePlayer().isActive && this.contactWithPlayer()) {   // TODO: encapsulate
            global_current_active_level.get().loadPlayerFromCheckPoint = true;  // TODO: encapsulate
            this.makeNotActive();
        }
    }

    /**
     * true means this contact with player
     */
    private boolean contactWithPlayer() {
        // TODO: encapsulate
        boolean playerInHorizontalRange = 
            (getCurrentActivePlayer().pos.x  + (getCurrentActivePlayer().diameter / 2) >= this.leftX) &&
            (getCurrentActivePlayer().pos.x  - (getCurrentActivePlayer().diameter / 2) <= this.leftX + this.width);

        boolean playerInVerticalRange = 
            (getCurrentActivePlayer().pos.y  + (getCurrentActivePlayer().diameter / 2) >= this.topY) &&
            (getCurrentActivePlayer().pos.y  - (getCurrentActivePlayer().diameter / 2) <= this.topY + this.height);;


        println(playerInHorizontalRange && playerInVerticalRange);
        return playerInHorizontalRange && playerInVerticalRange;
    }

}
