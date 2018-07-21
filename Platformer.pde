/**
 * Main sketch file
 */
import java.util.Set;
import java.util.HashSet;
import java.util.List;
import java.util.ArrayList;
import java.lang.ref.WeakReference;
import java.util.Optional;

import javafx.scene.media.Media;
import javafx.scene.media.MediaPlayer;
import javafx.util.Duration;
import javafx.embed.swing.JFXPanel;

// gravity that affects characters
PVector global_gravity;

// wall slide acceleration
PVector global_wall_slide_acceleration;

// background image
PImage global_background_image;

/*** MUSIC ***/
// level song
Media global_level_song;
// player for level song
MediaPlayer global_level_song_player;

// player death song
Media global_player_death_song;
// player for level song
MediaPlayer global_player_death_song_player;


/*** LEVEL ***/
// level select menu
LevelSelectMenu global_level_select_menu;

/*** MUSIC ***/
// stores current active level
WeakReference<ALevel> global_current_active_level;

// stores currently active level number
int global_current_active_level_number;

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
 * runs once;
 * setup canvas size with variable values and initialize fields
 */
void settings() {
    global_background_image = loadImage(Constants.BACKGROUND_IMAGE_NAME);

    global_gravity = new PVector(0, Constants.GRAVITY);
    global_wall_slide_acceleration = new PVector(0, Constants.WALL_SLIDE_ACCELERATION);
    
    new JFXPanel(); // initialize JavaFx toolkit
    global_level_song = new Media(convertPathToValidUri(dataPath(Constants.LEVEL_SONG_NAME)));
    global_player_death_song = new Media(convertPathToValidUri(dataPath(Constants.PLAYER_DEATH_SONG_NAME)));
    
    global_level_song_player = new MediaPlayer(global_level_song);
    global_player_death_song_player = new MediaPlayer(global_player_death_song);

    global_current_active_level_number = 0;

    size(Constants.SCREEN_WIDTH, Constants.SCREEN_HEIGHT);
    global_level_select_menu = new LevelSelectMenu(true);
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
    playSong(false);

    // to reset level after player death song finishes without freezing game
    new Thread( new Runnable() {
        public void run()  {
            try  {
                getCurrentActivePlayer().makeNotActive(); // TODO: encapsulate
                Thread.sleep( (long) global_player_death_song.getDuration().toMillis() );  // wait for player death song duration
            }
            catch (InterruptedException ie)  { }
            
            global_current_active_level.get().deactivateLevel();
            LevelFactory levelFactory = new LevelFactory();
            global_current_active_level = new WeakReference(levelFactory.getLevel(true));
        }
    } ).start();

}

/**
 * return player of current active level
 */
private Player getCurrentActivePlayer() {
    return global_current_active_level.get().player;    // TODO: encapsulate
}

/**
 * return non-player characters of current active level
 */
private Set<ACharacter> getCurrentActiveCharactersList() {
    return global_current_active_level.get().charactersList;    // TODO: encapsulate
}

/**
 * return viewbox of current active level
 */
private ViewBox getCurrentActiveViewBox() {
    return global_current_active_level.get().viewBox; // TODO: encapsulate
}

/**
 * return width of current active level
 */
private int getCurrentActiveLevelWidth() {
    return global_levels_width_array[global_current_active_level_number];
}

/**
 * loop song
 * true isLevelSong - level song
 * false isLevelSong - player death song
 */
private void loopSong(boolean isLevelSong) {
    if(isLevelSong) {
        global_level_song_player.setCycleCount(Integer.MAX_VALUE);
        global_level_song_player.play();
    } else {
        global_player_death_song_player.setCycleCount(Integer.MAX_VALUE);
        global_player_death_song_player.play();  
    }
}

/**
 * play song
 * true isLevelSong - level song
 * false isLevelSong - player death song
 */
private void playSong(boolean isLevelSong) {
    if(isLevelSong) {
        global_level_song_player.setCycleCount(1);
        global_level_song_player.play();
    } else {
        global_player_death_song_player.setCycleCount(1);
        global_player_death_song_player.play();  
    }
}

/**
 * stop song
 */
private void stopSong() {
    global_level_song_player.stop();
    global_player_death_song_player.stop();
}

/**
 * convert given string to valid uri path and return result
 */
private String convertPathToValidUri(String path) {
    return path
        .replace(" ", "%20")            // space is illegal character
        .replace("\\", "/")             // back-slash illegal character
        .replace("C:/", "file:///C:/"); // prevent unsupported protocol c
}
