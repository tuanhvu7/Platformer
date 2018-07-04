/**
 * warp block;
 */
public class WarpBlock extends ABlock implements IDrawable {

    // boundary that warps player upon player contact
    private PVector warpTriggerBoundary;

    // location to warp player
    private PVector endWarpPosition;

    /**
     * set properties of this;
     * sets this to affect all characters and be visible
     */
    WarpBlock(int leftX, int topY, int width, int height, int blockLineThickness, 
            boolean isActive, int levelIndex) {
        
        super(leftX, topY, width, height, blockLineThickness, false, levelIndex);   // initially not active, to activate based on isActive

        this.topSide = new WarpBlockTopBoundary(
            leftX,
            topY,
            width,
            blockLineThickness,
            false,  // initially not active, to activate based on isActive
            levelIndex
        );
        
        if(isActive) {
            this.makeActive();
        }
    }

    /**
     * set properties of this;
     * sets this to be active for all characters; 
     */
    WarpBlock(int leftX, int topY, int width, int height, int blockLineThickness,
            boolean isVisible, boolean isActive, int levelIndex) {

        super(leftX, topY, width, height, blockLineThickness,
                isVisible, false, levelIndex);  // initially not active, to activate based on isActive

        this.topSide = new WarpBlockTopBoundary(
            leftX + 1,
            topY,
            width - 1,
            blockLineThickness,
            isVisible,
            false,  // initially not active, to activate based on isActive
            levelIndex
        );

        if(isActive) {
            this.makeActive();
        }
    }

    /**
     * runs continuously
     */
    public void draw() {
        if(this.isVisible) {
            this.show();
        }
        this.handlePlayerContact();
    }

    /**
     * display block
     */
    void show() {
        fill(Constants.WARP_BLOCK_COLOR);
        rect(this.leftX, this.topY, this.width, this.height);
    }

    /**
     * active and add this to game
     */
    void makeActive() {
        this.isActive = true;
        registerMethod("draw", this); // connect this draw() from main draw()

        // make horizontal boundaries first since their detection takes precedence
        this.bottomSide.makeActive();
        this.topSide.makeActive();
        this.leftSide.makeActive();
        this.rightSide.makeActive();
    }

    /**
     * deactivate and remove this from game
     */
    void makeNotActive() {
        this.isActive = false;
        unregisterMethod("draw", this); // disconnect this draw() from main draw()

        this.topSide.makeNotActive();
        this.bottomSide.makeNotActive();
        this.leftSide.makeNotActive();
        this.rightSide.makeNotActive();
    }
}
