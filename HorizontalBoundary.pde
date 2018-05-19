public class HorizontalBoundary extends ABoundary implements IBoundary {

    /**
     * Set boundary properties
     */
    HorizontalBoundary(int startXPoint, int startyPoint, int x2Offset, int boundaryWidth) {
        super(startXPoint, startyPoint, x2Offset, 0, boundaryWidth);
    }

    /**
     * return true if collide with given character
     */
    boolean collisionWithCharacter(ACharacter character) {
        if(character.pos.x > this.pos.x - (character.width / 2)
            && character.pos.x < this.pos.x + this.x2Offset + (character.width / 2)
            && character.pos.y <= this.pos.y + (character.height / 2)
            && character.pos.y >= this.pos.y - (character.height / 2)) {
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
            global_player.handleCollisionWithHorizontalBoundary(this.pos.y);
        } else {
            if(this.charactersTouchingThis.contains(global_player)) {
                global_player.numberOfBoundaryCollision--;
                this.charactersTouchingThis.remove(global_player);
            }
        }
    }
}
