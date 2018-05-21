/**
 * Main sketch file
 */
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
    global_player = new Player(width / 2, 0, 16, 16);

    // HorizontalBoundary floor = new HorizontalBoundary(width / 2, height / 2, 100, 1, true);
    // registerMethod("draw", floor);
    // HorizontalBoundary floor2 = new HorizontalBoundary(width / 2, height / 4, 100, 1, true);
    // registerMethod("draw", floor2);
    // HorizontalBoundary floor3 = new HorizontalBoundary(width / 2, height / 6, 100, 1, false);
    // registerMethod("draw", floor3);
    // HorizontalBoundary floor4 = new HorizontalBoundary(width / 2, height / 8, 100, 1, true);
    // registerMethod("draw", floor4);

    HorizontalBoundary floor = new HorizontalBoundary(0, height - 100, width - 100, 1, true);
    registerMethod("draw", floor);

    // VerticalBoundary wall = new VerticalBoundary(width / 2, 0, height - 100, 1);
    VerticalBoundary wall = new VerticalBoundary(width / 2, height-100, -200, 1);
    registerMethod("draw", wall);

    registerMethod("draw", global_player);
    registerMethod("keyEvent", global_player);
}

void draw() {
    background(Constants.SCREEN_BACKGROUND);
}
