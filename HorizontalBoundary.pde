/**
 * horizontal line boundaries
 */
public class HorizontalBoundary extends ABoundary implements IBoundary {

    // true means character cannot go through top side of boundary
    // false means character cannot go through bottom side of boundary
    private boolean isTopSideBoundary;

    /**
     * Set boundary properties
     */
    HorizontalBoundary(int startXPoint, int startyPoint, int x2Offset, int boundaryWidth, boolean isTopSideBoundary) {
        super(startXPoint, startyPoint, x2Offset, 0, boundaryWidth);
        this.isTopSideBoundary = isTopSideBoundary;
    }

    /**
     * return true if collide with given character
     */
    boolean collisionWithCharacter(ACharacter character) {
        if(character.pos.x > this.startPoint.x - (character.width / 2)
            && character.pos.x < this.endPoint.x + (character.width / 2)
            && character.pos.y <= this.startPoint.y + (character.height / 2)
            && character.pos.y >= this.startPoint.y - (character.height / 2)) {
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
            global_player.handleCollisionWithHorizontalBoundary(this.startPoint.y, this.isTopSideBoundary);
        } else {
            if(this.charactersTouchingThis.contains(global_player)) {
                global_player.numberOfBoundaryCollision--;
                this.charactersTouchingThis.remove(global_player);
            }
        }
    }
}
