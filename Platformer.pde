/**
 * Main sketch file
 */
import java.util.Set;
import java.util.HashSet;
import java.util.List;
import java.util.ArrayList;
import java.lang.ref.WeakReference;

import ddf.minim.*;
import ddf.minim.AudioPlayer;
import ddf.minim.AudioInput;

// gravity that affects characters
PVector global_gravity;

// wall slide acceleration
PVector global_wall_slide_acceleration;

// background image
PImage backgroundImage;

// for loading song files
Minim global_minim;

// song for level
AudioPlayer global_song_player;

// list of levels
List< WeakReference<ALevel> > global_levels_list;

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
    global_levels_list = new ArrayList< WeakReference<ALevel> >();

    global_gravity = new PVector(0, Constants.GRAVITY);
    global_wall_slide_acceleration = new PVector(0, Constants.WALL_SLIDE_ACCELERATION);
    
    global_minim = new Minim(this);
    global_song_player = global_minim.loadFile(dataPath(Constants.LEVEL_SONG_NAME));

    size(Constants.SCREEN_WIDTH, Constants.SCREEN_HEIGHT);
}

/**
 * runs once initialize program
 */
void setup() { 
    global_levels_list.add(new WeakReference(new LevelOne(true, 1)));
    global_levels_list.get(0).get().setUpLevel();
    // global_levels_list.add(new LevelTwo(false, 2));
}

/**
 * runs continuously
 */
void draw() { }

/**
 * reset level
 */
void resetLevel() {
    stopLevelSong();
    loadPlayerDeathSong();
    playSong();

    // to reset level after player death song finishes without freezing game
    new Thread( new Runnable() {
        public void run()  {
            try  { 
                global_levels_list.get(0).get().player.makeNotActive(); // TODO: encapsulate
                Thread.sleep( global_song_player.getMetaData().length() );  // wait for player death song duration
            }
            catch (InterruptedException ie)  { }
            
            loadLevelSong();

            global_levels_list.get(0).get().deactivateLevel();
            global_levels_list.set(0, new WeakReference(new LevelOne(true, 1)));
            global_levels_list.get(0).get().setUpLevel();
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
 * play death song
 */
private void loadLevelSong() {
    global_song_player = global_minim.loadFile(dataPath(Constants.LEVEL_SONG_NAME));
}

/**
 * play death song
 */
private void loadPlayerDeathSong() {
    global_song_player = global_minim.loadFile(dataPath(Constants.PLAYER_DEATH_SONG_NAME));
}

/**
 * stop level song
 */
private void stopLevelSong() {
    global_song_player.close();
}
