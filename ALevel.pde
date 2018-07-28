/**
 * common for levels
 */
abstract class ALevel {

    // true means this is active
    protected boolean isActive;

    // player-controllable character
    protected Player player;

    // level viewbox
    protected ViewBox viewBox;

    // level checkpoint
    protected Checkpoint checkpoint;

    // set of all non-playable characters in level
    protected Set<ACharacter> charactersList;

    // set of all boundaries in level
    protected Set<ABoundary> boundariesList;

    // set of all blocks in level
    protected Set<ABlock> blocksList;

    // pause menu for level
    private PauseMenu pauseMenu;

    // true means level is paused and menu appears
    protected boolean isPaused;

    // checkpoint x position
    protected int checkpointXPos;

    // true means load player at checkpoint position
    protected boolean loadPlayerFromCheckPoint;

    /**
     * sets properties of this
     */
    ALevel(boolean isActive, boolean loadPlayerFromCheckPoint) {

        this.charactersList = new HashSet<ACharacter>();
        this.boundariesList = new HashSet<ABoundary>();
        this.blocksList = new HashSet<ABlock>();

        this.isPaused = false;

        this.loadPlayerFromCheckPoint = loadPlayerFromCheckPoint;

        if(isActive) {
            this.setUpActivateLevel();
            this.setUpActivateFloorWalls();
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
    void setUpActivateLevel() { }

    /**
     * handle conditional enemy triggers in this;
     * to override in extended classes if needed
     */
    void handleConditionalEnemyTriggers() { }


    /**
     * deactiviate this
     */
    void deactivateLevel() {
        this.viewBox.makeNotActive();

        for(ACharacter curCharacter : this.charactersList) {
            curCharacter.makeNotActive();
        }

        for(ABoundary curBoundary : this.boundariesList) {
            curBoundary.makeNotActive();
        }

        for(ABlock curBlock : this.blocksList) {
            curBlock.makeNotActive();
        }

        this.charactersList.clear();
        this.boundariesList.clear();
        this.blocksList.clear();
        
        // make this not active
        this.isActive = false;
        unregisterMethod("keyEvent", this);   // connect this keyEvent() from main keyEvent()
        unregisterMethod("draw", this); // disconnect this draw() from main draw()
    }

    /**
     * deactiviate player;
     * for removing player while letting game run during player death handling
     */
    void deactivatePlayer() {
        this.player.makeNotActive();
    }

    /**
     * close pause menu
     */
    void closePauseMenu() {
        this.pauseMenu.deactivateMenu();
    }

   /**
    * runs continuously
    */
    void draw() {
        // draw background image horizontally until level width is filled
        int levelWidthLeftToDraw = getCurrentActiveLevelWidth();
        int numberHorizontalBackgroundIterations = 
            (int) Math.ceil( (double) getCurrentActiveLevelWidth() / global_background_image.width);
        
        for(int i = 0; i < numberHorizontalBackgroundIterations; i++) {
            int widthToDraw = 
            Math.min(
                global_background_image.width, 
                levelWidthLeftToDraw);
            
            image(
                global_background_image, 
                i * global_background_image.width, 
                0, 
                widthToDraw, 
                global_background_image.height);

            levelWidthLeftToDraw -= widthToDraw;
        }

        this.handleConditionalEnemyTriggers();
    }
        
    /**
     * handle character keypress controls
     */
    void keyEvent(KeyEvent keyEvent) {
        if(this.player.isActive) {  // only allow pause if player is active // TODO: encapsulate
            // press 'p' for pause
            if(keyEvent.getAction() == KeyEvent.PRESS) {
                char keyPressed = keyEvent.getKey();

                if(keyPressed == 'p') {   // pause
                    this.isPaused = !this.isPaused;

                    if(this.isPaused) {
                        stopSong();
                        noLoop();
                        this.pauseMenu = new PauseMenu(
                            (int) this.viewBox.pos.x, // TODO: encapsulate
                            true);

                    } else {
                        loopSong(ESongType.Level);
                        loop();
                        this.closePauseMenu();
                    }
                }
            }
        }
    }

   /**
    * setup activate floor and walls
    */
    protected void setUpActivateFloorWalls() {
        // stage floor
        this.boundariesList.add(new HorizontalBoundary(
            0,
            Constants.LEVEL_FLOOR_Y_POSITION,
            getCurrentActiveLevelWidth(),
            Constants.DEFAULT_BOUNDARY_LINE_THICKNESS,
            true,
            this.isActive
        ));

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
}
