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
private Media global_level_song;
// player for level song
private MediaPlayer global_level_song_player;

// player death song
private Media global_player_death_song;
// player for player death song
private MediaPlayer global_player_death_song_player;

// level complete song
private Media global_level_complete_song;
// player for level complete song
private MediaPlayer global_level_complete_song_player;

// player action 
private Media global_player_action_song;
// player for player action 
private MediaPlayer global_player_action_song_player;

// event block descent song
private Media global_event_block_descent_song;
// player for event block descent song
private MediaPlayer global_event_block_descent_song_player;

// level complete thread
private WeakReference<Thread> global_level_complete_thread;

/*** LEVEL ***/
// level select menu
private LevelSelectMenu global_level_select_menu;

/*** MUSIC ***/
// stores current active level
private WeakReference<ALevel> global_current_active_level;

// stores currently active level number
private int global_current_active_level_number;

// widths of all levels
private final int[] global_levels_width_array = {
    0,          // non-existent level zero
    1500,       // 5632 level one
    1000
};

// heights of all levels
private final int[] global_levels_height_array = {
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
    global_level_complete_song = new Media(convertPathToValidUri(dataPath(Constants.LEVEL_COMPLETE_SONG_NAME)));
    global_player_action_song = new Media(convertPathToValidUri(dataPath(Constants.PLAYER_ACTION_SOUND_NAME)));
    global_event_block_descent_song = new Media(convertPathToValidUri(dataPath(Constants.EVENT_BLOCK_DESCENT_SOUND_NAME)));

    global_level_song_player = new MediaPlayer(global_level_song);
    global_player_death_song_player = new MediaPlayer(global_player_death_song);
    global_level_complete_song_player = new MediaPlayer(global_level_complete_song);
    global_player_action_song_player = new MediaPlayer(global_player_action_song);
    global_event_block_descent_song_player = new MediaPlayer(global_event_block_descent_song);

    global_current_active_level_number = 0;

    size(Constants.SCREEN_WIDTH, Constants.SCREEN_HEIGHT);
    global_level_select_menu = new LevelSelectMenu(true);
}

/**
 * runs continuously; need this to run draw() for levels
 */
void draw() { }

/**
 * reset level
 */
private void resetLevel() {
    stopSong();
    playSong(ESongType.PlayerDeath);

    // to reset level after player death song finishes without freezing game
    new Thread( new Runnable() {
        public void run()  {
            try  {
                println("running reset level thread!!!");
                if(global_level_complete_thread != null) {
                    global_level_complete_thread.get().interrupt();
                }
                getCurrentActivePlayer().makeNotActive();
                Thread.sleep( (long) global_player_death_song.getDuration().toMillis() );  // wait for song duration
                
                boolean loadPlayerFromCheckPoint = global_current_active_level.get().loadPlayerFromCheckPoint;    // TODO: encapsulate
                global_current_active_level.get().deactivateLevel();
                LevelFactory levelFactory = new LevelFactory();
                global_current_active_level = new WeakReference( levelFactory.getLevel(true, loadPlayerFromCheckPoint) );
            }
            catch (InterruptedException ie)  { }
        }
    } ).start();

}

/**
 * complete level
 */
private void handleLevelComplete() {
    stopSong();
    playSong(ESongType.LevelComplete);

    global_level_complete_thread = new WeakReference(
        new Thread( new Runnable() {
            public void run()  {
                try  {
                    println("running level complete thread!!!");
                    global_current_active_level.get().isHandlingLevelComplete = true;    // TODO: encapsulate
                    getCurrentActivePlayer().resetControlPressed();
                    getCurrentActivePlayer().setVel(new PVector(Constants.PLAYER_LEVEL_COMPLETE_SPEED, 0));
                    unregisterMethod("keyEvent", getCurrentActivePlayer()); // disconnect this keyEvent() from main keyEvent()
                    
                    Thread.sleep( (long) global_level_complete_song.getDuration().toMillis() );  // wait for song duration
                    getCurrentActivePlayer().makeNotActive();
                    global_current_active_level.get().deactivateLevel();
                    global_current_active_level_number = 0;
                    global_level_select_menu.setupActivateMenu();
                }
                catch (InterruptedException ie)  { }
            }
        } )
    );
    global_level_complete_thread.get().start();
}

/*** getters and setters ***/
public LevelSelectMenu getLevelSelectMenu() {
    return global_level_select_menu;
}

public ALevel getCurrentActiveLevel() {
    return global_current_active_level.get();
}

public void setCurrentActiveLevel(ALevel currentActiveLevel) {
    global_current_active_level = new WeakReference<ALevel>(currentActiveLevel);
}

public int getCurrentActiveLevelNumber() {
    return global_current_active_level_number;
}

public void setCurrentActiveLevelNumber(int currentActiveLevelNumber) {
    global_current_active_level_number = currentActiveLevelNumber;
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
 * return blocks of current active level
 */
private Set<ABlock> getCurrentActiveBlocksList() {
    return global_current_active_level.get().blocksList;    // TODO: encapsulate
}

/**
 * return collectables of current active level
 */
private Set<ACollectable> getCurrentActiveLevelCollectables() {
    return global_current_active_level.get().collectablesList;    // TODO: encapsulate
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
 */
private void loopSong(ESongType songType) {
    switch(songType) {
        case Level:
            global_level_song_player.setCycleCount(Integer.MAX_VALUE);
            global_level_song_player.play();
        break;

        default:    
        break;	
    }
}

/**
 * play song
 */
private void playSong(ESongType songType) {
    switch(songType) {
        case PlayerDeath:
            global_player_death_song_player.setCycleCount(1);
            global_player_death_song_player.play();
        break;

        case LevelComplete:
            global_level_complete_song_player.setCycleCount(1);
            global_level_complete_song_player.play();
        break;

        case PlayerAction:
            // to reset level after player death song finishes without freezing game
            new Thread( new Runnable() {
                public void run()  {
                    try  {
                        global_player_action_song_player.setCycleCount(1);
                        global_player_action_song_player.play();
                        Thread.sleep( (long) global_player_action_song.getDuration().toMillis() );  // wait for song duration
                        global_player_action_song_player.stop();
                    }
                    catch (InterruptedException ie)  { }
                }
            } ).start();
        break;

        case EventBlockDescent:
            // to reset level after player death song finishes without freezing game
            new Thread( new Runnable() {
                public void run()  {
                    try  {
                        global_event_block_descent_song_player.setCycleCount(1);
                        global_event_block_descent_song_player.play();
                        Thread.sleep( (long) global_event_block_descent_song.getDuration().toMillis() );  // wait for song duration
                        global_event_block_descent_song_player.stop();
                    }
                    catch (InterruptedException ie)  { }
                }
            } ).start();
        break;

        default:    
        break;	
    }
}

/**
 * stop song
 */
private void stopSong() {
    global_level_song_player.stop();
    global_player_death_song_player.stop();
    global_level_complete_song_player.stop();
    global_player_action_song_player.stop();
    global_event_block_descent_song_player.stop();
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
