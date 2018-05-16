public abstract class Character {
    PVector pos;
    PVector vel;
    int width;
    int height;

    boolean isOnGround;

    Character(int x, int y, int width, int height) {
        this.pos = new PVector(x, y);
        this.vel = new PVector();
        this.width = width;
        this.height = height;
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
        global_playerOnGround = true;
    }

    void handleInAir() {
        this.pos.add(this.vel);
        this.vel.y += global_gravity.y;
    }

    // void draw() { }
}
