/**
 * Block;
 * invisible block only has bottom boundary active
 */
public class Block extends ABlock {

    // true means breakable from bottom
    final boolean isBreakableFromBottom;

    /**
     * set properties of this;
     * sets this to affect all characters and be visible
     */
    public Block(int leftX, int topY,
                 int width, int height, int blockLineThickness,
                 boolean isBreakableFromBottom, boolean isActive) {

        super(leftX, topY, width, height, blockLineThickness, false);   // initially not active, to be set in makeActive()

        if (isBreakableFromBottom) {
            this.fillColor = Constants.BREAKABLE_BLOCK_COLOR;
        } else {
            this.fillColor = Constants.DEFAULT_BLOCK_COLOR;
        }
        this.isBreakableFromBottom = isBreakableFromBottom;

        this.topSide = new HorizontalBoundary(
            leftX,
            topY,
            width,
            blockLineThickness,
            true,
            false  // initially not active, to be set in makeActive()
        );

        if (isActive) {
            this.makeActive();
        }
    }

    /**
     * set properties of this;
     * sets this to be active for all characters;
     * if given isVisible is false, only bottom boundary of block is active
     * to all characters
     */
    public Block(int leftX, int topY, int width, int height, int blockLineThickness,
                 boolean isVisible, boolean isBreakableFromBottom, boolean isActive) {

        super(leftX, topY, width, height, blockLineThickness,
            isVisible, false);  // initially not active, to be set in makeActive(), isVisible

        if (isBreakableFromBottom) {
            this.fillColor = Constants.BREAKABLE_BLOCK_COLOR;
        } else {
            this.fillColor = Constants.DEFAULT_BLOCK_COLOR;
        }
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

        if (isActive) {
            this.makeActive();
        }
    }

    /**
     * runs continuously
     */
    @Override
    public void draw() {
        if (this.isVisible) {
            this.show();
        }

        Player player = getCurrentActivePlayer();
        // handle player collision with invisible block
        if (player != null && this.bottomSide.contactWithCharacter(player)) {
            if (!this.isVisible) {
                this.handleInvisibleBlockCollisionWithPlayer();

            } else if (this.isBreakableFromBottom) {
                this.removeBlockFromPlayerContact();
            }
        }
    }


    /**
     * active and add this to game
     */
    void makeActive() {
        registerMethod("draw", this); // connect this draw() from main draw()

        // make horizontal boundaries first since their detection takes precedence
        this.bottomSide.makeActive();

        if (this.isVisible) {
            this.topSide.makeActive();
            this.leftSide.makeActive();
            this.rightSide.makeActive();
        }
    }

    /**
     * deactivate and remove this from game
     */
    @Override
    public void makeNotActive() {
        this.topSide.makeNotActive();
        this.bottomSide.makeNotActive();
        this.leftSide.makeNotActive();
        this.rightSide.makeNotActive();

        unregisterMethod("draw", this); // disconnect this draw() from main draw()
    }

    /**
     * handle invisible block player contact
     */
    void handleInvisibleBlockCollisionWithPlayer() {
        if (this.isBreakableFromBottom) {
            this.removeBlockFromPlayerContact();

        } else {
            this.isVisible = true;
            this.topSide.makeActive();
            this.topSide.setVisible(true);

            this.bottomSide.setVisible(true);

            this.leftSide.makeActive();
            this.leftSide.setVisible(true);

            this.rightSide.makeActive();
            this.rightSide.setVisible(true);
        }
    }

    /**
     * remove block from player contact
     */
    void removeBlockFromPlayerContact() {
        getCurrentActivePlayer().handleContactWithHorizontalBoundary(
            this.bottomSide.getStartPoint().y,
            false);
        resourceUtils.playSong(ESongType.PLAYER_ACTION);
        this.makeNotActive();
        getCurrentActiveLevelDrawableCollection().removeDrawable(this);
    }
}
