/**
 * top horizontal line boundaries of event blocks;
 * player can descend down this
 */
public class EventBlockTopBoundary extends HorizontalBoundary {

    /**
     * set properties of this;
     * sets this to affect all characters and be visible
     */
    EventBlockTopBoundary(int startXPoint, int startyPoint, int x2Offset, int boundaryLineThickness,
                            boolean isActive, int levelIndex) {
        super(startXPoint, startyPoint, x2Offset, boundaryLineThickness,
                true, isActive, levelIndex);
    }

    /**
     * set properties of this
     * sets this to affect all characters
     */
    EventBlockTopBoundary(int startXPoint, int startyPoint, int x2Offset, int boundaryLineThickness,
                            boolean isVisible,
                            boolean isActive, int levelIndex) {
        super(startXPoint, startyPoint, x2Offset, boundaryLineThickness,
                isVisible, true, isActive, levelIndex);
    }

    /**
     * set properties of this
     */
    EventBlockTopBoundary(int startXPoint, int startyPoint, int x2Offset, int boundaryLineThickness,
                            boolean isVisible, boolean doesAffectPlayer, boolean doesAffectNonPlayers,
                            boolean isActive, int levelIndex) {
        super(startXPoint, startyPoint, x2Offset, boundaryLineThickness,
                isVisible, doesAffectPlayer, doesAffectNonPlayers,
                true, isActive, levelIndex);
    }

    /**
     * check and handle contact with player
     */
    protected void checkHandleContactWithPlayer() {
        Player curPlayer = getPlayerAtLevelIndex(this.levelIndex);
        if(this.doesAffectPlayer && curPlayer.isActive) { // TODO: encapsulate
            // boundary collision for player
            if(this.contactWithCharacter(curPlayer)) { // this has contact with player
                if(!curPlayer.eventTopBoundaryContacts.contains(this)) { // new collision detected    // TODO: encapsulate
                    curPlayer.eventTopBoundaryContacts.add(this);
                    curPlayer.numberOfFloorBoundaryContacts++; // TODO: encapsulate
                    curPlayer.handleContactWithHorizontalBoundary(this.startPoint.y, true);
                }

            } else {    // this DOES NOT have contact with player
                if(curPlayer.eventTopBoundaryContacts.contains(this)) {   // TODO: encapsulate
                    curPlayer.eventTopBoundaryContacts.remove(this);   // TODO: encapsulate
                    curPlayer.numberOfFloorBoundaryContacts--; // TODO: encapsulate
                }
            }
        }
    }

}