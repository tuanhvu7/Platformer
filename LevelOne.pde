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
     * setup and activate level
     */
    void setUpActivateLevel() {
        // make this active
        this.isActive = true;
        registerMethod("draw", this); // connect this draw() from main draw()

        this.viewBox = new ViewBox(0, 0, this.levelIndex, this.isActive);
        this.player = new Player(200, 0, Constants.PLAYER_DIAMETER, this.isActive);

        loopSong();

        charactersList.add( new Enemy(
            global_levels_width_array[this.levelIndex] - 500,
            0,
            Constants.BIG_ENEMY_DIAMETER,
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
            1,
            true,
            this.isActive,
            this.levelIndex
        ));

        this.boundariesList.add(new HorizontalBoundary(
            100,
            height - 400,
            100,
            1,
            true,
            this.isActive,
            this.levelIndex
        ));

        this.boundariesList.add(new HorizontalBoundary(
            200,
            height - 600,
            100,
            1,
            false,
            this.isActive,
            this.levelIndex
        ));

        this.boundariesList.add(new HorizontalBoundary(
            100,
            height - 800,
            100,
            1,
            true,
            this.isActive,
            this.levelIndex
        ));

        // stage floor
        this.boundariesList.add(new HorizontalBoundary(
            0,
            height - 100,
            global_levels_width_array[this.levelIndex],
            1,
            true,
            this.isActive,
            this.levelIndex
        ));

        // stage right and left walls
        this.boundariesList.add(new VerticalBoundary(
            0,
            0,
            height - 100,
            1,
            this.isActive,
            this.levelIndex
        ));

        this.boundariesList.add(new VerticalBoundary(
            global_levels_width_array[this.levelIndex],
            0,
            height - 100,
            1,
            this.isActive,
            this.levelIndex
        ));
    }

}
