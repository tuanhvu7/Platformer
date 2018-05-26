public class Enemy extends ACharacter implements ICharacter {

  // true means flying enemy (not affected by gravity)
  boolean isFlying;

  // true means invulnerable, cannot be killed by player contact
  boolean isInvulnerable;

  // true means visible by player
  boolean isVisible;

  // active means still in game (boundary and player collision detection)
  boolean isActive;

  /**
   * Set player properties
   */
  Enemy(int x, int y, int width, int height, boolean isFlying, boolean isInvulnerable, boolean isVisible) {
      super(x, y, width, height);
      this.vel.x = -Constants.ENEMY_RUN_SPEED;
      
      this.isFlying = isFlying;
      this.isInvulnerable = isInvulnerable;
      this.isVisible = isVisible;

  }

  /**
   * runs continuously. handles enemy movement and physics
   */
  void draw() {
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
