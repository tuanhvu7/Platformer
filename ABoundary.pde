/**
 * Common for line boundaries
 */
abstract class ABoundary {
    // start point (smaller x and smaller y) coordinate for boundary
    protected PVector startPoint;
    
    // end piont (larger x and larger y) coordinate for boundary
    protected PVector endPoint;

    // width of boundary
    protected int boundaryWidth;

    /**
     * Set boundary properties
     * @param startXPoint starting x coordinate
     * @param startYPoint starting y coordinate
     * @param x2Offset difference between starting and ending x coordinates (x2 - x1)
     * @param y2Offset difference between starting and ending y coordinates (y2 - y1)
     * @param boundaryWidth width of line
     */
    ABoundary(int startXPoint, int startYPoint, int x2Offset, int y2Offset, int boundaryWidth) {
        
        this.startPoint = new PVector(
            Math.min(startXPoint, startXPoint + x2Offset), 
            Math.min(startYPoint, startYPoint + y2Offset));

        this.endPoint = new PVector(
            Math.max(startXPoint, startXPoint + x2Offset), 
            Math.max(startYPoint, startYPoint + y2Offset));

        this.boundaryWidth = boundaryWidth;
    }

    /**
     * display line boundary
     */
    void show() {
        stroke(0);
        strokeWeight(this.boundaryWidth);
        line(this.startPoint.x, this.startPoint.y, this.endPoint.x, this.endPoint.y);
    }

}
