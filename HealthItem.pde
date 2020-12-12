public class HealthItem extends ACollectable {

    private final int healthChangeAmount;

    /**
     * set properties of this;
     * sets this to affect all characters and be visible
     */
    public HealthItem(int healthChangeAmount,
                      int leftX, int topY, int width, int height,
                      int blockLineThickness, boolean initAsActive) {
        super(leftX, topY, width, height, blockLineThickness, initAsActive);
        this.healthChangeAmount = healthChangeAmount;
        this.fillColor = Constants.HEALTH_ITEM_COLOR;
    }

    @Override
    void show() {
        fill(this.fillColor);
        strokeWeight(this.blockLineThickness);
        rect(this.leftX, this.topY, this.width, this.height);
        if (this.healthChangeAmount > 0) {
            fill(Constants.POSITIVE_HEALTH_ITEM_TEXT_COLOR);
        } else if (this.healthChangeAmount == 0) {
            fill(Constants.ZERO_HEALTH_ITEM_TEXT_COLOR);
        } else {
            fill(Constants.NEGATIVE_HEALTH_ITEM_TEXT_COLOR);
        }
        textAlign(CENTER, CENTER);
        textSize(Math.min(this.width / 2, this.height / 2));
        text(
            Math.abs(this.healthChangeAmount) + "",
            this.leftX,
            this.topY,
            this.width,
            this.height);
    }

    @Override
    void checkHandleContactWithPlayer() {
        if (this.contactWithPlayer()) {
            getCurrentActivePlayer().changeHealth(this.healthChangeAmount);
            this.makeNotActive();
            getCurrentActiveLevelDrawableCollection().removeDrawable(this);
        }
    }
}
