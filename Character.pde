public abstract class Character {
    PVector pos;
    PVector vel;
    int width;
    int height;

    Character(int x, int y, int width, int height) {
        this.pos = new PVector(x, y);
        this.vel = new PVector();
        this.width = width;
        this.height = height;
    }

    void setPos(PVector newPos) {
        this.pos = newPos;
        this.vel.y += gravity.y;
    }

    void show() {
        fill(255, 0, 0);
        strokeWeight(0);
        ellipse(this.pos.x, this.pos.y, this.width, this.height);
    }

    boolean collideWithBoundary() {
        for(int i = 0; i < boundaryList.size(); i++) {
            if(boundaryList.get(i).collide(this)) {
                this.vel.y = 0;
                this.pos.y = boundaryList.get(i).pos.y - this.height / 2;
                playerCanJumpAgain = true;
                return true;
            }
        }
        return false;
    }

    // void draw() { }
}
