/**
 * vertical line boundaries; walls
 */
public class VerticalBoundary extends ABoundary implements IBoundary, IDrawable {

    /**
     * Set boundary properties;
     * sets boundary to be active for all characters and visible
     */
    VerticalBoundary(int startXPoint, int startyPoint, int y2Offset, int boundaryWidth, boolean isInGame) {
        super(startXPoint, startyPoint, 0, y2Offset, boundaryWidth,
                true, true, true, isInGame);
    }

    /**
     * Set boundary properties
     */
    VerticalBoundary(int startXPoint, int startyPoint, int y2Offset, int boundaryWidth,
                        boolean isVisible, boolean isActiveToPlayer, boolean isActiveToNonPlayers, 
                        boolean isInGame) {
        super(startXPoint, startyPoint, 0, y2Offset, boundaryWidth,
                isVisible, isActiveToPlayer, isActiveToNonPlayers, isInGame);
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

        if(this.isActiveToPlayer && global_player.isInGame) {   // TODO: encapsulate
            // boundary collision for player
            if(contactWithCharacter(global_player)) {
                if(!this.charactersTouchingThis.contains(global_player)) {  // new collision detected
                    global_player.isTouchingVerticalBoundary = true;    // TODO: encapsulate
                    this.charactersTouchingThis.add(global_player);
                }
                global_player.handleContactWithVerticalBoundary(this.startPoint.x);
                
            } else {
                if(this.charactersTouchingThis.contains(global_player)) {
                    global_player.isTouchingVerticalBoundary = false;   // TODO: encapsulate
                    this.charactersTouchingThis.remove(global_player);
                }
            }
        }

        if(this.isActiveToNonPlayers) {
            // boundary collision for non-player characters
            for(ACharacter curCharacter : global_characters_list) {
                if(curCharacter.isInGame && this.contactWithCharacter(curCharacter)) {  // TODO: encapsulate
                    curCharacter.handleContactWithVerticalBoundary(this.startPoint.x);     
                }
            }
        }
    }

}