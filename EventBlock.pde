/**
 * event block;
 */
public class EventBlock extends ABlock implements IDrawable {

    // boundary that events player upon player contact
    private EventTriggerHorizontalBoundary eventTriggerBoundary;

    /**
     * set properties of this;
     * sets this to have launch event and affect all characters and be visible
     */
    EventBlock(int leftX, int topY, int width, int height, int blockLineThickness,
                boolean isEventTriggerFloorBoundary, boolean isActive, int levelIndex) {
        
        super(leftX, topY, width, height, blockLineThickness, false, levelIndex);   // initially not active, to be set in makeActive()

        this.topSide = new EventBlockTopBoundary(
            leftX,
            topY,
            width,
            blockLineThickness,
            false,  // initially not active, to be set in makeActive()
            levelIndex
        );

        this.eventTriggerBoundary = new EventTriggerHorizontalBoundary(
            leftX + 10,
            topY + height - (height / 5),
            width - 20,
            blockLineThickness,
            isEventTriggerFloorBoundary,
            false,  // initially not active, to be set in makeActive()
            levelIndex,
            (EventBlockTopBoundary) this.topSide
        );
        
        if(isActive) {
            this.makeActive();
        }
    }

    /**
     * set properties of this;
     * sets this to have warp event and affect all characters and be visible
     */
    EventBlock(int leftX, int topY, int width, int height, int blockLineThickness, 
                int endWarpXPositon, int endWarpYPositon,
                boolean isEventTriggerFloorBoundary, boolean isActive, int levelIndex) {
        
        super(leftX, topY, width, height, blockLineThickness, false, levelIndex);   // initially not active, to be set in makeActive()

        this.topSide = new EventBlockTopBoundary(
            leftX,
            topY,
            width,
            blockLineThickness,
            false,  // initially not active, to be set in makeActive()
            levelIndex
        );

        this.eventTriggerBoundary = new EventTriggerHorizontalBoundary(
            leftX + 10,
            topY + height - (height / 5),
            width - 20,
            blockLineThickness,
            endWarpXPositon, 
            endWarpYPositon,
            isEventTriggerFloorBoundary,
            false,  // initially not active, to be set in makeActive()
            levelIndex,
            (EventBlockTopBoundary) this.topSide
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
    }

    /**
     * display block
     */
    void show() {
        fill(Constants.EVENT_BLOCK_COLOR);
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
        this.eventTriggerBoundary.makeActive();
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
        this.eventTriggerBoundary.makeNotActive();
    }
}
