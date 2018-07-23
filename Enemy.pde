/**
 * enemy
 */
public class Enemy extends ACharacter implements IDrawable {

    // true means flying enemy (not affected by gravity)
    private boolean isFlying;

    // true means invulnerable, cannot be killed by player contact
    private boolean isInvulnerable;

    // true means visible by player
    private boolean isVisible;

    /**
     * set properties of this
     */
    Enemy(int x, int y, int diameter,
            boolean isFlying, boolean isInvulnerable, boolean isVisible, boolean isActive) {
        super(x, y, diameter, isActive);
        this.vel.x = -Constants.ENEMY_RUN_SPEED;

        this.isFlying = isFlying;
        this.isInvulnerable = isInvulnerable;
        this.isVisible = isVisible;
    }

    /**
     * return angle of collision between this and player;
     * range of collision angles (in degrees): [0, 90]
     * negative angle means no collision
     */
    double collisionWithPlayer() {
        float xDifference = Math.abs(this.pos.x - getCurrentActivePlayer().pos.x); // TODO: encapsulate
        float yDifference = Math.abs(this.pos.y - getCurrentActivePlayer().pos.y); // TODO: encapsulate

        // distance between player and this must be sum of their radii for collision
        float distanceNeededForCollision = (this.diameter / 2) + (getCurrentActivePlayer().diameter / 2); // TODO: encapsulate

        // pythagorean theorem
        boolean isAtCollisionDistance =
            Math.sqrt(Math.pow(xDifference, 2) + Math.pow(yDifference, 2)) <= distanceNeededForCollision;

        if(isAtCollisionDistance) {
            return Math.atan2(yDifference, xDifference);
        } else {
            return -1.0;
        }
    }

    /**
     * runs continuously. handles enemy movement and physics
     */
    void draw() {
        this.checkHandleContactWithPlayer();
        this.handleMovement();

        if(this.isVisible) {
            fill(Constants.ENEMY_COLOR);
            this.show();
        }
    }

    /**
     *  check and handle contact with player
     */
    private void checkHandleContactWithPlayer() {
        if(getCurrentActivePlayer().isActive) {   // TODO: encapsulate
            double collisionAngle = this.collisionWithPlayer();
            if(collisionAngle >= 0) {
                println("coll angle: " + Math.toDegrees(collisionAngle));
                println("min angle: " + Constants.MIN_PLAYER_KILL_ENEMY_COLLISION_ANGLE);
                if(Math.toDegrees(collisionAngle) >= Constants.MIN_PLAYER_KILL_ENEMY_COLLISION_ANGLE 
                    && this.pos.y > getCurrentActivePlayer().pos.y)  // player is above this // TODO: encapsulate
                {
                    println("killed enemy: " + Math.toDegrees(collisionAngle));
                    this.makeNotActive();
                    getCurrentActiveCharactersList().remove(this);
                    getCurrentActivePlayer().handleJumpKillEnemyPhysics();

                } else {
                    println("killed player: " + Math.toDegrees(collisionAngle));
                    resetLevel();
                }
            }
        }
    }

   /**
    * handle movement (position, velocity)
    */
    private void handleMovement() {
        if(this.numberOfFloorBoundaryContacts == 0 && !this.isFlying) {
            this.handleInAirPhysics();
        }

        this.pos.add(this.vel);
    }

}
