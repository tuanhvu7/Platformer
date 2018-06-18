/**
 * Block;
 * invisible block only has bottom boundary active
 */
public class Block implements IDrawable {

    private boolean isActive;
    private boolean isVisible;

    private int leftX;
    private int topY;
    private int width;
    private int height;

    private int levelIndex;

    private HorizontalBoundary topBoundary;
    private HorizontalBoundary bottomBoundary;

    private VerticalBoundary leftBoundary;
    private VerticalBoundary rightBoundary;

    /**
     * set properties of this;
     * sets this to affect all characters and be visible
     */
    Block(int leftX, int topY, int width, int height, int blockLineThickness, 
            boolean isActive, int levelIndex) {
        
        this.leftX = leftX;
        this.topY = topY;
        this.width = width;
        this.height = height;

        this.isActive = isActive;
        this.isVisible = true;

        this.levelIndex = levelIndex;

        this.topBoundary = new HorizontalBoundary(
            leftX,
            topY,
            width,
            blockLineThickness,
            true,
            true,
            false,  // initially not active, to activate based on isActive
            levelIndex
        );

        this.bottomBoundary = new HorizontalBoundary(
            leftX,
            topY + height,
            width,
            blockLineThickness,
            true,
            false,
            false,  // initially not active, to activate based on isActive
            levelIndex
        );

        this.leftBoundary = new VerticalBoundary(
            leftX,
            topY + 1,
            height - 1,
            blockLineThickness,
            true,
            false,  // initially not active, to activate based on isActive
            levelIndex
        );

        this.rightBoundary = new VerticalBoundary(
            leftX + width,
            topY + 1,
            height - 1,
            blockLineThickness,
            true,
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
     * if givien isVisible is false, only bottom boundary of block is active
     * to all characters
     */
    Block(int leftX, int topY, int width, int height, int blockLineThickness,
            boolean isVisible, boolean isActive, int levelIndex) {

        this.leftX = leftX;
        this.topY = topY;
        this.width = width;
        this.height = height;

        this.isActive = isActive;
        this.isVisible = isVisible;

        this.levelIndex = levelIndex;

        this.topBoundary = new HorizontalBoundary(
            leftX + 1,
            topY,
            width - 1,
            blockLineThickness,
            isVisible,
            true,
            false,  // initially not active, to activate based on isActive && isVisible
            levelIndex
        );

        this.bottomBoundary = new HorizontalBoundary(
            leftX + 1,
            topY + height,
            width - 1,
            blockLineThickness,
            isVisible,
            false,
            false,  // initially not active, to activate based on isActive
            levelIndex
        );

        this.leftBoundary = new VerticalBoundary(
            leftX,
            topY,
            height,
            blockLineThickness,
            isVisible,
            false,  // initially not active, to activate based on isActive && isVisible
            levelIndex
        );

        this.rightBoundary = new VerticalBoundary(
            leftX + width,
            topY,
            height,
            blockLineThickness,
            isVisible,
            false,  // initially not active, to activate based on isActive && isVisible
            levelIndex
        );
    }

    /**
     * runs continuously
     */
    public void draw() {
        if(this.isVisible) {
            this.show();
        }
        
        // handle player collision with invisible block
        if( this.isActive && 
            !this.isVisible && 
            getPlayerAtLevelIndex(this.levelIndex).isActive &&  // TODO: encapsulate
            this.bottomBoundary.contactWithCharacter(getPlayerAtLevelIndex(this.levelIndex)) ) 
        {

            this.isVisible = true;
            this.topBoundary.makeActive();
            this.topBoundary.isVisible = true;  // TODO: encapsulate
            
            this.bottomBoundary.isVisible = true;  // TODO: encapsulate

            this.leftBoundary.makeActive();
            this.leftBoundary.isVisible = true;  // TODO: encapsulate

            this.rightBoundary.makeActive();
            this.rightBoundary.isVisible = true;  // TODO: encapsulate
            
        }
    }

    /**
     * display block
     */
    void show() {
        fill(Constants.BLOCK_COLOR);
        rect(this.leftX, this.topY, this.width, this.height);
    }

    /**
     * active and add this to game
     */
    void makeActive() {
        this.isActive = true;
        registerMethod("draw", this); // connect this draw() from main draw()

        this.bottomBoundary.makeActive();
        
        if(this.isVisible) {
            this.topBoundary.makeActive();
            this.leftBoundary.makeActive();
            this.rightBoundary.makeActive();
        }
    }

    /**
     * deactivate and remove this from game
     */
    void makeNotActive() {
        this.isActive = false;
        unregisterMethod("draw", this); // disconnect this draw() from main draw()

        this.topBoundary.makeNotActive();
        this.bottomBoundary.makeNotActive();
        this.leftBoundary.makeNotActive();
        this.rightBoundary.makeNotActive();
    }

}