/**
 * Block;
 * invisible block only has bottom boundary active
 */
public class Block extends ABlock implements IDrawable {

    /**
     * set properties of this;
     * sets this to affect all characters and be visible
     */
    Block(int leftX, int topY, int width, int height, int blockLineThickness, 
            boolean isActive, int levelIndex) {
        
        super(leftX, topY, width, height, blockLineThickness, false, levelIndex);   // initially not active, to be set in makeActive()

        this.topSide = new HorizontalBoundary(
            leftX,
            topY,
            width,
            blockLineThickness,
            true,
            false,  // initially not active, to be set in makeActive()
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

        super(leftX, topY, width, height, blockLineThickness,
                isVisible, false, levelIndex);  // initially not active, to be set in makeActive(), isVisible

        this.topSide = new HorizontalBoundary(
            leftX,
            topY,
            width,
            blockLineThickness,
            isVisible,
            true,
            false,  // initially not active, to be set in makeActive()
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
        this.handleInvisibleBlock();
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

        // make horizontal boundaries first since their detection takes precedence
        this.bottomSide.makeActive();
        
        if(this.isVisible) {
            this.topSide.makeActive();
            this.leftSide.makeActive();
            this.rightSide.makeActive();
        }
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

    /**
     * handle invisible block player contact
     */
    private void handleInvisibleBlock() {
        Player curPlayer = getPlayerAtLevelIndex(this.levelIndex);

        // handle player collision with invisible block
        if( this.isActive && 
            !this.isVisible && 
            curPlayer.isActive &&  // TODO: encapsulate
            this.bottomSide.contactWithCharacter(curPlayer) ) 
        {

            this.isVisible = true;
            this.topSide.makeActive();
            this.topSide.isVisible = true;  // TODO: encapsulate
            
            this.bottomSide.isVisible = true;  // TODO: encapsulate

            this.leftSide.makeActive();
            this.leftSide.isVisible = true;  // TODO: encapsulate

            this.rightSide.makeActive();
            this.rightSide.isVisible = true;  // TODO: encapsulate
            
        }
    }
}
