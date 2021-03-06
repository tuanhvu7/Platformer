/**
 * Common for line boundaries
 */
public abstract class ABoundary implements IDrawable {

    // start point (smaller x and smaller y) coordinate for boundary
    final PVector startPoint;
    // end point (larger x and larger y) coordinate for boundary
    final PVector endPoint;

    // stoke thickness of boundary
    private final int boundaryLineThickness;

    // true means visible to player
    private boolean isVisible;

    // true means check and handle collision between this and player characters
    boolean doesAffectPlayer;

    // true means check and handle collision between this and non-player characters
    final boolean doesAffectNonPlayers;

    // set of all characters that are touching this
    final Set<ACharacter> charactersTouchingThis;

    /**
     * set properties of this
     *
     * @param x1Point  first x coordinate
     * @param y1Point  first y coordinate
     * @param x2Offset difference between first and second x coordinates (x2 - x1)
     * @param y2Offset difference between first and second y coordinates (y2 - y1)
     */
    ABoundary(int x1Point, int y1Point, int x2Offset, int y2Offset, int boundaryLineThickness,
              boolean isVisible, boolean doesAffectPlayer, boolean doesAffectNonPlayers,
              boolean initAsActive) {

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

        this.charactersTouchingThis = Collections.newSetFromMap(new ConcurrentHashMap<ACharacter, Boolean>());

        if (initAsActive) {
            this.makeActive();
        }
    }

    /**
     * runs continuously
     */
    @Override
    public void draw() {
        this.show();
        if (getCurrentActivePlayer() != null) {
            this.checkHandleContactWithPlayer();
        }
        this.checkHandleContactWithNonPlayerCharacters();
    }

    /**
     * check and handle contact with player
     */
    abstract void checkHandleContactWithPlayer();

    /**
     * check and handle contact with non-player characters
     */
    abstract void checkHandleContactWithNonPlayerCharacters();

    /**
     * display line boundary
     */
    void show() {
        if (this.isVisible) {
            stroke(Constants.BOUNDARY_COLOR);
            strokeWeight(this.boundaryLineThickness);
            line(this.startPoint.x, this.startPoint.y, this.endPoint.x, this.endPoint.y);
        }
    }

    /**
     * active and add this to game
     */
    public void makeActive() {
        this.charactersTouchingThis.clear();
        registerMethod(EProcessingMethods.DRAW.toString(), this); // connect this draw() from main draw()
    }

    /**
     * deactivate and remove this from game
     */
    public void makeNotActive() {
        unregisterMethod(EProcessingMethods.DRAW.toString(), this); // disconnect this draw() from main draw()
    }

    /*** getters and setters ***/
    public PVector getStartPoint() {
        return startPoint;
    }

    public PVector getEndPoint() {
        return endPoint;
    }

    public void setVisible(boolean visible) {
        isVisible = visible;
    }

    public void setDoesAffectPlayer(boolean doesAffectPlayer) {
        this.doesAffectPlayer = doesAffectPlayer;
    }

}
