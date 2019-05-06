public class LevelThree extends ALevel {

    /**
     * sets properties, boundaries, and characters of this
     */
    public LevelThree(boolean isActive, boolean loadPlayerFromCheckPoint) {
        super(isActive, loadPlayerFromCheckPoint, Constants.BIG_ENEMY_DIAMETER + 200);
    }

    @Override
    void setUpActivateLevel() {
        this.makeActive();
        resourceUtils.loopSong(ESongType.LEVEL);

        final int playerStartXPos = Constants.SCREEN_WIDTH / 6;
        final int playerStartYPos = Constants.SCREEN_HEIGHT / 4;

        this.viewBox = new ViewBox(
            0,
            playerStartYPos,
            true);
        this.player = new Player(
            playerStartXPos,
            playerStartYPos,
            Constants.PLAYER_DIAMETER,
            true);

        this.setupActivateBeforeCheckpoint(playerStartXPos, playerStartYPos);
    }

    private void setupActivateBeforeCheckpoint(final int playerStartXPos, final int playerStartYPos) {
        // extend left wall to bottom of level
        this.levelDrawableCollection.addDrawable(new VerticalBoundary(
            0,
            Constants.LEVEL_FLOOR_Y_POSITION,
            getCurrentActiveLevelHeight() - Constants.LEVEL_FLOOR_Y_POSITION,
            Constants.DEFAULT_BOUNDARY_LINE_THICKNESS,
            true
        ));


        this.levelDrawableCollection.addDrawable(new LevelGoal(
            playerStartXPos,
            playerStartYPos + 2 * Constants.PLAYER_DIAMETER,
            Constants.CHECKPOINT_WIDTH,
            Constants.SCREEN_HEIGHT,
            Constants.DEFAULT_BOUNDARY_LINE_THICKNESS,
            true
        ));

        this.levelDrawableCollection.addDrawable(new VerticalBoundary(
            2 * playerStartXPos,
            playerStartYPos,
            getCurrentActiveLevelHeight() - (playerStartYPos / 2),
            Constants.DEFAULT_BOUNDARY_LINE_THICKNESS,
            true
        ));

        this.levelDrawableCollection.addDrawable(new FlyingEnemy(
            2 * playerStartXPos,
            Constants.SMALL_ENEMY_DIAMETER,
            Constants.SMALL_ENEMY_DIAMETER,
            0,
            Constants.ENEMY_FAST_MOVEMENT_SPEED,
            true,
            true,
            true
        ));

        this.levelDrawableCollection.addDrawable(new VerticalBoundary(
            4 * playerStartXPos,
            playerStartYPos,
            getCurrentActiveLevelHeight() - (playerStartYPos / 2),
            Constants.DEFAULT_BOUNDARY_LINE_THICKNESS,
            true
        ));

        this.levelDrawableCollection.addDrawable(new HorizontalBoundary(
            4 * playerStartXPos,
            getCurrentActiveLevelHeight() + Constants.DEFAULT_BOUNDARY_LINE_THICKNESS,
            1000,
            Constants.DEFAULT_BOUNDARY_LINE_THICKNESS,
            true,
            true
        ));

        for (int i = 0; i < 10; i++) {
            this.levelDrawableCollection.addDrawable(new FlyingEnemy(
                5 * playerStartXPos,
                (Constants.SMALL_ENEMY_DIAMETER / 2) + (Constants.SMALL_ENEMY_DIAMETER * i),
                Constants.SMALL_ENEMY_DIAMETER,
                0,
                Constants.ENEMY_FAST_MOVEMENT_SPEED,
                true,
                true,
                true
            ));
        }

        for (int i = 0; i < 10; i++) {
            this.levelDrawableCollection.addDrawable(new FlyingEnemy(
                5 * playerStartXPos,
                (getCurrentActiveLevelHeight() - (Constants.SMALL_ENEMY_DIAMETER / 2)) - (Constants.SMALL_ENEMY_DIAMETER * i),
                Constants.SMALL_ENEMY_DIAMETER,
                0,
                -Constants.ENEMY_FAST_MOVEMENT_SPEED,
                true,
                true,
                true
            ));
        }

        this.levelDrawableCollection.addDrawable(new VerticalBoundary(
            6 * playerStartXPos,
            playerStartYPos,
            getCurrentActiveLevelHeight() - (playerStartYPos / 2),
            Constants.DEFAULT_BOUNDARY_LINE_THICKNESS,
            true
        ));
    }

}
