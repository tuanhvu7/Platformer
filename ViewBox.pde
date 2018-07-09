/**
 * viewbox that keeps track of screen position to display character;
 * to be used in translate(x, y) in draw()
 */
public class ViewBox implements IDrawable {
    
    // top-left (x, y) coordinates of viewbox position
    private PVector pos;

    // velocity of viewbox
    private PVector vel;

    // 0 means this is in level at 0th index of global_levels_list
    private int levelIndex;

    // true means display this and have this move according to player position
    private boolean isActive;

    /**
     * set properties of this
     */
    ViewBox(int startXPos, int startYPos, int levelIndex, boolean isActive) {
        this.pos = new PVector(startXPos, startYPos);
        this.vel = new PVector(0, 0);
        this.levelIndex = levelIndex;
        this.isActive = isActive;
        if(isActive) {
            this.makeActive();
        }
    }

    /**
     * runs continuously. handles viewbox position
     */
    void draw() {
        this.handleMovement();
        
        // move viewbox as necessary
        translate(-this.pos.x, -0);
    }

    /**
     * activate and add this to game
     */
    void makeActive() {
        this.isActive = true;
        registerMethod("draw", this); // connect this draw() from main draw()
    }

    /**
     * deactivate and remove this from game
     */
    void makeNotActive() {
        this.isActive = false;
        unregisterMethod("draw", this); // disconnect this draw() from main draw()
    }

    /**
     * set given value to be middle x position of this;
     * set this x position to be at start or end of level this is in if
     * given value would result this x position level overflow
     */
    void setViewBoxHorizontalPosition(float middleXPos) {
        if(middleXPos - width / 2 < 0) {
            this.pos.x = 0;
        } else if(middleXPos + width / 2 > global_levels_width_array[this.levelIndex]) {
            this.pos.x = global_levels_width_array[this.levelIndex] - Constants.SCREEN_WIDTH;
        } else {
            this.pos.x = middleXPos - (Constants.SCREEN_WIDTH / 2);
        }
    }

   /**
    * handle movement (position, velocity)
    */
    private void handleMovement() {
        if(getPlayerAtLevelIndex(this.levelIndex).moveLeftPressed) {    // TODO: encapsulate
            if(this.pos.x > 0       // left edge of viewbox not at left edge of level
                && this.playerAtViewBoxBoundary(true)) 
            {
                this.vel.x = -Constants.PLAYER_RUN_SPEED;
            } else {
                this.vel.x = 0;
            }
        } 
        if(getPlayerAtLevelIndex(this.levelIndex).moveRightPressed) {   // TODO: encapsulate
            if(this.pos.x < global_levels_width_array[this.levelIndex] - width   // right edge of viewbox not at right edge of level
                && this.playerAtViewBoxBoundary(false)) 
            {
                this.vel.x = Constants.PLAYER_RUN_SPEED;
            } else {
                this.vel.x = 0;
            }
        } 
        if(!getPlayerAtLevelIndex(this.levelIndex).moveLeftPressed && // TODO: encapsulate
            !getPlayerAtLevelIndex(this.levelIndex).moveRightPressed)   // TODO: encapsulate
        {   
            this.vel.x = 0;
        }

        this.pos.add(this.vel);

        // fix viewbox level overflows
        if(this.pos.x > global_levels_width_array[this.levelIndex] - width) {
            this.pos.x = global_levels_width_array[this.levelIndex] - width;
        } else if(this.pos.x < 0) {
            this.pos.x = 0;
        }
    }

    /**
     * return if player is at lower (left) or upper (right) boundary (from given value) of viewbox
     */
    private boolean playerAtViewBoxBoundary(boolean isLowerLeftBoundary) {
        if(isLowerLeftBoundary) {
            return getPlayerAtLevelIndex(this.levelIndex).pos.x <= this.pos.x + Constants.VIEWBOX_BOUNDARY * width;  // TODO: encapsulate
        } else {
            return getPlayerAtLevelIndex(this.levelIndex).pos.x >= this.pos.x + (1.00 - Constants.VIEWBOX_BOUNDARY) * width; // TODO: encapsulate
        }
    }

}
