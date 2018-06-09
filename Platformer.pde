/**
 * Main sketch file
 */
import java.util.Set;
import java.util.HashSet;
import java.util.List;
import java.util.ArrayList;
import java.lang.ref.WeakReference;

import ddf.minim.Minim;
import ddf.minim.AudioPlayer;
import ddf.minim.AudioInput;

// gravity that affects characters
PVector global_gravity;

// wall slide acceleration
PVector global_wall_slide_acceleration;

// background image
PImage global_background_image;

// for loading song files
Minim global_minim;

// song for level
AudioPlayer global_song_player;

LevelSelectMenu global_level_select_menu;

// list of levels
List< WeakReference<ALevel> > global_levels_list;

// stores currently active level
int global_current_active_level;

// widths of all levels
final int[] global_levels_width_array = {
    0,          // non-existent level zero
    1500,       // 5632 level one
    1000
};

// heights of all levels
final int[] global_levels_height_array = {
    0,      // non-existent level zero
    900,    // level one
    900
};

/**
 * setup canvas size with variable values and initialize fields
 */
void settings() {
    global_background_image = loadImage(Constants.BACKGROUND_IMAGE_NAME);
    global_levels_list = new ArrayList< WeakReference<ALevel> >();

    global_gravity = new PVector(0, Constants.GRAVITY);
    global_wall_slide_acceleration = new PVector(0, Constants.WALL_SLIDE_ACCELERATION);
    
    global_minim = new Minim(this);
    global_song_player = global_minim.loadFile(dataPath(Constants.LEVEL_SONG_NAME));

    global_current_active_level = 0;

    size(Constants.SCREEN_WIDTH, Constants.SCREEN_HEIGHT);
}

/**
 * runs once initialize program
 */
void setup() {

    global_level_select_menu = new LevelSelectMenu(true);

    global_levels_list.add(new WeakReference(null)); // no level zero
    global_levels_list.add(new WeakReference(new LevelOne(false, 1)));
    global_levels_list.add(new WeakReference(new LevelTwo(false, 2)));
}

/**
 * runs continuously
 */
void draw() { }

/**
 * reset level
 */
private void resetLevel() {
    stopSong();
    loadPlayerDeathSong();
    playSong();

    // to reset level after player death song finishes without freezing game
    new Thread( new Runnable() {
        public void run()  {
            try  { 
                global_levels_list.get(global_current_active_level).get().player.makeNotActive(); // TODO: encapsulate
                Thread.sleep( global_song_player.getMetaData().length() );  // wait for player death song duration
            }
            catch (InterruptedException ie)  { }
            
            loadLevelSong();

            global_levels_list.get(global_current_active_level).get().deactivateLevel();
            global_levels_list.get(global_current_active_level).get().setUpActivateLevel();
        }
    } ).start();

}

/**
 * return player of level at given index in global_levels_list
 */
private Player getPlayerAtLevelIndex(int levelIndex) {
    return global_levels_list.get(levelIndex).get().player;   // TODO: encapsulate
}

/**
 * return non-player characters of level at given index in global_levels_list
 */
private Set<ACharacter> getCharactersListAtLevelIndex(int levelIndex) {
    return global_levels_list.get(levelIndex).get().charactersList;   // TODO: encapsulate
}

/**
 * loop song
 */
private void loopSong() {
    global_song_player.loop();
}

/**
 * play song
 */
private void playSong() {
    global_song_player.play();
}

/**
 * load death song
 */
private void loadLevelSong() {
    global_song_player = global_minim.loadFile(dataPath(Constants.LEVEL_SONG_NAME));
}

/**
 * load death song
 */
private void loadPlayerDeathSong() {
    global_song_player = global_minim.loadFile(dataPath(Constants.PLAYER_DEATH_SONG_NAME));
}

/**
 * stop song
 */
private void stopSong() {
    global_song_player.close();
}
