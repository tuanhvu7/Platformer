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

    // number of boundaries this is touching;
    // touching 0 mean this is in air
    protected int numberOfBoundaryCollision;

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

        this.numberOfBoundaryCollision = 0;
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
     * handle collision with horizontal boundary
     */
    void handleCollisionWithHorizontalBoundary(float boundaryYPoint, boolean isTopSideBoundary) {
        if(isTopSideBoundary) {
            this.vel.y = 0;
            this.pos.y = boundaryYPoint - this.height / 2;
        } else {
            this.vel.y = 1;
            this.pos.add(this.vel);
        }
    }

    void handleCollisionWithVerticalBoundary(float boundaryXPoint) {
        this.vel.x = 0;
        if(this.pos.x > boundaryXPoint) {
            this.pos.x = boundaryXPoint + this.width / 2;
        } else {
            this.pos.x = boundaryXPoint - this.width / 2;
        }
        
    }

    /**
     * handle arial
     */
    void handleInAir() {
        this.pos.add(this.vel);
        this.vel.y = Math.min(this.vel.y + global_gravity.y, Constants.MAX_VERTICAL_VELOCITY);
    }

}
