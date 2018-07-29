/**
 * Block;
 * invisible block only has bottom boundary active
 */
public class Block extends ABlock implements IDrawable {

    // true means breakable from bottom
    private boolean isBreakableFromBottom;

    /**
     * set properties of this;
     * sets this to affect all characters and be visible
     */
    Block(int leftX, int topY, int width, int height, int blockLineThickness, boolean isBreakableFromBottom,
            boolean isActive) {
        
        super(leftX, topY, width, height, blockLineThickness, false);   // initially not active, to be set in makeActive()

        this.isBreakableFromBottom = isBreakableFromBottom;

        this.topSide = new HorizontalBoundary(
            leftX,
            topY,
            width,
            blockLineThickness,
            true,
            false  // initially not active, to be set in makeActive()
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
            boolean isVisible, boolean isBreakableFromBottom, boolean isActive) {

        super(leftX, topY, width, height, blockLineThickness,
                isVisible, false);  // initially not active, to be set in makeActive(), isVisible

        this.isBreakableFromBottom = isBreakableFromBottom;

        this.topSide = new HorizontalBoundary(
            leftX,
            topY,
            width,
            blockLineThickness,
            isVisible,
            true,
            false  // initially not active, to be set in makeActive()
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

        // handle player collision with invisible block
        if(this.bottomSide.contactWithCharacter(getCurrentActivePlayer())) {
            if(!this.isVisible) {
                this.handleInvisibleBlockCollisionWithPlayer();
            } else if(this.isBreakableFromBottom) {
                getCurrentActivePlayer().handleContactWithHorizontalBoundary(
                    this.bottomSide.startPoint.y,  // TODO: encapsulate
                    false);
                this.makeNotActive();
                getCurrentActiveBlocksList().remove(this);
            }   
        }
    }

    /**
     * display block
     */
    void show() {
        fill(Constants.DEFAULT_BLOCK_COLOR);
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
    private void handleInvisibleBlockCollisionWithPlayer() {
        if(this.isBreakableFromBottom) {
            getCurrentActivePlayer().handleContactWithHorizontalBoundary(
                this.bottomSide.startPoint.y,  // TODO: encapsulate
                false);
            this.makeNotActive();
            getCurrentActiveBlocksList().remove(this);

        } else {
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
