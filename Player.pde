/**
 * player controllable character in game
 */
public class Player extends ACharacter implements IDrawable {

    // number of wall-like boundaries this is touching;
    private int numberOfVerticalBoundaryContacts;

    // number of ceiling-like boundaries this is touching;
    private int numberOfCeilingBoundaryContacts;

    // top boundary of event blocks that this is touching
    private Set<EventBlockTopBoundary> eventTopBoundaryContacts;

    // player pressed control states
    private boolean moveLeftPressed;
    private boolean moveRightPressed;
    private boolean jumpPressed;

    private boolean isDescendingDownEventBlock;

    private boolean ableToMoveRight;
    private boolean ableToMoveLeft;

    /**
     * set properties of this
     */
    Player(int x, int y, int diameter, boolean isActive) {
        super(x, y, diameter, isActive);
        this.numberOfVerticalBoundaryContacts = 0;
        this.numberOfFloorBoundaryContacts = 0;

        this.eventTopBoundaryContacts = new HashSet<EventBlockTopBoundary>();

        this.moveLeftPressed = false;
        this.moveRightPressed = false;
        this.jumpPressed = false;

        this.isDescendingDownEventBlock = false;

        this.ableToMoveRight = true;
        this.ableToMoveLeft = true;
    }
    
    /**
     * handle character keypress controls
     */
    void keyEvent(KeyEvent keyEvent) {

        if(keyEvent.getAction() == KeyEvent.PRESS) {
            if(key == 'a') {   //left
                this.moveLeftPressed = true;
            }
            if(key == 'd') {   //right
                this.moveRightPressed = true;
            }
            if(key == 'w') {
                this.jumpPressed = true;
            }
            if(key == 's' && this.eventTopBoundaryContacts.size() == 1 && !isDescendingDownEventBlock) 
            {
                this.isDescendingDownEventBlock = true;
            }

        } else if(keyEvent.getAction() == KeyEvent.RELEASE) {
            if(key == 'a') {       //left
                this.moveLeftPressed = false;
            }
            if(key == 'd') {       //right
                 this.moveRightPressed = false;
            }
            if(key == 'w') {
                this.jumpPressed = false;
            }
        }

    }

    /**
     * runs continuously. handles player movement and physics
     */
    void draw() {
        if(this.isDescendingDownEventBlock) {
            this.handleEventBlockDescent();
        } else {
            this.handleHorizontalMovement();
            this.handleVerticalMovement();
        }

        this.pos.add(this.vel);
        
        fill(Constants.PLAYER_COLOR);
        this.show(); 
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

    /**
     * handle contact with horizontal boundary
     */
    void handleContactWithHorizontalBoundary(float boundaryYPoint, boolean isFloorBoundary) {
        if(isFloorBoundary) { // floor-like boundary
            if(this.vel.y > 0) {    // boundary only act like floor if this is falling onto boundary
                this.vel.y = 0;
                this.pos.y = boundaryYPoint - this.diameter / 2;
            }
        } else {    // ceiling-like boundary
            if(this.vel.y < 0) {    // boundary only act like ceiling if this is rising into boundary
                this.vel.y = 1;
                this.pos.y = boundaryYPoint + this.diameter / 2;
                this.pos.add(this.vel);
            }
        }
    }

    /**
     * handle contact with vertical boundary
     */
    void handleContactWithVerticalBoundary(float boundaryXPoint) {
        this.vel.x = 0;
        if(this.pos.x > boundaryXPoint) {   // left boundary
            this.ableToMoveLeft = false;
        } else {    // right boundary
            this.ableToMoveRight = false;
        }  
    }

    /**
     * handle contact with this and event boundary
     */
    void handleConactWithEventBoundary(EventBlockTopBoundary eventBlockTopBoundary, PVector endWarpPosition) {
        registerMethod("keyEvent", this); // connect this draw() from main draw()
        this.isDescendingDownEventBlock = false;
        if(endWarpPosition == null) {
            this.vel.y = Constants.CHARACTER_LAUNCH_EVENT_VERTICAL_VELOCITY;
        } else {
            this.pos.x = endWarpPosition.x;
            this.pos.y = endWarpPosition.y;

           getCurrentActiveViewBox().setViewBoxHorizontalPosition(this.pos.x);
            this.vel.y = Constants.CHARACTER_WARP_EVENT_VERTICAL_VELOCITY;
        }
        eventBlockTopBoundary.doesAffectPlayer = true;  // TODO: encapsulate
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
        this.vel.y = Constants.PLAYER_JUMP_KILL_ENEMY_HOP_VERTICAL_VELOCITY;
    }

    /**
     * handle this descent down event block
     */
    private void handleEventBlockDescent() {
        if(this.eventTopBoundaryContacts.size() == 1) {
            this.moveLeftPressed = false;
            this.moveRightPressed = false;
            this.jumpPressed = false;
            unregisterMethod("keyEvent", this); // disconnect this keyEvent() from main keyEvent()
            
            EventBlockTopBoundary firstEventTopBoundaryContacts = 
                this.eventTopBoundaryContacts.stream().findFirst().get();
                
            // TODO: encapsulate
            int middleOfBoundary = Math.round(
                (firstEventTopBoundaryContacts.endPoint.x + firstEventTopBoundaryContacts.startPoint.x) / 2);
            
            firstEventTopBoundaryContacts.doesAffectPlayer = false; // TODO: encapsulate
            this.pos.x = middleOfBoundary;    
            this.vel.x = 0;
            this.vel.y = Constants.EVENT_BLOCK_DESCENT_VERTICAL_VELOCITY;
        }
    }

    /**
     * handle horizontal movement of this
     */
    private void handleHorizontalMovement() {
        if(this.moveLeftPressed && this.ableToMoveLeft) {
            this.vel.x = -Constants.PLAYER_RUN_SPEED;
        }
        if(this.moveRightPressed && this.ableToMoveRight) {
            this.vel.x = Constants.PLAYER_RUN_SPEED;
        }
        if(!this.moveLeftPressed && !this.moveRightPressed) {
            this.vel.x = 0;
        }
    }

    /**
     * handle vertical movement of this
     */
    private void handleVerticalMovement() {
        if(this.jumpPressed) {    // jump button pressed/held
            if( this.numberOfFloorBoundaryContacts > 0 || 
                (this.numberOfVerticalBoundaryContacts > 0 && this.numberOfCeilingBoundaryContacts == 0) )
            { // able to jump
                this.vel.y = Constants.PLAYER_JUMP_VERTICAL_VELOCITY;
            } else {
                // for jumping higher the longer jump button is held
                this.vel.y = Math.min(
                    this.vel.y + global_gravity.y * Constants.VARIABLE_JUMP_GRAVITY_MULTIPLIER, 
                    Constants.MAX_VERTICAL_VELOCITY);
            }

        } else {    // jump button not pressed
            if(this.numberOfVerticalBoundaryContacts > 0) {   // touching wall
                this.handleOnWallPhysics();
            } else if(this.numberOfFloorBoundaryContacts == 0) {    // in air
                this.handleInAirPhysics();
            }
        }
    }

}
