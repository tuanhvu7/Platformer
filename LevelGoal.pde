/**
 * level goal
 */
public class LevelGoal extends ACollectable {
    /**
     * set properties of this;
     * sets this to affect all characters and be visible
     */
    LevelGoal(int leftX, int topY, int width, int height, int blockLineThickness, boolean isActive) {
        super(leftX, topY, width, height, blockLineThickness, isActive);
    }

    /**
     * display block
     */
    void show() {
        fill(Constants.LEVEL_GOAL_BLOCK_COLOR);
        strokeWeight(this.blockLineThickness);
        rect(this.leftX, this.topY, this.width, this.height);
    }

    /**
     * check and handle contact with player
     */
    protected void checkHandleContactWithPlayer() {
        if(getCurrentActivePlayer().isActive && this.contactWithPlayer()) {   // TODO: encapsulate
            this.makeNotActive();
            handleLevelComplete();
        }
    }
}