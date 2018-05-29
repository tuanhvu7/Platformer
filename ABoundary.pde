/**
 * Common for line boundaries
 */
abstract class ABoundary {
    // start point (smaller x and smaller y) coordinate for boundary
    protected PVector startPoint;
    
    // end piont (larger x and larger y) coordinate for boundary
    protected PVector endPoint;

    // stoke thickness of boundary
    protected int boundaryLineThickness;

    // true means visible to player
    protected boolean isVisible;

    // true means check and handle collision between this and player characters
    protected boolean isActiveToPlayer;

    // true means check and handle collision between this and non-player characters
    protected boolean isActiveToNonPlayers;

    // set of all characters that are touching this
    protected Set<ACharacter> charactersTouchingThis;

    /**
     * Set boundary properties
     * @param startXPoint starting x coordinate
     * @param startYPoint starting y coordinate
     * @param x2Offset difference between starting and ending x coordinates (x2 - x1)
     * @param y2Offset difference between starting and ending y coordinates (y2 - y1)
     */
    ABoundary(int startXPoint, int startYPoint, int x2Offset, int y2Offset, int boundaryLineThickness,
                boolean isVisible, boolean isActiveToPlayer, boolean isActiveToNonPlayers) {
        
        this.startPoint = new PVector(
            Math.min(startXPoint, startXPoint + x2Offset), 
            Math.min(startYPoint, startYPoint + y2Offset));

        this.endPoint = new PVector(
            Math.max(startXPoint, startXPoint + x2Offset), 
            Math.max(startYPoint, startYPoint + y2Offset));

        this.boundaryLineThickness = boundaryLineThickness;

        this.isVisible = isVisible;
        this.isActiveToPlayer = isActiveToPlayer;
        this.isActiveToNonPlayers = isActiveToNonPlayers;

        this.charactersTouchingThis = new HashSet<ACharacter>();
    }

    /**
     * display line boundary
     */
    void show() {
        if(this.isVisible) {
            stroke(Constants.BOUNDARY_COLOR);
            strokeWeight(this.boundaryLineThickness);
            line(this.startPoint.x, this.startPoint.y, this.endPoint.x, this.endPoint.y);
        }
    }

}
