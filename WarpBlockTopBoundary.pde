/**
 * horizontal line boundaries of warp blocks
 */
public class WarpBlockTopBoundary extends HorizontalBoundary {

    /**
     * set properties of this;
     * sets this to affect all characters and be visible
     */
    WarpBlockTopBoundary(int startXPoint, int startyPoint, int x2Offset, int boundaryLineThickness,
                            boolean isActive, int levelIndex) {
        super(startXPoint, startyPoint, x2Offset, boundaryLineThickness,
                false, isActive, levelIndex);
    }

    /**
     * set properties of this
     * sets this to affect all characters
     */
    WarpBlockTopBoundary(int startXPoint, int startyPoint, int x2Offset, int boundaryLineThickness,
                            boolean isVisible,
                            boolean isActive, int levelIndex) {
        super(startXPoint, startyPoint, x2Offset, boundaryLineThickness,
                isVisible, false, isActive, levelIndex);
    }

    /**
     * set properties of this
     */
    WarpBlockTopBoundary(int startXPoint, int startyPoint, int x2Offset, int boundaryLineThickness,
                            boolean isVisible, boolean doesAffectPlayer, boolean doesAffectNonPlayers,
                            boolean isActive, int levelIndex) {
        super(startXPoint, startyPoint, x2Offset, boundaryLineThickness,
                isVisible, doesAffectPlayer, doesAffectNonPlayers,
                false, isActive, levelIndex);
    }

    /**
     * check and handle contact with player
     */
    private void checkHandleContactWithPlayer() {
        Player curPlayer =  getPlayerAtLevelIndex(this.levelIndex);

        if(this.doesAffectPlayer && curPlayer.isActive) { // TODO: encapsulate
            // boundary collision for player
            if(this.contactWithCharacter(curPlayer)) { // this has contact with player
                if(!curPlayer.warpBlockContacts.contains(curPlayer)) { // new collision detected    // TODO: encapsulate
                    curPlayer.warpBlockContacts.add(this);
                    curPlayer.numberOfFloorBoundaryContacts++; // TODO: encapsulate
                }

            } else {    // this DOES NOT have contact with player
                if(curPlayer.warpBlockContacts.contains(curPlayer)) {   // TODO: encapsulate
                    curPlayer.warpBlockContacts.remove(this);   // TODO: encapsulate
                    curPlayer.numberOfFloorBoundaryContacts--; // TODO: encapsulate
                }
            }
        }
    }

}