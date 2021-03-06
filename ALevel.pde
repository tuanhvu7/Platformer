/**
 * common for levels
 */
public abstract class ALevel implements IDrawable, IKeyControllable {
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
    ALevel(boolean initAsActive, boolean loadPlayerFromCheckPoint, int goalRightSideOffsetWithStageWidth) {

        this.levelDrawableCollection = new LevelDrawableCollection();

        this.isPaused = false;

        this.loadPlayerFromCheckPoint = loadPlayerFromCheckPoint;

        this.isHandlingLevelComplete = false;

        if (initAsActive) {
            this.setUpActivateLevel();
            this.setUpActivateWallsGoal(goalRightSideOffsetWithStageWidth);
        }
    }

    /**
     * active and add this to game
     */
    void makeActive() {
        registerMethod(EProcessingMethods.KEY_EVENT.toString(), this);   // connect this keyEvent() from main keyEvent()
        registerMethod(EProcessingMethods.DRAW.toString(), this); // connect this draw() from main draw()
    }

    /**
     * setup and activate this; to override in extended classes
     */
    abstract void setUpActivateLevel();

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
        unregisterMethod(EProcessingMethods.KEY_EVENT.toString(), this);   // connect this keyEvent() from main keyEvent()
        unregisterMethod(EProcessingMethods.DRAW.toString(), this); // disconnect this draw() from main draw()
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
        this.drawBackground();
    }

    /**
     * handle character keypress controls
     */
    @Override
    public void keyEvent(KeyEvent keyEvent) {
        if (this.player != null && !this.isHandlingLevelComplete) {  // only allow pause if player is active
            // press 'p' for pause
            if (keyEvent.getAction() == KeyEvent.PRESS) {
                String keyPressed = keyEvent.getKey() + "";

                if (EReservedControlKeys.p.toString().equalsIgnoreCase(keyPressed)) {   // pause
                    this.isPaused = !this.isPaused;

                    if (this.isPaused) {
                        resourceUtils.stopSong();
                        noLoop();
                        this.pauseMenu = new PauseMenu(
                            (int) this.viewBox.getPos().x,
                            true);

                    } else {
                        resourceUtils.loopSong(ESongType.LEVEL);
                        loop();
                        this.closePauseMenu();
                    }
                }
            }
        }
    }

    /**
     * draw background at proper location
     */
    void drawBackground() {
        // for scrolling background
        translate(-this.viewBox.getPos().x, -this.viewBox.getPos().y);

        int levelWidthLeftToDraw = getCurrentActiveLevelWidth();
        int numberHorizontalBackgroundIterations =
            (int) Math.ceil((double) getCurrentActiveLevelWidth() / Constants.SCREEN_WIDTH);
        for (int curHorizontalItr = 0; curHorizontalItr < numberHorizontalBackgroundIterations; curHorizontalItr++) {
            int curIterationWidthToDraw =
                Math.min(
                    Constants.SCREEN_WIDTH,
                    levelWidthLeftToDraw);

            // lazy load level background
            final int curItrLeftX = curHorizontalItr * Constants.SCREEN_WIDTH;
            final boolean viewBoxInCurXRange =
                (curItrLeftX <= this.viewBox.getPos().x
                    && curItrLeftX + Constants.SCREEN_WIDTH >= this.viewBox.getPos().x)
                    || (curItrLeftX <= this.viewBox.getPos().x + Constants.SCREEN_WIDTH
                    && curItrLeftX + Constants.SCREEN_WIDTH >= this.viewBox.getPos().x + Constants.SCREEN_WIDTH);

            if (viewBoxInCurXRange) {
                int levelHeightLeftToDraw = getCurrentActiveLevelHeight();
                int numberVerticalBackgroundIterations =
                    (int) Math.ceil((double) getCurrentActiveLevelHeight() / Constants.SCREEN_HEIGHT);

                for (int curVerticalItr = 0; curVerticalItr < numberVerticalBackgroundIterations; curVerticalItr++) {
                    int curIterationHeightToDraw =
                        Math.min(
                            Constants.SCREEN_HEIGHT,
                            levelHeightLeftToDraw);

                    int startYPosToDraw =
                        -curVerticalItr * Constants.SCREEN_HEIGHT
                            + (Constants.SCREEN_HEIGHT - curIterationHeightToDraw);

                    image(
                        resourceUtils.levelBackgroundImage,
                        (curHorizontalItr * Constants.SCREEN_WIDTH), // start x pos
                        startYPosToDraw,  // start y pos
                        curIterationWidthToDraw,
                        curIterationHeightToDraw,

                        0,
                        0,
                        curIterationWidthToDraw,
                        curIterationHeightToDraw);

                    levelHeightLeftToDraw -= curIterationHeightToDraw;
                }
            }
            levelWidthLeftToDraw -= curIterationWidthToDraw;
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
