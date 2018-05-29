public class Enemy extends ACharacter implements IDrawable {

  // true means flying enemy (not affected by gravity)
  boolean isFlying;

  // true means invulnerable, cannot be killed by player contact
  boolean isInvulnerable;

  // true means visible by player
  boolean isVisible;

  /**
   * Set player properties
   */
  Enemy(int x, int y, int diameter, boolean isFlying, boolean isInvulnerable, boolean isVisible) {
      super(x, y, diameter);
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
    float xDifference = Math.abs(this.pos.x - global_player.pos.x);   // TODO: encapsulate
    float yDifference =  Math.abs(this.pos.y - global_player.pos.y);  // TODO: encapsulate

    // distance between player and this must be sum of their radii for collision
    float distanceNeededForCollision = (this.diameter / 2) + (global_player.diameter / 2);  // TODO: encapsulate

    // pythagorean theorem
    boolean isAtCollisionDistance = 
      Math.sqrt(Math.pow(xDifference, 2) +  Math.pow(yDifference, 2)) <= distanceNeededForCollision;

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
      // check collision with player
      double collisionAngle = this.collisionWithPlayer();
      if(collisionAngle >= 0) {
        if(collisionAngle >= Math.toRadians(Constants.MIN_PLAYER_KILL_ENEMY_COLLISION_ANGLE)
            && this.pos.y > global_player.pos.y) {  // player is above this // TODO: encapsulate
          
          this.removeFromGame();
          global_player.handleJumpKillEnemyPhysics();

        } else {
          global_player.removeFromGame();
        }
      }

      // check collision with boundary
      if(this.numberOfHorizontalBoundaryContacts == 0 && !this.isFlying) {
        this.handleInAirPhysics();
      }

      this.pos.add(this.vel);

      if(this.isVisible) {
        fill(Constants.ENEMY_COLOR);
        this.show();
      }

  }

}
