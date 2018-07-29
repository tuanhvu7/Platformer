/**
 * checkpoint
 */
public class Checkpoint extends ACollectable {

    /**
     * set properties of this;
     * sets this to affect all characters and be visible
     */
    Checkpoint(int leftX, int topY, int width, int height, int blockLineThickness, boolean isActive) {
        super(leftX, topY, width, height, blockLineThickness, isActive);
    }

    /**
     * display block
     */
    void show() {
        fill(Constants.CHECKPOINT_BLOCK_COLOR);
        strokeWeight(this.blockLineThickness);
        rect(this.leftX, this.topY, this.width, this.height);
    }

    /**
     *  check and handle contact with player
     */
    protected void checkHandleContactWithPlayer() {
        if(getCurrentActivePlayer().isActive && this.contactWithPlayer()) {   // TODO: encapsulate
            global_current_active_level.get().loadPlayerFromCheckPoint = true;  // TODO: encapsulate
            this.makeNotActive();
            getCurrentActiveLevelCollectables().remove(this);
        }
    }

}
