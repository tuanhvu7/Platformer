/**
 * common for rectangular collectables
 */
public abstract class ACollectable implements IDrawable {

    int fillColor;

    // position and dimensions
    int leftX;
    int topY;
    final int width;
    final int height;

    final int blockLineThickness;

    /**
     * set properties of this;
     * sets this to affect all characters and be visible
     */
    ACollectable(int leftX, int topY, int width, int height,
                 int blockLineThickness, boolean initAsActive) {

        this.leftX = leftX;
        this.topY = topY;
        this.width = width;
        this.height = height;

        this.blockLineThickness = blockLineThickness;

        if (initAsActive) {
            this.makeActive();
        }
    }

    /**
     * runs continuously
     */
    @Override
    public void draw() {
        this.show();
        if (getCurrentActivePlayer() != null) {
            this.checkHandleContactWithPlayer();
        }
    }

    /**
     * active and add this to game
     */
    public void makeActive() {
        registerMethod(EProcessingMethods.DRAW.toString(), this); // connect this draw() from main draw()
    }

    /**
     * deactivate and remove this from game
     */
    public void makeNotActive() {
        unregisterMethod(EProcessingMethods.DRAW.toString(), this); // disconnect this draw() from main draw()
    }

    /**
     * display block
     */
    void show() {
        fill(this.fillColor);
        strokeWeight(this.blockLineThickness);
        rect(this.leftX, this.topY, this.width, this.height);
    }

    /**
     * check and handle contact with player;
     * to override in extended classes
     */
    abstract void checkHandleContactWithPlayer();

    /**
     * true means this contact with player
     */
    boolean contactWithPlayer() {
        Player curPlayer = getCurrentActivePlayer();
        boolean playerInHorizontalRange =
            (curPlayer.getPos().x + (curPlayer.getDiameter() / 2) >= this.leftX) &&
                (curPlayer.getPos().x - (curPlayer.getDiameter() / 2) <= this.leftX + this.width);

        boolean playerInVerticalRange =
            (curPlayer.getPos().y + (curPlayer.getDiameter() / 2) >= this.topY) &&
                (curPlayer.getPos().y - (curPlayer.getDiameter() / 2) <= this.topY + this.height);

        return playerInHorizontalRange && playerInVerticalRange;
    }

    /*** getters and setters ***/
    public void setLeftX(int leftX) {
        this.leftX = leftX;
    }

    public void setTopY(int topY) {
        this.topY = topY;
    }

    public int getWidth() {
        return width;
    }

    public int getHeight() {
        return height;
    }
}
