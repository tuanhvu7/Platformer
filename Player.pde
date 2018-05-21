/**
 * player controllable character in game
 */
public class Player extends ACharacter {

    // true means this is touching vertical boundary
    private boolean isTouchingVerticalBoundary;

    /**
     * Set player properties
     */
    Player(int x, int y, int width, int height) {
        super(x, y, width, height);
        this.isTouchingVerticalBoundary = false;
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

        if(this.isJumping) {
            if(numberOfHorizontalBoundaryContacts > 0 || this.isTouchingVerticalBoundary) { // able to jump
                this.vel.y = -Constants.MAIN_CHARACTER_JUMP_HEIGHT;
            } else {   // in air
                this.handleInAir();
            }

        } else {
            if(this.isTouchingVerticalBoundary) {   // touching wall
                this.handleOnWall();
            } else if(numberOfHorizontalBoundaryContacts == 0) {    // in air
                this.handleInAir();
            }
        }

        this.pos.add(this.vel);
        
        this.show();
    }

    /**
     * handle contact with vertical boundary
     */
    void handleContactWithVerticalBoundary(float boundaryXPoint) {
        this.vel.x = 0;
        if(this.pos.x > boundaryXPoint) {   // left boundary
            this.pos.x = boundaryXPoint + this.width / 2;
        } else {    // right boundary
            this.pos.x = boundaryXPoint - this.width / 2;
        }  
    }

    private void handleOnWall() {
        this.pos.add(this.vel);
        this.vel.y = Math.min(this.vel.y + global_wall_slide_acceleration.y, Constants.MAX_VERTICAL_VELOCITY);
    }
}