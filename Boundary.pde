class Boundary {
    PVector pos;
    int x2Offset;
    int y2Offset;
    int boundaryWidth;

    Boundary(int xPoint, int yPoint, int x2Offset, int y2Offset, int boundaryWidth) {
        this.pos = new PVector(xPoint, yPoint);
        this.x2Offset = x2Offset;
        this.y2Offset = y2Offset;
        this.boundaryWidth = boundaryWidth;
    }

    void show() {
        stroke(0);
        strokeWeight(this.boundaryWidth);
        line(this.pos.x, this.pos.y, this.pos.x + this.x2Offset, this.pos.y + this.y2Offset);
    }

    boolean collide(PVector otherPos, int otherHeight) {
        if(otherPos.x > this.pos.x && otherPos.x < this.pos.x + this.x2Offset
            && otherPos.y > this.pos.y - boundaryWidth - otherHeight) {
            return true;
        } else {
            return false;
        }
    }

    boolean collide(Character character) {
        if(character.pos.x > this.pos.x 
            && character.pos.x < this.pos.x + this.x2Offset
            && character.pos.y <= this.pos.y + (character.height / 2)
            && character.pos.y >= this.pos.y - (character.height / 2)) {
            return true;
        } else {
            return false;
        }
    }
}
