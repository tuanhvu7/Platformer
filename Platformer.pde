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

    ViewBox viewBox = new ViewBox(0, 0);

    global_characters_list = new HashSet<ACharacter>();

    global_gravity = new PVector(0, Constants.GRAVITY);
    global_wall_slide_acceleration = new PVector(0, Constants.WALL_SLIDE_ACCELERATION);

    global_player = new Player(200, 0, Constants.PLAYER_DIAMETER, true); 

    Enemy enemyOne = new Enemy(Constants.LEVEL_WIDTH - 500, 0, Constants.REGULAR_ENEMY_DIAMETER, false, false, true, true);
    global_characters_list.add(enemyOne);

    HorizontalBoundary platform = new HorizontalBoundary(0, height - 200, 100, 1, true, true);
    HorizontalBoundary platform2 = new HorizontalBoundary(100, height - 400, 100, 1, true, true);
    HorizontalBoundary platform3 = new HorizontalBoundary(200, height - 600, 100, 1, false, true);
    HorizontalBoundary platform4 = new HorizontalBoundary(100, height - 800, 100, 1, true, true);

    HorizontalBoundary floor = new HorizontalBoundary(0, height - 100, Constants.LEVEL_WIDTH, 1, true, true);

    VerticalBoundary leftWall = new VerticalBoundary(0, 0, height - 100, 1, true);

    VerticalBoundary rightWall = new VerticalBoundary(Constants.LEVEL_WIDTH, 0, height - 100, 1, true);

    // HorizontalBoundary testPlat = new HorizontalBoundary(width / 2, height / 2, 100, 1, true, true);
    // HorizontalBoundary testPlat2 = new HorizontalBoundary(width / 2, height / 4, 100, 1, true, true);
    // HorizontalBoundary testPlat3 = new HorizontalBoundary(width / 2, height / 6, 100, 1, false, true);
    // HorizontalBoundary testPlat4 = new HorizontalBoundary(width / 2, height / 8, 100, 1, true, true);

    // VerticalBoundary middleWall = new VerticalBoundary(width / 2, height / 2, height / 2 - 100, 1);
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

}
