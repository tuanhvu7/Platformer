/**
 * common for levels
 */
public abstract class ALevel implements IDrawable {

    // true means this is active
    boolean isActive;

    // player-controllable character
    Player player;

    // level viewbox
    ViewBox viewBox;

    // set of all non-playable characters in level
    final Set<ACharacter> charactersList;

    // set of all boundaries in level
    final Set<ABoundary> boundariesList;

    // set of all blocks in level
    final Set<ABlock> blocksList;

    // set of all collectables in level
    final Set<ACollectable> collectablesList;

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

        this.charactersList = new HashSet<ACharacter>();
        this.boundariesList = new HashSet<ABoundary>();
        this.blocksList = new HashSet<ABlock>();
        this.collectablesList = new HashSet<ACollectable>();

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
        this.isActive = true;
        registerMethod("keyEvent", this);   // connect this keyEvent() from main keyEvent()
        registerMethod("draw", this); // connect this draw() from main draw()
    }

    /**
     * setup and activate this; to override in extended classes
     */
    void setUpActivateLevel() {
    }

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
        this.player.makeNotActive();

        this.viewBox.makeNotActive();

        for (ACharacter curCharacter : this.charactersList) {
            curCharacter.makeNotActive();
        }

        for (ABoundary curBoundary : this.boundariesList) {
            curBoundary.makeNotActive();
        }

        for (ABlock curBlock : this.blocksList) {
            curBlock.makeNotActive();
        }

        for (ACollectable curCollectable : this.collectablesList) {
            curCollectable.makeNotActive();
        }

        this.charactersList.clear();
        this.boundariesList.clear();
        this.blocksList.clear();
        this.collectablesList.clear();

        // make this not active
        this.isActive = false;
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

        for (int i = 0; i < numberHorizontalBackgroundIterations; i++) {
            int widthToDraw =
                Math.min(
                    getLevelBackgroundImage().width,
                    levelWidthLeftToDraw);

            image(
                getLevelBackgroundImage(),
                i * getLevelBackgroundImage().width,
                0,
                widthToDraw,
                getLevelBackgroundImage().height);

            levelWidthLeftToDraw -= widthToDraw;
        }

        this.handleConditionalEnemyTriggers();
    }

    /**
     * handle character keypress controls
     */
    public void keyEvent(KeyEvent keyEvent) {
        if (this.player.isActive() && !this.isHandlingLevelComplete) {  // only allow pause if player is active
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
        this.collectablesList.add(new LevelGoal(
            
            getCurrentActiveLevelWidth() - Constants.LEVEL_GOAL_WIDTH - goalRightSideOffsetWithStageWidth,
            Constants.LEVEL_FLOOR_Y_POSITION - Constants.LEVEL_GOAL_HEIGHT,
            Constants.LEVEL_GOAL_WIDTH,
            Constants.LEVEL_GOAL_HEIGHT,
            Constants.DEFAULT_BOUNDARY_LINE_THICKNESS,
            this.isActive)
        );

        // stage right and left walls
        this.boundariesList.add(new VerticalBoundary(
            0,
            0,
            Constants.LEVEL_FLOOR_Y_POSITION,
            Constants.DEFAULT_BOUNDARY_LINE_THICKNESS,
            this.isActive
        ));

        this.boundariesList.add(new VerticalBoundary(
            getCurrentActiveLevelWidth(),
            0,
            Constants.LEVEL_FLOOR_Y_POSITION,
            Constants.DEFAULT_BOUNDARY_LINE_THICKNESS,
            this.isActive
        ));
    }

    /*** getters and setters ***/
    public Player getPlayer() {
        return player;
    }

    public ViewBox getViewBox() {
        return viewBox;
    }

    public Set<ACharacter> getCharactersList() {
        return charactersList;
    }

    public Set<ABlock> getBlocksList() {
        return blocksList;
    }

    public Set<ACollectable> getCollectablesList() {
        return collectablesList;
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
