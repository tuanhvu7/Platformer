/**
 * Level two
 */
public class LevelTwo extends ALevel implements IDrawable {

    /**
     * sets properties, boundaries, and characters of this
     */
    public LevelTwo(boolean isActive, boolean loadPlayerFromCheckPoint) {
        super(isActive, loadPlayerFromCheckPoint, 0);
    }

    /**
     * setup and activate this
     */
    @Override
    public void setUpActivateLevel() {
        this.makeActive();

        this.viewBox = new ViewBox(0, 0, this.isActive);
        this.player = new Player(200, 0, Constants.PLAYER_DIAMETER, this.isActive);

        loopSong(ESongType.LEVEL);

        charactersList.add(new Enemy(
            getCurrentActiveLevelWidth() - 500,
            0,
            Constants.BIG_ENEMY_DIAMETER,
            -Constants.ENEMY_REGULAR_RUN_SPEED,
            false,
            false,
            true,
            this.isActive)
        );

        this.boundariesList.add(new HorizontalBoundary(
            width / 2,
            height / 2,
            100,
            Constants.DEFAULT_BOUNDARY_LINE_THICKNESS,
            true,
            this.isActive
        ));

        this.boundariesList.add(new HorizontalBoundary(
            width / 2,
            height / 4,
            100,
            Constants.DEFAULT_BOUNDARY_LINE_THICKNESS,
            true,
            this.isActive
        ));

        this.boundariesList.add(new HorizontalBoundary(
            width / 2,
            height / 6,
            100,
            Constants.DEFAULT_BOUNDARY_LINE_THICKNESS,
            false,
            this.isActive
        ));

        this.boundariesList.add(new HorizontalBoundary(
            width / 2,
            height / 8,
            100,
            Constants.DEFAULT_BOUNDARY_LINE_THICKNESS,
            true,
            this.isActive
        ));

        this.boundariesList.add(new VerticalBoundary(
            width / 2,
            height / 2,
            height / 2 - 100,
            Constants.DEFAULT_BOUNDARY_LINE_THICKNESS,
            this.isActive
        ));
    }

}