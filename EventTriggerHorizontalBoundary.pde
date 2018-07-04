/**
 * horizontal line boundaries that trigger events
 */
public class EventTriggerHorizontalBoundary extends HorizontalBoundary {

    // if not null, end location of warp event; else, launch event
    private PVector endWarpPosition;

    /**
     * set properties of this; 
     * sets this to have launch event and affect all characters and be invisible
     */
    EventTriggerHorizontalBoundary(int startXPoint, int startyPoint, int x2Offset, int boundaryLineThickness,
                                    boolean isFloorBoundary, boolean isActive, int levelIndex) {
        super(startXPoint, startyPoint, x2Offset, boundaryLineThickness,
                false, isFloorBoundary, isActive, levelIndex);

        this.endWarpPosition = null;
        this.isFloorBoundary = isFloorBoundary;
    }

    /**
     * set properties of this;
     * sets this to have warp event and affect all characters and be invisible
     */
    EventTriggerHorizontalBoundary(int startXPoint, int startyPoint, int x2Offset, int boundaryLineThickness,
                                    int endWarpXPositon, int endWarpYPositon,
                                    boolean isFloorBoundary, boolean isActive, int levelIndex) {
        super(startXPoint, startyPoint, x2Offset, boundaryLineThickness,
                false, isFloorBoundary, isActive, levelIndex);

        this.endWarpPosition = new PVector(endWarpXPositon, endWarpYPositon);
        this.isFloorBoundary = isFloorBoundary;
    }

    /**
     * check and handle contact with player
     */
    private void checkHandleContactWithPlayer() {
        Player curPlayer = getPlayerAtLevelIndex(this.levelIndex);

        if(this.doesAffectPlayer && curPlayer.isActive) { // TODO: encapsulate
            // boundary collision for player
            if(this.contactWithCharacter(curPlayer)) { // this has contact with player
                curPlayer.handleConactWithEventBoundary(endWarpPosition);
            }
        }
    }

    /**
     *  check and handle contact with non-player characters
     */
    private void checkHandleContactWithNonPlayerCharacters() {
        if(this.doesAffectNonPlayers) {
            // boundary collision for non-player characters
            for(ACharacter curCharacter: getCharactersListAtLevelIndex(this.levelIndex)) { // this has contact with non-player
                if(curCharacter.isActive) { // TODO: encapsulate
                    if(this.contactWithCharacter(curCharacter)) {


                    }
                }
            }
        }
    }

}