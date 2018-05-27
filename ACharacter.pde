/**
 * Common for circular characters
 */
abstract class ACharacter {
    // position vector of center of character (x, y)
    protected PVector pos;
    // velocity vector of character (x, y)
    protected PVector vel;
    
    // character diameter
    protected int diameter;

    // character movement states
    protected boolean isMovingLeft;
    protected boolean isMovingRight;
    protected boolean isJumping;

    // number of horizontal boundaries this is touching;
    protected int numberOfHorizontalBoundaryContacts;

    // true means still in game (boundary and player collision detection)
    boolean isActive;

    /**
     * set character properties
     */
    ACharacter(int x, int y, int diameter) {
        this.pos = new PVector(x, y);
        this.vel = new PVector();
        this.diameter = diameter;

        this.isActive = true;

        this.isMovingLeft = false;
        this.isMovingRight = false;
        this.isJumping = false;

        this.numberOfHorizontalBoundaryContacts = 0;
    }

    /**
     * draw circle character
     */
    void show() {
        strokeWeight(0);
        ellipse(this.pos.x, this.pos.y, this.diameter, this.diameter);
    }

    /**
     * handle contact with horizontal boundary
     */
    void handleContactWithHorizontalBoundary(float boundaryYPoint, boolean isTopSideBoundary) {
        if(isTopSideBoundary) { // floor-like boundary
            if(this.vel.y > 0) {    // boundary only act like floor if this is falling onto boundary
                this.vel.y = 0;
                this.pos.y = boundaryYPoint - this.diameter / 2;
            }
        } else {    // ceiling-like boundary
            if(this.vel.y < 0) {    // boundary only act like ceiling if this is rising into boundary
                this.vel.y = 1;
                this.pos.add(this.vel);
            }
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
