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

    private BlockHorizontalBoundary topBoundary;
    private BlockHorizontalBoundary bottomBoundary;

    private BlockVerticalBoundary leftBoundary;
    private BlockVerticalBoundary rightBoundary;

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

        this.topBoundary = new BlockHorizontalBoundary(
            leftX,
            topY,
            width,
            blockLineThickness,
            true,
            true,
            false,  // initially not active, to activate based on isActive
            levelIndex
        );

        this.bottomBoundary = new BlockHorizontalBoundary(
            leftX,
            topY + height,
            width,
            blockLineThickness,
            true,
            false,
            false,  // initially not active, to activate based on isActive
            levelIndex
        );

        this.leftBoundary = new BlockVerticalBoundary(
            leftX,
            topY + 1,
            height - 1,
            blockLineThickness,
            true,
            false,  // initially not active, to activate based on isActive
            levelIndex
        );

        this.rightBoundary = new BlockVerticalBoundary(
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

        this.topBoundary = new BlockHorizontalBoundary(
            leftX + 1,
            topY,
            width - 1,
            blockLineThickness,
            isVisible,
            true,
            false,  // initially not active, to activate based on isActive && isVisible
            levelIndex
        );

        this.bottomBoundary = new BlockHorizontalBoundary(
            leftX + 1,
            topY + height,
            width - 1,
            blockLineThickness,
            isVisible,
            false,
            false,  // initially not active, to activate based on isActive
            levelIndex
        );

        this.leftBoundary = new BlockVerticalBoundary(
            leftX,
            topY,
            height,
            blockLineThickness,
            isVisible,
            false,  // initially not active, to activate based on isActive && isVisible
            levelIndex
        );

        this.rightBoundary = new BlockVerticalBoundary(
            leftX + width,
            topY,
            height,
            blockLineThickness,
            isVisible,
            false,  // initially not active, to activate based on isActive && isVisible
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
        this.handlePlayerContact();
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

    /**
     * handle invisible block player contact
     */
    private void handleInvisibleBlock() {
        Player curPlayer = getPlayerAtLevelIndex(this.levelIndex);

        // handle player collision with invisible block
        if( this.isActive && 
            !this.isVisible && 
            curPlayer.isActive &&  // TODO: encapsulate
            this.bottomBoundary.contactWithCharacter(curPlayer) ) 
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
     * handle contact with player
     */
    private void handlePlayerContact() {
        Player curPlayer = getPlayerAtLevelIndex(this.levelIndex);

        boolean isTopBoundaryPlayerContact = 
            this.topBoundary.charactersTouchingThis.contains(curPlayer);    // TODO: encapsulate

        boolean isBottomBoundaryPlayerContact = 
            this.bottomBoundary.charactersTouchingThis.contains(curPlayer); // TODO: encapsulate

        boolean isLeftBoundaryPlayerContact = 
            this.leftBoundary.charactersTouchingThis.contains(curPlayer);   // TODO: encapsulate

        boolean isRightBoundaryPlayerContact = 
            this.rightBoundary.charactersTouchingThis.contains(curPlayer);  // TODO: encapsulate


        if(isTopBoundaryPlayerContact) {
            if(!isLeftBoundaryPlayerContact && !isRightBoundaryPlayerContact) {
                curPlayer
                    .handleContactWithHorizontalBoundary(
                        this.topBoundary.startPoint.y,  // TODO: encapsulate
                        this.topBoundary.getIsFloorBoundary());
            }
        
        } else if(isBottomBoundaryPlayerContact) {
            if(!isLeftBoundaryPlayerContact && !isRightBoundaryPlayerContact) {
                curPlayer
                    .handleContactWithHorizontalBoundary(
                        this.bottomBoundary.startPoint.y,   // TODO: encapsulate
                        this.bottomBoundary.getIsFloorBoundary());
            }

        } else if(isLeftBoundaryPlayerContact) {
            if(!isTopBoundaryPlayerContact && !isBottomBoundaryPlayerContact) {
                curPlayer.handleContactWithVerticalBoundary(this.leftBoundary.startPoint.x);    // TODO: encapsulate
            }

        } else if(isRightBoundaryPlayerContact) {
            if(!isTopBoundaryPlayerContact && !isBottomBoundaryPlayerContact) {
                curPlayer.handleContactWithVerticalBoundary(this.rightBoundary.startPoint.x);   // TODO: encapsulate
            }
        }
    }

}
