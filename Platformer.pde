Character global_player;
PVector global_gravity;

boolean global_isPlayerMovingLeft;
boolean global_isPlayerMovingRight;
boolean global_isPlayerJumping;
boolean global_playerOnGround;

void settings() {
    size(Constants.SCREEN_WIDTH, Constants.SCREEN_HEIGHT);
}

void setup() {

    background(Constants.SCREEN_BACKGROUND);
    global_gravity = new PVector(0, Constants.GRAVITY);
    global_player = new Player(width / 2 + 20, height / 2 - 100, 16, 16);
    global_isPlayerMovingLeft = false;
    global_isPlayerMovingRight = false;
    global_isPlayerJumping = false;
    global_playerOnGround = false;

    Boundary floor = new Boundary(width / 2, height / 2, 100, 0, 5);
    // Boundary floor2 = new Boundary(width / 2, height / 4, 100, 0, 5);

    // Boundary floor3 = new Boundary(width / 2, height / 6, 100, 0, 5);
    // Boundary floor4 = new Boundary(width / 2, height / 8, 100, 0, 5);

    registerMethod("draw", floor);
    // registerMethod("draw", floor2);
    // registerMethod("draw", floor3);
    // registerMethod("draw", floor4);

    registerMethod("draw", global_player);
    // registerMethod("keyEvent", global_player);
}

void draw() {
    background(Constants.SCREEN_BACKGROUND);
}

void keyPressed() {
    if (key == 'a') {//left
        global_isPlayerMovingLeft = true;
    }
    if (key == 'd') {//right
        global_isPlayerMovingRight = true;
    }
    if (key == 'w') {
        global_isPlayerJumping = true;
        global_playerOnGround = false;
    }
}

void keyReleased() {
    if (key == 'a') {//left
        global_isPlayerMovingLeft = false;
    }
    if (key == 'd') {//right
        global_isPlayerMovingRight = false;
    }
    if (key == 'w') {
        global_isPlayerJumping = false;
	}
}

