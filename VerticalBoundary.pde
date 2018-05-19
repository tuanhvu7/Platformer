public class VerticalBoundary extends ABoundary implements IBoundary {

    /**
     * Set boundary properties
     */
    VerticalBoundary(int startXPoint, int startyPoint, int y2Offset, int boundaryWidth) {
        super(startXPoint, startyPoint, 0, y2Offset, boundaryWidth);
    }

    /**
     * return true if collide with given character
     */
    boolean collisionWithCharacter(ACharacter character) {
        if(character.pos.x >= this.pos.x - (character.width / 2)
            && character.pos.x <= this.pos.x + (character.width / 2)
            && character.pos.y < this.pos.y + this.y2Offset + (character.height / 2)
            && character.pos.y > this.pos.y - (character.width / 2)) {
            return true;
        } else {
            return false;
        }
    }

    /**
     * runs continuously. checks and handles collision between characters
     */
    void draw() {
        this.show();
        if(collisionWithCharacter(global_player)) {
            if(!this.charactersTouchingThis.contains(global_player)) {
                global_player.numberOfBoundaryCollision++;
                this.charactersTouchingThis.add(global_player);
            }
            global_player.handleCollisionWithVerticalBoundary(this.pos.x);
        } else {
            if(this.charactersTouchingThis.contains(global_player)) {
                global_player.numberOfBoundaryCollision--;
                this.charactersTouchingThis.remove(global_player);
            }
        }
    }

}