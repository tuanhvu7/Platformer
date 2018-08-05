/**
 * event block;
 */
public class EventBlock extends ABlock implements IDrawable {

    // boundary that events player upon player contact
    private final EventTriggerHorizontalBoundary eventTriggerBoundary;

    /**
     * set properties of this;
     * sets this to have launch event and affect all characters and be visible
     */
    public EventBlock(int leftX, int topY, int width, int height, int blockLineThickness,
                      boolean isEventTriggerFloorBoundary, boolean isActive) {

        super(leftX, topY, width, height, blockLineThickness, false);   // initially not active, to be set in makeActive()

        this.fillColor = Constants.EVENT_BLOCK_COLOR;

        this.topSide = new EventBlockTopBoundary(
            leftX,
            topY,
            width,
            blockLineThickness,
            false  // initially not active, to be set in makeActive()
        );

        this.eventTriggerBoundary = new EventTriggerHorizontalBoundary(
            leftX + 10,
            topY + height - (height / 5),
            width - 20,
            blockLineThickness,
            isEventTriggerFloorBoundary,
            false,  // initially not active, to be set in makeActive()
            (EventBlockTopBoundary) this.topSide
        );

        if (isActive) {
            this.makeActive();
        }
    }

    /**
     * set properties of this;
     * sets this to have warp event and affect all characters and be visible
     */
    public EventBlock(int leftX, int topY, int width, int height, int blockLineThickness,
                      int endWarpXPosition, int endWarpYPosition,
                      boolean isEventTriggerFloorBoundary, boolean isActive) {

        super(leftX, topY, width, height, blockLineThickness, false);   // initially not active, to be set in makeActive()

        this.fillColor = Constants.EVENT_BLOCK_COLOR;

        this.topSide = new EventBlockTopBoundary(
            leftX,
            topY,
            width,
            blockLineThickness,
            false  // initially not active, to be set in makeActive()
        );

        this.eventTriggerBoundary = new EventTriggerHorizontalBoundary(
            leftX + 10,
            topY + height - (height / 5),
            width - 20,
            blockLineThickness,
            endWarpXPosition,
            endWarpYPosition,
            isEventTriggerFloorBoundary,
            false,  // initially not active, to be set in makeActive()
            (EventBlockTopBoundary) this.topSide
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
    }

    /**
     * active and add this to game
     */
    private void makeActive() {
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
    @Override
    public void makeNotActive() {
        unregisterMethod("draw", this); // disconnect this draw() from main draw()

        this.topSide.makeNotActive();
        this.bottomSide.makeNotActive();
        this.leftSide.makeNotActive();
        this.rightSide.makeNotActive();
        this.eventTriggerBoundary.makeNotActive();
    }
}