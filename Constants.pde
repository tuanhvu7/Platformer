/**
 * app.constants used across app
 */
public class Constants {

    /*** level panel config ***/
    public static final int TEXT_SIZE = 24;
    public static final int PANEL_SIZE = 200;
    public static final int DEFAULT_PANEL_COLOR = #00FF00;
    public static final int LEVEL_CHECKPOINT_LOAD_PANEL_COLOR = #FFDAB9;

    /*** screen config ***/
    public static final int SCREEN_HEIGHT = 900;
    public static final int SCREEN_WIDTH = 1000;
    public static final int LEVEL_FLOOR_Y_POSITION = SCREEN_HEIGHT - 100;
    /*
     * lower and upper boundary of viewbox;
     * viewbox will move to follow player if player goes past this screen size boundary
     * Example: 0.25 means viewbox follow player if player goes past upper and lower 25% screen size
     */
    public static final double HORIZONTAL_VIEWBOX_BOUNDARY = 0.35;
    public static final double VERTICAL_VIEWBOX_BOUNDARY = 0.1;


    /*** velocity and acceleration physics ***/
    public static final float GRAVITY = 0.4;
    // gravity multiplier for jumping higher when holding jump button
    public static final float WALL_SLIDE_ACCELERATION = 0.1;
    public static final int CHARACTER_JUMP_VERTICAL_VELOCITY  = -12;
    public static final float VARIABLE_JUMP_GRAVITY_MULTIPLIER = 0.55f;
    public static final float EVENT_BLOCK_DESCENT_VERTICAL_VELOCITY = 1.5f;
    public static final float MAX_VERTICAL_VELOCITY = 15;

    /*** Event config ***/
    public static final int CHARACTER_LAUNCH_EVENT_VERTICAL_VELOCITY = -27;
    // launch vertical velocity after warping to desired location
    public static final int CHARACTER_WARP_EVENT_VERTICAL_VELOCITY = -10;

    /*** player config ***/
    public static final int PLAYER_MOVEMENT_SPEED = 3;
    public static final int PLAYER_LEVEL_COMPLETE_SPEED = 1;
    public static final int PLAYER_JUMP_KILL_ENEMY_HOP_VERTICAL_VELOCITY = -7;
    public static final int PLAYER_DEFAULT_COLOR = #000000;
    public static final int PLAYER_DAMAGED_COLOR = #888888;
    public static final int PLAYER_DIAMETER = 60;
    public static final int PLAYER_HEALTH_TEXT_COLOR = #FFFFFF;
    // minimum angle (degrees) of collision between player and enemy
    // for player to kill enemy
    public static final double MIN_PLAYER_KILL_ENEMY_COLLISION_ANGLE = 20.0;

    /*** enemy config **/
    public static final int ENEMY_SLOW_MOVEMENT_SPEED = 1;
    public static final float ENEMY_REGULAR_MOVEMENT_SPEED = 2.5f;
    public static final int ENEMY_FAST_MOVEMENT_SPEED = 5;
    public static final int ENEMY_COLOR = #FF0000;
    public static final int SMALL_ENEMY_DIAMETER = 60;
    public static final int MEDIUM_ENEMY_DIAMETER = 250;
    public static final int BIG_ENEMY_DIAMETER = 500;


    /*** boundary and block config ***/
    public static final int BOUNDARY_COLOR = #000000;
    public static final int DEFAULT_BOUNDARY_LINE_THICKNESS = 1;

    public static final int BREAKABLE_BLOCK_COLOR = #800000;
    public static final int DEFAULT_BLOCK_COLOR = #CD853F;
    public static final int DEFAULT_BLOCK_SIZE = 100;

    public static final int ITEM_BLOCK_TEXT_COLOR = #000000;

    public static final int EVENT_BLOCK_COLOR = #00E500;
    public static final int DEFAULT_EVENT_BLOCK_WIDTH = 125;
    public static final int DEFAULT_EVENT_BLOCK_HEIGHT = 200;

    /*** collectable config ***/
    public static final int CHECKPOINT_COLOR = #FFD700;
    public static final int CHECKPOINT_WIDTH = 40;
    public static final int CHECKPOINT_HEIGHT = 100;

    public static final int LEVEL_GOAL_COLOR = #DCDCDC;
    public static final int LEVEL_GOAL_WIDTH = 40;
    public static final int LEVEL_GOAL_HEIGHT = LEVEL_FLOOR_Y_POSITION;

    public static final int HEALTH_ITEM_COLOR = #DCDCDC;
    public static final int NEGATIVE_HEALTH_ITEM_TEXT_COLOR = #FF0000;
    public static final int ZERO_HEALTH_ITEM_TEXT_COLOR = #888888;
    public static final int POSITIVE_HEALTH_ITEM_TEXT_COLOR = #008000;
    public static final int HEALTH_ITEM_SIZE = 60;

    /**
     * make this class "static"
     */
    private Constants() {
    }

}
