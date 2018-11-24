/**
 * Level two
 */
public class LevelTwo extends ALevel implements IDrawable {

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

        loopSong(ESongType.LEVEL);

        final int levelMiddleXPos = getCurrentActiveLevelWidth() / 2;
        this.checkpointXPos = levelMiddleXPos - 1750 - 50;

        if (this.loadPlayerFromCheckPoint) {
            this.viewBox = new ViewBox(
                this.checkpointXPos - ((Constants.SCREEN_WIDTH / 2) + 75),
                0,
                this.isActive);
            this.player = new Player(
                this.checkpointXPos,
                0,
                Constants.PLAYER_DIAMETER,
                this.isActive);
        } else {
            this.viewBox = new ViewBox(
                levelMiddleXPos,
                0,
                this.isActive);
            this.player = new Player(
                levelMiddleXPos + (Constants.SCREEN_WIDTH / 2) + 75,
                0,
                Constants.PLAYER_DIAMETER,
                this.isActive);

            this.collectablesList.add(new Checkpoint(
                this.checkpointXPos,
                Constants.LEVEL_FLOOR_Y_POSITION - Constants.CHECKPOINT_HEIGHT,
                Constants.CHECKPOINT_WIDTH,
                Constants.CHECKPOINT_HEIGHT,
                Constants.DEFAULT_BOUNDARY_LINE_THICKNESS,
                this.isActive)
            );
        }


        this.setupActivateStartWrongSection(levelMiddleXPos);
        this.setupActivateMiddleWrongSection(levelMiddleXPos + 1750);
        this.setupActivateEndWrongSection(levelMiddleXPos + 1750 + 2250);

        this.setupActivateStartCorrectSection(levelMiddleXPos);
        this.setupActivateMiddleCorrectSection(levelMiddleXPos - 1750);
        this.setupActivateEndCorrectSection(levelMiddleXPos - 1750 - 2250);
    }

    /* ****** WRONG SECTION ****** */

    private void setupActivateStartWrongSection(final int startXPos) {
        // section floor
        this.boundariesList.add(new HorizontalBoundary(
            startXPos,
            Constants.LEVEL_FLOOR_Y_POSITION,
            1000,
            Constants.DEFAULT_BOUNDARY_LINE_THICKNESS,
            true,
            this.isActive
        ));

        // level half split boundary
        this.boundariesList.add(new VerticalBoundary(
            startXPos,
            Constants.LEVEL_FLOOR_Y_POSITION,
            -Constants.LEVEL_FLOOR_Y_POSITION,
            Constants.DEFAULT_BOUNDARY_LINE_THICKNESS,
            this.isActive
        ));

        for (int i = 0; i < 5; i++) {
            this.charactersList.add(new FlyingEnemy(
                (startXPos + 2 * Constants.REGULAR_ENEMY_DIAMETER) - (i * Constants.REGULAR_ENEMY_DIAMETER),
                (Constants.SCREEN_HEIGHT - getCurrentActiveLevelHeight()) / 2,
                Constants.REGULAR_ENEMY_DIAMETER,
                0,
                0,
                true,
                true,
                this.isActive
            ));
        }

        this.charactersList.add(new Enemy(
            startXPos + (Constants.BIG_ENEMY_DIAMETER / 2),
            0,
            Constants.BIG_ENEMY_DIAMETER,
            Constants.ENEMY_REGULAR_RUN_SPEED,
            true,
            true,
            this.isActive
        ));

        for (int i = 0; i < 7; i++) {
            this.charactersList.add(new FlyingEnemy(
                startXPos + 1100 + i * (Constants.REGULAR_ENEMY_DIAMETER + 30),
                Constants.LEVEL_FLOOR_Y_POSITION - Constants.REGULAR_ENEMY_DIAMETER,
                Constants.REGULAR_ENEMY_DIAMETER,
                0,
                Constants.ENEMY_SLOW_RUN_SPEED,
                200,
                Constants.LEVEL_FLOOR_Y_POSITION - Constants.REGULAR_ENEMY_DIAMETER,
                false,
                true,
                this.isActive
            ));
        }
    }

    private void setupActivateMiddleWrongSection(final int startXPos) {
        // section floor
        this.boundariesList.add(new HorizontalBoundary(
            startXPos,
            Constants.LEVEL_FLOOR_Y_POSITION,
            2000,
            Constants.DEFAULT_BOUNDARY_LINE_THICKNESS,
            true,
            this.isActive
        ));

        // stair section
        for (int i = 0; i < 3; i++) {
            this.blocksList.add(new Block(
                startXPos + 500 + (i + 1) * Constants.DEFAULT_BLOCK_SIZE,
                height - (i + 2) * Constants.DEFAULT_BLOCK_SIZE,
                Constants.DEFAULT_BLOCK_SIZE,
                (i + 1) * Constants.DEFAULT_BLOCK_SIZE,
                Constants.DEFAULT_BOUNDARY_LINE_THICKNESS,
                false,
                this.isActive
            ));
        }

        Enemy enemyToAddForTrigger = new Enemy(
            startXPos + 2000,
            Constants.LEVEL_FLOOR_Y_POSITION - Constants.REGULAR_ENEMY_DIAMETER,
            Constants.REGULAR_ENEMY_DIAMETER,
            -Constants.ENEMY_REGULAR_RUN_SPEED,
            false,
            true,
            false
        );
        this.charactersList.add(enemyToAddForTrigger);
        this.boundariesList.add(new EnemyTriggerVerticalBoundary(
            startXPos + 500 + 4 * Constants.DEFAULT_BLOCK_SIZE + 2 * Constants.DEFAULT_BLOCK_SIZE,
            0,
            Constants.LEVEL_FLOOR_Y_POSITION,
            Constants.DEFAULT_BOUNDARY_LINE_THICKNESS,
            this.isActive,
            enemyToAddForTrigger
        ));
    }

    private void setupActivateEndWrongSection(final int startXPos) {
        // section floor
        this.boundariesList.add(new HorizontalBoundary(
            startXPos,
            Constants.LEVEL_FLOOR_Y_POSITION,
            getCurrentActiveLevelWidth() - startXPos - 2 * Constants.PLAYER_DIAMETER,
            Constants.DEFAULT_BOUNDARY_LINE_THICKNESS,
            true,
            this.isActive
        ));

        this.blocksList.add(new EventBlock(
            startXPos,
            Constants.LEVEL_FLOOR_Y_POSITION - Constants.DEFAULT_EVENT_BLOCK_HEIGHT,
            Constants.DEFAULT_EVENT_BLOCK_WIDTH,
            Constants.DEFAULT_EVENT_BLOCK_HEIGHT,
            Constants.DEFAULT_BOUNDARY_LINE_THICKNESS,
            true,
            this.isActive
        ));

        Set<Enemy> enemyAtEndToTrigger = new HashSet<Enemy>();
        for (int i = 0; i < 2; i++) {
            Enemy enemyToAdd = new Enemy(
                getCurrentActiveLevelWidth() - (i + 1) * Constants.REGULAR_ENEMY_DIAMETER,
                Constants.LEVEL_FLOOR_Y_POSITION - (Constants.REGULAR_ENEMY_DIAMETER / 2),
                Constants.REGULAR_ENEMY_DIAMETER,
                -Constants.ENEMY_REGULAR_RUN_SPEED,
                false,
                true,
                false
            );
            this.charactersList.add(enemyToAdd);
            enemyAtEndToTrigger.add(enemyToAdd);
        }
        this.boundariesList.add(new EnemyTriggerVerticalBoundary(
            startXPos + Constants.DEFAULT_EVENT_BLOCK_WIDTH,
            0,
            Constants.LEVEL_FLOOR_Y_POSITION,
            Constants.DEFAULT_BOUNDARY_LINE_THICKNESS,
            this.isActive,
            enemyAtEndToTrigger
        ));
    }

    /* ****** CORRECT SECTION ****** */

    private void setupActivateStartCorrectSection(final int startXPos) {
        // section floor
        this.boundariesList.add(new HorizontalBoundary(
            startXPos,
            Constants.LEVEL_FLOOR_Y_POSITION,
            -1000,
            Constants.DEFAULT_BOUNDARY_LINE_THICKNESS,
            true,
            this.isActive
        ));

        Enemy enemyToAddForTrigger = new Enemy(
            startXPos - 700,
            0,
            Constants.BIG_ENEMY_DIAMETER,
            Constants.ENEMY_REGULAR_RUN_SPEED,
            true,
            true,
            false);
        this.charactersList.add(enemyToAddForTrigger);
        this.boundariesList.add(new EnemyTriggerVerticalBoundary(
            startXPos - 500,
            0,
            Constants.LEVEL_FLOOR_Y_POSITION,
            Constants.DEFAULT_BOUNDARY_LINE_THICKNESS,
            this.isActive,
            enemyToAddForTrigger
        ));

        for (int i = 0; i < 7; i++) {
            this.charactersList.add(new FlyingEnemy(
                startXPos - (1100 + i * (Constants.REGULAR_ENEMY_DIAMETER + 30)),
                Constants.LEVEL_FLOOR_Y_POSITION - Constants.REGULAR_ENEMY_DIAMETER,
                Constants.REGULAR_ENEMY_DIAMETER,
                0,
                Constants.ENEMY_SLOW_RUN_SPEED,
                200,
                Constants.LEVEL_FLOOR_Y_POSITION - Constants.REGULAR_ENEMY_DIAMETER,
                i % 2 == 0,
                true,
                this.isActive
            ));
        }
    }

    private void setupActivateMiddleCorrectSection(final int startXPos) {
        // section floor
        this.boundariesList.add(new HorizontalBoundary(
            startXPos,
            Constants.LEVEL_FLOOR_Y_POSITION,
            -2000,
            Constants.DEFAULT_BOUNDARY_LINE_THICKNESS,
            true,
            this.isActive
        ));

        // stair section
        for (int i = 0; i < 3; i++) {
            this.blocksList.add(new Block(
                startXPos - (500 + (i + 2) * Constants.DEFAULT_BLOCK_SIZE),
                height - (i + 2) * Constants.DEFAULT_BLOCK_SIZE,
                Constants.DEFAULT_BLOCK_SIZE,
                (i + 1) * Constants.DEFAULT_BLOCK_SIZE,
                Constants.DEFAULT_BOUNDARY_LINE_THICKNESS,
                false,
                this.isActive
            ));
        }

        Enemy enemyToAddForTrigger = new Enemy(
            startXPos - 2000,
            Constants.LEVEL_FLOOR_Y_POSITION - Constants.REGULAR_ENEMY_DIAMETER,
            Constants.REGULAR_ENEMY_DIAMETER,
            Constants.ENEMY_REGULAR_RUN_SPEED,
            false,
            true,
            false
        );
        this.charactersList.add(enemyToAddForTrigger);
        this.boundariesList.add(new EnemyTriggerVerticalBoundary(
            startXPos - (500 + 4 * Constants.DEFAULT_BLOCK_SIZE) - 2 * Constants.DEFAULT_BLOCK_SIZE,
            0,
            Constants.LEVEL_FLOOR_Y_POSITION,
            Constants.DEFAULT_BOUNDARY_LINE_THICKNESS,
            this.isActive,
            enemyToAddForTrigger
        ));

        // calculated using distance from pit to start from left most x pos of stairs
        final int numTimesBlockIterate =
            (2000 - (2000 - (500 + (4 + 2) * Constants.DEFAULT_BLOCK_SIZE))) / Constants.DEFAULT_BLOCK_SIZE;
        for (int i = 0; i < numTimesBlockIterate; i++) {
            this.blocksList.add(new Block(
                startXPos - (500 + (4 + i) * Constants.DEFAULT_BLOCK_SIZE), // start from left most x pos of stairs
                Constants.LEVEL_FLOOR_Y_POSITION - Constants.DEFAULT_BLOCK_SIZE - Constants.PLAYER_DIAMETER - 10,
                Constants.DEFAULT_BLOCK_SIZE,
                Constants.DEFAULT_BLOCK_SIZE,
                Constants.DEFAULT_BOUNDARY_LINE_THICKNESS,
                false,
                false,
                this.isActive
            ));
        }
    }

    private void setupActivateEndCorrectSection(final int startXPos) {
        // section floor
        this.boundariesList.add(new HorizontalBoundary(
            startXPos,
            Constants.LEVEL_FLOOR_Y_POSITION,
            -(getCurrentActiveLevelWidth() - (getCurrentActiveLevelWidth() / 2 + 1750 + 2250) - 2 * Constants.PLAYER_DIAMETER),
            Constants.DEFAULT_BOUNDARY_LINE_THICKNESS,
            true,
            this.isActive
        ));

        // event block with invincible enemy
        final int eventBlockInvulnerableEnemyXReference = startXPos - Constants.DEFAULT_EVENT_BLOCK_WIDTH;
        this.blocksList.add(new EventBlock(
            eventBlockInvulnerableEnemyXReference,
            Constants.LEVEL_FLOOR_Y_POSITION - Constants.DEFAULT_EVENT_BLOCK_HEIGHT,
            Constants.DEFAULT_EVENT_BLOCK_WIDTH,
            Constants.DEFAULT_EVENT_BLOCK_HEIGHT,
            Constants.DEFAULT_BOUNDARY_LINE_THICKNESS,
            true,
            this.isActive
        ));
        this.charactersList.add(new Enemy(
            eventBlockInvulnerableEnemyXReference + (Constants.DEFAULT_EVENT_BLOCK_WIDTH / 2),
            Constants.LEVEL_FLOOR_Y_POSITION - Constants.DEFAULT_EVENT_BLOCK_HEIGHT - Constants.REGULAR_ENEMY_DIAMETER,
            Constants.DEFAULT_EVENT_BLOCK_WIDTH,
            0,
            true,
            false,
            this.isActive
        ));

        Set<Enemy> enemyAtEndToTrigger = new HashSet<Enemy>();
        for (int i = 0; i < 2; i++) {
            Enemy enemyToAdd = new Enemy(
                (i + 1) * Constants.REGULAR_ENEMY_DIAMETER,
                Constants.LEVEL_FLOOR_Y_POSITION - (Constants.REGULAR_ENEMY_DIAMETER / 2),
                Constants.REGULAR_ENEMY_DIAMETER,
                Constants.ENEMY_REGULAR_RUN_SPEED,
                true,
                true,
                false
            );
            this.charactersList.add(enemyToAdd);
            enemyAtEndToTrigger.add(enemyToAdd);
        }
        this.boundariesList.add(new EnemyTriggerVerticalBoundary(
            startXPos - Constants.DEFAULT_EVENT_BLOCK_WIDTH,
            0,
            Constants.LEVEL_FLOOR_Y_POSITION,
            Constants.DEFAULT_BOUNDARY_LINE_THICKNESS,
            this.isActive,
            enemyAtEndToTrigger
        ));

        // correct goal post
        this.collectablesList.add(new LevelGoal(
            Constants.LEVEL_GOAL_WIDTH + 4 * Constants.PLAYER_DIAMETER,
            Constants.LEVEL_FLOOR_Y_POSITION - Constants.LEVEL_GOAL_HEIGHT,
            Constants.LEVEL_GOAL_WIDTH,
            Constants.LEVEL_GOAL_HEIGHT,
            Constants.DEFAULT_BOUNDARY_LINE_THICKNESS,
            this.isActive)
        );
    }

}
