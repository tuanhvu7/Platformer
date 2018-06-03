/**
 * Main sketch file
 */
import java.util.Set;
import java.util.HashSet;
import java.util.List;
import java.util.ArrayList;

// gravity that affects characters
PVector global_gravity;

// wall slide acceleration
PVector global_wall_slide_acceleration;

// background image
PImage backgroundImage;

// player controllable character
Player global_player;

// list of levels
List<ALevel> global_levels_list;


/**
 * setup canvas size with variable values
 */
void settings() {
    backgroundImage = loadImage(Constants.BACKGROUND_IMAGE_NAME);
    global_levels_list = new ArrayList<ALevel>();
    size(Constants.SCREEN_WIDTH, Constants.SCREEN_HEIGHT);
}

/**
 * runs once initialize program
 */
void setup() { 
    global_levels_list.add(new LevelOne(true, 1));
}

/**
 * runs continuously
 */
void draw() {

    // draw background image horizontally until level width is filled
    int levelWidthLeftToDraw = Constants.LEVEL_WIDTH;
    int numberHorizontalBackgroundIterations = 
        (int) Math.ceil( (double) Constants.LEVEL_WIDTH / backgroundImage.width);
    
    for(int i = 0; i < numberHorizontalBackgroundIterations; i++) {
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
