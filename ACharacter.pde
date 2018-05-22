/**
 * Common for circular characters
 */
abstract class ACharacter {
    // position vector of character (x, y)
    protected PVector pos;
    // velocity vector of character (x, y)
    protected PVector vel;
    
    // character width and height
    protected int width;
    protected int height;

    // character movement states
    protected boolean isMovingLeft;
    protected boolean isMovingRight;
    protected boolean isJumping;

    // number of horizontal boundaries this is touching;
    protected int numberOfHorizontalBoundaryContacts;

    /**
     * set character properties
     */
    ACharacter(int x, int y, int width, int height) {
        this.pos = new PVector(x, y);
        this.vel = new PVector();
        this.width = width;
        this.height = height;

        this.isMovingLeft = false;
        this.isMovingRight = false;
        this.isJumping = false;

        this.numberOfHorizontalBoundaryContacts = 0;
    }

    /**
     * set position of character
     */
    void setPos(PVector newPos) {
        this.pos = newPos;
        this.vel.y += global_gravity.y;
    }

    /**
     * draw circle character
     */
    void show() {
        fill(255, 0, 0);
        strokeWeight(0);
        ellipse(this.pos.x, this.pos.y, this.width, this.height);
    }

    /**
     * handle contact with horizontal boundary
     */
    void handleContactWithHorizontalBoundary(float boundaryYPoint, boolean isTopSideBoundary) {
        if(isTopSideBoundary) { // floor-like object
            this.vel.y = 0;
            this.pos.y = boundaryYPoint - this.height / 2;
        } else {    // ceiling-like object
            this.vel.y = 1;
            this.pos.add(this.vel);
        }
    }

    /**
     * handle contact with vertical boundary
     */
    void handleContactWithVerticalBoundary(float boundaryXPoint) {
        this.vel.x = -this.vel.x; // move in oposite horizontal direction
    }

    /**
     * handle arial physics
     */
    void handleInAirPhysics() {
        this.vel.y = Math.min(this.vel.y + global_gravity.y, Constants.MAX_VERTICAL_VELOCITY);
    }

}
