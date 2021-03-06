/**
 * Common for circular characters
 */
public abstract class ACharacter implements IDrawable {

    // (x, y) coordinates of center of character (x, y)
    final PVector pos;
    // (x, y) velocity of character (x, y)
    PVector vel;

    final int diameter;

    int fillColor;

    // number of floor-like boundaries this is touching;
    int numberOfFloorBoundaryContacts;

    /**
     * set properties of this
     */
    ACharacter(int x, int y, int diameter, boolean initAsActive) {
        this.pos = new PVector(x, y);
        this.vel = new PVector();
        this.diameter = diameter;

        this.numberOfFloorBoundaryContacts = 0;

        if (initAsActive) {
            this.makeActive();
        }
    }

    /**
     * draw circle character
     */
    void show() {
        fill(this.fillColor);
        strokeWeight(0);
        ellipse(this.pos.x, this.pos.y, this.diameter, this.diameter);
    }

    /**
     * handle contact with horizontal boundary
     */
    public void handleContactWithHorizontalBoundary(float boundaryYPoint, boolean isFloorBoundary) {
        if (isFloorBoundary) { // floor-like boundary
            if (this.vel.y > 0) {    // boundary only act like floor if this is falling onto boundary
                this.vel.y = 0;
                this.pos.y = boundaryYPoint - this.diameter / 2;
            }
        } else {    // ceiling-like boundary
            if (this.vel.y < 0) {    // boundary only act like ceiling if this is rising into boundary
                this.vel.y = 1;
                this.pos.y = boundaryYPoint + this.diameter / 2;
                this.pos.add(this.vel);
            }
        }
    }

    /**
     * handle contact with vertical boundary
     */
    public void handleContactWithVerticalBoundary(float boundaryXPoint) {
        final boolean movingIntoBoundaryFromRight = this.pos.x > boundaryXPoint && this.vel.x < 0;
        final boolean movingIntoBoundaryFromLeft = this.pos.x < boundaryXPoint && this.vel.x > 0;
        if (movingIntoBoundaryFromRight || movingIntoBoundaryFromLeft) {
            this.vel.x = -this.vel.x; // move in opposite horizontal direction
        }
    }

    /**
     * handle movement (horizontal, vertical) of this
     */
    abstract void handleMovement();

    /**
     * handle arial physics
     */
    void handleInAirPhysics() {
        this.vel.y = Math.min(this.vel.y + getGravity().y, Constants.MAX_VERTICAL_VELOCITY);
    }


    /**
     * active and add this to game
     */
    public void makeActive() {
        registerMethod(EProcessingMethods.DRAW.toString(), this); // connect this draw() from main draw()
    }

    /**
     * deactivate and remove this from game
     */
    public void makeNotActive() {
        unregisterMethod(EProcessingMethods.DRAW.toString(), this); // disconnect this draw() from main draw()
    }

    /**
     * @param amount change numberOfFloorBoundaryContacts by given value
     */
    public void changeNumberOfFloorBoundaryContacts(int amount) {
        this.numberOfFloorBoundaryContacts += amount;
    }

    /**
     * check and handle death of this by going offscreen
     */
    void checkHandleOffscreenDeath() {
        int upperScreenLimit = height - getCurrentActiveLevelHeight();

        if (this.pos.y + this.diameter / 2 <= upperScreenLimit
            || this.pos.y - this.diameter / 2 >= height) {

            this.handleDeath(true);
        }
    }

    /**
     * handle death of this;
     * to override in extended methods
     */
    abstract void handleDeath(boolean isOffscreenDeath);

    /*** getters and setters ***/
    public PVector getPos() {
        return pos;
    }

    public PVector getVel() {
        return vel;
    }

    public void setVel(PVector vel) {
        this.vel = vel;
    }

    public int getDiameter() {
        return diameter;
    }
}
