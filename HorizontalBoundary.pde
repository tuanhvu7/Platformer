/**
 * horizontal line boundaries; floors or ceilings
 */
public class HorizontalBoundary extends ABoundary implements IBoundary, IDrawable {

    // true means character cannot go through top side of boundary
    // false means character cannot go through bottom side of boundary
    private boolean isTopSideBoundary;

    /**
     * set properties of this;
     * sets this to affect all characters and be visible
     */
    HorizontalBoundary(int startXPoint, int startyPoint, int x2Offset, int boundaryLineThickness,
                        boolean isTopSideBoundary, boolean isActive, int levelIndex) {
        super(startXPoint, startyPoint, x2Offset, 0, boundaryLineThickness,
            true, true, true, isActive, levelIndex);

        this.isTopSideBoundary = isTopSideBoundary;
    }

    /**
     * set properties of this
     * sets this to affect all characters
     */
    HorizontalBoundary(int startXPoint, int startyPoint, int x2Offset, int boundaryLineThickness,
                        boolean isVisible, boolean isTopSideBoundary,
                        boolean isActive, int levelIndex) {
        super(startXPoint, startyPoint, x2Offset, 0, boundaryLineThickness,
            isVisible, true, true, isActive, levelIndex);

        this.isTopSideBoundary = isTopSideBoundary;
    }

    /**
     * set properties of this
     */
    HorizontalBoundary(int startXPoint, int startyPoint, int x2Offset, int boundaryLineThickness,
                        boolean isVisible, boolean doesAffectPlayer, boolean doesAffectNonPlayers,
                        boolean isTopSideBoundary, boolean isActive, int levelIndex) {
        super(startXPoint, startyPoint, x2Offset, 0, boundaryLineThickness,
            isVisible, doesAffectPlayer, doesAffectNonPlayers, isActive, levelIndex);

        this.isTopSideBoundary = isTopSideBoundary;
    }

    /**
     * return true if collide with given character
     */
    boolean contactWithCharacter(ACharacter character) {

        // if(this.isTopSideBoundary) {
        //     return 
        //         character.pos.x > this.startPoint.x - (character.diameter / 2)      // > lower x boundary
        //         && character.pos.x < this.endPoint.x + (character.diameter / 2)     // < upper x boundary
        //         && character.pos.y < this.startPoint.y                              // center of character above boundary
        //         && character.pos.y + (character.diameter / 2) >= this.startPoint.y; // bottom of character 'touching' boundary

        // } else {    // bottom-side boundary
        //     return 
        //         character.pos.x > this.startPoint.x - (character.diameter / 2)      // > lower x boundary
        //         && character.pos.x < this.endPoint.x + (character.diameter / 2)     // < upper x boundary
        //         && character.pos.y > this.startPoint.y                              // center of character below boundary
        //         && character.pos.y - (character.diameter / 2) <= this.startPoint.y; // top of character 'touching' boundary
        // }

        return
            character.pos.x > this.startPoint.x - (character.diameter / 2)      // > lower x boundary
            && character.pos.x < this.endPoint.x + (character.diameter / 2)     // < upper x boundary
            && character.pos.y - (character.diameter / 2) <= this.startPoint.y  // top of character contact or in vincinity
            && character.pos.y + (character.diameter / 2) >= this.startPoint.y; // bottom of character contact or in vincinity
    }

    /**
     * runs continuously. checks and handles contact between this and characters
     */
    void draw() {
        this.show();

        if(this.doesAffectPlayer && getPlayerAtLevelIndex(this.levelIndex).isActive) { // TODO: encapsulate
            // boundary collision for player
            if(contactWithCharacter(getPlayerAtLevelIndex(this.levelIndex))) {  // TODO: encapsulate
                if(isTopSideBoundary && !this.charactersTouchingThis.contains(getPlayerAtLevelIndex(this.levelIndex))) { // new collision detected
                    getPlayerAtLevelIndex(this.levelIndex).numberOfTopHorizontalBoundaryContacts++; // TODO: encapsulate
                    this.charactersTouchingThis.add(getPlayerAtLevelIndex(this.levelIndex));
                }
                getPlayerAtLevelIndex(this.levelIndex).handleContactWithHorizontalBoundary(this.startPoint.y, this.isTopSideBoundary);

            } else {
                if(isTopSideBoundary && this.charactersTouchingThis.contains(getPlayerAtLevelIndex(this.levelIndex))) {
                    getPlayerAtLevelIndex(this.levelIndex).numberOfTopHorizontalBoundaryContacts--; // TODO: encapsulate
                    this.charactersTouchingThis.remove(getPlayerAtLevelIndex(this.levelIndex));
                }
            }
        }

        if(this.doesAffectNonPlayers) {
            // boundary collision for non-player characters
            for(ACharacter curCharacter: getCharactersListAtLevelIndex(this.levelIndex)) { // TODO: encapsulate
                if(curCharacter.isActive) { // TODO: encapsulate
                    if(this.contactWithCharacter(curCharacter)) {
                        if(this.isTopSideBoundary && !this.charactersTouchingThis.contains(curCharacter)) { // new collision detected
                            curCharacter.numberOfTopHorizontalBoundaryContacts++; // TODO: encapsulate
                            this.charactersTouchingThis.add(curCharacter);
                        }
                        curCharacter.handleContactWithHorizontalBoundary(this.startPoint.y, this.isTopSideBoundary);

                    } else {
                        if(this.isTopSideBoundary && this.charactersTouchingThis.contains(curCharacter)) { // curCharacter no longer colliding with this
                            curCharacter.numberOfTopHorizontalBoundaryContacts--; // TODO: encapsulate
                            this.charactersTouchingThis.remove(curCharacter);
                        }
                    }
                }
            }
        }

    }
}