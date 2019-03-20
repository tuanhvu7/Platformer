/**
 * Level one
 */
public class LevelOne extends ALevel {

    // true means big enemy trigger boundary has been activated
    private boolean bigEnemyTriggerActivated;
    // size of this characters list to make big enemy trigger boundary active
    private int bigEnemyTriggerCharacterListSizeCondition;

    /**
     * sets properties, boundaries, and characters of this
     */
    public LevelOne(boolean isActive, boolean loadPlayerFromCheckPoint) {
        super(isActive, loadPlayerFromCheckPoint, Constants.BIG_ENEMY_DIAMETER + 200);
    }

    /**
     * setup and activate this
     */
    @Override
    public void setUpActivateLevel() {
        this.bigEnemyTriggerActivated = false;
        this.checkpointXPos = 3100;

        this.makeActive();
        loopSong(ESongType.LEVEL);

        if (this.loadPlayerFromCheckPoint) {
            this.viewBox = new ViewBox(this.checkpointXPos - 200, 0, true);
            this.player = new Player(this.checkpointXPos, 0, Constants.PLAYER_DIAMETER, true);
        } else {
            this.viewBox = new ViewBox(0, 0, true);
            this.player = new Player(200, 0, Constants.PLAYER_DIAMETER, true);

            this.levelDrawableCollection.addDrawable(new Checkpoint(
                this.checkpointXPos,
                Constants.LEVEL_FLOOR_Y_POSITION - Constants.CHECKPOINT_HEIGHT,
                Constants.CHECKPOINT_WIDTH,
                Constants.CHECKPOINT_HEIGHT,
                Constants.DEFAULT_BOUNDARY_LINE_THICKNESS,
                true)
            );
        }

        this.setupActivateBeforeCheckpoint();

        final int startMiddleSectionXPos = 3000;
        this.setupActivateMiddleSectionAfterCheckpoint(startMiddleSectionXPos);
        this.setupActivateEndSection(startMiddleSectionXPos + 2000);
        this.bigEnemyTriggerCharacterListSizeCondition
            = this.levelDrawableCollection.getCharactersList().size() - 2;
    }

    /**
     * handle conditional enemy triggers in this;
     * to override in extended classes
     */
    @Override
    public void handleConditionalEnemyTriggers() {
        if (!bigEnemyTriggerActivated
            && this.levelDrawableCollection.getCharactersList().size() == this.bigEnemyTriggerCharacterListSizeCondition) {

            Enemy triggerEnemy = new Enemy(
                3000,
                0,
                Constants.BIG_ENEMY_DIAMETER,
                -Constants.ENEMY_REGULAR_RUN_SPEED,
                false,
                true,
                false
            );

            this.levelDrawableCollection.addDrawable(triggerEnemy);

            this.levelDrawableCollection.addDrawable(new EnemyTriggerVerticalBoundary(
                2900,
                0,
                Constants.LEVEL_FLOOR_Y_POSITION,
                Constants.DEFAULT_BOUNDARY_LINE_THICKNESS,
                true,
                triggerEnemy
            ));

            this.bigEnemyTriggerActivated = true;
        }
    }

    /**
     * setup activate section before checkpoint
     */
    private void setupActivateBeforeCheckpoint() {
        // stage floor
        this.levelDrawableCollection.addDrawable(new HorizontalBoundary(
            0,
            Constants.LEVEL_FLOOR_Y_POSITION,
            2500,
            Constants.DEFAULT_BOUNDARY_LINE_THICKNESS,
            true,
            true
        ));

        this.levelDrawableCollection.addDrawable(new Enemy(
            500,
            0,
            Constants.BIG_ENEMY_DIAMETER,
            -Constants.ENEMY_REGULAR_RUN_SPEED,
            false,
            true,
            true)
        );

        this.levelDrawableCollection.addDrawable(new Block(
            750,
            height - 300 - Constants.DEFAULT_BLOCK_SIZE,
            Constants.DEFAULT_BLOCK_SIZE,
            Constants.DEFAULT_BLOCK_SIZE,
            Constants.DEFAULT_BOUNDARY_LINE_THICKNESS,
            true,
            true
        ));

        this.levelDrawableCollection.addDrawable(new Enemy(
            1750,
            0,
            Constants.REGULAR_ENEMY_DIAMETER,
            -Constants.ENEMY_SLOW_RUN_SPEED,
            false,
            true,
            true)
        );
        this.levelDrawableCollection.addDrawable(new Enemy(
            1750 + Constants.REGULAR_ENEMY_DIAMETER,
            0,
            Constants.REGULAR_ENEMY_DIAMETER,
            -Constants.ENEMY_SLOW_RUN_SPEED,
            false,
            true,
            true)
        );
        this.levelDrawableCollection.addDrawable(new Enemy(
            1750 + 2 * Constants.REGULAR_ENEMY_DIAMETER,
            0,
            Constants.REGULAR_ENEMY_DIAMETER,
            -Constants.ENEMY_SLOW_RUN_SPEED,
            false,
            true,
            true)
        );
        this.levelDrawableCollection.addDrawable(new Enemy(
            1750 + 3 * Constants.REGULAR_ENEMY_DIAMETER,
            0,
            Constants.REGULAR_ENEMY_DIAMETER,
            -Constants.ENEMY_SLOW_RUN_SPEED,
            false,
            true,
            true)
        );
        this.levelDrawableCollection.addDrawable(new Enemy(
            1750 + 4 * Constants.REGULAR_ENEMY_DIAMETER,
            0,
            Constants.REGULAR_ENEMY_DIAMETER,
            -Constants.ENEMY_SLOW_RUN_SPEED,
            false,
            true,
            true)
        );
        this.levelDrawableCollection.addDrawable(new Enemy(
            1750 + 5 * Constants.REGULAR_ENEMY_DIAMETER,
            0,
            Constants.REGULAR_ENEMY_DIAMETER,
            -Constants.ENEMY_SLOW_RUN_SPEED,
            false,
            true,
            true)
        );
        this.levelDrawableCollection.addDrawable(new Enemy(
            1750 + 6 * Constants.REGULAR_ENEMY_DIAMETER,
            0,
            Constants.REGULAR_ENEMY_DIAMETER,
            -Constants.ENEMY_SLOW_RUN_SPEED,
            false,
            true,
            true)
        );

        this.levelDrawableCollection.addDrawable(new EventBlock( // launch event
            2000,
            Constants.LEVEL_FLOOR_Y_POSITION - Constants.DEFAULT_EVENT_BLOCK_HEIGHT,
            Constants.DEFAULT_EVENT_BLOCK_WIDTH,
            Constants.DEFAULT_EVENT_BLOCK_HEIGHT,
            Constants.DEFAULT_BOUNDARY_LINE_THICKNESS,
            true,
            true
        ));

        int playerWarpEndXPos = 2800;
        this.levelDrawableCollection.addDrawable(new EventBlock( // warp event
            2000 + Constants.DEFAULT_EVENT_BLOCK_WIDTH + Constants.PLAYER_DIAMETER + 100,
            Constants.LEVEL_FLOOR_Y_POSITION - Constants.DEFAULT_EVENT_BLOCK_HEIGHT,
            Constants.DEFAULT_EVENT_BLOCK_WIDTH,
            Constants.DEFAULT_EVENT_BLOCK_HEIGHT,
            Constants.DEFAULT_BOUNDARY_LINE_THICKNESS,
            playerWarpEndXPos,
            750,
            true,
            true
        ));

        this.levelDrawableCollection.addDrawable(new Block(
            2550,
            Constants.LEVEL_FLOOR_Y_POSITION - 300 - Constants.DEFAULT_BLOCK_SIZE,
            Constants.DEFAULT_BLOCK_SIZE,
            Constants.DEFAULT_BLOCK_SIZE,
            Constants.DEFAULT_BOUNDARY_LINE_THICKNESS,
            false,
            false,
            true
        ));
    }

    /**
     * setup activate middle section after checkpoint
     */
    private void setupActivateMiddleSectionAfterCheckpoint(final int startXPos) {
        // stage floor
        this.levelDrawableCollection.addDrawable(new HorizontalBoundary(
            startXPos,
            Constants.LEVEL_FLOOR_Y_POSITION,
            2000,
            Constants.DEFAULT_BOUNDARY_LINE_THICKNESS,
            true,
            true
        ));

        this.levelDrawableCollection.addDrawable(new HorizontalBoundary(
            startXPos + 250,
            Constants.LEVEL_FLOOR_Y_POSITION - 4 * Constants.PLAYER_DIAMETER,
            4 * Constants.PLAYER_DIAMETER,
            Constants.DEFAULT_BOUNDARY_LINE_THICKNESS,
            true,
            true
        ));

        // controllable enemy
        Enemy enemyToAdd = new ControllableEnemy(
            startXPos + 1000 + 4 * Constants.PLAYER_DIAMETER,
            Constants.LEVEL_FLOOR_Y_POSITION - Constants.REGULAR_ENEMY_DIAMETER - 10,
            Constants.REGULAR_ENEMY_DIAMETER,
            -Constants.ENEMY_FAST_RUN_SPEED,
            false,
            true,
            false
        );
        this.levelDrawableCollection.addDrawable(enemyToAdd);
        this.levelDrawableCollection.addDrawable(new EnemyTriggerVerticalBoundary(
            startXPos + 500 + 4 * Constants.PLAYER_DIAMETER,
            0,
            Constants.LEVEL_FLOOR_Y_POSITION,
            Constants.DEFAULT_BOUNDARY_LINE_THICKNESS,
            true,
            enemyToAdd
        ));

        // flying enemies
        Set<Enemy> triggerEnemySet = new HashSet<Enemy>();
        enemyToAdd = new FlyingEnemy(
            startXPos + 1600 + 4 * Constants.PLAYER_DIAMETER,
            Constants.LEVEL_FLOOR_Y_POSITION - 4 * Constants.PLAYER_DIAMETER,
            Constants.REGULAR_ENEMY_DIAMETER,
            -Constants.ENEMY_FAST_RUN_SPEED,
            0,
            false,
            true,
            false);
        triggerEnemySet.add(enemyToAdd);
        this.levelDrawableCollection.addDrawable(enemyToAdd);
        enemyToAdd = new FlyingEnemy(
            startXPos + 1600 + 8 * Constants.PLAYER_DIAMETER,
            Constants.LEVEL_FLOOR_Y_POSITION - 6 * Constants.PLAYER_DIAMETER,
            Constants.REGULAR_ENEMY_DIAMETER,
            -Constants.ENEMY_FAST_RUN_SPEED,
            0,
            false,
            true,
            false);
        triggerEnemySet.add(enemyToAdd);
        this.levelDrawableCollection.addDrawable(enemyToAdd);
        enemyToAdd = new FlyingEnemy(
            startXPos + 1600 + 14 * Constants.PLAYER_DIAMETER,
            Constants.LEVEL_FLOOR_Y_POSITION - 5 * Constants.PLAYER_DIAMETER,
            Constants.BIG_ENEMY_DIAMETER,
            -Constants.ENEMY_FAST_RUN_SPEED,
            0,
            false,
            true,
            false);
        triggerEnemySet.add(enemyToAdd);
        this.levelDrawableCollection.addDrawable(enemyToAdd);

        this.levelDrawableCollection.addDrawable(new EnemyTriggerVerticalBoundary(
            startXPos + 1100 + 4 * Constants.PLAYER_DIAMETER,
            0,
            Constants.LEVEL_FLOOR_Y_POSITION,
            Constants.DEFAULT_BOUNDARY_LINE_THICKNESS,
            true,
            triggerEnemySet
        ));
    }

    /**
     * setup activate middle section after checkpoint
     */
    private void setupActivateEndSection(final int startXPos) {
        this.levelDrawableCollection.addDrawable(new HorizontalBoundary(
            startXPos,
            Constants.LEVEL_FLOOR_Y_POSITION,
            250,
            Constants.DEFAULT_BOUNDARY_LINE_THICKNESS,
            false,
            true,
            false,
            true,
            true
        ));
        this.levelDrawableCollection.addDrawable(new HorizontalBoundary(
            startXPos + 250,
            Constants.LEVEL_FLOOR_Y_POSITION,
            250,
            Constants.DEFAULT_BOUNDARY_LINE_THICKNESS,
            true,
            false,
            false,
            true,
            true
        ));

        final int endStageFloorPosition = startXPos + 500;
        // stage floor
        this.levelDrawableCollection.addDrawable(new HorizontalBoundary(
            endStageFloorPosition,
            Constants.LEVEL_FLOOR_Y_POSITION,
            getCurrentActiveLevelWidth() - startXPos,
            Constants.DEFAULT_BOUNDARY_LINE_THICKNESS,
            true,
            true
        ));

        // event block with invincible enemy
        final int eventBlockInvulnerableEnemyXReference = endStageFloorPosition + 300;
        this.levelDrawableCollection.addDrawable(new EventBlock( // launch event
            eventBlockInvulnerableEnemyXReference,
            Constants.LEVEL_FLOOR_Y_POSITION - Constants.DEFAULT_EVENT_BLOCK_HEIGHT,
            Constants.DEFAULT_EVENT_BLOCK_WIDTH,
            Constants.DEFAULT_EVENT_BLOCK_HEIGHT,
            Constants.DEFAULT_BOUNDARY_LINE_THICKNESS,
            true,
            true
        ));
        this.levelDrawableCollection.addDrawable(new Enemy(
            eventBlockInvulnerableEnemyXReference + (Constants.DEFAULT_EVENT_BLOCK_WIDTH / 2),
            Constants.LEVEL_FLOOR_Y_POSITION - Constants.DEFAULT_EVENT_BLOCK_HEIGHT - Constants.REGULAR_ENEMY_DIAMETER,
            Constants.DEFAULT_EVENT_BLOCK_WIDTH,
            0,
            true,
            false,
            true
        ));

        /*** START two event blocks trap ***/
        final int eventBlockGoingToTrapXReference = endStageFloorPosition + 750;
        final int eventBlockTrapXReference = endStageFloorPosition + 2000;
        this.levelDrawableCollection.addDrawable(new EventBlock( // warp event
            eventBlockGoingToTrapXReference,
            Constants.LEVEL_FLOOR_Y_POSITION - Constants.DEFAULT_EVENT_BLOCK_HEIGHT,
            Constants.DEFAULT_EVENT_BLOCK_WIDTH,
            Constants.DEFAULT_EVENT_BLOCK_HEIGHT,
            Constants.DEFAULT_BOUNDARY_LINE_THICKNESS,
            eventBlockTrapXReference + (Constants.DEFAULT_EVENT_BLOCK_WIDTH / 2),
            Constants.LEVEL_FLOOR_Y_POSITION - Constants.DEFAULT_EVENT_BLOCK_HEIGHT + Constants.REGULAR_ENEMY_DIAMETER,
            true,
            true
        ));

        this.levelDrawableCollection.addDrawable(new Block(  // block left of event block trap
            eventBlockTrapXReference - Constants.DEFAULT_BLOCK_SIZE,
            Constants.LEVEL_FLOOR_Y_POSITION - Constants.DEFAULT_EVENT_BLOCK_HEIGHT - (4 * Constants.PLAYER_DIAMETER),
            Constants.DEFAULT_BLOCK_SIZE,
            Constants.DEFAULT_EVENT_BLOCK_HEIGHT + (4 * Constants.PLAYER_DIAMETER),
            Constants.DEFAULT_BOUNDARY_LINE_THICKNESS,
            false,
            true
        ));
        this.levelDrawableCollection.addDrawable(new Block(  // block above event block trap
            eventBlockTrapXReference,
            Constants.LEVEL_FLOOR_Y_POSITION - Constants.DEFAULT_EVENT_BLOCK_HEIGHT - (4 * Constants.PLAYER_DIAMETER),
            Constants.DEFAULT_EVENT_BLOCK_WIDTH,
            Constants.DEFAULT_BLOCK_SIZE,
            Constants.DEFAULT_BOUNDARY_LINE_THICKNESS,
            false,
            true
        ));
        this.levelDrawableCollection.addDrawable(new EventBlock( // warp event
            eventBlockTrapXReference,
            Constants.LEVEL_FLOOR_Y_POSITION - Constants.DEFAULT_EVENT_BLOCK_HEIGHT,
            Constants.DEFAULT_EVENT_BLOCK_WIDTH,
            Constants.DEFAULT_EVENT_BLOCK_HEIGHT,
            Constants.DEFAULT_BOUNDARY_LINE_THICKNESS,
            eventBlockInvulnerableEnemyXReference + (Constants.DEFAULT_EVENT_BLOCK_WIDTH / 2),
            Constants.LEVEL_FLOOR_Y_POSITION - Constants.DEFAULT_EVENT_BLOCK_HEIGHT + Constants.REGULAR_ENEMY_DIAMETER,
            true,
            true
        ));
        this.levelDrawableCollection.addDrawable(new Block(  // block right of event block trap
            eventBlockTrapXReference + Constants.DEFAULT_EVENT_BLOCK_WIDTH,
            Constants.LEVEL_FLOOR_Y_POSITION - Constants.DEFAULT_EVENT_BLOCK_HEIGHT - (4 * Constants.PLAYER_DIAMETER),
            Constants.DEFAULT_BLOCK_SIZE,
            Constants.DEFAULT_EVENT_BLOCK_HEIGHT + (4 * Constants.PLAYER_DIAMETER),
            Constants.DEFAULT_BOUNDARY_LINE_THICKNESS,
            false,
            true
        ));
        /*** END two event blocks trap ***/


        /*** START two event blocks NOT trap ***/
        final int doubleEventBlockXReference = endStageFloorPosition + 1000;
        // for warp x position to line up with another event block's x position
        final int eventBlockSurroundedByBlocksXPos
            = doubleEventBlockXReference + (2 * Constants.DEFAULT_EVENT_BLOCK_WIDTH);
        this.levelDrawableCollection.addDrawable(new EventBlock( // warp event
            doubleEventBlockXReference,
            Constants.LEVEL_FLOOR_Y_POSITION - Constants.DEFAULT_EVENT_BLOCK_HEIGHT,
            Constants.DEFAULT_EVENT_BLOCK_WIDTH,
            Constants.DEFAULT_EVENT_BLOCK_HEIGHT,
            Constants.DEFAULT_BOUNDARY_LINE_THICKNESS,
            eventBlockSurroundedByBlocksXPos + (Constants.DEFAULT_EVENT_BLOCK_WIDTH / 2),
            Constants.LEVEL_FLOOR_Y_POSITION - Constants.DEFAULT_EVENT_BLOCK_HEIGHT + Constants.REGULAR_ENEMY_DIAMETER,
            true,
            true
        ));

        // invincible enemy at end of level
        Enemy triggerEnemy = new Enemy(
            getCurrentActiveLevelWidth() - (Constants.BIG_ENEMY_DIAMETER / 2),
            Constants.LEVEL_FLOOR_Y_POSITION - (Constants.BIG_ENEMY_DIAMETER / 2),
            Constants.BIG_ENEMY_DIAMETER,
            0,
            true,
            true,
            false
        );
        this.levelDrawableCollection.addDrawable(triggerEnemy);
        this.levelDrawableCollection.addDrawable(new EnemyTriggerVerticalBoundary(
            doubleEventBlockXReference + (int) (1.5 * Constants.DEFAULT_EVENT_BLOCK_WIDTH),
            0,
            Constants.LEVEL_FLOOR_Y_POSITION,
            Constants.DEFAULT_BOUNDARY_LINE_THICKNESS,
            true,
            triggerEnemy
        ));
        // warp to event block with invincible enemy
        this.levelDrawableCollection.addDrawable(new EventBlock( // warp event
            eventBlockSurroundedByBlocksXPos,
            Constants.LEVEL_FLOOR_Y_POSITION - Constants.DEFAULT_EVENT_BLOCK_HEIGHT,
            Constants.DEFAULT_EVENT_BLOCK_WIDTH,
            Constants.DEFAULT_EVENT_BLOCK_HEIGHT,
            Constants.DEFAULT_BOUNDARY_LINE_THICKNESS,
            eventBlockInvulnerableEnemyXReference + (Constants.DEFAULT_EVENT_BLOCK_WIDTH / 2),
            Constants.LEVEL_FLOOR_Y_POSITION - Constants.DEFAULT_EVENT_BLOCK_HEIGHT + Constants.REGULAR_ENEMY_DIAMETER,
            true,
            true
        ));
        /*** END two event blocks NOT trap ***/
    }

}