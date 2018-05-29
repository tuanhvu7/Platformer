/**
 * horizontal line boundaries; floors or ceilings
 */
public class HorizontalBoundary extends ABoundary implements IBoundary, IDrawable {

    // true means character cannot go through top side of boundary
    // false means character cannot go through bottom side of boundary
    private boolean isTopSideBoundary;

    /**
     * Set boundary properties;
     * sets boundary to be active for all characters and visible
     */
    HorizontalBoundary(int startXPoint, int startyPoint, int x2Offset, int boundaryWidth, boolean isTopSideBoundary) {
        super(startXPoint, startyPoint, x2Offset, 0, boundaryWidth,
                true, true, true);
        
        this.isTopSideBoundary = isTopSideBoundary;
    }

    /**
     * Set boundary properties
     */
    HorizontalBoundary(int startXPoint, int startyPoint, int x2Offset, int boundaryWidth, 
                        boolean isVisible, boolean isActiveToPlayer, boolean isActiveToNonPlayers, 
                        boolean isTopSideBoundary) {
        super(startXPoint, startyPoint, x2Offset, 0, boundaryWidth,
                isVisible, isActiveToPlayer, isActiveToNonPlayers);
        
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

        if(this.isActiveToPlayer) {
            // boundary collision for player
            if(contactWithCharacter(global_player)) {
                if(isTopSideBoundary && !this.charactersTouchingThis.contains(global_player)) { // new collision detected
                    global_player.numberOfHorizontalBoundaryContacts++; // TODO: encapsulate
                    this.charactersTouchingThis.add(global_player);
                }
                global_player.handleContactWithHorizontalBoundary(this.startPoint.y, this.isTopSideBoundary);

            } else {
                if(isTopSideBoundary && this.charactersTouchingThis.contains(global_player)) {
                    global_player.numberOfHorizontalBoundaryContacts--; // TODO: encapsulate
                    this.charactersTouchingThis.remove(global_player);
                }
            }
        }

        if(this.isActiveToNonPlayers) {
            // boundary collision for non-player characters
            for(ACharacter curCharacter : global_characters_list) {
                if(this.contactWithCharacter(curCharacter)) {
                    if(this.isTopSideBoundary && !this.charactersTouchingThis.contains(curCharacter)) { // new collision detected
                        curCharacter.numberOfHorizontalBoundaryContacts++;  // TODO: encapsulate
                        this.charactersTouchingThis.add(curCharacter);
                    }
                    curCharacter.handleContactWithHorizontalBoundary(this.startPoint.y, this.isTopSideBoundary);

                } else {
                    if(this.isTopSideBoundary && this.charactersTouchingThis.contains(curCharacter)) {
                        curCharacter.numberOfHorizontalBoundaryContacts--;  // TODO: encapsulate
                        this.charactersTouchingThis.remove(curCharacter);
                    }
                }
            }
        }

    }
}
