/**
 * player controllable character in game
 */
public class Player extends ACharacter implements IDrawable {

    // true means this is touching vertical boundary
    private boolean isTouchingVerticalBoundary;

    // number of ceiling-like boundaries this is touching;
    protected int numberOfCeilingBoundaryContacts;

    /**
     * set properties of this
     */
    Player(int x, int y, int diameter, boolean isActive) {
        super(x, y, diameter, isActive);
        this.isTouchingVerticalBoundary = false;
        this.numberOfFloorBoundaryContacts = 0;
    }
    
    /**
     * handle character keypress controls
     */
    void keyEvent(KeyEvent keyEvent) {

        if(keyEvent.getAction() == KeyEvent.PRESS) {
            char keyPressed = keyEvent.getKey();

            if(keyPressed == 'a') {   //left
                this.isMovingLeft = true;
            }
            if(keyPressed == 'd') {   //right
                this.isMovingRight = true;
            }
            if(keyPressed == 'w') {
                this.isJumping = true;
            }

        } else if(keyEvent.getAction() == KeyEvent.RELEASE) {
            if(key == 'a') {       //left
                this.isMovingLeft = false;
            }
            if(key == 'd') {       //right
                 this.isMovingRight = false;
            }
            if(key == 'w') {
                this.isJumping = false;
            }
        }

    }

    /**
     * runs continuously. handles player movement and physics
     */
    void draw() {
        this.handleMovement();
        
        fill(Constants.PLAYER_COLOR);
        this.show(); 
    }

    /**
     * handle contact with horizontal boundary
     */
    void handleContactWithHorizontalBoundary(float boundaryYPoint, boolean isFloorBoundary) {
        // // for Block mechanics; only handle if no contact with ceiling-like boundary
        if(!this.isTouchingVerticalBoundary) {
            if(isFloorBoundary) { // floor-like boundary
                if(this.vel.y > 0) {    // boundary only act like floor if this is falling onto boundary
                    this.vel.y = 0;
                    this.pos.y = boundaryYPoint - this.diameter / 2;
                }
            } else {    // ceiling-like boundary
                if(this.vel.y < 0) {    // boundary only act like ceiling if this is rising into boundary
                    this.vel.y = 1;
                    this.pos.add(this.vel);
                }
            }
        }
    }

    /**
     * handle contact with vertical boundary
     */
    void handleContactWithVerticalBoundary(float boundaryXPoint) {
         // for Block mechanics; only handle if no contact with ceiling-like boundary
        if(this.numberOfCeilingBoundaryContacts == 0) {
            this.vel.x = 0;
            if(this.pos.x > boundaryXPoint) {   // left boundary
                this.pos.x = boundaryXPoint + this.diameter / 2; // prevent this from going through boundary
            } else {    // right boundary
                this.pos.x = boundaryXPoint - this.diameter / 2; // prevent this from going through boundary
            }  
        }
    }

    /**
     * handle wall sliding physics
     */
    private void handleOnWallPhysics() {
        this.vel.y = Math.min(this.vel.y + global_wall_slide_acceleration.y, Constants.MAX_VERTICAL_VELOCITY);
    }

    /**
     * handle jump on enemy physics
     */
    private void handleJumpKillEnemyPhysics() {
        this.vel.y = -Constants.PLAYER_JUMP_KILL_ENEMY_HOP_HEIGHT;
    }

   /**
    * handle movement (position, velocity) of this
    */
    private void handleMovement() {
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
            if( this.numberOfFloorBoundaryContacts > 0 || 
                (this.isTouchingVerticalBoundary && this.numberOfCeilingBoundaryContacts == 0) )
            { // able to jump
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
            } else if(this.numberOfFloorBoundaryContacts == 0) {    // in air
                this.handleInAirPhysics();
            }
        }

        this.pos.add(this.vel);
    }

    
    /**
     * active and add this to game
     */
    void makeActive() {
        this.isActive = true;
        registerMethod("keyEvent", this);   // connect this keyEvent() from main keyEvent()
        registerMethod("draw", this); // connect this draw() from main draw()
    }

    /**
     * deactivate and remove this from game
     */
    void makeNotActive() {
        this.isActive = false;
        unregisterMethod("draw", this); // disconnect this draw() from main draw()
        unregisterMethod("keyEvent", this); // disconnect this keyEvent() from main keyEvent()
    }
}
