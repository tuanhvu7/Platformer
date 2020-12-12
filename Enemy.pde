/**
 * enemy
 */
public class Enemy extends ACharacter {

    // true means invulnerable; always kills player on contact
    private final boolean isInvulnerable;

    boolean isVisible;

    /**
     * set properties of this
     */
    public Enemy(int x, int y, int diameter, float horizontalVel,
                 boolean isInvulnerable, boolean isVisible, boolean initAsActive) {
        super(x, y, diameter, initAsActive);

        this.fillColor = Constants.ENEMY_COLOR;

        this.vel.x = horizontalVel;

        this.isInvulnerable = isInvulnerable;
        this.isVisible = isVisible;
    }

    /**
     * runs continuously. handles enemy movement and physics
     */
    @Override
    public void draw() {
        this.checkHandleOffscreenDeath();

        if (getCurrentActivePlayer() != null) {
            this.checkHandleContactWithPlayer();
        }
        this.handleMovement();

        if (this.isVisible) {
            this.show();
        }
    }

    /**
     * draw circle character
     */
    @Override
    void show() {
        if (this.isInvulnerable) {
            fill(
                random(0, 255),
                random(0, 255),
                random(0, 255));
        } else {
            fill(this.fillColor);
        }
        strokeWeight(0);
        ellipse(this.pos.x, this.pos.y, this.diameter, this.diameter);
    }

    /**
     * check and handle contact with player
     */
    private void checkHandleContactWithPlayer() {
        Player curPlayer = getCurrentActivePlayer();
        if (curPlayer.isCanHaveContactWithEnemies()) {   // to prevent multiple consecutive deaths and damage
            double collisionAngle = this.collisionWithPlayer();
            if (collisionAngle >= 0) {
                if (Math.toDegrees(collisionAngle) >= Constants.MIN_PLAYER_KILL_ENEMY_COLLISION_ANGLE
                    && this.pos.y > curPlayer.getPos().y
                    && !this.isInvulnerable)  // player is above this
                {
                    this.handleDeath(false);

                } else {
                    this.isVisible = true;
                    curPlayer.changeHealth(-1);
                }
            }
        }
    }

    /**
     * return angle of collision between this and player;
     * range of collision angles (in degrees): [0, 90]
     * negative angle means no collision
     */
    private double collisionWithPlayer() {
        Player curPlayer = getCurrentActivePlayer();
        float xDifference = Math.abs(this.pos.x - curPlayer.getPos().x);
        float yDifference = Math.abs(this.pos.y - curPlayer.getPos().y);

        // distance between player and this must be sum of their radii for collision
        float distanceNeededForCollision = (this.diameter / 2) + (curPlayer.getDiameter() / 2);

        // pythagorean theorem
        boolean isAtCollisionDistance =
            Math.sqrt(Math.pow(xDifference, 2) + Math.pow(yDifference, 2)) <= distanceNeededForCollision;

        if (isAtCollisionDistance) {
            return Math.atan2(yDifference, xDifference);
        } else {
            return -1.0;
        }
    }

    /**
     * handle movement (position, velocity)
     */
    @Override
    void handleMovement() {
        this.handleInAirPhysics();
        this.pos.add(this.vel);
    }

    /**
     * handle death
     */
    @Override
    void handleDeath(boolean isOffscreenDeath) {
        this.makeNotActive();
        getCurrentActiveLevelDrawableCollection().removeDrawable(this);
        if (!isOffscreenDeath) {
            resourceUtils.playSong(ESongType.PLAYER_ACTION);
            getCurrentActivePlayer().handleJumpKillEnemyPhysics();
        }
    }

}