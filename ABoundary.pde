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
     * @param x1Point first x coordinate
     * @param y1Point first y coordinate
     * @param x2Offset difference between first and second x coordinates (x2 - x1)
     * @param y2Offset difference between first and second y coordinates (y2 - y1)
     */
    ABoundary(int x1Point, int y1Point, int x2Offset, int y2Offset, int boundaryLineThickness,
                boolean isVisible, boolean isActiveToPlayer, boolean isActiveToNonPlayers) {
        
        // set start points to be smaller of given values
        this.startPoint = new PVector(
            Math.min(x1Point, x1Point + x2Offset), 
            Math.min(y1Point, y1Point + y2Offset));

        // set end points to be larger of given values
        this.endPoint = new PVector(
            Math.max(x1Point, x1Point + x2Offset), 
            Math.max(y1Point, y1Point + y2Offset));

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
