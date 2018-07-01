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

    private BlockHorizontalBoundary topSide;
    private BlockHorizontalBoundary bottomSide;

    private BlockVerticalBoundary leftSide;
    private BlockVerticalBoundary rightSide;

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

        this.topSide = new BlockHorizontalBoundary(
            leftX,
            topY,
            width,
            blockLineThickness,
            true,
            false,  // initially not active, to activate based on isActive
            levelIndex
        );

        this.bottomSide = new BlockHorizontalBoundary(
            leftX,
            topY + height,
            width,
            blockLineThickness,
            false,
            false,  // initially not active, to activate based on isActive
            levelIndex
        );

        this.leftSide = new BlockVerticalBoundary(
            leftX,
            topY + 1,
            height - 1,
            blockLineThickness,
            false,  // initially not active, to activate based on isActive
            levelIndex
        );

        this.rightSide = new BlockVerticalBoundary(
            leftX + width,
            topY + 1,
            height - 1,
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

        this.topSide = new BlockHorizontalBoundary(
            leftX + 1,
            topY,
            width - 1,
            blockLineThickness,
            isVisible,
            true,
            false,  // initially not active, to activate based on isActive && isVisible
            levelIndex
        );

        this.bottomSide = new BlockHorizontalBoundary(
            leftX + 1,
            topY + height,
            width - 1,
            blockLineThickness,
            isVisible,
            false,
            false,  // initially not active, to activate based on isActive
            levelIndex
        );

        this.leftSide = new BlockVerticalBoundary(
            leftX,
            topY,
            height,
            blockLineThickness,
            isVisible,
            false,  // initially not active, to activate based on isActive && isVisible
            levelIndex
        );

        this.rightSide = new BlockVerticalBoundary(
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

    /**
     * handle contact with player
     */
    private void handlePlayerContact() {
        Player curPlayer = getPlayerAtLevelIndex(this.levelIndex);

        boolean istopSidePlayerContact = 
            this.topSide.charactersTouchingThis.contains(curPlayer);    // TODO: encapsulate

        boolean isbottomSidePlayerContact = 
            this.bottomSide.charactersTouchingThis.contains(curPlayer); // TODO: encapsulate

        boolean isleftSidePlayerContact = 
            this.leftSide.charactersTouchingThis.contains(curPlayer);   // TODO: encapsulate

        boolean isrightSidePlayerContact = 
            this.rightSide.charactersTouchingThis.contains(curPlayer);  // TODO: encapsulate


        if(istopSidePlayerContact) {
            if(!isleftSidePlayerContact && !isrightSidePlayerContact) {
                curPlayer
                    .handleContactWithHorizontalBoundary(
                        this.topSide.startPoint.y,  // TODO: encapsulate
                        this.topSide.getIsFloorBoundary());
            }
        
        } else if(isbottomSidePlayerContact) {
            if(!isleftSidePlayerContact && !isrightSidePlayerContact) {
                curPlayer
                    .handleContactWithHorizontalBoundary(
                        this.bottomSide.startPoint.y,   // TODO: encapsulate
                        this.bottomSide.getIsFloorBoundary());
            }

        } else if(isleftSidePlayerContact) {
            if(!istopSidePlayerContact && !isbottomSidePlayerContact) {
                curPlayer.handleContactWithVerticalBoundary(this.leftSide.startPoint.x);    // TODO: encapsulate
            }

        } else if(isrightSidePlayerContact) {
            if(!istopSidePlayerContact && !isbottomSidePlayerContact) {
                curPlayer.handleContactWithVerticalBoundary(this.rightSide.startPoint.x);   // TODO: encapsulate
            }
        }
    }

}
