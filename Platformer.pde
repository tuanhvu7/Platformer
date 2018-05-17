import java.util.Set;
import java.util.HashSet;

PVector global_gravity;
Player global_player;

void settings() {
    size(Constants.SCREEN_WIDTH, Constants.SCREEN_HEIGHT);
}

void setup() {

    background(Constants.SCREEN_BACKGROUND);
    global_gravity = new PVector(0, Constants.GRAVITY);
    global_player = new Player(width / 2 + 20, height / 2 - 100, 16, 16);

    Boundary floor = new Boundary(width / 2, height / 2, 100, 0, 5);
    Boundary floor2 = new Boundary(width / 2, height / 4, 100, 0, 5);
    Boundary floor3 = new Boundary(width / 2, height / 6, 100, 0, 5);
    Boundary floor4 = new Boundary(width / 2, height / 8, 100, 0, 5);

    registerMethod("draw", floor);
    registerMethod("draw", floor2);
    registerMethod("draw", floor3);
    registerMethod("draw", floor4);

    registerMethod("draw", global_player);
    registerMethod("keyEvent", global_player);
}

void draw() {
    background(Constants.SCREEN_BACKGROUND);
}
