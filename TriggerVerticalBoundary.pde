/**
 * boundary to add enemies upon player contact
 */
public class TriggerVerticalBoundary extends VerticalBoundary {

    // set of enemies to be added
    private Set<Enemy> enemiesToAddSet;

    /**
     * set properties of this
     * sets this to affect all characters
     */
    TriggerVerticalBoundary(int startXPoint, int startYPoint, int y2Offset, int boundaryLineThickness,
                            boolean isVisible, boolean isActive, int levelIndex, Set<Enemy> enemySet) {
        super(startXPoint, startYPoint, y2Offset, boundaryLineThickness,
                isVisible, isActive, levelIndex);
        this.enemiesToAddSet = enemySet;
    }

    /**
     * runs continuously. checks and handles contact between this and characters
     */
    void draw() {
        this.show();
        this.checkHandleContactWithPlayer();
    }

    /**
     * check and handle contact with player
     */
    private void checkHandleContactWithPlayer() {
        Player curPlayer =  getPlayerAtLevelIndex(this.levelIndex);

        if(this.doesAffectPlayer && curPlayer.isActive) {   // TODO: encapsulate
            // boundary collision for player
            if(contactWithCharacter(curPlayer)) {  // this has contact with non-player
                for(Enemy curEnemy : enemiesToAddSet) {
                    curEnemy.makeActive();
                }
                this.makeNotActive();
            }
        }
    }

}