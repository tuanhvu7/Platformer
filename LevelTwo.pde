/**
 * Level two
 */
public class LevelTwo extends ALevel implements IDrawable {

    /**
     * sets properties, boundaries, and characters of this
     */
    LevelTwo(boolean isActive, boolean loadPlayerFromCheckPoint) {
        super(isActive, loadPlayerFromCheckPoint);
    }

    /**
     * setup and activate this
     */
    void setUpActivateLevel() {
        this.makeActive();

        this.viewBox = new ViewBox(0, 0, this.isActive);
        this.player = new Player(200, 0, Constants.PLAYER_DIAMETER, this.isActive);

        loopSong(true);

        charactersList.add( new Enemy(
            getCurrentActiveLevelWidth() - 500,
            0,
            Constants.BIG_ENEMY_DIAMETER,
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
