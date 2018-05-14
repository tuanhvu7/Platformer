Character Player;
PVector gravity;
ArrayList<Boundary> boundaryList;

boolean PlayerStopHorizontal;
boolean PlayerVerticalStill;

boolean isPlayerMovingLeft;
boolean isPlayerMovingRight;
boolean isPlayerJumping;
boolean playerCanJumpAgain;

void settings() {
    size(Constants.SCREEN_WIDTH, Constants.SCREEN_HEIGHT);
}

void setup() {

    boundaryList = new ArrayList<Boundary>();

    background(Constants.SCREEN_BACKGROUND);
    gravity = new PVector(0, Constants.GRAVITY);
    Player = new Player(width / 2 + 20, height / 2 - 100, 16, 16);
    isPlayerMovingLeft = false;
    isPlayerMovingRight = false;
    isPlayerJumping = false;
    playerCanJumpAgain = false;

    Boundary floor = new Boundary(width / 2, height / 2, 100, 0, 5);
    Boundary floor2 = new Boundary(width / 2, height / 4, 100, 0, 5);

    Boundary floor3 = new Boundary(width / 2, height / 6, 100, 0, 5);
    Boundary floor4 = new Boundary(width / 2, height / 8, 100, 0, 5);

    boundaryList.add(floor);
    boundaryList.add(floor2);
    boundaryList.add(floor3);
    boundaryList.add(floor4);
    registerMethod("draw", Player);
    // registerMethod("keyEvent", Player);
}

void draw() {
    background(Constants.SCREEN_BACKGROUND);

    for(int i = 0; i < boundaryList.size(); i++) {
        boundaryList.get(i).show();
    }
}

void keyPressed() {
    if (key == 'a') {//left
        isPlayerMovingLeft = true;
    }
    if (key == 'd') {//right
        isPlayerMovingRight = true;
    }
    if (key == 'w') {
        isPlayerJumping = true;
        playerCanJumpAgain = false;
    }
}

void keyReleased() {
    println("keyreleased");
    if (key == 'a') {//left
        isPlayerMovingLeft = false;
    }
    if (key == 'd') {//right
        isPlayerMovingRight = false;
    }
    if (key == 'w') {
        isPlayerJumping = false;
	}
}

