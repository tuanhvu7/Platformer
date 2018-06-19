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
    protected boolean doesAffectPlayer;

    // true means check and handle collision between this and non-player characters
    protected boolean doesAffectNonPlayers;

    // set of all characters that are touching this
    protected Set<ACharacter> charactersTouchingThis;

    // true means this is active (character collision detection)
    protected boolean isActive;

    // 0 means this is in level at 0th index of global_levels_list
    protected int levelIndex;

    /**
     * set properties of this
     * @param x1Point first x coordinate
     * @param y1Point first y coordinate
     * @param x2Offset difference between first and second x coordinates (x2 - x1)
     * @param y2Offset difference between first and second y coordinates (y2 - y1)
     */
    ABoundary(int x1Point, int y1Point, int x2Offset, int y2Offset, int boundaryLineThickness,
                boolean isVisible, boolean doesAffectPlayer, boolean doesAffectNonPlayers,
                boolean isActive, int levelIndex) {
        
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
        this.doesAffectPlayer = doesAffectPlayer;
        this.doesAffectNonPlayers = doesAffectNonPlayers;

        this.charactersTouchingThis = new HashSet<ACharacter>();

        this.levelIndex = levelIndex;
        
        if(isActive) {
            this.makeActive();
        }
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

    /**
     * active and add this to game
     */
    void makeActive() {
        this.charactersTouchingThis.clear();
        this.isActive = true;
        registerMethod("draw", this); // connect this draw() from main draw()
    }

    /**
     * deactivate and remove this from game
     */
    void makeNotActive() {
        this.isActive = false;
        unregisterMethod("draw", this); // disconnect this draw() from main draw()
    }

}
