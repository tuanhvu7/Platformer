/**
 * horizontal line boundaries of blocks
 */
public class BlockHorizontalBoundary extends HorizontalBoundary {

    /**
     * set properties of this;
     * sets this to affect all characters and be visible
     */
    BlockHorizontalBoundary(int startXPoint, int startyPoint, int x2Offset, int boundaryLineThickness,
                            boolean isFloorBoundary, boolean isActive, int levelIndex) {
        super(startXPoint, startyPoint, x2Offset, boundaryLineThickness,
                isFloorBoundary, isActive, levelIndex);
    }

    /**
     * set properties of this
     * sets this to affect all characters
     */
    BlockHorizontalBoundary(int startXPoint, int startyPoint, int x2Offset, int boundaryLineThickness,
                            boolean isVisible, boolean isFloorBoundary,
                            boolean isActive, int levelIndex) {
        super(startXPoint, startyPoint, x2Offset, boundaryLineThickness,
                isVisible, isFloorBoundary, isActive, levelIndex);
    }

    /**
     * set properties of this
     */
    BlockHorizontalBoundary(int startXPoint, int startyPoint, int x2Offset, int boundaryLineThickness,
                            boolean isVisible, boolean doesAffectPlayer, boolean doesAffectNonPlayers,
                            boolean isFloorBoundary, boolean isActive, int levelIndex) {
        super(startXPoint, startyPoint, x2Offset, boundaryLineThickness,
                isVisible, doesAffectPlayer, doesAffectNonPlayers,
                isFloorBoundary, isActive, levelIndex);
    }

    /**
     * check and handle contact with player
     */
    private void checkHandleContactWithPlayer() {
        Player curPlayer =  getPlayerAtLevelIndex(this.levelIndex);

        if(this.doesAffectPlayer && curPlayer.isActive) { // TODO: encapsulate
            // boundary collision for player
            if(this.contactWithCharacter(curPlayer)) { // this has contact with player
                if(!this.charactersTouchingThis.contains(curPlayer)) { // new collision detected
                    this.charactersTouchingThis.add(curPlayer);
                    if(this.isFloorBoundary) {
                        curPlayer.numberOfFloorBoundaryContacts++; // TODO: encapsulate
                        
                    } else {
                        curPlayer.numberOfCeilingBoundaryContacts++;  // TODO: encapsulate
                    }
                }

            } else {    // this DOES NOT have contact with player
                if(this.charactersTouchingThis.contains(curPlayer)) {
                    if(this.isFloorBoundary) {
                        curPlayer.numberOfFloorBoundaryContacts--; // TODO: encapsulate
                    } else {
                        curPlayer.numberOfCeilingBoundaryContacts--;  // TODO: encapsulate
                    }
                    this.charactersTouchingThis.remove(curPlayer);
                }
            }
        }
    }

}