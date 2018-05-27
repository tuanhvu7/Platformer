/**
 * Main sketch file
 */
import java.util.Set;
import java.util.HashSet;

// gravity that affects characters
PVector global_gravity;

// wall slide acceleration
PVector global_wall_slide_acceleration;

// player controllable character
Player global_player;

// list of non-player characters
Set<ACharacter> global_characters_list;

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

    global_characters_list = new HashSet<ACharacter>();

    global_gravity = new PVector(0, Constants.GRAVITY);
    global_wall_slide_acceleration = new PVector(0, Constants.WALL_SLIDE_ACCELERATION);

    global_player = new Player(width / 2, 0, Constants.PLAYER_DIAMETER); 
    registerMethod("draw", global_player);
    registerMethod("keyEvent", global_player);

    Enemy enemyOne = new Enemy(width - 100, 0, Constants.REGULAR_ENEMY_DIAMETER, false, false, true);
    registerMethod("draw", enemyOne);
    global_characters_list.add(enemyOne);

    HorizontalBoundary platform = new HorizontalBoundary(0, height - 200, 100, 1, true);
    registerMethod("draw", platform);
    HorizontalBoundary platform2 = new HorizontalBoundary(100, height - 400, 100, 1, true);
    registerMethod("draw", platform2);
    HorizontalBoundary platform3 = new HorizontalBoundary(200, height - 600, 100, 1, false);
    registerMethod("draw", platform3);
    HorizontalBoundary platform4 = new HorizontalBoundary(100, height - 800, 100, 1, true);
    registerMethod("draw", platform4);

    HorizontalBoundary floor = new HorizontalBoundary(0, height - 100, width - 100, 1, true);
    registerMethod("draw", floor);

    VerticalBoundary leftWall = new VerticalBoundary(0, 0, height - 100, 1);
    registerMethod("draw", leftWall);

    // VerticalBoundary middleWall = new VerticalBoundary(width / 2, height / 2, height / 2 - 100, 1);
    // registerMethod("draw", middleWall);
}

/**
 * runs continuously
 */
void draw() {
    background(Constants.SCREEN_BACKGROUND);
}
