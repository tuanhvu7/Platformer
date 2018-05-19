/**
 * Common for line boundaries
 */
abstract class ABoundary {
    protected PVector pos;
    protected int x2Offset;
    protected int y2Offset;
    protected int boundaryWidth;

    // set of all characters that are touching this
    protected Set<ACharacter> charactersTouchingThis;

    /**
     * Set boundary properties
     * @param startXPoint starting x coordinate
     * @param startYPoint starting y coordinate
     * @param x2Offset difference between starting and ending x coordinates (x2 - x1)
     * @param y2Offset difference between starting and ending y coordinates (y2 - y1)
     * @param boundaryWidth width of line
     */
    ABoundary(int startXPoint, int startYPoint, int x2Offset, int y2Offset, int boundaryWidth) {
        this.pos = new PVector(startXPoint, startYPoint);
        this.x2Offset = x2Offset;
        this.y2Offset = y2Offset;
        this.boundaryWidth = boundaryWidth;

        this.charactersTouchingThis = new HashSet<ACharacter>();
    }

    /**
     * display line boundary
     */
    void show() {
        stroke(0);
        strokeWeight(this.boundaryWidth);
        line(this.pos.x, this.pos.y, this.pos.x + this.x2Offset, this.pos.y + this.y2Offset);
    }

}
