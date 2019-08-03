public class LevelThree extends ALevel {

    /**
     * sets properties, boundaries, and characters of this
     */
    public LevelThree(boolean isActive, boolean loadPlayerFromCheckPoint) {
        super(isActive, loadPlayerFromCheckPoint, 200);
    }

    @Override
    void setUpActivateLevel() {
        final int playerStartXPos = Constants.SCREEN_WIDTH / 6;
        final int playerStartYPos = Constants.SCREEN_HEIGHT / 4;
        this.checkpointXPos = 15 * playerStartXPos + 5 * Constants.CHECKPOINT_WIDTH;

        this.makeActive();
        resourceUtils.loopSong(ESongType.LEVEL);

        if (this.isLoadPlayerFromCheckPoint()) {
            this.viewBox = new ViewBox(
                this.checkpointXPos - 200,
                playerStartYPos,
                true);
            this.player = new Player(
                this.checkpointXPos,
                playerStartYPos,
                Constants.PLAYER_DIAMETER,
                true);
        } else {
            this.viewBox = new ViewBox(
                0,
                playerStartYPos,
                true);
            this.player = new Player(
                playerStartXPos,
                playerStartYPos,
                Constants.PLAYER_DIAMETER,
                true);

            this.levelDrawableCollection.addDrawable(new Checkpoint(
                this.checkpointXPos,
                Constants.LEVEL_FLOOR_Y_POSITION - Constants.CHECKPOINT_HEIGHT,
                Constants.CHECKPOINT_WIDTH,
                Constants.CHECKPOINT_HEIGHT,
                Constants.DEFAULT_BOUNDARY_LINE_THICKNESS,
                true)
            );
        }

        int levelFloorXPosReference = this.setupActivateBeginningBeforeCheckpoint(playerStartXPos, playerStartYPos);
        levelFloorXPosReference = this.setupActivateEndBeforeCheckpoint(levelFloorXPosReference + 332);

        levelFloorXPosReference = this.setupActivateBeginningAfterCheckpoint(levelFloorXPosReference + 300);
        this.setupActivateEndAfterCheckpoint(levelFloorXPosReference);
    }

    /**
     * @return x-pos of left-most drawable in section
     */
    private int setupActivateBeginningBeforeCheckpoint(final int beginningGoalXPos, final int beginningGoalYPos) {
        // extend left wall to bottom of level
        this.levelDrawableCollection.addDrawable(new VerticalBoundary(
            0,
            Constants.LEVEL_FLOOR_Y_POSITION,
            getCurrentActiveLevelHeight() - Constants.LEVEL_FLOOR_Y_POSITION,
            Constants.DEFAULT_BOUNDARY_LINE_THICKNESS,
            true
        ));


        this.levelDrawableCollection.addDrawable(new LevelGoal(
            beginningGoalXPos,
            beginningGoalYPos + 2 * Constants.PLAYER_DIAMETER,
            Constants.CHECKPOINT_WIDTH,
            Constants.SCREEN_HEIGHT,
            Constants.DEFAULT_BOUNDARY_LINE_THICKNESS,
            true
        ));

        this.levelDrawableCollection.addDrawable(new VerticalBoundary(
            2 * beginningGoalXPos,
            beginningGoalYPos,
            getCurrentActiveLevelHeight() - (beginningGoalYPos / 2),
            Constants.DEFAULT_BOUNDARY_LINE_THICKNESS,
            true
        ));

        this.levelDrawableCollection.addDrawable(new FlyingEnemy(
            2 * beginningGoalXPos,
            Constants.SMALL_ENEMY_DIAMETER,
            Constants.SMALL_ENEMY_DIAMETER,
            0,
            Constants.ENEMY_FAST_MOVEMENT_SPEED,
            false,
            false,
            true,
            true,
            true
        ));

        this.levelDrawableCollection.addDrawable(new VerticalBoundary(
            4 * beginningGoalXPos,
            getCurrentActiveLevelHeight() / 2,
            Constants.DEFAULT_BLOCK_SIZE,
            Constants.DEFAULT_BOUNDARY_LINE_THICKNESS,
            true
        ));
        HealthItem healthItemForBlock =
            new HealthItem(
                1,
                0,
                0,
                Constants.HEALTH_ITEM_SIZE,
                Constants.HEALTH_ITEM_SIZE,
                Constants.DEFAULT_BOUNDARY_LINE_THICKNESS,
                false
            );
        this.levelDrawableCollection.addDrawable((healthItemForBlock));
        this.levelDrawableCollection.addDrawable(new ItemBlock(
            4 * beginningGoalXPos + Constants.PLAYER_DIAMETER,
            (getCurrentActiveLevelHeight() / 2) - (2 * Constants.DEFAULT_BLOCK_SIZE),
            Constants.DEFAULT_BLOCK_SIZE,
            Constants.DEFAULT_BLOCK_SIZE,
            healthItemForBlock,
            Constants.DEFAULT_BOUNDARY_LINE_THICKNESS,
            false,
            false,
            true
        ));

        // double flying enemy groups
        this.levelDrawableCollection.addDrawable(new VerticalBoundary(
            6 * beginningGoalXPos,
            beginningGoalYPos,
            getCurrentActiveLevelHeight() - (beginningGoalYPos / 2),
            Constants.DEFAULT_BOUNDARY_LINE_THICKNESS,
            true
        ));
        this.levelDrawableCollection.addDrawable(new HorizontalBoundary(
            6 * beginningGoalXPos,
            getCurrentActiveLevelHeight(),
            2 * beginningGoalXPos,
            Constants.DEFAULT_BOUNDARY_LINE_THICKNESS,
            true,
            true
        ));
        for (int i = 0; i < 10; i++) {
            this.levelDrawableCollection.addDrawable(new FlyingEnemy(
                7 * beginningGoalXPos,
                (Constants.SMALL_ENEMY_DIAMETER / 2) + (Constants.SMALL_ENEMY_DIAMETER * i),
                Constants.SMALL_ENEMY_DIAMETER,
                0,
                Constants.ENEMY_FAST_MOVEMENT_SPEED,
                false,
                false,
                true,
                true,
                true
            ));
        }
        for (int i = 0; i < 10; i++) {
            this.levelDrawableCollection.addDrawable(new FlyingEnemy(
                7 * beginningGoalXPos,
                (getCurrentActiveLevelHeight() - (Constants.SMALL_ENEMY_DIAMETER / 2)) - (Constants.SMALL_ENEMY_DIAMETER * i),
                Constants.SMALL_ENEMY_DIAMETER,
                0,
                -Constants.ENEMY_FAST_MOVEMENT_SPEED,
                true,
                false,
                true,
                true,
                true
            ));
        }

        final int leftMostDrawableXPos = 8 * beginningGoalXPos;
        this.levelDrawableCollection.addDrawable(new VerticalBoundary(
            leftMostDrawableXPos,
            beginningGoalYPos,
            getCurrentActiveLevelHeight() - (beginningGoalYPos / 2),
            Constants.DEFAULT_BOUNDARY_LINE_THICKNESS,
            true
        ));

        return leftMostDrawableXPos;

    }

    /**
     * @return x-pos of left-most drawable in section
     */
    private int setupActivateEndBeforeCheckpoint(final int startXPos) {
        // small middle gap with enemies
        this.levelDrawableCollection.addDrawable(new VerticalBoundary(
            startXPos,
            0,
            getCurrentActiveLevelHeight() / 2 - Constants.PLAYER_DIAMETER,
            Constants.DEFAULT_BOUNDARY_LINE_THICKNESS,
            true
        ));
        this.levelDrawableCollection.addDrawable(new VerticalBoundary(
            startXPos,
            getCurrentActiveLevelHeight() / 2 + Constants.PLAYER_DIAMETER,
            getCurrentActiveLevelHeight()
                - (getCurrentActiveLevelHeight() / 2 + Constants.PLAYER_DIAMETER),
            Constants.DEFAULT_BOUNDARY_LINE_THICKNESS,
            true
        ));
        this.levelDrawableCollection.addDrawable(new HorizontalBoundary(
            startXPos,
            getCurrentActiveLevelHeight() / 3,
            5 * Constants.DEFAULT_BLOCK_SIZE,
            Constants.DEFAULT_BOUNDARY_LINE_THICKNESS,
            true,
            true
        ));
        for (int i = 0; i < 4; i++) {
            this.levelDrawableCollection.addDrawable(new FlyingEnemy(
                startXPos + (3 * Constants.SMALL_ENEMY_DIAMETER / 2),
                getCurrentActiveLevelHeight() / 2 + i * Constants.PLAYER_DIAMETER,
                Constants.SMALL_ENEMY_DIAMETER,
                0,
                0,
                false,
                false,
                true,
                true,
                true
            ));
        }

        final int mediumEnemyWallXPos = (startXPos * 3) / 2;
        // medium enemy wall
        for (int i = 0; i < 3; i++) {
            this.levelDrawableCollection.addDrawable(new FlyingEnemy(
                mediumEnemyWallXPos,
                Constants.MEDIUM_ENEMY_DIAMETER / 2 + i * Constants.MEDIUM_ENEMY_DIAMETER,
                Constants.MEDIUM_ENEMY_DIAMETER,
                0,
                0,
                false,
                false,
                true,
                true,
                true
            ));
        }

        final int sectionFloorXOffset = this.checkpointXPos - (mediumEnemyWallXPos);
        this.levelDrawableCollection.addDrawable(new HorizontalBoundary(
            mediumEnemyWallXPos,
            Constants.LEVEL_FLOOR_Y_POSITION,
            sectionFloorXOffset,
            Constants.DEFAULT_BOUNDARY_LINE_THICKNESS,
            true,
            true,
            false,
            true,
            true
        ));

        return mediumEnemyWallXPos + sectionFloorXOffset;
    }

    /**
     * @return sum of given startXPos and section floor x offset
     */
    private int setupActivateBeginningAfterCheckpoint(final int startXPos) {
        final int sectionFloorXOffset = 2000;
        // section floor
        this.levelDrawableCollection.addDrawable(new HorizontalBoundary(
            startXPos,
            Constants.LEVEL_FLOOR_Y_POSITION,
            sectionFloorXOffset,
            Constants.DEFAULT_BOUNDARY_LINE_THICKNESS,
            true,
            true
        ));

        // fast up flying enemy and trigger
        Enemy enemyToAddForTrigger = new FlyingEnemy(
            startXPos - 150,
            Constants.SCREEN_HEIGHT,
            Constants.MEDIUM_ENEMY_DIAMETER,
            0,
            -Constants.ENEMY_FAST_MOVEMENT_SPEED * 3,
            -Constants.MEDIUM_ENEMY_DIAMETER,
            Constants.SCREEN_HEIGHT,
            false,
            false,
            true,
            true,
            false
        );
        this.levelDrawableCollection.addDrawable(enemyToAddForTrigger);
        this.levelDrawableCollection.addDrawable(new EnemyTriggerVerticalBoundary(
            startXPos - 250,
            0,
            Constants.LEVEL_FLOOR_Y_POSITION,
            Constants.DEFAULT_BOUNDARY_LINE_THICKNESS,
            true,
            enemyToAddForTrigger
        ));

        this.levelDrawableCollection.addDrawable(new EventBlock(    // launch event
            startXPos,
            Constants.LEVEL_FLOOR_Y_POSITION - Constants.DEFAULT_EVENT_BLOCK_HEIGHT,
            Constants.DEFAULT_EVENT_BLOCK_WIDTH,
            Constants.DEFAULT_EVENT_BLOCK_HEIGHT,
            Constants.DEFAULT_BOUNDARY_LINE_THICKNESS,
            Constants.CHARACTER_LAUNCH_EVENT_VERTICAL_VELOCITY / 2,
            true,
            true
        ));
        this.levelDrawableCollection.addDrawable(new EventBlock(    // launch event
            startXPos + Constants.DEFAULT_EVENT_BLOCK_WIDTH,
            Constants.LEVEL_FLOOR_Y_POSITION - Constants.DEFAULT_EVENT_BLOCK_HEIGHT,
            Constants.DEFAULT_EVENT_BLOCK_WIDTH,
            Constants.DEFAULT_EVENT_BLOCK_HEIGHT,
            Constants.DEFAULT_BOUNDARY_LINE_THICKNESS,
            Constants.CHARACTER_LAUNCH_EVENT_VERTICAL_VELOCITY,
            true,
            true
        ));

        // small flying enemy group with trigger
        Set<Enemy> enemiesToAddForTrigger = new HashSet<Enemy>();
        for (int i = 0; i < 5; i++) {
            enemyToAddForTrigger = new FlyingEnemy(
                startXPos + 8 * Constants.DEFAULT_EVENT_BLOCK_WIDTH,
                Constants.LEVEL_FLOOR_Y_POSITION - (Constants.SMALL_ENEMY_DIAMETER / 2) - (Constants.SMALL_ENEMY_DIAMETER * i),
                Constants.SMALL_ENEMY_DIAMETER,
                -Constants.ENEMY_FAST_MOVEMENT_SPEED,
                0,
                false,
                true,
                false,
                true,
                false
            );
            enemiesToAddForTrigger.add(enemyToAddForTrigger);
            this.levelDrawableCollection.addDrawable(enemyToAddForTrigger);
        }
        this.levelDrawableCollection.addDrawable(new EnemyTriggerVerticalBoundary(
            startXPos + 4 * Constants.DEFAULT_EVENT_BLOCK_WIDTH,
            0,
            Constants.LEVEL_FLOOR_Y_POSITION,
            Constants.DEFAULT_BOUNDARY_LINE_THICKNESS,
            true,
            enemiesToAddForTrigger
        ));

        // flying enemy wall that covers height of screen and trigger
        enemiesToAddForTrigger = new HashSet<Enemy>();
        int currFlyingEnemyYPos = Constants.LEVEL_FLOOR_Y_POSITION - (Constants.SMALL_ENEMY_DIAMETER / 2);
        while (currFlyingEnemyYPos > Constants.SMALL_ENEMY_DIAMETER / 2) {
            enemyToAddForTrigger = new FlyingEnemy(
                startXPos + 11 * Constants.DEFAULT_EVENT_BLOCK_WIDTH,
                currFlyingEnemyYPos,
                Constants.SMALL_ENEMY_DIAMETER,
                -Constants.ENEMY_FAST_MOVEMENT_SPEED,
                0,
                false,
                true,
                false,
                true,
                false
            );
            enemiesToAddForTrigger.add(enemyToAddForTrigger);
            this.levelDrawableCollection.addDrawable(enemyToAddForTrigger);
            currFlyingEnemyYPos = currFlyingEnemyYPos - Constants.SMALL_ENEMY_DIAMETER;
        }
        this.levelDrawableCollection.addDrawable(new EnemyTriggerVerticalBoundary(
            startXPos + 6 * Constants.DEFAULT_EVENT_BLOCK_WIDTH,
            0,
            Constants.LEVEL_FLOOR_Y_POSITION,
            Constants.DEFAULT_BOUNDARY_LINE_THICKNESS,
            true,
            enemiesToAddForTrigger
        ));

        return startXPos + sectionFloorXOffset;
    }

    private void setupActivateEndAfterCheckpoint(final int startXPos) {
        // section floor
        this.levelDrawableCollection.addDrawable(new HorizontalBoundary(
            startXPos,
            Constants.LEVEL_FLOOR_Y_POSITION,
            3500,
            Constants.DEFAULT_BOUNDARY_LINE_THICKNESS,
            true,
            true
        ));

        // big falling enemy with trigger; and block
        Enemy enemyToAddForTrigger = new Enemy(
            startXPos + 250,
            -Constants.BIG_ENEMY_DIAMETER / 2 + 1,
            Constants.BIG_ENEMY_DIAMETER,
            0,
            true,
            true,
            false
        );
        this.levelDrawableCollection.addDrawable(enemyToAddForTrigger);
        this.levelDrawableCollection.addDrawable(new EnemyTriggerVerticalBoundary(
            startXPos + 250,
            0,
            Constants.LEVEL_FLOOR_Y_POSITION,
            Constants.DEFAULT_BOUNDARY_LINE_THICKNESS,
            true,
            enemyToAddForTrigger
        ));
        this.levelDrawableCollection.addDrawable(new Block(
            startXPos + 250,
            Constants.SCREEN_HEIGHT / 2,
            Constants.DEFAULT_BLOCK_SIZE,
            Constants.DEFAULT_BLOCK_SIZE,
            Constants.DEFAULT_BOUNDARY_LINE_THICKNESS,
            false,
            false,
            true
        ));

        this.levelDrawableCollection.addDrawable(new HealthItem(
            1,
            startXPos + 1000,
            Constants.LEVEL_FLOOR_Y_POSITION - Constants.HEALTH_ITEM_SIZE,
            Constants.HEALTH_ITEM_SIZE,
            Constants.HEALTH_ITEM_SIZE,
            Constants.DEFAULT_BOUNDARY_LINE_THICKNESS,
            true
        ));

        // zig-zag enemies and trigger
        Set<Enemy> enemiesToAddForTrigger = new HashSet<Enemy>();
        for (int i = 0; i < 8; i++) {
            enemyToAddForTrigger = new FlyingEnemy(
                startXPos + 1500 + (250 * i),
                Constants.LEVEL_FLOOR_Y_POSITION - (2 * Constants.SMALL_ENEMY_DIAMETER),
                Constants.SMALL_ENEMY_DIAMETER,
                -Constants.ENEMY_FAST_MOVEMENT_SPEED,
                Constants.ENEMY_FAST_MOVEMENT_SPEED,
                Constants.LEVEL_FLOOR_Y_POSITION - (4 * Constants.SMALL_ENEMY_DIAMETER),
                Constants.LEVEL_FLOOR_Y_POSITION,
                false,
                true,
                false,
                true,
                false
            );
            enemiesToAddForTrigger.add(enemyToAddForTrigger);
            this.levelDrawableCollection.addDrawable(enemyToAddForTrigger);
        }
        this.levelDrawableCollection.addDrawable(new EnemyTriggerVerticalBoundary(
            startXPos + 1000,
            0,
            Constants.LEVEL_FLOOR_Y_POSITION,
            Constants.DEFAULT_BOUNDARY_LINE_THICKNESS,
            true,
            enemiesToAddForTrigger
        ));

        // invincible enemy near end
        this.levelDrawableCollection.addDrawable(new Enemy(
            startXPos + 2000,
            Constants.LEVEL_FLOOR_Y_POSITION - Constants.BIG_ENEMY_DIAMETER,
            Constants.BIG_ENEMY_DIAMETER,
            0,
            true,
            true,
            true
        ));

        // controllable enemy at end
        enemyToAddForTrigger = new ControllableEnemy(
            getCurrentActiveLevelWidth() - Constants.SMALL_ENEMY_DIAMETER,
            Constants.LEVEL_FLOOR_Y_POSITION - Constants.SMALL_ENEMY_DIAMETER,
            Constants.SMALL_ENEMY_DIAMETER,
            true,
            true,
            Constants.PLAYER_MOVEMENT_SPEED,
            false,
            true,
            false
        );
        this.levelDrawableCollection.addDrawable(enemyToAddForTrigger);
        this.levelDrawableCollection.addDrawable(new EnemyTriggerVerticalBoundary(
            startXPos + 1500,
            0,
            Constants.LEVEL_FLOOR_Y_POSITION,
            Constants.DEFAULT_BOUNDARY_LINE_THICKNESS,
            true,
            enemyToAddForTrigger
        ));
    }

}
