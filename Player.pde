/**
 * player controllable character in game
 */
public class Player extends ACharacter {

    /**
     * Set player properties
     */
    Player(int x, int y, int width, int height) {
        super(x, y, width, height);
    }
    
    /**
     * handle character keypress controls
     */
    void keyEvent(KeyEvent keyEvent) {

        if(keyEvent.getAction() == KeyEvent.PRESS) {
            char keyPressed = keyEvent.getKey();

            if (keyPressed == 'a') {   //left
                this.isMovingLeft = true;
            }
            if (keyPressed == 'd') {   //right
                this.isMovingRight = true;
            }
            if (keyPressed == 'w') {
                this.isJumping = true;
            }

        } else if(keyEvent.getAction() == KeyEvent.RELEASE) {
            if (key == 'a') {       //left
                this.isMovingLeft = false;
            }
            if (key == 'd') {       //right
                 this.isMovingRight = false;
            }
            if (key == 'w') {
                this.isJumping = false;
            }
        }

    }

    /**
     * runs continuously. handles player movement and physics
     */
    void draw() {

        if(this.isMovingLeft) {
            this.vel.x = -Constants.MAIN_CHARACTER_RUN_SPEED;
        }
        if(this.isMovingRight) {
            this.vel.x = Constants.MAIN_CHARACTER_RUN_SPEED;
        }
        if(!this.isMovingLeft && !this.isMovingRight) {
            this.vel.x = 0;
        }

        if(isJumping && numberOfBoundaryCollision > 0) {    // jumping so set vertical velocity
            this.vel.y = -Constants.MAIN_CHARACTER_JUMP_HEIGHT;

        } else if(numberOfBoundaryCollision == 0) { // in air so gravity act
            this.handleInAir();
        }

        this.pos.add(this.vel);
        
        this.show();
    }
}