/**
 * vertical line boundaries
 */
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
    boolean contactWithCharacter(ACharacter character) {
        if(character.pos.x >= this.startPoint.x - (character.width / 2)         // contact right of character
            && character.pos.x <= this.startPoint.x + (character.width / 2)     // contact left of character
            && character.pos.y > this.startPoint.y - (character.height / 2)     // > lower y boundary
            && character.pos.y < this.endPoint.y + (character.height / 2)) {    // < upper y boundary
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
                if(!this.charactersTouchingThis.contains(curCharacter)) {  // new collision detected
                    if(curCharacter instanceof Player) {    // handle wall jump mechanic only for player
                        ((Player) curCharacter).isTouchingVerticalBoundary = true;
                        this.charactersTouchingThis.add(curCharacter);
                    }
                }
                curCharacter.handleContactWithVerticalBoundary(this.startPoint.x);
                
            } else {
                if(this.charactersTouchingThis.contains(curCharacter)) {
                    if(curCharacter instanceof Player) {    // handle wall jump mechanic only for player
                        ((Player) curCharacter).isTouchingVerticalBoundary = false;
                        this.charactersTouchingThis.remove(curCharacter);
                    }
                }
            }
        }
    }

}