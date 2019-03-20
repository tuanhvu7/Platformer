/**
 * common for levels
 */
public abstract class ALevel implements IDrawable {
    // player-controllable character
    Player player;

    // level viewbox
    ViewBox viewBox;

    // drawables in this
    final LevelDrawableCollection levelDrawableCollection;

    // pause menu for level
    private PauseMenu pauseMenu;

    // true means level is paused and menu appears
    private boolean isPaused;

    // checkpoint x position
    int checkpointXPos;

    // true means load player at checkpoint position
    boolean loadPlayerFromCheckPoint;

    // true means running handleLevelComplete thread
    private boolean isHandlingLevelComplete;

    /**
     * sets properties of this
     */
    ALevel(boolean isActive, boolean loadPlayerFromCheckPoint, int goalRightSideOffsetWithStageWidth) {

        this.levelDrawableCollection = new LevelDrawableCollection();

        this.isPaused = false;

        this.loadPlayerFromCheckPoint = loadPlayerFromCheckPoint;

        this.isHandlingLevelComplete = false;

        if (isActive) {
            this.setUpActivateLevel();
            this.setUpActivateWallsGoal(goalRightSideOffsetWithStageWidth);
        }
    }

    /**
     * active and add this to game
     */
    void makeActive() {
        registerMethod("keyEvent", this);   // connect this keyEvent() from main keyEvent()
        registerMethod("draw", this); // connect this draw() from main draw()
    }

    /**
     * setup and activate this; to override in extended classes
     */
    abstract void setUpActivateLevel();

    /**
     * handle conditional enemy triggers in this;
     * to override in extended classes if needed
     */
    void handleConditionalEnemyTriggers() {
    }

    /**
     * deactivate this;
     */
    public void deactivateLevel() {
        if (this.player != null) {
            this.player.makeNotActive();
        }

        this.viewBox.makeNotActive();

        this.levelDrawableCollection.deactivateClearAllDrawable();

        // make this not active
        unregisterMethod("keyEvent", this);   // connect this keyEvent() from main keyEvent()
        unregisterMethod("draw", this); // disconnect this draw() from main draw()
    }

    /**
     * close pause menu
     */
    public void closePauseMenu() {
        this.pauseMenu.deactivateMenu();
    }

    /**
     * runs continuously
     */
    @Override
    public void draw() {
        // draw background image horizontally until level width is filled
        int levelWidthLeftToDraw = getCurrentActiveLevelWidth();
        int numberHorizontalBackgroundIterations =
            (int) Math.ceil((double) getCurrentActiveLevelWidth() / getLevelBackgroundImage().width);

        int levelHeightLeftToDraw = getCurrentActiveLevelHeight();
        int numberVerticalBackgroundIterations =
            (int) Math.ceil((double) getCurrentActiveLevelHeight() / getLevelBackgroundImage().height);

        for (int i = 0; i < numberVerticalBackgroundIterations; i++) {
            for (int j = 0; j < numberHorizontalBackgroundIterations; j++) {
                int curIterationWidthToDraw =
                    Math.min(
                        getLevelBackgroundImage().width,
                        levelWidthLeftToDraw);

                int curIterationHeightToDraw =
                    Math.min(
                        getLevelBackgroundImage().height,
                        levelHeightLeftToDraw);

                int startYPosToDraw =
                    -i * getLevelBackgroundImage().height
                        - (getLevelBackgroundImage().height - curIterationHeightToDraw);

                image(
                    getLevelBackgroundImage(),
                    i * getLevelBackgroundImage().width, // start x pos
                    startYPosToDraw,  // start y pos
                    curIterationWidthToDraw,
                    curIterationHeightToDraw);

                levelWidthLeftToDraw -= curIterationWidthToDraw;
                levelHeightLeftToDraw -= curIterationHeightToDraw;
            }
        }

        this.handleConditionalEnemyTriggers();
    }

    /**
     * handle character keypress controls
     */
    public void keyEvent(KeyEvent keyEvent) {
        if (this.player != null && !this.isHandlingLevelComplete) {  // only allow pause if player is active
            // press 'p' for pause
            if (keyEvent.getAction() == KeyEvent.PRESS) {
                char keyPressed = keyEvent.getKey();

                if (keyPressed == 'p') {   // pause
                    this.isPaused = !this.isPaused;

                    if (this.isPaused) {
                        stopSong();
                        noLoop();
                        this.pauseMenu = new PauseMenu(
                            (int) this.viewBox.getPos().x,
                            true);

                    } else {
                        loopSong(ESongType.LEVEL);
                        loop();
                        this.closePauseMenu();
                    }
                }
            }
        }
    }

    /**
     * setup activate walls, and goal
     *
     * @param goalRightSideOffsetWithStageWidth offset of goal's right side relative to stage width
     *                                          (example: 50 means goal is 50 pixels less than stage width
     */
    private void setUpActivateWallsGoal(int goalRightSideOffsetWithStageWidth) {
        // stage goal
        this.levelDrawableCollection.addDrawable(new LevelGoal(
            getCurrentActiveLevelWidth() - Constants.LEVEL_GOAL_WIDTH - goalRightSideOffsetWithStageWidth,
            Constants.LEVEL_FLOOR_Y_POSITION - Constants.LEVEL_GOAL_HEIGHT,
            Constants.LEVEL_GOAL_WIDTH,
            Constants.LEVEL_GOAL_HEIGHT,
            Constants.DEFAULT_BOUNDARY_LINE_THICKNESS,
            true)
        );

        // stage right and left walls
        this.levelDrawableCollection.addDrawable(new VerticalBoundary(
            0,
            0,
            Constants.LEVEL_FLOOR_Y_POSITION,
            Constants.DEFAULT_BOUNDARY_LINE_THICKNESS,
            true
        ));

        this.levelDrawableCollection.addDrawable(new VerticalBoundary(
            getCurrentActiveLevelWidth(),
            0,
            Constants.LEVEL_FLOOR_Y_POSITION,
            Constants.DEFAULT_BOUNDARY_LINE_THICKNESS,
            true
        ));
    }

    /*** getters and setters ***/
    public Player getPlayer() {
        return player;
    }

    public void setPlayer(Player player) {
        this.player = player;
    }

    public ViewBox getViewBox() {
        return viewBox;
    }

    public LevelDrawableCollection getLevelDrawableCollection() {
        return levelDrawableCollection;
    }

    public void setPaused(boolean paused) {
        isPaused = paused;
    }

    public boolean isLoadPlayerFromCheckPoint() {
        return loadPlayerFromCheckPoint;
    }

    public void setLoadPlayerFromCheckPoint(boolean loadPlayerFromCheckPoint) {
        this.loadPlayerFromCheckPoint = loadPlayerFromCheckPoint;
    }

    public boolean isHandlingLevelComplete() {
        return isHandlingLevelComplete;
    }

    public void setHandlingLevelComplete(boolean handlingLevelComplete) {
        isHandlingLevelComplete = handlingLevelComplete;
    }
}
