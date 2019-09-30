/**
 * player control key bindings
 */
public class PlayerControlSettings {
    // default player controls
    private int PLAYER_UP = 'w';
    private int PLAYER_DOWN = 's';
    private int PLAYER_LEFT = 'a';
    private int PLAYER_RIGHT = 'd';


    /*** getters and setters ***/
    public int getPlayerUp() {
        return PLAYER_UP;
    }

    /**
     * set player up control to given keyCode if give keyCode is available
     */
    public void setPlayerUp(int playerUp) {
        if (isKeyCodeAvailable(playerUp)) {
            PLAYER_UP = playerUp;
        }
    }

    public int getPlayerDown() {
        return PLAYER_DOWN;
    }

    /**
     * set player down control to given keyCode if give keyCode is available
     */
    public void setPlayerDown(int playerDown) {
        if (isKeyCodeAvailable(playerDown)) {
            PLAYER_DOWN = playerDown;
        }
    }

    public int getPlayerLeft() {
        return PLAYER_LEFT;
    }

    /**
     * set player left control to given keyCode if give keyCode is available
     */
    public void setPlayerLeft(int playerLeft) {
        if (isKeyCodeAvailable(playerLeft)) {
            PLAYER_LEFT = playerLeft;
        }
    }

    public int getPlayerRight() {
        return PLAYER_RIGHT;
    }

    /**
     * set player right control to given keyCode if give keyCode is available
     */
    public void setPlayerRight(int playerRight) {
        if (isKeyCodeAvailable(playerRight)) {
            PLAYER_RIGHT = playerRight;
        }
    }


    /**
     * @return true if given keyCode is available (not used)
     */
    public boolean isKeyCodeAvailable(int keyCode) {
        return this.getPlayerUp() != keyCode
            && this.getPlayerLeft() != keyCode
            && this.getPlayerDown() != keyCode
            && this.getPlayerRight() != keyCode;
    }
}
