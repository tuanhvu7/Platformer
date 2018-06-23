/**
 * Level one
 */
public class LevelOne extends ALevel implements IDrawable {

    /**
     * sets properties, boundaries, and characters of this
     */
    LevelOne(boolean isActive, int levelNumber) {
        super(isActive, levelNumber);
    }

    /**
     * setup and activate this
     */
    void setUpActivateLevel() {
        this.makeActive();

        this.viewBox = new ViewBox(0, 0, this.levelIndex, this.isActive);
        this.player = new Player(200, 0, Constants.PLAYER_DIAMETER, this.isActive);

        loopSong(true);

        charactersList.add(new Enemy(
            global_levels_width_array[this.levelIndex] - 500,
            0,
            Constants.REGULAR_ENEMY_DIAMETER,
            false,
            false,
            true,
            this.levelIndex,
            this.isActive)
        );

        this.boundariesList.add(new HorizontalBoundary(
            0,
            height - 200,
            100,
            Constants.DEFAULT_BOUNDARY_LINE_THICKNESS,
            true,
            this.isActive,
            this.levelIndex
        ));

        this.boundariesList.add(new HorizontalBoundary(
            100,
            height - 400,
            100,
            Constants.DEFAULT_BOUNDARY_LINE_THICKNESS,
            true,
            this.isActive,
            this.levelIndex
        ));

        this.boundariesList.add(new HorizontalBoundary(
            200,
            height - 600,
            100,
            Constants.DEFAULT_BOUNDARY_LINE_THICKNESS,
            false,
            this.isActive,
            this.levelIndex
        ));

        this.boundariesList.add(new HorizontalBoundary(
            100,
            height - 800,
            100,
            Constants.DEFAULT_BOUNDARY_LINE_THICKNESS,
            true,
            this.isActive,
            this.levelIndex
        ));

        this.blocksList.add(new Block(
            global_levels_width_array[this.levelIndex] / 2 - 300,
            height - 300,
            Constants.DEFAULT_BLOCK_SIZE,
            Constants.DEFAULT_BLOCK_SIZE,
            Constants.DEFAULT_BOUNDARY_LINE_THICKNESS,
            this.isActive,
            this.levelIndex
        ));

        // stage floor
        this.boundariesList.add(new HorizontalBoundary(
            0,
            height - 100,
            global_levels_width_array[this.levelIndex],
            Constants.DEFAULT_BOUNDARY_LINE_THICKNESS,
            true,
            this.isActive,
            this.levelIndex
        ));

        // stage right and left walls
        this.boundariesList.add(new VerticalBoundary(
            0,
            0,
            height - 100,
            Constants.DEFAULT_BOUNDARY_LINE_THICKNESS,
            this.isActive,
            this.levelIndex
        ));

        this.boundariesList.add(new VerticalBoundary(
            global_levels_width_array[this.levelIndex],
            0,
            height - 100,
            Constants.DEFAULT_BOUNDARY_LINE_THICKNESS,
            this.isActive,
            this.levelIndex
        ));
    }

}
