/**
 * checkpoint
 */
public class Checkpoint extends ACollectable {

    /**
     * set properties of this;
     * sets this to affect all characters and be visible
     */
    public Checkpoint(int leftX, int topY, int width, int height, int blockLineThickness, boolean isActive) {
        super(leftX, topY, width, height, blockLineThickness, isActive);
        this.fillColor = Constants.CHECKPOINT_COLOR;
    }

    /**
     * check and handle contact with player
     */
    @Override
    void checkHandleContactWithPlayer() {
        if (getCurrentActivePlayer().isActive() && this.contactWithPlayer()) {
            getCurrentActiveLevel().setLoadPlayerFromCheckPoint(true);
            this.makeNotActive();
            getCurrentActiveLevelCollectables().remove(this);
        }
    }

}