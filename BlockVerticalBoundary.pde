/**
 * vertical line boundaries of blocks
 */
public class BlockVerticalBoundary extends VerticalBoundary {

    /**
     * set properties of this;
     * sets this to affect all characters and be visible
     */
    BlockVerticalBoundary(int startXPoint, int startyPoint, int y2Offset, int boundaryLineThickness, 
                            boolean isActive, int levelIndex) {
        super(startXPoint, startyPoint, y2Offset, boundaryLineThickness, isActive, levelIndex);
    }

    /**
     * set properties of this
     * sets this to affect all characters
     */
    BlockVerticalBoundary(int startXPoint, int startyPoint, int y2Offset, int boundaryLineThickness,
                            boolean isVisible, boolean isActive, int levelIndex) {
        super(startXPoint, startyPoint, y2Offset, boundaryLineThickness, isVisible, isActive, levelIndex);
    }

    /**
     * set properties of this
     */
    BlockVerticalBoundary(int startXPoint, int startyPoint, int y2Offset, int boundaryLineThickness,
                            boolean isVisible, boolean doesAffectPlayer, boolean doesAffectNonPlayers, 
                            boolean isActive, int levelIndex) {
        super(startXPoint, startyPoint, y2Offset, boundaryLineThickness,
                isVisible, doesAffectPlayer, doesAffectNonPlayers, isActive, levelIndex);
    }

    /**
     * check and handle contact with player
     */
    private void checkHandleContactWithPlayer() {
        Player curPlayer =  getPlayerAtLevelIndex(this.levelIndex);

        if(this.doesAffectPlayer && curPlayer.isActive) {   // TODO: encapsulate
            // boundary collision for player
            if(contactWithCharacter(curPlayer)) {  // this has contact with non-player
                if(!this.charactersTouchingThis.contains(curPlayer)) {  // new collision detected
                    curPlayer.numberOfVerticalBoundaryContacts++;    // TODO: encapsulate
                    this.charactersTouchingThis.add(curPlayer);
                }
                
            } else {    // this DOES NOT have contact with non-player
                if(this.charactersTouchingThis.contains(curPlayer)) {
                    curPlayer.numberOfVerticalBoundaryContacts--;   // TODO: encapsulate
                    this.charactersTouchingThis.remove(curPlayer);
                }
            }
        }
    }

}