/**
 * Level one
 */
public class LevelOne extends ALevel implements IDrawable {

    /**
     * sets level properties, boundaries, and characters
     */
    LevelOne(boolean isLevelLoaded, int levelNumber) {
        super(isLevelLoaded, levelNumber);
    }

    /**
     * setup level
     */
    void setUpLevel() {
        this.makeActive();

        this.viewBox = new ViewBox(0, 0, this.levelIndex, this.isLevelLoaded);

        this.player = new Player(200, 0, Constants.PLAYER_DIAMETER, this.isLevelLoaded);

        loopSong();

        charactersList.add( new Enemy(
            global_levels_width_array[this.levelIndex] - 500,
            0,
            Constants.BIG_ENEMY_DIAMETER,
            false,
            false,
            true,
            this.levelIndex,
            this.isLevelLoaded)
        );

        this.boundariesList.add(new HorizontalBoundary(
            0,
            height - 200,
            100,
            1,
            true,
            this.isLevelLoaded,
            this.levelIndex
        ));

        this.boundariesList.add(new HorizontalBoundary(
            100,
            height - 400,
            100,
            1,
            true,
            this.isLevelLoaded,
            this.levelIndex
        ));

        this.boundariesList.add(new HorizontalBoundary(
            200,
            height - 600,
            100,
            1,
            false,
            this.isLevelLoaded,
            this.levelIndex
        ));

        this.boundariesList.add(new HorizontalBoundary(
            100,
            height - 800,
            100,
            1,
            true,
            this.isLevelLoaded,
            this.levelIndex
        ));

        // stage floor
        this.boundariesList.add(new HorizontalBoundary(
            0,
            height - 100,
            global_levels_width_array[this.levelIndex],
            1,
            true,
            this.isLevelLoaded,
            this.levelIndex
        ));

        // stage right and left walls
        this.boundariesList.add(new VerticalBoundary(
            0,
            0,
            height - 100,
            1,
            this.isLevelLoaded,
            this.levelIndex
        ));

        this.boundariesList.add(new VerticalBoundary(
            global_levels_width_array[this.levelIndex],
            0,
            height - 100,
            1,
            this.isLevelLoaded,
            this.levelIndex
        ));
    }

}
