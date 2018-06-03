/**
 * Level one
 */
public class LevelOne extends ALevel implements IDrawable {

    /**
     * sets level properties, boundaries, and characters
     */
    LevelOne(boolean isLevelLoaded, int levelNumber) {
        super(isLevelLoaded, levelNumber);

        ViewBox viewBox = new ViewBox(0, 0);

        charactersList = new HashSet<ACharacter>();

        global_gravity = new PVector(0, Constants.GRAVITY);
        global_wall_slide_acceleration = new PVector(0, Constants.WALL_SLIDE_ACCELERATION);

        global_player = new Player(200, 0, Constants.PLAYER_DIAMETER, true); 

        // Enemy enemyOne = new Enemy(Constants.LEVEL_WIDTH - 500, 0, Constants.REGULAR_ENEMY_DIAMETER, false, false, true, true);
        // charactersList.add(enemyOne);

        Enemy enemyTwo = new Enemy(Constants.LEVEL_WIDTH - 500, 0, Constants.BIG_ENEMY_DIAMETER, false, false, true, true);
        charactersList.add(enemyTwo);

        HorizontalBoundary platform = new HorizontalBoundary(0, height - 200, 100, 1, true, true, this.levelNumber);
        HorizontalBoundary platform2 = new HorizontalBoundary(100, height - 400, 100, 1, true, true, this.levelNumber);
        HorizontalBoundary platform3 = new HorizontalBoundary(200, height - 600, 100, 1, false, true, this.levelNumber);
        HorizontalBoundary platform4 = new HorizontalBoundary(100, height - 800, 100, 1, true, true, this.levelNumber);

        HorizontalBoundary floor = new HorizontalBoundary(0, height - 100, Constants.LEVEL_WIDTH, 1, true, true, this.levelNumber);

        VerticalBoundary leftWall = new VerticalBoundary(0, 0, height - 100, 1, true, this.levelNumber);

        VerticalBoundary rightWall = new VerticalBoundary(Constants.LEVEL_WIDTH, 0, height - 100, 1, true, this.levelNumber);

        // HorizontalBoundary testPlat = new HorizontalBoundary(width / 2, height / 2, 100, 1, true, true, this.levelNumber);
        // HorizontalBoundary testPlat2 = new HorizontalBoundary(width / 2, height / 4, 100, 1, true, true, this.levelNumber);
        // HorizontalBoundary testPlat3 = new HorizontalBoundary(width / 2, height / 6, 100, 1, false, true, this.levelNumber);
        // HorizontalBoundary testPlat4 = new HorizontalBoundary(width / 2, height / 8, 100, 1, true, true, this.levelNumber);

        // Vert icalBoundary middleWall = new VerticalBoundary(width / 2, height / 2, height / 2 - 100, 1, true, this.levelNumber);
    }

}