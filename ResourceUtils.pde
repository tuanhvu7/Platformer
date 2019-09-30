public class ResourceUtils {

    public ResourceUtils() {
    }

    private static final String DEFAULT_MENU_IMAGE_NAME = "sky-blue-bg.png";
    public final PImage defaultMenuImage = loadImage(ResourceUtils.DEFAULT_MENU_IMAGE_NAME);

    // background image
    private static final String LEVEL_BACKGROUND_IMAGE_NAME = "sky-bg.png";
    public final PImage levelBackgroundImage = loadImage(ResourceUtils.LEVEL_BACKGROUND_IMAGE_NAME);

    /*** MUSIC ***/
    // level select menu song
    private static final String OUT_OF_LEVEL_MENU_SONG_NAME = "level-select-menu-song.mp3";
    private final Media outOfLevelMenuSong 
        = new Media(convertPathToValidUri(dataPath(OUT_OF_LEVEL_MENU_SONG_NAME)));
    // player for level select menu song
    private final MediaPlayer outOfLevelMenuSongPlayer = new MediaPlayer(outOfLevelMenuSong);

    // level song
    private static final String LEVEL_SONG_NAME = "level-song.mp3"; 
    private final Media levelSong
        = new Media(convertPathToValidUri(dataPath(LEVEL_SONG_NAME)));
    // player for level song
    private final MediaPlayer levelSongPlayer = new MediaPlayer(levelSong);

    // player death song
    private static final String PLAYER_DEATH_SONG_NAME = "player-death-song.mp3"; 
    private final Media playerDeathSong
        = new Media(convertPathToValidUri(dataPath(PLAYER_DEATH_SONG_NAME)));
    // player for player death song
    private final MediaPlayer playerDeathSongPlayer = new MediaPlayer(playerDeathSong);

    // level complete song
    private static final String LEVEL_COMPLETE_SONG_NAME = "level-complete-song.mp3";
    private final Media levelCompleteSong
        = new Media(convertPathToValidUri(dataPath(LEVEL_COMPLETE_SONG_NAME)));
    // player for level complete song
    private final MediaPlayer levelCompleteSongPlayer = new MediaPlayer(levelCompleteSong);

    // player action
    private static final String PLAYER_ACTION_SONG_NAME = "player-action-song.mp3";
    private final Media playerActionSong
        = new Media(convertPathToValidUri(dataPath(PLAYER_ACTION_SONG_NAME)));
    // player for player action 
    private final MediaPlayer playerActionSongPlayer = new MediaPlayer(playerActionSong);

    // player damage 
    private static final String PLAYER_DAMAGE_SONG_NAME = "player-damage-song.mp3";
    private final Media playerDamageSong
        = new Media(convertPathToValidUri(dataPath(PLAYER_DAMAGE_SONG_NAME)));
    // player for player damage 
    private final MediaPlayer playerDamageSongPlayer = new MediaPlayer(playerDamageSong);

    // event block descent song
    private static final String EVENT_BLOCK_DESCENT_SONG_NAME = "event-block-descent-song.mp3";
    private final Media eventBlockDescentSong
        = new Media(convertPathToValidUri(dataPath(EVENT_BLOCK_DESCENT_SONG_NAME)));
    // player for event block descent song
    private final MediaPlayer eventBlockDescentSongPlayer = new MediaPlayer(eventBlockDescentSong);

   /**
    * loop song
    */
    public void loopSong(ESongType songType) {
        switch(songType) {
            case OUT_OF_LEVEL_MENU:
                outOfLevelMenuSongPlayer.setCycleCount(Integer.MAX_VALUE);
                outOfLevelMenuSongPlayer.play();
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
     * get song duration in milliseconds
     */
    public double getSongDurationMilliSec(ESongType songType) {
        switch (songType) {
            case PLAYER_DEATH:
                return playerDeathSong.getDuration().toMillis();
            case PLAYER_DAMAGE:
                return playerDamageSong.getDuration().toMillis();
            case LEVEL_COMPLETE:
                return levelCompleteSong.getDuration().toMillis();
            default:
                return 0;
        }
    }

   /**
    * play song
    */
    public void playSong(ESongType songType) {
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
    public void stopSong() {
        outOfLevelMenuSongPlayer.stop();
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
}
