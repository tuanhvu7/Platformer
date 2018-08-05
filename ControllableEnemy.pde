/**
 * controllable enemy
 */
public class ControllableEnemy extends Enemy {

    private boolean jumpPressed;

    /**
     * set properties of this
     */
    public ControllableEnemy(int x, int y, int diameter, float runSpeed,
                             boolean isFlying, boolean isInvulnerable, boolean isVisible, boolean isActive) {
        super(x, y, diameter, runSpeed, isFlying, isInvulnerable, isVisible, isActive);
        this.jumpPressed = false;
    }


    /**
     * active and add this to game
     */
    @Override
    public void makeActive() {
        registerMethod("draw", this); // connect this draw() from main draw()
        registerMethod("keyEvent", this); // disconnect this keyEvent() from main keyEvent()
    }

    /**
     * deactivate and remove this from game
     */
    @Override
    public void makeNotActive() {
        unregisterMethod("draw", this); // disconnect this draw() from main draw()
        unregisterMethod("keyEvent", this); // disconnect this keyEvent() from main keyEvent()
    }

    /**
     * handle movement (position, velocity)
     */
    @Override
    void handleMovement() {
        if (!this.isFlying) {

            if (this.jumpPressed) {    // jump button pressed/held
                if (this.numberOfFloorBoundaryContacts > 0) { // able to jump
                    this.vel.y = Constants.PLAYER_JUMP_VERTICAL_VELOCITY;
                } else {
                    // for jumping higher the longer jump button is held
                    this.vel.y = Math.min(
                        this.vel.y + getGravity().y * Constants.VARIABLE_JUMP_GRAVITY_MULTIPLIER,
                        Constants.MAX_VERTICAL_VELOCITY);
                }

            } else if (this.numberOfFloorBoundaryContacts == 0) {    // in air
                this.handleInAirPhysics();
            }
        }

        this.pos.add(this.vel);
    }

    /**
     * handle character keypress controls
     */
    public void keyEvent(KeyEvent keyEvent) {
        if (keyEvent.getAction() == KeyEvent.PRESS) {
            if (keyEvent.getKey() == 'w') {
                this.jumpPressed = true;
            }

        } else if (keyEvent.getAction() == KeyEvent.RELEASE) {
            if (keyEvent.getKey() == 'w') {
                this.jumpPressed = false;
            }
        }
    }

}