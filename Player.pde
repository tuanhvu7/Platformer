public class Player extends Character {

    Player(int x, int y, int width, int height) {
        super(x, y, width, height);
    }

    void draw() {

        if(global_isPlayerMovingLeft) {
            this.vel.x = -Constants.MAIN_CHARACTER_RUN_SPEED;
        }
        if(global_isPlayerMovingRight) {
            this.vel.x = Constants.MAIN_CHARACTER_RUN_SPEED;
        }

        if(!global_isPlayerMovingLeft && !global_isPlayerMovingRight) {
            this.vel.x = 0;
        }

        if(global_isPlayerJumping && global_playerOnGround) {
            this.vel.y = -Constants.MAIN_CHARACTER_JUMP_HEIGHT;
            global_playerOnGround = false;
        }
        this.pos.add(this.vel);
        
        this.show();
    }
}