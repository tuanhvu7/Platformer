/**
 * vertical line boundaries; walls
 */
public class VerticalBoundary extends ABoundary implements IBoundary, IDrawable {

    /**
     * set properties of this;
     * sets this to affect all characters and be visible
     */
    VerticalBoundary(int startXPoint, int startYPoint, int y2Offset, int boundaryLineThickness, 
                        boolean isActive) {
        super(startXPoint, startYPoint, 0, y2Offset, boundaryLineThickness,
                true, true, true, isActive);
    }

    /**
     * set properties of this
     * sets this to affect all characters
     */
    VerticalBoundary(int startXPoint, int startYPoint, int y2Offset, int boundaryLineThickness,
                        boolean isVisible, boolean isActive) {
        super(startXPoint, startYPoint, 0, y2Offset, boundaryLineThickness,
                isVisible, true, true, isActive);
    }

    /**
     * set properties of this
     */
    VerticalBoundary(int startXPoint, int startYPoint, int y2Offset, int boundaryLineThickness,
                        boolean isVisible, boolean doesAffectPlayer, boolean doesAffectNonPlayers, 
                        boolean isActive) {
        super(startXPoint, startYPoint, 0, y2Offset, boundaryLineThickness,
                isVisible, doesAffectPlayer, doesAffectNonPlayers, isActive);
    }

    /**
     * return true if collide with given character
     */
    boolean contactWithCharacter(ACharacter character) {
        if( character.pos.x  + (character.diameter / 2) >= this.startPoint.x         // contact right of character
            && character.pos.x - (character.diameter / 2) <= this.startPoint.x      // contact left of character
            && character.pos.y > this.startPoint.y - (character.diameter / 2)       // > lower y boundary
            && character.pos.y < this.endPoint.y + (character.diameter / 2) )         // < upper y boundary
        {      
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
        this.checkHandleContactWithPlayer();
        this.checkHandleContactWithNonPlayerCharacters();
    }

    /**
     * check and handle contact with player
     */
    private void checkHandleContactWithPlayer() {
        Player curPlayer =  getCurrentActivePlayer();

        if(this.doesAffectPlayer && curPlayer.isActive) {   // TODO: encapsulate
            // boundary collision for player
            if(contactWithCharacter(curPlayer)) {  // this has contact with non-player
                if(!this.charactersTouchingThis.contains(curPlayer)) {  // new collision detected
                    curPlayer.numberOfVerticalBoundaryContacts++;    // TODO: encapsulate
                    this.charactersTouchingThis.add(curPlayer);
                }
                curPlayer.handleContactWithVerticalBoundary(this.startPoint.x);
                
            } else {    // this DOES NOT have contact with player
                if(this.charactersTouchingThis.contains(curPlayer)) {
                    curPlayer.ableToMoveRight = true;    // TODO: encapsulate
                    curPlayer.ableToMoveLeft = true;    // TODO: encapsulate
                    curPlayer.numberOfVerticalBoundaryContacts--;   // TODO: encapsulate
                    this.charactersTouchingThis.remove(curPlayer);
                }
            }
        }
    }

    /**
     *  check and handle contact with non-player characters
     */
    private void checkHandleContactWithNonPlayerCharacters() {
        if(this.doesAffectNonPlayers) {
            // boundary collision for non-player characters
            for( ACharacter curCharacter : getCurrentActiveCharactersList() ) {
                if(curCharacter.isActive && this.contactWithCharacter(curCharacter)) {  // TODO: encapsulate
                    curCharacter.handleContactWithVerticalBoundary(this.startPoint.x);     
                }
            }
        }
    }

}