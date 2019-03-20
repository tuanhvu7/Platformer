/**
 * level goal
 */
public class LevelGoal extends ACollectable {
    /**
     * set properties of this;
     * sets this to affect all characters and be visible
     */
    public LevelGoal(int leftX, int topY, int width, int height, int blockLineThickness, boolean isActive) {
        super(leftX, topY, width, height, blockLineThickness, isActive);
        this.fillColor = Constants.LEVEL_GOAL_COLOR;
    }

    /**
     * check and handle contact with player
     */
    @Override
    void checkHandleContactWithPlayer() {
        if (this.contactWithPlayer()) {
            this.makeNotActive();
            getCurrentActiveLevelDrawableCollection().removeDrawable(this);
            handleLevelComplete();
        }
    }
}