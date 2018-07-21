/**
 * common for blocks
 */
abstract class ABlock {
    protected boolean isActive;
    protected boolean isVisible;

    protected int leftX;
    protected int topY;
    protected int width;
    protected int height;

    protected int levelIndex;

    protected HorizontalBoundary topSide;
    protected HorizontalBoundary bottomSide;

    protected VerticalBoundary leftSide;
    protected VerticalBoundary rightSide;

    /**
     * set properties of this;
     * sets this to affect all characters and be visible
     */
    ABlock(int leftX, int topY, int width, int height, int blockLineThickness, 
            boolean isActive, int levelIndex) {
        
        this.leftX = leftX;
        this.topY = topY;
        this.width = width;
        this.height = height;

        this.isVisible = true;

        this.levelIndex = levelIndex;

        this.bottomSide = new HorizontalBoundary(
            leftX,
            topY + height,
            width,
            blockLineThickness,
            false,
            isActive,
            levelIndex
        );

        this.leftSide = new VerticalBoundary(
            leftX,
            topY + 1,
            height - 2,
            blockLineThickness,
            isActive,
            levelIndex
        );

        this.rightSide = new VerticalBoundary(
            leftX + width,
            topY + 1,
            height - 2,
            blockLineThickness,
            isActive,
            levelIndex
        );
    }

    /**
     * set properties of this;
     * sets this to be active for all characters; 
     * if givien isVisible is false, only bottom boundary of block is active
     * to all characters
     */
    ABlock(int leftX, int topY, int width, int height, int blockLineThickness,
            boolean isVisible, boolean isActive, int levelIndex) {

        this.leftX = leftX;
        this.topY = topY;
        this.width = width;
        this.height = height;

        this.isVisible = isVisible;

        this.levelIndex = levelIndex;

        this.bottomSide = new HorizontalBoundary(
            leftX + 1,
            topY + height,
            width - 1,
            blockLineThickness,
            isVisible,
            false,
            isActive,
            levelIndex
        );

        this.leftSide = new VerticalBoundary(
            leftX,
            topY,
            height,
            blockLineThickness,
            isVisible,
            isActive,
            levelIndex
        );

        this.rightSide = new VerticalBoundary(
            leftX + width,
            topY,
            height,
            blockLineThickness,
            isVisible,
            isActive,
            levelIndex
        );
    }

    /**
     * deactivate and remove this from game;
     * to override in extended classes
     */
    public void makeNotActive() {}

}
