/**
 * Level two
 */
public class LevelTwo extends ALevel implements IDrawable {

    /**
     * sets level properties, boundaries, and characters
     */
    LevelTwo(boolean isLevelLoaded, int levelNumber) {
        super(isLevelLoaded, levelNumber);

        ViewBox viewBox = new ViewBox(0, 0, this.levelIndex, this.isLevelLoaded);

        charactersList = new HashSet<ACharacter>();

        this.player = new Player(200, 0, Constants.PLAYER_DIAMETER, this.isLevelLoaded);

        loopSong();

        charactersList.add(new Enemy(
            global_levels_width_array[this.levelIndex] - 500,
            0,
            Constants.REGULAR_ENEMY_DIAMETER,
            false,
            false,
            true,
            this.levelIndex,
            this.isLevelLoaded)
        );

        HorizontalBoundary testPlat = new HorizontalBoundary(
            width / 2,
            height / 2,
            100,
            1,
            true,
            this.isLevelLoaded,
            this.levelIndex
        );

        HorizontalBoundary testPlat2 = new HorizontalBoundary(
            width / 2,
            height / 4,
            100,
            1,
            true,
            this.isLevelLoaded,
            this.levelIndex
        );
            
        HorizontalBoundary testPlat3 = new HorizontalBoundary(
            width / 2,
            height / 6,
            100,
            1,
            false,
            this.isLevelLoaded,
            this.levelIndex
        );

        HorizontalBoundary testPlat4 = new HorizontalBoundary(
            width / 2,
            height / 8,
            100,
            1,
            true,
            this.isLevelLoaded,
            this.levelIndex
        );

        HorizontalBoundary floor = new HorizontalBoundary(
            0,
            height - 100,
            global_levels_width_array[this.levelIndex],
            1,
            true,
            this.isLevelLoaded,
            this.levelIndex
        );

        VerticalBoundary leftWall = new VerticalBoundary(
            0,
            0,
            height - 100,
            1,
            this.isLevelLoaded,
            this.levelIndex
        );

        VerticalBoundary rightWall = new VerticalBoundary(
            global_levels_width_array[this.levelIndex],
            0,
            height - 100,
            1,
            this.isLevelLoaded,
            this.levelIndex
        );

        // VerticalBoundary middleWall = new VerticalBoundary(width / 2, height / 2, height / 2 - 100, 1, this.isLevelLoaded, this.levelIndex);
    }

}