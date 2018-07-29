/**
 * Level one
 */
public class LevelOne extends ALevel implements IDrawable {

    // true means big enemy trigger boundary has been activated
    private boolean bigEnemyTriggerActived;
    // size of this characters list to make big enemy trigger boundary active
    private int bigEnemyTriggerCharacterListSizeCondition;

    /**
     * sets properties, boundaries, and characters of this
     */
    LevelOne(boolean isActive, boolean loadPlayerFromCheckPoint) {
        super(isActive, loadPlayerFromCheckPoint);
    }

    /**
     * setup and activate this
     */
    void setUpActivateLevel() {
        this.bigEnemyTriggerActived = false;
        this.bigEnemyTriggerCharacterListSizeCondition = 0;
        this.checkpointXPos = 1200;

        this.makeActive();

        if(this.loadPlayerFromCheckPoint) {
            this.viewBox = new ViewBox(this.checkpointXPos - 200, 0, this.isActive);
            this.player = new Player(this.checkpointXPos, 0, Constants.PLAYER_DIAMETER, this.isActive);
        } else {
            this.viewBox = new ViewBox(0, 0, this.isActive);
            this.player = new Player(200, 0, Constants.PLAYER_DIAMETER, this.isActive);

            this.collectablesList.add(new Checkpoint(
                this.checkpointXPos,
                Constants.LEVEL_FLOOR_Y_POSITION - Constants.CHECKPOINT_BLOCK_HEIGHT,
                Constants.CHECKPOINT_BLOCK_WIDTH,
                Constants.CHECKPOINT_BLOCK_HEIGHT,
                Constants.DEFAULT_BOUNDARY_LINE_THICKNESS,
                this.isActive)
            );
        }

        loopSong(ESongType.Level);

        charactersList.add(new Enemy(
            getCurrentActiveLevelWidth() - 500,
            0,
            Constants.REGULAR_ENEMY_DIAMETER,
            -Constants.ENEMY_RUN_SPEED,
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
        //     Constants.LEVEL_FLOOR_Y_POSITION - Constants.DEFAULT_EVENT_BLOCK_HEIGHT,
        //     Constants.DEFAULT_EVENT_BLOCK_WIDTH,
        //     Constants.DEFAULT_EVENT_BLOCK_HEIGHT,
        //     Constants.DEFAULT_BOUNDARY_LINE_THICKNESS,
        //     true, 
        //     this.isActive
        // ));

        // int playerWarpEndXPos = 1000;
        // // int playerWarpEndXPos = getCurrentActiveLevelWidth() - Constants.PLAYER_DIAMETER - 1;  // test end of state
        // // int playerWarpEndXPos = Constants.PLAYER_DIAMETER / 2 + 1;   // test beginning of stage

        // this.blocksList.add(new EventBlock( // warp event
        //     getCurrentActiveLevelWidth() / 2 - 300,
        //     Constants.LEVEL_FLOOR_Y_POSITION - Constants.DEFAULT_EVENT_BLOCK_HEIGHT,
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
        if(!bigEnemyTriggerActived && this.charactersList.size() == this.bigEnemyTriggerCharacterListSizeCondition) {
            Set<Enemy> enemySet = new HashSet<Enemy>();
            Enemy triggerEnemy = new Enemy(
                1200,
                0,
                Constants.REGULAR_ENEMY_DIAMETER,
                -Constants.ENEMY_RUN_SPEED,
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
                Constants.LEVEL_FLOOR_Y_POSITION,
                Constants.DEFAULT_BOUNDARY_LINE_THICKNESS,
                true,
                this.isActive,
                enemySet
            ));

            this.bigEnemyTriggerActived = true;
        }
    }

}
