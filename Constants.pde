/**
 * constants used across app
 */
class Constants {

    /*** level panel config ***/
    private static final int TEXT_SIZE = 24;
    private static final int PANEL_HEIGHT = 200;
    private static final int PANEL_WIDTH = 200;
    private static final int PANEL_COLOR = #00FF00;


    /*** screen config ***/
    private static final int SCREEN_BACKGROUND = #7EC0EE;
    private static final int SCREEN_HEIGHT = 900;
    private static final int SCREEN_WIDTH = 1000;
    // lower and upper boundary of viewbox; 
    // viewbox will move to follow player if player goes past this screen size boundary
    // Example: 0.25 means viewbox follow player if player goes past upper and lower 25% screen size
    private static final double VIEWBOX_BOUNDARY = 0.25;


    /*** velocity and acceleration physics ***/
    private static final float GRAVITY = 0.4;
    // gravity multiplier for jumping higher when holding jump button
    private static final float WALL_SLIDE_ACCELERATION = 0.1;
    private static final float VARIABLE_JUMP_GRAVITY_MULTIPLIER = 0.55;
    private static final float EVENT_BLOCK_DESCENT_VERTICAL_VELOCITY = 1;
    private static final float MAX_VERTICAL_VELOCITY = 15;
    
    /*** Event config ***/
    private static final int CHARACTER_LAUNCH_EVENT_VERTICAL_VELOCITY = -27;
    // launch vertical velocity after warping to desired location
    private static final int CHARACTER_WARP_EVENT_VERTICAL_VELOCITY = -10;

    /*** player config ***/
    private static final int PLAYER_RUN_SPEED = 3;
    private static final int PLAYER_JUMP_VERTICAL_VELOCITY = -12;
    private static final int PLAYER_JUMP_KILL_ENEMY_HOP_VERTICAL_VELOCITY = -7;
    private static final int PLAYER_COLOR = #000000;
    private static final int PLAYER_DIAMETER = 60;
    // minimun angle (degrees) of collision between player and enemy
    // for player to kill enemy
    private static final double MIN_PLAYER_KILL_ENEMY_COLLISION_ANGLE = 20.0;

    /*** enemy config **/
    private static final float ENEMY_RUN_SPEED = 2.5;
    private static final int ENEMY_COLOR = #FF0000;
    private static final int REGULAR_ENEMY_DIAMETER = 60;
    private static final int BIG_ENEMY_DIAMETER = 500;


    /*** boundary and block config ***/
    private static final int BOUNDARY_COLOR = #000000;
    private static final int DEFAULT_BOUNDARY_LINE_THICKNESS = 1;

    private static final int BLOCK_COLOR = #CD853F;
    private static final int DEFAULT_BLOCK_SIZE = 100; 

    private static final int EVENT_BLOCK_COLOR = #00E500;
    private static final int DEFAULT_EVENT_BLOCK_WIDTH = 125; 
    private static final int DEFAULT_EVENT_BLOCK_HEIGHT = 200; 

    /*** assets path ***/
    private static final String BACKGROUND_IMAGE_NAME = "sky-blue-bg.png";
    private static final String LEVEL_SONG_NAME = "ugandan-knuckles-song.mp3"; 
    private static final String PLAYER_DEATH_SONG_NAME = "ugandan-knuckles-song-end.mp3"; 

    private Constants() {}
}
