/**
 * Main sketch file
 */
import java.util.Set;
import java.util.HashSet;

PVector global_gravity;
PVector global_wall_slide_acceleration;
Set<ACharacter> charactersList;

/**
 * setup canvas size with variable values
 */
void settings() {
    size(Constants.SCREEN_WIDTH, Constants.SCREEN_HEIGHT);
}

/**
 * runs once initialize program
 */
void setup() {

    background(Constants.SCREEN_BACKGROUND);

    charactersList = new HashSet<ACharacter>();

    global_gravity = new PVector(0, Constants.GRAVITY);
    global_wall_slide_acceleration = new PVector(0, Constants.WALL_SLIDE_ACCELERATION);

    Player player = new Player(width / 2, 0, Constants.PLAYER_RADIUS, Constants.PLAYER_RADIUS); 
    registerMethod("draw", player);
    registerMethod("keyEvent", player);
    charactersList.add(player);

    Enemy enemyOne = new Enemy(width - 100, 0, Constants.REGULAR_ENEMY_RADIUS, Constants.REGULAR_ENEMY_RADIUS, false, false, true);
    registerMethod("draw", enemyOne);
    charactersList.add(enemyOne);

    // HorizontalBoundary platform = new HorizontalBoundary(width / 2, height / 2, 100, 1, true);
    // registerMethod("draw", platform);
    // HorizontalBoundary platform2 = new HorizontalBoundary(width / 2, height / 4, 100, 1, true);
    // registerMethod("draw", platform2);
    // HorizontalBoundary platform3 = new HorizontalBoundary(width / 2, height / 6, 100, 1, false);
    // registerMethod("draw", platform3);
    // HorizontalBoundary platform4 = new HorizontalBoundary(width / 2, height / 8, 100, 1, true);
    // registerMethod("draw", platform4);

    HorizontalBoundary floor = new HorizontalBoundary(0, height - 100, width - 100, 1, true);
    registerMethod("draw", floor);

    VerticalBoundary leftWall = new VerticalBoundary(0, 0, height - 100, 1);
    registerMethod("draw", leftWall);
}

/**
 * runs continuously
 */
void draw() {
    background(Constants.SCREEN_BACKGROUND);
}
