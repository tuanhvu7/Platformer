/**
 * Main sketch file
 */
import java.util.Set;
import java.util.HashSet;
import java.util.List;
import java.util.ArrayList;
import java.lang.ref.WeakReference;
import java.util.Optional;
import java.util.Collections;
import java.util.concurrent.ConcurrentHashMap;

import javafx.scene.media.Media;
import javafx.scene.media.MediaPlayer;
import javafx.util.Duration;
import javafx.embed.swing.JFXPanel;

// gravity that affects characters
private final PVector gravity = new PVector(0, Constants.GRAVITY);;

// wall slide acceleration
private final PVector wallSlideAcceleration = new PVector(0, Constants.WALL_SLIDE_ACCELERATION);;

// handles resources (images, music)
private ResourceUtils resourceUtils;

// handles player control settings
private PlayerControlSettings playerControlSettings;

// handles reserved control keys
private ReservedControlUtils reservedControlUtils;

// level complete thread
Thread levelCompleteThread;

/*** MENUS ***/
// level select menu
private LevelSelectMenu levelSelectMenu;

// configure player control menu
private ConfigurePlayerControlMenu configurePlayerControlMenu;

/*** MUSIC ***/
// stores current active level
private WeakReference<ALevel> currentActiveLevel;

// stores currently active level number
private int currentActiveLevelNumber;

// widths of all levels
private final int[] levelsWidthArray = {
    0,          // non-existent level zero
    8750,
    12000,
    8500
};

// heights of all levels
private final int[] levelsHeightArray = {
    0,      // non-existent level zero
    900,    // level one
    1300,
    900
};

/**
 * runs once;
 * setup canvas size with variable values and initialize fields
 */
void settings() {
    
    new JFXPanel(); // initialize JavaFx toolkit

    resourceUtils = new ResourceUtils();
    playerControlSettings = new PlayerControlSettings();
    reservedControlUtils = new ReservedControlUtils();
    currentActiveLevelNumber = 0;

    size(Constants.SCREEN_WIDTH, Constants.SCREEN_HEIGHT);
    levelSelectMenu = new LevelSelectMenu(true);
    configurePlayerControlMenu = new ConfigurePlayerControlMenu(false);
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

                resourceUtils.stopSong();
                resourceUtils.playSong(ESongType.PLAYER_DEATH);
                Thread.sleep((long) resourceUtils.getSongDurationMilliSec(ESongType.PLAYER_DEATH));  // wait for song duration

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
                    getCurrentActiveLevel().setHandlingLevelComplete(true);
                    getCurrentActivePlayer().resetControlPressed();
                    getCurrentActivePlayer().setVel(new PVector(Constants.PLAYER_LEVEL_COMPLETE_SPEED, 0));
                    unregisterMethod("keyEvent", getCurrentActivePlayer()); // disconnect this keyEvent() from main keyEvent()
                    
                    resourceUtils.stopSong();
                    resourceUtils.playSong(ESongType.LEVEL_COMPLETE);
                    Thread.sleep((long) resourceUtils.getSongDurationMilliSec(ESongType.LEVEL_COMPLETE));  // wait for song duration
                    
                    getCurrentActivePlayer().makeNotActive();
                    currentActiveLevel.get().deactivateLevel();
                    currentActiveLevelNumber = 0;
                    levelSelectMenu.setupActivateMenu();
                } catch (InterruptedException ie)  { }
            }
        });
    levelCompleteThread.start();
}

/*** getters and setters ***/
public PVector getGravity() {
    return gravity;
}

public PVector getWallSlideAcceleration() {
    return wallSlideAcceleration;
}

public LevelSelectMenu getLevelSelectMenu() {
    return levelSelectMenu;
}

public ConfigurePlayerControlMenu getChangePlayerControlMenu() {
    return configurePlayerControlMenu;
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
    return currentActiveLevel.get().getPlayer();
}

/**
 * return viewbox of current active level
 */
public ViewBox getCurrentActiveViewBox() {
    return currentActiveLevel.get().getViewBox();
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
