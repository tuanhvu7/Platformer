/**
 * Main sketch file
 */
import java.util.Set;
import java.util.HashSet;

// gravity that affects characters
PVector global_gravity;

// wall slide acceleration
PVector global_wall_slide_acceleration;

// background image
PImage backgroundImage;

// player controllable character
Player global_player;

// list of non-player characters
Set<ACharacter> global_characters_list;

// viewbox
ViewBox global_view_box;

/**
 * setup canvas size with variable values
 */
void settings() {
    backgroundImage = loadImage(Constants.BACKGROUND_IMAGE_NAME);
    size(Constants.SCREEN_WIDTH, Constants.SCREEN_HEIGHT);
}

/**
 * runs once initialize program
 */
void setup() {

    global_view_box = new ViewBox(0, 0);
    registerMethod("draw", global_view_box);

    global_characters_list = new HashSet<ACharacter>();

    global_gravity = new PVector(0, Constants.GRAVITY);
    global_wall_slide_acceleration = new PVector(0, Constants.WALL_SLIDE_ACCELERATION);

    global_player = new Player(200, 0, Constants.PLAYER_DIAMETER); 
    registerMethod("draw", global_player);
    registerMethod("keyEvent", global_player);

    Enemy enemyOne = new Enemy(Constants.LEVEL_WIDTH - 500, 0, Constants.REGULAR_ENEMY_DIAMETER, false, false, true);
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

    HorizontalBoundary floor = new HorizontalBoundary(0, height - 100, Constants.LEVEL_WIDTH, 1, true);
    registerMethod("draw", floor);

    VerticalBoundary leftWall = new VerticalBoundary(0, 0, height - 100, 1);
    registerMethod("draw", leftWall);

    VerticalBoundary rightWall = new VerticalBoundary(Constants.LEVEL_WIDTH, 0, height - 100, 1);
    registerMethod("draw", rightWall);

    // HorizontalBoundary testPlat = new HorizontalBoundary(width / 2, height / 2, 100, 1, true);
    // registerMethod("draw", testPlat);
    // HorizontalBoundary testPlat2 = new HorizontalBoundary(width / 2, height / 4, 100, 1, true);
    // registerMethod("draw", testPlat2);
    // HorizontalBoundary testPlat3 = new HorizontalBoundary(width / 2, height / 6, 100, 1, false);
    // registerMethod("draw", testPlat3);
    // HorizontalBoundary testPlat4 = new HorizontalBoundary(width / 2, height / 8, 100, 1, true);
    // registerMethod("draw", testPlat4);

    // VerticalBoundary middleWall = new VerticalBoundary(width / 2, height / 2, height / 2 - 100, 1);
    // registerMethod("draw", middleWall);
}

/**
 * runs continuously
 */
void draw() {

    // draw background image horizontally until level width is filled
    int levelWidthLeftToDraw = Constants.LEVEL_WIDTH;
    int numberHorizontalBackgroundIterations = 
        (int) Math.ceil( (double) Constants.LEVEL_WIDTH / backgroundImage.width);
    
    for (int i = 0; i < numberHorizontalBackgroundIterations; i++) {
        int widthToDraw = 
        Math.min(
            backgroundImage.width, 
            levelWidthLeftToDraw);
        
        image(
            backgroundImage, 
            i * backgroundImage.width, 
            0, 
            widthToDraw, 
            backgroundImage.height);

        levelWidthLeftToDraw -= widthToDraw;
    }

    // move viewbox if necessary
    translate(-this.global_view_box.pos.x, -0);
}
