/**
 * vertical line boundaries; walls
 */
public class VerticalBoundary extends ABoundary implements IBoundary, IDrawable {

    /**
     * set properties of this;
     * sets this to be active for all characters and visible
     */
    VerticalBoundary(int startXPoint, int startyPoint, int y2Offset, int boundaryWidth, 
                        boolean isActive, int levelIndex) {
        super(startXPoint, startyPoint, 0, y2Offset, boundaryWidth,
                true, true, true, isActive, levelIndex);
    }

    /**
     * set properties of this
     */
    VerticalBoundary(int startXPoint, int startyPoint, int y2Offset, int boundaryWidth,
                        boolean isVisible, boolean isActiveToPlayer, boolean isActiveToNonPlayers, 
                        boolean isActive, int levelIndex) {
        super(startXPoint, startyPoint, 0, y2Offset, boundaryWidth,
                isVisible, isActiveToPlayer, isActiveToNonPlayers, isActive, levelIndex);
    }

    /**
     * return true if collide with given character
     */
    boolean contactWithCharacter(ACharacter character) {
        if(character.pos.x  + (character.diameter / 2) >= this.startPoint.x         // contact right of character
            && character.pos.x - (character.diameter / 2) <= this.startPoint.x      // contact left of character
            && character.pos.y > this.startPoint.y - (character.diameter / 2)       // > lower y boundary
            && character.pos.y < this.endPoint.y + (character.diameter / 2)) {      // < upper y boundary
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

        if(this.isActiveToPlayer && getPlayerAtLevelIndex(this.levelIndex).isActive) {   // TODO: encapsulate
            // boundary collision for player
            if(contactWithCharacter(getPlayerAtLevelIndex(this.levelIndex))) {
                if(!this.charactersTouchingThis.contains(getPlayerAtLevelIndex(this.levelIndex))) {  // new collision detected
                    getPlayerAtLevelIndex(this.levelIndex).isTouchingVerticalBoundary = true;    // TODO: encapsulate
                    this.charactersTouchingThis.add(getPlayerAtLevelIndex(this.levelIndex));
                }
                getPlayerAtLevelIndex(this.levelIndex).handleContactWithVerticalBoundary(this.startPoint.x);
                
            } else {
                if(this.charactersTouchingThis.contains(getPlayerAtLevelIndex(this.levelIndex))) {
                    getPlayerAtLevelIndex(this.levelIndex).isTouchingVerticalBoundary = false;   // TODO: encapsulate
                    this.charactersTouchingThis.remove(getPlayerAtLevelIndex(this.levelIndex));
                }
            }
        }

        if(this.isActiveToNonPlayers) {
            // boundary collision for non-player characters
            for( ACharacter curCharacter : getCharactersListAtLevelIndex(this.levelIndex) ) {
                if(curCharacter.isActive && this.contactWithCharacter(curCharacter)) {  // TODO: encapsulate
                    curCharacter.handleContactWithVerticalBoundary(this.startPoint.x);     
                }
            }
        }
    }

}