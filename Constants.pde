/**
 * constants used across app
 */
class Constants {
    /*** screen config ***/
    private static final int SCREEN_BACKGROUND = #7EC0EE;
    private static final int SCREEN_HEIGHT = 900;
    private static final int SCREEN_WIDTH = 1000;

    /*** velocity and acceleration physics ***/
    private static final float GRAVITY = 0.4;
    // gravity multiplier for jumping higher when holding jump button
    private static final float WALL_SLIDE_ACCELERATION = 0.1;
    private static final float VARIABLE_JUMP_GRAVITY_MULTIPLIER = 0.55;
    private static final float MAX_VERTICAL_VELOCITY = 15;

    /*** player config ***/
    private static final int PLAYER_RUN_SPEED = 3;
    private static final int PLAYER_JUMP_HEIGHT = 12;
    private static final int PLAYER_COLOR = #FFFFFF;
    private static final int PLAYER_DIAMETER = 60;

    /*** enemy config **/
    private static final float ENEMY_RUN_SPEED = 2.5;
    private static final int ENEMY_COLOR = #FF0000;
    private static final int REGULAR_ENEMY_DIAMETER = 60;

}