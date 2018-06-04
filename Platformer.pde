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

// list of levels
List<ALevel> global_levels_list;

// widths of all levels
final int[] global_levels_width_array = {
    1500,    // 5632 level one
    1000
};

// heights of all levels
final int[] global_levels_height_array = {
    900,    // level one
    900
};


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
    global_levels_list.add(new LevelTwo(false, 2));
}

/**
 * runs continuously
 */
void draw() { }

/**
 * return player of level at given index in global_levels_list
 */
private Player getPlayerAtLevelIndex(int levelIndex) {
    return global_levels_list.get(levelIndex).player;   // TODO: encapsulate
}

/**
 * return non-player characters of level at given index in global_levels_list
 */
private Set<ACharacter> getCharactersListAtLevelIndex(int levelIndex) {
    return global_levels_list.get(levelIndex).charactersList;   // TODO: encapsulate
}
