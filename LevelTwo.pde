/**
 * Level two
 */
public class LevelTwo extends ALevel {

    /**
     * sets properties, boundaries, and characters of this
     */
    public LevelTwo(boolean isActive, boolean loadPlayerFromCheckPoint) {
        super(isActive, loadPlayerFromCheckPoint, 4 * Constants.PLAYER_DIAMETER);
    }

    /**
     * setup and activate this
     */
    @Override
    public void setUpActivateLevel() {
        this.makeActive();

        resourceUtils.loopSong(ESongType.LEVEL);

        final int levelMiddleXPos = getCurrentActiveLevelWidth() / 2;
        this.checkpointXPos = levelMiddleXPos - 1750 - 50;
        if (this.loadPlayerFromCheckPoint) {
            this.viewBox = new ViewBox(
                this.checkpointXPos - ((Constants.SCREEN_WIDTH / 2) + 75),
                0,
                true);
            this.player = new Player(
                this.checkpointXPos,
                0,
                Constants.PLAYER_DIAMETER,
                true);
        } else {
            this.viewBox = new ViewBox(
                levelMiddleXPos,
                0,
                true);
            this.player = new Player(
                levelMiddleXPos + (Constants.SCREEN_WIDTH / 2) + 75,
                0,
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


        this.setupActivateStartWrongSection(levelMiddleXPos);
        this.setupActivateMiddleWrongSection(levelMiddleXPos + 1750);
        this.setupActivateEndWrongSection(levelMiddleXPos + 1750 + 2250);

        this.setupActivateStartCorrectSection(levelMiddleXPos);
        final int widthOfMiddleCorrectSection = 2000;
        this.setupActivateMiddleCorrectSection(levelMiddleXPos - 1750, widthOfMiddleCorrectSection);
        this.setupActivateEndCorrectSection(levelMiddleXPos - 1750 - widthOfMiddleCorrectSection - 250);
    }

    /* ****** WRONG SECTION ****** */

    private void setupActivateStartWrongSection(final int startXPos) {
        // section floor
        this.levelDrawableCollection.addDrawable(new HorizontalBoundary(
            startXPos,
            Constants.LEVEL_FLOOR_Y_POSITION,
            1000,
            Constants.DEFAULT_BOUNDARY_LINE_THICKNESS,
            true,
            true
        ));

        // level half split boundary
        this.levelDrawableCollection.addDrawable(new VerticalBoundary(
            startXPos,
            Constants.LEVEL_FLOOR_Y_POSITION,
            -Constants.LEVEL_FLOOR_Y_POSITION,
            Constants.DEFAULT_BOUNDARY_LINE_THICKNESS,
            true
        ));

        for (int i = 0; i < 5; i++) {
            this.levelDrawableCollection.addDrawable(new FlyingEnemy(
                (startXPos + 2 * Constants.SMALL_ENEMY_DIAMETER) - (i * Constants.SMALL_ENEMY_DIAMETER),
                (Constants.SCREEN_HEIGHT - getCurrentActiveLevelHeight()) / 2,
                Constants.SMALL_ENEMY_DIAMETER,
                0,
                0,
                true,
                true,
                true
            ));
        }

        this.levelDrawableCollection.addDrawable(new Enemy(
            startXPos + (Constants.BIG_ENEMY_DIAMETER / 2),
            0,
            Constants.BIG_ENEMY_DIAMETER,
            Constants.ENEMY_REGULAR_MOVEMENT_SPEED,
            true,
            true,
            true
        ));

        for (int i = 0; i < 7; i++) {
            this.levelDrawableCollection.addDrawable(new FlyingEnemy(
                startXPos + 1100 + i * (Constants.SMALL_ENEMY_DIAMETER + 30),
                Constants.LEVEL_FLOOR_Y_POSITION - Constants.SMALL_ENEMY_DIAMETER,
                Constants.SMALL_ENEMY_DIAMETER,
                0,
                Constants.ENEMY_SLOW_MOVEMENT_SPEED,
                200,
                Constants.LEVEL_FLOOR_Y_POSITION - Constants.SMALL_ENEMY_DIAMETER,
                false,
                true,
                true
            ));
        }
    }

    private void setupActivateMiddleWrongSection(final int startXPos) {
        // section floor
        this.levelDrawableCollection.addDrawable(new HorizontalBoundary(
            startXPos,
            Constants.LEVEL_FLOOR_Y_POSITION,
            2000,
            Constants.DEFAULT_BOUNDARY_LINE_THICKNESS,
            true,
            true
        ));

        // item block before stair section
        HealthItem healthItemForBlock =
            new HealthItem(
                -1,
                0,
                0,
                Constants.HEALTH_ITEM_SIZE,
                Constants.HEALTH_ITEM_SIZE,
                1,
                false
            );
        this.levelDrawableCollection.addDrawable((healthItemForBlock));
        this.levelDrawableCollection.addDrawable(new ItemBlock(
            startXPos + 250,
            Constants.LEVEL_FLOOR_Y_POSITION - 3 * Constants.DEFAULT_BLOCK_SIZE,
            Constants.DEFAULT_BLOCK_SIZE,
            Constants.DEFAULT_BLOCK_SIZE,
            healthItemForBlock,
            1,
            false,
            true
        ));

        // stair section
        for (int i = 0; i < 3; i++) {
            this.levelDrawableCollection.addDrawable(new Block(
                startXPos + 500 + (i + 1) * Constants.DEFAULT_BLOCK_SIZE,
                height - (i + 2) * Constants.DEFAULT_BLOCK_SIZE,
                Constants.DEFAULT_BLOCK_SIZE,
                (i + 1) * Constants.DEFAULT_BLOCK_SIZE,
                Constants.DEFAULT_BOUNDARY_LINE_THICKNESS,
                false,
                true
            ));
        }

        Enemy enemyToAddForTrigger = new Enemy(
            startXPos + 2000,
            Constants.LEVEL_FLOOR_Y_POSITION - Constants.SMALL_ENEMY_DIAMETER,
            Constants.SMALL_ENEMY_DIAMETER,
            -Constants.ENEMY_REGULAR_MOVEMENT_SPEED,
            false,
            true,
            false
        );
        this.levelDrawableCollection.addDrawable(enemyToAddForTrigger);
        this.levelDrawableCollection.addDrawable(new EnemyTriggerVerticalBoundary(
            startXPos + 500 + 4 * Constants.DEFAULT_BLOCK_SIZE + 2 * Constants.DEFAULT_BLOCK_SIZE,
            0,
            Constants.LEVEL_FLOOR_Y_POSITION,
            Constants.DEFAULT_BOUNDARY_LINE_THICKNESS,
            true,
            enemyToAddForTrigger
        ));
    }

    private void setupActivateEndWrongSection(final int startXPos) {
        // section floor
        this.levelDrawableCollection.addDrawable(new HorizontalBoundary(
            startXPos,
            Constants.LEVEL_FLOOR_Y_POSITION,
            getCurrentActiveLevelWidth() - startXPos - 2 * Constants.PLAYER_DIAMETER,
            Constants.DEFAULT_BOUNDARY_LINE_THICKNESS,
            true,
            true
        ));

        this.levelDrawableCollection.addDrawable(new EventBlock(
            startXPos,
            Constants.LEVEL_FLOOR_Y_POSITION - Constants.DEFAULT_EVENT_BLOCK_HEIGHT,
            Constants.DEFAULT_EVENT_BLOCK_WIDTH,
            Constants.DEFAULT_EVENT_BLOCK_HEIGHT,
            Constants.DEFAULT_BOUNDARY_LINE_THICKNESS,
            true,
            true
        ));

        Set<Enemy> enemyAtEndToTrigger = new HashSet<Enemy>();
        for (int i = 0; i < 2; i++) {
            Enemy enemyToAdd = new FlyingEnemy(
                getCurrentActiveLevelWidth() - (i + 1) * Constants.SMALL_ENEMY_DIAMETER,
                Constants.LEVEL_FLOOR_Y_POSITION - (Constants.SMALL_ENEMY_DIAMETER / 2),
                Constants.SMALL_ENEMY_DIAMETER,
                -Constants.ENEMY_REGULAR_MOVEMENT_SPEED,
                0,
                false,
                true,
                false
            );
            this.levelDrawableCollection.addDrawable(enemyToAdd);
            enemyAtEndToTrigger.add(enemyToAdd);
        }
        this.levelDrawableCollection.addDrawable(new EnemyTriggerVerticalBoundary(
            startXPos + Constants.DEFAULT_EVENT_BLOCK_WIDTH,
            0,
            Constants.LEVEL_FLOOR_Y_POSITION,
            Constants.DEFAULT_BOUNDARY_LINE_THICKNESS,
            true,
            enemyAtEndToTrigger
        ));
    }

    /* ****** CORRECT SECTION ****** */

    private void setupActivateStartCorrectSection(final int startXPos) {
        // section floor
        this.levelDrawableCollection.addDrawable(new HorizontalBoundary(
            startXPos,
            Constants.LEVEL_FLOOR_Y_POSITION,
            -1000,
            Constants.DEFAULT_BOUNDARY_LINE_THICKNESS,
            true,
            true
        ));

        Enemy enemyToAddForTrigger = new Enemy(
            startXPos - 700,
            0,
            Constants.BIG_ENEMY_DIAMETER,
            Constants.ENEMY_REGULAR_MOVEMENT_SPEED,
            true,
            true,
            false);
        this.levelDrawableCollection.addDrawable(enemyToAddForTrigger);
        this.levelDrawableCollection.addDrawable(new EnemyTriggerVerticalBoundary(
            startXPos - 500,
            0,
            Constants.LEVEL_FLOOR_Y_POSITION,
            Constants.DEFAULT_BOUNDARY_LINE_THICKNESS,
            true,
            enemyToAddForTrigger
        ));

        for (int i = 0; i < 7; i++) {
            this.levelDrawableCollection.addDrawable(new FlyingEnemy(
                startXPos - (1100 + i * (Constants.SMALL_ENEMY_DIAMETER + 30)),
                Constants.LEVEL_FLOOR_Y_POSITION - Constants.SMALL_ENEMY_DIAMETER,
                Constants.SMALL_ENEMY_DIAMETER,
                0,
                Constants.ENEMY_SLOW_MOVEMENT_SPEED,
                200,
                Constants.LEVEL_FLOOR_Y_POSITION - Constants.SMALL_ENEMY_DIAMETER,
                i % 2 == 0,
                true,
                true
            ));
        }
    }

    private void setupActivateMiddleCorrectSection(final int startXPos, final int widthOfMiddleCorrectSection) {
        // section floor
        this.levelDrawableCollection.addDrawable(new HorizontalBoundary(
            startXPos,
            Constants.LEVEL_FLOOR_Y_POSITION,
            -widthOfMiddleCorrectSection,
            Constants.DEFAULT_BOUNDARY_LINE_THICKNESS,
            true,
            true
        ));

        // item block before stair section
        HealthItem healthItemForBlock =
            new HealthItem(
                -1,
                0,
                0,
                Constants.HEALTH_ITEM_SIZE,
                Constants.HEALTH_ITEM_SIZE,
                Constants.DEFAULT_BOUNDARY_LINE_THICKNESS,
                false
            );
        this.levelDrawableCollection.addDrawable((healthItemForBlock));
        this.levelDrawableCollection.addDrawable(new ItemBlock(
            startXPos - 250 - Constants.DEFAULT_BLOCK_SIZE,
            Constants.LEVEL_FLOOR_Y_POSITION - 3 * Constants.DEFAULT_BLOCK_SIZE,
            Constants.DEFAULT_BLOCK_SIZE,
            Constants.DEFAULT_BLOCK_SIZE,
            healthItemForBlock,
            Constants.DEFAULT_BOUNDARY_LINE_THICKNESS,
            false,
            true
        ));

        // stair section
        int leftXPosOfStairsSection = 0;
        for (int i = 0; i < 3; i++) {
            leftXPosOfStairsSection = startXPos - (500 + (i + 2) * Constants.DEFAULT_BLOCK_SIZE);
            this.levelDrawableCollection.addDrawable(new Block(
                leftXPosOfStairsSection,
                height - (i + 2) * Constants.DEFAULT_BLOCK_SIZE,
                Constants.DEFAULT_BLOCK_SIZE,
                (i + 1) * Constants.DEFAULT_BLOCK_SIZE,
                Constants.DEFAULT_BOUNDARY_LINE_THICKNESS,
                false,
                true
            ));
        }

        Enemy enemyToAddForTrigger = new Enemy(
            startXPos - 2000,
            Constants.LEVEL_FLOOR_Y_POSITION - Constants.SMALL_ENEMY_DIAMETER,
            Constants.SMALL_ENEMY_DIAMETER,
            Constants.ENEMY_REGULAR_MOVEMENT_SPEED,
            false,
            true,
            false
        );
        this.levelDrawableCollection.addDrawable(enemyToAddForTrigger);
        this.levelDrawableCollection.addDrawable(new EnemyTriggerVerticalBoundary(
            startXPos - (500 + 4 * Constants.DEFAULT_BLOCK_SIZE) - 2 * Constants.DEFAULT_BLOCK_SIZE,
            0,
            Constants.LEVEL_FLOOR_Y_POSITION,
            Constants.DEFAULT_BOUNDARY_LINE_THICKNESS,
            true,
            enemyToAddForTrigger
        ));

        // calculated using distance from pit to start from left most x pos of stairs
        final int numTimesBlockIterate =
            ((widthOfMiddleCorrectSection - (startXPos - leftXPosOfStairsSection))
                / Constants.DEFAULT_BLOCK_SIZE) - 1; // -1 to not have block at end
        for (int i = 0; i < numTimesBlockIterate; i++) {
            if (i == 0) {   // block closest to stairs is item block
                healthItemForBlock =
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
                    leftXPosOfStairsSection - (i + 1) * Constants.DEFAULT_BLOCK_SIZE, // start from left most x pos of stairs
                    Constants.LEVEL_FLOOR_Y_POSITION - Constants.DEFAULT_BLOCK_SIZE - Constants.PLAYER_DIAMETER - 10,
                    Constants.DEFAULT_BLOCK_SIZE,
                    Constants.DEFAULT_BLOCK_SIZE,
                    healthItemForBlock,
                    Constants.DEFAULT_BOUNDARY_LINE_THICKNESS,
                    false,
                    false,
                    true
                ));
            } else {
                this.levelDrawableCollection.addDrawable(new Block(
                    leftXPosOfStairsSection - (i + 1) * Constants.DEFAULT_BLOCK_SIZE, // start from left most x pos of stairs
                    Constants.LEVEL_FLOOR_Y_POSITION - Constants.DEFAULT_BLOCK_SIZE - Constants.PLAYER_DIAMETER - 10,
                    Constants.DEFAULT_BLOCK_SIZE,
                    Constants.DEFAULT_BLOCK_SIZE,
                    Constants.DEFAULT_BOUNDARY_LINE_THICKNESS,
                    false,
                    false,
                    true
                ));
            }
        }
    }

    private void setupActivateEndCorrectSection(final int startXPos) {
        // section floor
        this.levelDrawableCollection.addDrawable(new HorizontalBoundary(
            startXPos,
            Constants.LEVEL_FLOOR_Y_POSITION,
            -(getCurrentActiveLevelWidth() - (getCurrentActiveLevelWidth() / 2 + 1750 + 2250) - 2 * Constants.PLAYER_DIAMETER),
            Constants.DEFAULT_BOUNDARY_LINE_THICKNESS,
            true,
            true
        ));

        // event block with invincible enemy
        final int eventBlockInvulnerableEnemyXReference = startXPos - Constants.DEFAULT_EVENT_BLOCK_WIDTH;
        this.levelDrawableCollection.addDrawable(new EventBlock(
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
            Constants.LEVEL_FLOOR_Y_POSITION - Constants.DEFAULT_EVENT_BLOCK_HEIGHT - Constants.SMALL_ENEMY_DIAMETER,
            Constants.DEFAULT_EVENT_BLOCK_WIDTH,
            0,
            true,
            false,
            true
        ));

        Set<Enemy> enemyAtEndToTrigger = new HashSet<Enemy>();
        for (int i = 0; i < 2; i++) {
            Enemy enemyToAdd = new FlyingEnemy(
                (i + 1) * Constants.SMALL_ENEMY_DIAMETER,
                Constants.LEVEL_FLOOR_Y_POSITION - (Constants.SMALL_ENEMY_DIAMETER / 2),
                Constants.SMALL_ENEMY_DIAMETER,
                Constants.ENEMY_REGULAR_MOVEMENT_SPEED,
                0,
                true,
                true,
                false
            );
            this.levelDrawableCollection.addDrawable(enemyToAdd);
            enemyAtEndToTrigger.add(enemyToAdd);
        }
        this.levelDrawableCollection.addDrawable(new EnemyTriggerVerticalBoundary(
            startXPos - Constants.DEFAULT_EVENT_BLOCK_WIDTH,
            0,
            Constants.LEVEL_FLOOR_Y_POSITION,
            Constants.DEFAULT_BOUNDARY_LINE_THICKNESS,
            true,
            enemyAtEndToTrigger
        ));

        // correct goal post
        this.levelDrawableCollection.addDrawable(new LevelGoal(
            Constants.LEVEL_GOAL_WIDTH + 4 * Constants.PLAYER_DIAMETER,
            Constants.LEVEL_FLOOR_Y_POSITION - Constants.LEVEL_GOAL_HEIGHT,
            Constants.LEVEL_GOAL_WIDTH,
            Constants.LEVEL_GOAL_HEIGHT,
            Constants.DEFAULT_BOUNDARY_LINE_THICKNESS,
            true)
        );
    }

}
