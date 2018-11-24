/**
 * top horizontal line boundaries of event blocks;
 * player can descend down this
 */
public class EventBlockTopBoundary extends HorizontalBoundary {
    /**
     * set properties of this;
     * sets this to affect all characters and be visible
     */
    public EventBlockTopBoundary(int startXPoint, int startYPoint, int x2Offset, int boundaryLineThickness,
                                 boolean isActive) {
        super(startXPoint, startYPoint, x2Offset, boundaryLineThickness, true, isActive);
    }

    /**
     * set properties of this
     * sets this to affect all characters
     */
    public EventBlockTopBoundary(int startXPoint, int startYPoint, int x2Offset, int boundaryLineThickness,
                                 boolean isVisible, boolean isActive) {
        super(startXPoint, startYPoint, x2Offset, boundaryLineThickness, isVisible, true, isActive);
    }

    /**
     * set properties of this
     */
    public EventBlockTopBoundary(int startXPoint, int startYPoint, int x2Offset, int boundaryLineThickness,
                                 boolean isVisible, boolean doesAffectPlayer, boolean doesAffectNonPlayers,
                                 boolean isActive) {
        super(startXPoint, startYPoint, x2Offset, boundaryLineThickness,
            isVisible, doesAffectPlayer, doesAffectNonPlayers,
            true, isActive);
    }

    /**
     * check and handle contact with player
     */
    @Override
    void checkHandleContactWithPlayer() {
        Player curPlayer = getCurrentActivePlayer();
        if (this.doesAffectPlayer && curPlayer.isActive()) {
            // boundary collision for player
            if (this.contactWithCharacter(curPlayer) && !this.isPreviousContactWithPlayer()) { // this has contact with player
                if (!curPlayer.getEventBlockTopBoundaryContacts().contains(this) && !this.charactersTouchingThis.contains(curPlayer)) { // new collision detected
                    curPlayer.getEventBlockTopBoundaryContacts().add(this);
                    this.charactersTouchingThis.add(curPlayer);
                    curPlayer.changeNumberOfFloorBoundaryContacts(1);
                }
                curPlayer.handleContactWithHorizontalBoundary(this.startPoint.y, true);

            } else {    // this DOES NOT have contact with player
                if (curPlayer.getEventBlockTopBoundaryContacts().contains(this) && this.charactersTouchingThis.contains(curPlayer)) {
                    if (curPlayer.isShouldSetPreviousFloorBoundaryContact()) {
                        curPlayer.setPreviousFloorBoundaryContact(this);
                    }
                    curPlayer.changeNumberOfFloorBoundaryContacts(-1);
                    curPlayer.getEventBlockTopBoundaryContacts().remove(this);
                    this.charactersTouchingThis.remove(curPlayer);
                }
            }
        }
    }
}