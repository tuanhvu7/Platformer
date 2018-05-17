public abstract class Character {
    protected PVector pos;
    protected PVector vel;
    
    protected int width;
    protected int height;

    protected boolean isMovingLeft;
    protected boolean isMovingRight;
    protected boolean isJumping;

    protected int numberOfBoundaryCollision;

    void keyEvent(KeyEvent keyEvent) { }

    Character(int x, int y, int width, int height) {
        this.pos = new PVector(x, y);
        this.vel = new PVector();
        this.width = width;
        this.height = height;

        this.isMovingLeft = false;
        this.isMovingRight = false;
        this.isJumping = false;

        this.numberOfBoundaryCollision = 0;
    }

    void setPos(PVector newPos) {
        this.pos = newPos;
        this.vel.y += global_gravity.y;
    }

    void show() {
        fill(255, 0, 0);
        strokeWeight(0);
        ellipse(this.pos.x, this.pos.y, this.width, this.height);
    }

    void handleCollideWithBoundary(float boundaryYPoint) {
        this.vel.y = 0;
        this.pos.y = boundaryYPoint - this.height / 2;
    }

    void handleInAir() {
        this.pos.add(this.vel);
        this.vel.y += global_gravity.y;
    }

    // void draw() { }
}
