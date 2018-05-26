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
    boolean contactWithCharacter(ACharacter character) {
        if(character.pos.x > this.startPoint.x - (character.width / 2)          // > lower x boundary
            && character.pos.x < this.endPoint.x + (character.width / 2)        // < upper x boundary
            && character.pos.y <= this.startPoint.y + (character.height / 2)    // contact bottom of character
            && character.pos.y >= this.startPoint.y - (character.height / 2)) { // contact top of character
            return true;
        } else {
            return false;
        }
    }

    /**
     * runs continuously. checks and handles contact between this and characters
     */
    void draw() {
        this.show();

        for(ACharacter curCharacter : charactersList) {
            if(this.contactWithCharacter(curCharacter)) {
                if(this.isTopSideBoundary && !this.charactersTouchingThis.contains(curCharacter)) { // new collision detected
                    curCharacter.numberOfHorizontalBoundaryContacts++;
                    this.charactersTouchingThis.add(curCharacter);
                }
                curCharacter.handleContactWithHorizontalBoundary(this.startPoint.y, this.isTopSideBoundary);

            } else {
                if(this.isTopSideBoundary && this.charactersTouchingThis.contains(curCharacter)) {
                    curCharacter.numberOfHorizontalBoundaryContacts--;
                    this.charactersTouchingThis.remove(curCharacter);
                }
            }
        }
    }
}
