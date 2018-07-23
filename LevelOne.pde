/**
 * Level one
 */
public class LevelOne extends ALevel implements IDrawable {

    // true means big enemy trigger boundary has been activated
    private boolean bigEnemyTriggerActived;

    /**
     * sets properties, boundaries, and characters of this
     */
    LevelOne(boolean isActive) {
        super(isActive, 1);
        this.bigEnemyTriggerActived = false;
    }

    /**
     * setup and activate this
     */
    void setUpActivateLevel() {
        this.makeActive();

        this.viewBox = new ViewBox(0, 0, this.isActive);
        this.player = new Player(200, 0, Constants.PLAYER_DIAMETER, this.isActive);

        loopSong(true);

        charactersList.add(new Enemy(
            getCurrentActiveLevelWidth() - 500,
            0,
            Constants.REGULAR_ENEMY_DIAMETER,
            false,
            false,
            true,
            this.isActive)
        );

        this.boundariesList.add(new HorizontalBoundary(
            0,
            height - 200,
            100,
            Constants.DEFAULT_BOUNDARY_LINE_THICKNESS,
            true,
            this.isActive
        ));

        this.boundariesList.add(new HorizontalBoundary(
            100,
            height - 400,
            100,
            Constants.DEFAULT_BOUNDARY_LINE_THICKNESS,
            true,
            this.isActive
        ));

        this.boundariesList.add(new HorizontalBoundary(
            200,
            height - 600,
            100,
            Constants.DEFAULT_BOUNDARY_LINE_THICKNESS,
            false,
            this.isActive
        ));

        this.boundariesList.add(new HorizontalBoundary(
            100,
            height - 800,
            100,
            Constants.DEFAULT_BOUNDARY_LINE_THICKNESS,
            true,
            this.isActive
        ));

        /*** START Blocks ***/

        // this.blocksList.add(new EventBlock( // launch event
        //     getCurrentActiveLevelWidth() / 2 - 300,
        //     this.floorYPosition - Constants.DEFAULT_EVENT_BLOCK_HEIGHT,
        //     Constants.DEFAULT_EVENT_BLOCK_WIDTH,
        //     Constants.DEFAULT_EVENT_BLOCK_HEIGHT,
        //     Constants.DEFAULT_BOUNDARY_LINE_THICKNESS,
        //     true, 
        //     this.isActive
        // ));

        // int playerWarpEndXPos = 1000;
        // // int playerWarpEndXPos = getCurrentActiveLevelWidth() - Constants.PLAYER_DIAMETER - 1;  // test end of state
        // // int playerWarpEndXPos = Constants.PLAYER_DIAMETER / 2 + 1;   // test beginning of stage

        // this.blocksList.add(new EventBlock( // launch event
        //     getCurrentActiveLevelWidth() / 2 - 300,
        //     this.floorYPosition - Constants.DEFAULT_EVENT_BLOCK_HEIGHT,
        //     Constants.DEFAULT_EVENT_BLOCK_WIDTH,
        //     Constants.DEFAULT_EVENT_BLOCK_HEIGHT,
        //     Constants.DEFAULT_BOUNDARY_LINE_THICKNESS,       
        //     playerWarpEndXPos,
        //     750,
        //     true, 
        //     this.isActive
        // ));

        // this.blocksList.add(new Block(
        //     getCurrentActiveLevelWidth() / 2 - 300,
        //     height - 300,
        //     Constants.DEFAULT_BLOCK_SIZE,
        //     Constants.DEFAULT_BLOCK_SIZE,
        //     Constants.DEFAULT_BOUNDARY_LINE_THICKNESS,
        //     false,
        //     this.isActive
        // ));

        // this.blocksList.add(new Block(
        //     getCurrentActiveLevelWidth() / 2 - 300 + Constants.DEFAULT_BLOCK_SIZE,
        //     height - 300 - Constants.DEFAULT_BLOCK_SIZE,
        //     Constants.DEFAULT_BLOCK_SIZE,
        //     Constants.DEFAULT_BLOCK_SIZE,
        //     Constants.DEFAULT_BOUNDARY_LINE_THICKNESS,
        //     true,
        //     this.isActive
        // ));

        /*** END Blocks ***/
    }

    /**
     * handle conditional enemy triggers in this;
     * to override in extended classes
     */
    void handleConditionalEnemyTriggers() {
        if(!bigEnemyTriggerActived && this.charactersList.size() < 1) {
            Set<Enemy> enemySet = new HashSet<Enemy>();
            Enemy triggerEnemy = new Enemy(
                1200,
                0,
                Constants.REGULAR_ENEMY_DIAMETER,
                false,
                false,
                true,
                false
            );

            enemySet.add(triggerEnemy);
            charactersList.add(triggerEnemy);

            this.boundariesList.add(new EnemyTriggerVerticalBoundary(
                1000,
                0,
                this.floorYPosition,
                Constants.DEFAULT_BOUNDARY_LINE_THICKNESS,
                true,
                this.isActive,
                enemySet
            ));

            this.bigEnemyTriggerActived = true;
        }
    }

}
