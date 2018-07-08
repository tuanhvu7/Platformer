/**
 * Common for circular characters
 */
abstract class ACharacter {
    // (x, y) coordinates of center of character (x, y)
    protected PVector pos;
    // (x, y) velocity of character (x, y)
    protected PVector vel;
    
    // character diameter
    protected int diameter;

    // number of floor-like boundaries this is touching;
    protected int numberOfFloorBoundaryContacts;

    // true means this is active (boundary and character collision detection)
    protected boolean isActive;

    // 0 means this is in level at 0th index of global_levels_list
    protected int levelIndex;

    /**
     * set properties of this
     */
    ACharacter(int x, int y, int diameter, boolean isActive, int levelIndex) {
        this.pos = new PVector(x, y);
        this.vel = new PVector();
        this.diameter = diameter;

        this.isActive = true;
        this.levelIndex = levelIndex;

        this.numberOfFloorBoundaryContacts = 0;

        if(isActive) {
            this.makeActive();
        }
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
    void handleContactWithHorizontalBoundary(float boundaryYPoint, boolean isFloorBoundary) {
        if(isFloorBoundary) { // floor-like boundary
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


    /**
     * active and add this to game
     */
    void makeActive() {
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
