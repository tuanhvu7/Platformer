/**
 * Viewbox to display player on screen;
 * moves accordingly to keep player on screen
 */
public class ViewBox {
    
    // top-left (x, y) coordinates of viewbox position
    PVector pos;


    /**
     * set viewbox properties
     */
    ViewBox(int startXPos, int startYPos) {
        pos = new PVector(startXPos, startYPos);
    }

    /**
     * runs continuously. handles viewbox position
     */
    void draw() {
        if(global_player.isMovingLeft) {    // TODO: encapsulate
            if(this.pos.x > 0       // left edge of viewbox not at left edge of level
                && this.playerAtViewBoxBoundary(true)) {
                
                this.pos.x -= Constants.PLAYER_RUN_SPEED;
            }
        }

        if(global_player.isMovingRight) {   // TODO: encapsulate
            if(this.pos.x < Constants.LEVEL_WIDTH - width   // right edge of viewbox not at right edge of level
                && this.playerAtViewBoxBoundary(false)) {
                
                this.pos.x += Constants.PLAYER_RUN_SPEED;
            }
        }
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