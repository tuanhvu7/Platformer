public class Player extends Character {

    Player(int x, int y, int width, int height) {
        super(x, y, width, height);
    }

    // void keyEvent(KeyEvent keyEvent) {

    //     char keyPressed = keyEvent.getKey();
    //     println("keypressed");
    //     if (keyPressed == 'a') {
    //         isMovingLeft = true;
    //         PlayerStopHorizontal = false;
    //     }
    //     if (keyPressed == 'd') {
    //         this.isMovingRight = true;
    //         PlayerStopHorizontal = false;
    //     }
    //     if (keyPressed == 'w' && !this.isInAir) {
    //         this.isjJumping = true;
    //     }

    // }

    void draw() {

        if(isPlayerMovingLeft) {
            this.vel.x = -Constants.MAIN_CHARACTER_RUN_SPEED;
        }
        if(isPlayerMovingRight) {
            this.vel.x = Constants.MAIN_CHARACTER_RUN_SPEED;
        }

        if(!isPlayerMovingLeft && !isPlayerMovingRight) {
            this.vel.x = 0;
        }

        if(isPlayerJumping && playerCanJumpAgain) {
            this.vel.y = -Constants.MAIN_CHARACTER_JUMP_HEIGHT;
            playerCanJumpAgain = false;
        }
        this.pos.add(this.vel);
        if(!collideWithBoundary()) {
            this.pos.add(this.vel);
            this.vel.y += gravity.y;
        }
        this.show();
    }
}