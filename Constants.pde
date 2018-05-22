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
    private static final float MAX_VERTICAL_VELOCITY = 13;

    /*** player config ***/
    private static final int PLAYER_RUN_SPEED = 3;
    private static final int PLAYER_JUMP_HEIGHT = 12;
}