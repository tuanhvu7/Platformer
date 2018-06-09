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
        if(getPlayerAtLevelIndex(this.levelIndex).isMovingLeft) {    // TODO: encapsulate
            if(this.pos.x > 0       // left edge of viewbox not at left edge of level
                && this.playerAtViewBoxBoundary(true)) {
                
                this.vel.x = -Constants.PLAYER_RUN_SPEED;
            } else {
                this.vel.x = 0;
            }
        }
        if(getPlayerAtLevelIndex(this.levelIndex).isMovingRight) {   // TODO: encapsulate
            if(this.pos.x < global_levels_width_array[this.levelIndex] - width   // right edge of viewbox not at right edge of level
                && this.playerAtViewBoxBoundary(false)) {
                
                this.vel.x = Constants.PLAYER_RUN_SPEED;
            } else {
                this.vel.x = 0;
            }
        }
        if(!getPlayerAtLevelIndex(this.levelIndex).isMovingLeft && !getPlayerAtLevelIndex(this.levelIndex).isMovingRight) {   // TODO: encapsulate
            this.vel.x = 0;
        }

        this.pos.add(this.vel);
        
        // move viewbox if necessary
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
     * return if player is at lower or upper boundary (from given value) of viewbox
     */
    private boolean playerAtViewBoxBoundary(boolean isLowerBoundary) {
        if(isLowerBoundary) {
            return getPlayerAtLevelIndex(this.levelIndex).pos.x <= this.pos.x + Constants.VIEWBOX_BOUNDARY * width;  // TODO: encapsulate
        } else {
            return getPlayerAtLevelIndex(this.levelIndex).pos.x >= this.pos.x + (1.00 - Constants.VIEWBOX_BOUNDARY) * width; // TODO: encapsulate
        }
    }

}