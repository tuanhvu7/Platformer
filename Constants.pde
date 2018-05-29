/**
 * constants used across app
 */
class Constants {

    /*** screen config ***/
    private static final int SCREEN_BACKGROUND = #7EC0EE;
    private static final int SCREEN_HEIGHT = 900;
    private static final int SCREEN_WIDTH = 1000;
    // lower and upper boundary of viewbox; 
    // viewbox will move to follow player if player goes past this screen size boundary
    // Example: 0.25 means viewbox follow player if player goes past upper and lower 25% screen size
    private static final double VIEWBOX_BOUNDARY = 0.25;

    /*** level config ***/
    private static final int LEVEL_WIDTH = 1500; // 5632
    private static final int LEVEL_HEIGHT = 900;

    /*** velocity and acceleration physics ***/
    private static final float GRAVITY = 0.4;
    // gravity multiplier for jumping higher when holding jump button
    private static final float WALL_SLIDE_ACCELERATION = 0.1;
    private static final float VARIABLE_JUMP_GRAVITY_MULTIPLIER = 0.55;
    private static final float MAX_VERTICAL_VELOCITY = 15;


    // minimun angle (degrees) of collision between player and enemy
    // for player to kill enemy
    private static final int MIN_PLAYER_KILL_ENEMY_COLLISION_ANGLE = 20;


    /*** player config ***/
    private static final int PLAYER_RUN_SPEED = 3;
    private static final int PLAYER_JUMP_HEIGHT = 12;
    private static final int PLAYER_JUMP_KILL_ENEMY_HOP_HEIGHT = 7;
    private static final int PLAYER_COLOR = #000000;
    private static final int PLAYER_DIAMETER = 60;


    /*** enemy config **/
    private static final float ENEMY_RUN_SPEED = 2.5;
    private static final int ENEMY_COLOR = #FF0000;
    private static final int REGULAR_ENEMY_DIAMETER = 60;

    /*** boundary and block config ***/
    private static final int BOUNDARY_COLOR = #000000;


    /*** assets path ***/
    private static final String BACKGROUND_IMAGE_NAME = "sky-blue-bg.png";

}