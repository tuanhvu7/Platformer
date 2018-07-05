/**
 * horizontal line boundaries; floors or ceilings
 */
public class HorizontalBoundary extends ABoundary implements IBoundary, IDrawable {

    // true means character cannot go through top side of boundary
    // false means character cannot go through bottom side of boundary
    protected boolean isFloorBoundary;

    /**
     * set properties of this;
     * sets this to affect all characters and be visible
     */
    HorizontalBoundary(int startXPoint, int startyPoint, int x2Offset, int boundaryLineThickness,
                        boolean isFloorBoundary, boolean isActive, int levelIndex) {
        super(startXPoint, startyPoint, x2Offset, 0, boundaryLineThickness,
            true, true, true, isActive, levelIndex);

        this.isFloorBoundary = isFloorBoundary;
    }

    /**
     * set properties of this
     * sets this to affect all characters
     */
    HorizontalBoundary(int startXPoint, int startyPoint, int x2Offset, int boundaryLineThickness,
                        boolean isVisible, boolean isFloorBoundary,
                        boolean isActive, int levelIndex) {
        super(startXPoint, startyPoint, x2Offset, 0, boundaryLineThickness,
            isVisible, true, true, isActive, levelIndex);

        this.isFloorBoundary = isFloorBoundary;
    }

    /**
     * set properties of this
     */
    HorizontalBoundary(int startXPoint, int startyPoint, int x2Offset, int boundaryLineThickness,
                        boolean isVisible, boolean doesAffectPlayer, boolean doesAffectNonPlayers,
                        boolean isFloorBoundary, boolean isActive, int levelIndex) {
        super(startXPoint, startyPoint, x2Offset, 0, boundaryLineThickness,
            isVisible, doesAffectPlayer, doesAffectNonPlayers, isActive, levelIndex);

        this.isFloorBoundary = isFloorBoundary;
    }

    /**
     * return true if valid collision with given character
     */
    boolean contactWithCharacter(ACharacter character) {

        // if(this.isFloorBoundary && character.vel.y > 0) {
        //     return 
        //         character.pos.x > this.startPoint.x - (character.diameter / 2)      // > lower x boundary
        //         && character.pos.x < this.endPoint.x + (character.diameter / 2)     // < upper x boundary
        //         && character.pos.y < this.startPoint.y                              // center of character above boundary
        //         && character.pos.y + (character.diameter / 2) >= this.startPoint.y; // bottom of character 'touching' boundary

        // } else if(!this.isFloorBoundary && character.vel.y < 0) {
        //     return 
        //         character.pos.x > this.startPoint.x - (character.diameter / 2)      // > lower x boundary
        //         && character.pos.x < this.endPoint.x + (character.diameter / 2)     // < upper x boundary
        //         && character.pos.y > this.startPoint.y                              // center of character below boundary
        //         && character.pos.y - (character.diameter / 2) <= this.startPoint.y; // top of character 'touching' boundary
        // } else {
        //     return false;
        // }

        // TODO: encapsulate
        boolean validBoundaryContactVelocity = 
            this.isFloorBoundary && character.vel.y > 0 || !this.isFloorBoundary && character.vel.y < 0;

        if(validBoundaryContactVelocity) {
            return
                character.pos.x > this.startPoint.x - (character.diameter / 2)      // > lower x boundary
                && character.pos.x < this.endPoint.x + (character.diameter / 2)     // < upper x boundary
                && character.pos.y - (character.diameter / 2) <= this.startPoint.y  // top of character contact or in vincinity
                && character.pos.y + (character.diameter / 2) >= this.startPoint.y; // bottom of character contact or in vincinity
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
     * return this.isFloorBoundary
     */
    public boolean getIsFloorBoundary() {
        return this.isFloorBoundary;
    }

    /**
     * check and handle contact with player
     */
    protected void checkHandleContactWithPlayer() {
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
                curPlayer.handleContactWithHorizontalBoundary(this.startPoint.y, this.isFloorBoundary);

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

    /**
     *  check and handle contact with non-player characters
     */
    private void checkHandleContactWithNonPlayerCharacters() {
        if(this.doesAffectNonPlayers) {
            // boundary collision for non-player characters
            for(ACharacter curCharacter: getCharactersListAtLevelIndex(this.levelIndex)) { // this has contact with non-player
                if(curCharacter.isActive) { // TODO: encapsulate
                    if(this.contactWithCharacter(curCharacter)) {
                        if(this.isFloorBoundary && !this.charactersTouchingThis.contains(curCharacter)) { // new collision detected
                            curCharacter.numberOfFloorBoundaryContacts++; // TODO: encapsulate
                            this.charactersTouchingThis.add(curCharacter);
                        }
                        curCharacter.handleContactWithHorizontalBoundary(this.startPoint.y, this.isFloorBoundary);

                    } else {    // this DOES NOT have contact with non-player
                        if(this.isFloorBoundary && this.charactersTouchingThis.contains(curCharacter)) { // curCharacter no longer colliding with this
                            curCharacter.numberOfFloorBoundaryContacts--; // TODO: encapsulate
                            this.charactersTouchingThis.remove(curCharacter);
                        }
                    }
                }
            }
        }
    }
    
}