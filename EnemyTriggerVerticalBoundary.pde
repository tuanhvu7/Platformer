/**
 * boundary to add enemies upon player contact
 */
public class EnemyTriggerVerticalBoundary extends VerticalBoundary {
    // set of enemies to be added
    private final Set<Enemy> enemiesToAddSet;

    /**
     * set properties of this;
     * only one enemy to trigger
     */
    public EnemyTriggerVerticalBoundary(int startXPoint, int startYPoint, int y2Offset, int boundaryLineThickness,
                                        boolean initAsActive, Enemy enemy) {
        super(startXPoint, startYPoint, y2Offset, boundaryLineThickness,
            false, initAsActive);
        Set<Enemy> set = Collections.newSetFromMap(new ConcurrentHashMap<Enemy, Boolean>());
        set.add(enemy);
        this.enemiesToAddSet = set;
    }

    /**
     * set properties of this;
     * set of enemies to trigger
     */
    public EnemyTriggerVerticalBoundary(int startXPoint, int startYPoint, int y2Offset, int boundaryLineThickness,
                                        boolean initAsActive, Set<Enemy> enemySet) {
        super(startXPoint, startYPoint, y2Offset, boundaryLineThickness,
            false, initAsActive);
        this.enemiesToAddSet = enemySet;
    }

    /**
     * runs continuously. checks and handles contact between this and characters
     */
    @Override
    public void draw() {
        this.show();
        if (getCurrentActivePlayer() != null) {
            this.checkHandleContactWithPlayer();
        }
    }

    /**
     * check and handle contact with player
     */
    @Override
    void checkHandleContactWithPlayer() {
        Player curPlayer = getCurrentActivePlayer();

        if (this.doesAffectPlayer) {
            // boundary collision for player
            if (contactWithCharacter(curPlayer)) {  // this has contact with non-player
                for (Enemy curEnemy : enemiesToAddSet) {
                    curEnemy.makeActive();
                }
                this.makeNotActive();
            }
        }
    }
}
