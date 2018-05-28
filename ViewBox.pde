/**
 * viewbox that keeps track of screen position to display character;
 * to be used in translate(x, y) in main draw()
 */
public class ViewBox {
    
    // top-left (x, y) coordinates of viewbox position
    PVector pos;

    // velocity of viewbox
    PVector vel;


    /**
     * set viewbox properties
     */
    ViewBox(int startXPos, int startYPos) {
        this.pos = new PVector(startXPos, startYPos);
        this.vel = new PVector(0, 0);
    }

    /**
     * runs continuously. handles viewbox position
     */
    void draw() {
        if(global_player.isMovingLeft) {    // TODO: encapsulate
            if(this.pos.x > 0       // left edge of viewbox not at left edge of level
                && this.playerAtViewBoxBoundary(true)) {
                
                this.vel.x = -Constants.PLAYER_RUN_SPEED;
            } else {
                this.vel.x = 0;
            }
        }
        if(global_player.isMovingRight) {   // TODO: encapsulate
            if(this.pos.x < Constants.LEVEL_WIDTH - width   // right edge of viewbox not at right edge of level
                && this.playerAtViewBoxBoundary(false)) {
                
                this.vel.x = Constants.PLAYER_RUN_SPEED;
            } else {
                this.vel.x = 0;
            }
        }
        if(!global_player.isMovingLeft && !global_player.isMovingRight) {   // TODO: encapsulate
            this.vel.x = 0;
        }

        this.pos.add(this.vel);
    }

    /**
     * return if player is at lower or upper boundary (from given value) of viewbox
     */
    private boolean playerAtViewBoxBoundary(boolean isLowerBoundary) {
        if(isLowerBoundary) {
            return global_player.pos.x <= this.pos.x + Constants.VIEWBOX_BOUNDARY * width;  // TODO: encapsulate
        } else {
            return global_player.pos.x >= this.pos.x + (1.00 - Constants.VIEWBOX_BOUNDARY) * width; // TODO: encapsulate
        }
    }

}