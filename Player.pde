/**
 * player controllable character in game
 */
public class Player extends ACharacter implements ICharacter {

    // true means this is touching vertical boundary
    private boolean isTouchingVerticalBoundary;

    /**
     * Set player properties
     */
    Player(int x, int y, int diameter) {
        super(x, y, diameter);
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
                this.vel.x = -Constants.PLAYER_RUN_SPEED;
            }
            if(this.isMovingRight) {
                this.vel.x = Constants.PLAYER_RUN_SPEED;
            }
            if(!this.isMovingLeft && !this.isMovingRight) {
                this.vel.x = 0;
            }

            if(this.isJumping) {    // jump button pressed/held
                if(this.numberOfHorizontalBoundaryContacts > 0 || this.isTouchingVerticalBoundary) { // able to jump
                    this.vel.y = -Constants.PLAYER_JUMP_HEIGHT;
                } else {
                    // for jumpin higher the longer jump button is held
                    this.vel.y = 
                    Math.min(
                        this.vel.y + global_gravity.y * Constants.VARIABLE_JUMP_GRAVITY_MULTIPLIER, 
                        Constants.MAX_VERTICAL_VELOCITY);
                }

            } else {    // jump button not pressed
                if(this.isTouchingVerticalBoundary) {   // touching wall
                    this.handleOnWallPhysics();
                } else if(this.numberOfHorizontalBoundaryContacts == 0) {    // in air
                    this.handleInAirPhysics();
                }
            }

            this.pos.add(this.vel);
            
            fill(Constants.PLAYER_COLOR);
            this.show(); 
    }

    /**
     * handle contact with vertical boundary
     */
    void handleContactWithVerticalBoundary(float boundaryXPoint) {
        this.vel.x = 0;
        if(this.pos.x > boundaryXPoint) {   // left boundary
            this.pos.x = boundaryXPoint + this.diameter / 2;
        } else {    // right boundary
            this.pos.x = boundaryXPoint - this.diameter / 2;
        }  
    }

    /**
     * handle wall sliding physics
     */
    private void handleOnWallPhysics() {
        this.vel.y = Math.min(this.vel.y + global_wall_slide_acceleration.y, Constants.MAX_VERTICAL_VELOCITY);
    }
}
