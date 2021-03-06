/**
 * Common for panels
 */
public abstract class APanel implements IDrawable, IMouseControllable {

    final int leftX;
    final int rightX;

    final int topY;
    final int bottomY;

    int panelColor;
    String panelText;

    private final int width;
    private final int height;

    /**
     * set properties of this
     */
    APanel(int panelColor, String panelText, int leftX, int topY, int width, int height, boolean initAsActive) {
        this.panelText = panelText;
        this.panelColor = panelColor;
        this.width = width;
        this.height = height;

        this.leftX = leftX;
        this.rightX = leftX + width;

        this.topY = topY;
        this.bottomY = topY + height;

        if (initAsActive) {
            this.makeActive();
        }
    }

    /**
     * active and add this to game
     */
    void makeActive() {
        registerMethod(EProcessingMethods.DRAW.toString(), this); // connect this draw() from main draw()
        registerMethod(EProcessingMethods.MOUSE_EVENT.toString(), this); // connect this mouseEvent() from main mouseEvent()
    }

    /**
     * deactivate and remove this from game
     */
    public void makeNotActive() {
        unregisterMethod(EProcessingMethods.DRAW.toString(), this); // disconnect this draw() from main draw()
        unregisterMethod(EProcessingMethods.MOUSE_EVENT.toString(), this); // connect this mouseEvent() from main mouseEvent()
    }

    /**
     * runs continuously; draws rectangle panel using this properties
     */
    @Override
    public void draw() {
        fill(this.panelColor);
        rect(this.leftX, this.topY, this.width, this.height);

        fill(0);
        textAlign(CENTER, CENTER);
        textSize(Constants.TEXT_SIZE);
        text(this.panelText + "", this.leftX, this.topY, this.width, this.height);
    }

    /**
     * Execute appropriate method (executeWhenClicked) when this is clicked
     */
    @Override
    public void mouseEvent(MouseEvent event) {
        if (event.getAction() == MouseEvent.CLICK) {
            if (isMouseIn()) {
                executeWhenClicked();
            }
        }
    }

    /**
     * to execute when this panel is clicked; to override in extended classes
     */
    abstract void executeWhenClicked();

    /**
     * return if mouse position inside this panel
     */
    boolean isMouseIn() {
        return mouseX > this.leftX &&
            mouseX < this.rightX &&
            mouseY > this.topY &&
            mouseY < this.bottomY;
    }

}
