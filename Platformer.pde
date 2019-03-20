/**
 * Main sketch file
 */
import java.util.Set;
import java.util.HashSet;
import java.util.List;
import java.util.ArrayList;
import java.lang.ref.WeakReference;
import java.util.Optional;
import java.net.URI;

import javafx.scene.media.Media;
import javafx.scene.media.MediaPlayer;
import javafx.util.Duration;
import javafx.embed.swing.JFXPanel;

// gravity that affects characters
private PVector gravity;

// wall slide acceleration
private PVector wallSlideAcceleration;

// background image
private PImage levelBackgroundImage;

/*** MUSIC ***/
// level select menu song
private Media levelSelectMenuSong;
// player for level select menu song
private MediaPlayer levelSelectMenuSongPlayer;

// level song
private Media levelSong;
// player for level song
private MediaPlayer levelSongPlayer;

// player death song
private Media playerDeathSong;
// player for player death song
private MediaPlayer playerDeathSongPlayer;

// level complete song
private Media levelCompleteSong;
// player for level complete song
private MediaPlayer levelCompleteSongPlayer;

// player action 
private Media playerActionSong;
// player for player action 
private MediaPlayer playerActionSongPlayer;

// player damage 
private Media playerDamageSong;
// player for player damage 
private MediaPlayer playerDamageSongPlayer;

// event block descent song
private Media eventBlockDescentSong;
// player for event block descent song
private MediaPlayer eventBlockDescentSongPlayer;

// level complete thread
Thread levelCompleteThread;

/*** LEVEL ***/
// level select menu
private LevelSelectMenu levelSelectMenu;

/*** MUSIC ***/
// stores current active level
private WeakReference<ALevel> currentActiveLevel;

// stores currently active level number
private int currentActiveLevelNumber;

// widths of all levels
private final int[] levelsWidthArray = {
    0,          // non-existent level zero
    8750,
    12000
};

// heights of all levels
private final int[] levelsHeightArray = {
    0,      // non-existent level zero
    900,    // level one
    1300
};

/**
 * runs once;
 * setup canvas size with variable values and initialize fields
 */
void settings() {
    levelBackgroundImage = loadImage(Constants.BACKGROUND_IMAGE_NAME);

    gravity = new PVector(0, Constants.GRAVITY);
    wallSlideAcceleration = new PVector(0, Constants.WALL_SLIDE_ACCELERATION);
    
    new JFXPanel(); // initialize JavaFx toolkit
    // set song files
    levelSelectMenuSong = new Media(convertPathToValidUri(dataPath(Constants.LEVEL_SELECT_MENU_SONG_NAME)));
    levelSong = new Media(convertPathToValidUri(dataPath(Constants.LEVEL_SONG_NAME)));
    playerDeathSong = new Media(convertPathToValidUri(dataPath(Constants.PLAYER_DEATH_SONG_NAME)));
    levelCompleteSong = new Media(convertPathToValidUri(dataPath(Constants.LEVEL_COMPLETE_SONG_NAME)));
    playerActionSong = new Media(convertPathToValidUri(dataPath(Constants.PLAYER_ACTION_SOUND_NAME)));
    playerDamageSong = new Media(convertPathToValidUri(dataPath(Constants.PLAYER_DAMAGE_SOUND_NAME)));
    eventBlockDescentSong = new Media(convertPathToValidUri(dataPath(Constants.EVENT_BLOCK_DESCENT_SOUND_NAME)));
    // set song players
    levelSelectMenuSongPlayer = new MediaPlayer(levelSelectMenuSong);
    levelSongPlayer = new MediaPlayer(levelSong);
    playerDeathSongPlayer = new MediaPlayer(playerDeathSong);
    levelCompleteSongPlayer = new MediaPlayer(levelCompleteSong);
    playerActionSongPlayer = new MediaPlayer(playerActionSong);
    playerDamageSongPlayer = new MediaPlayer(playerDamageSong);
    eventBlockDescentSongPlayer = new MediaPlayer(eventBlockDescentSong);

    currentActiveLevelNumber = 0;

    size(Constants.SCREEN_WIDTH, Constants.SCREEN_HEIGHT);
    levelSelectMenu = new LevelSelectMenu(true);
}

/**
 * runs continuously; need this to run draw() for levels
 */
void draw() { }

/**
 * reset level
 */
private void resetLevel() {
    // to reset level after player death song finishes without freezing game
    new Thread( new Runnable() {
        public void run()  {
            try  {
                if (levelCompleteThread != null) {
                    levelCompleteThread.interrupt();
                    levelCompleteThread = null;
                }

                getCurrentActivePlayer().makeNotActive();
                currentActiveLevel.get().setPlayer(null);  // to stop interactions with player

                stopSong();
                playSong(ESongType.PLAYER_DEATH);
                Thread.sleep( (long) playerDeathSong.getDuration().toMillis() );  // wait for song duration

                boolean loadPlayerFromCheckPoint = getCurrentActiveLevel().isLoadPlayerFromCheckPoint();
                getCurrentActiveLevel().deactivateLevel();
                LevelFactory levelFactory = new LevelFactory();
                currentActiveLevel = new WeakReference(levelFactory.getLevel(true, loadPlayerFromCheckPoint));
            }
            catch (InterruptedException ie)  { }
        }
    } ).start();

}

/**
 * complete level
 */
private void handleLevelComplete() {
    levelCompleteThread =
        new Thread(new Runnable() {
            public void run()  {
                try  {
                    // println("running level complete thread!!!");
                    currentActiveLevel.get().isHandlingLevelComplete = true;    // TODO: encapsulate
                    getCurrentActivePlayer().resetControlPressed();
                    getCurrentActivePlayer().setVel(new PVector(Constants.PLAYER_LEVEL_COMPLETE_SPEED, 0));
                    unregisterMethod("keyEvent", getCurrentActivePlayer()); // disconnect this keyEvent() from main keyEvent()
                    
                    stopSong();
                    playSong(ESongType.LEVEL_COMPLETE);
                    Thread.sleep( (long) levelCompleteSong.getDuration().toMillis() );  // wait for song duration
                    
                    getCurrentActivePlayer().makeNotActive();
                    currentActiveLevel.get().deactivateLevel();
                    currentActiveLevelNumber = 0;
                    levelSelectMenu.setupActivateMenu();
                } catch (InterruptedException ie)  { }
            }
        });
    levelCompleteThread.start();
}

/**
 * loop song
 */
private void loopSong(ESongType songType) {
    switch(songType) {
        case LEVEL_SELECT_MENU:
            levelSelectMenuSongPlayer.setCycleCount(Integer.MAX_VALUE);
            levelSelectMenuSongPlayer.play();
        break;

        case LEVEL:
            levelSongPlayer.setCycleCount(Integer.MAX_VALUE);
            levelSongPlayer.play();
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
        case PLAYER_DEATH:
            playerDeathSongPlayer.setCycleCount(1);
            playerDeathSongPlayer.play();
        break;

        case LEVEL_COMPLETE:
            levelCompleteSongPlayer.setCycleCount(1);
            levelCompleteSongPlayer.play();
        break;

        case PLAYER_DAMAGE:
            // to player damage song in parallel with level song
            new Thread( new Runnable() {
                public void run() {
                    try {
                        playerDamageSongPlayer.setCycleCount(1);
                        playerDamageSongPlayer.play();
                        Thread.sleep((long) playerDamageSong.getDuration().toMillis());  // wait for song duration
                        playerDamageSongPlayer.stop();
                    } catch (InterruptedException ie) { }
                }
            }).start();
            break;

        case PLAYER_ACTION:
            // to reset level after player death song finishes without freezing game
            new Thread( new Runnable() {
                public void run()  {
                    try  {
                        playerActionSongPlayer.setCycleCount(1);
                        playerActionSongPlayer.play();
                        Thread.sleep( (long) playerActionSong.getDuration().toMillis() );  // wait for song duration
                        playerActionSongPlayer.stop();
                    }
                    catch (InterruptedException ie)  { }
                }
            } ).start();
        break;

        case EVENT_BLOCK_DESCENT:
            // to reset level after player death song finishes without freezing game
            new Thread( new Runnable() {
                public void run()  {
                    try  {
                        eventBlockDescentSongPlayer.setCycleCount(1);
                        eventBlockDescentSongPlayer.play();
                        Thread.sleep( (long) eventBlockDescentSong.getDuration().toMillis() );  // wait for song duration
                        eventBlockDescentSongPlayer.stop();
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
    levelSelectMenuSongPlayer.stop();
    levelSongPlayer.stop();
    playerDeathSongPlayer.stop();
    levelCompleteSongPlayer.stop();
    playerActionSongPlayer.stop();
    eventBlockDescentSongPlayer.stop();
}

/**
 * convert given string to valid uri path and return result
 */
private String convertPathToValidUri(String path) {
    return new File(path).toURI().toString();
}

/*** getters and setters ***/
public PVector getGravity() {
    return gravity;
}

public PVector getWallSlideAcceleration() {
    return wallSlideAcceleration;
}

public PImage getLevelBackgroundImage() {
    return levelBackgroundImage;
}

public LevelSelectMenu getLevelSelectMenu() {
    return levelSelectMenu;
}

public ALevel getCurrentActiveLevel() {
    return currentActiveLevel.get();
}

public void setCurrentActiveLevel(ALevel newCurrentActiveLevel) {
    currentActiveLevel = new WeakReference<ALevel>(newCurrentActiveLevel);
}

public int getCurrentActiveLevelNumber() {
    return currentActiveLevelNumber;
}

public void setCurrentActiveLevelNumber(int newCurrentActiveLevelNumber) {
    currentActiveLevelNumber = newCurrentActiveLevelNumber;
}

/**
 * return player of current active level
 */
public Player getCurrentActivePlayer() {
    return currentActiveLevel.get().player;    // TODO: encapsulate
}

/**
 * return viewbox of current active level
 */
public ViewBox getCurrentActiveViewBox() {
    return currentActiveLevel.get().viewBox; // TODO: encapsulate
}

/**
    * return drawable collection of current active level
    */
public LevelDrawableCollection getCurrentActiveLevelDrawableCollection() {
    return this.currentActiveLevel.get().getLevelDrawableCollection();
}

/**
 * return width of current active level
 */
public int getCurrentActiveLevelWidth() {
    return levelsWidthArray[currentActiveLevelNumber];
}

/**
 * return height of current active level
 */
public int getCurrentActiveLevelHeight() {
    return levelsHeightArray[this.currentActiveLevelNumber];
}
