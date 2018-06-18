/**
 * common for levels
 */
abstract class ALevel {

    // true means this is active
    protected boolean isActive;

    // index of this in global_levels_list
    protected int levelIndex;

    // player-controllable character
    protected Player player;

    // level viewbox
    protected ViewBox viewBox;

    // set of all non-playable characters in level
    protected Set<ACharacter> charactersList;

    // set of all boundaries in level
    protected Set<ABoundary> boundariesList;

    // set of all blocks in level
    protected Set<Block> blocksList;

    // pause menu for level
    private PauseMenu pauseMenu;

    // true means level is paused and menu appears
    protected boolean isPaused;

    /**
     * sets properties of this
     */
    ALevel(boolean isActive, int levelNumber) {

        this.charactersList = new HashSet<ACharacter>();
        this.boundariesList = new HashSet<ABoundary>();
        this.blocksList = new HashSet<Block>();

        this.levelIndex = levelNumber; // means level 1 is in index 1 of global_levels_list
        this.isPaused = false;

        if(isActive) {
            this.setUpActivateLevel();
        }
    }

    /**
     * active and add this to game
     */
    protected void makeActive() {
        this.isActive = true;
        registerMethod("keyEvent", this);   // connect this keyEvent() from main keyEvent()
        registerMethod("draw", this); // connect this draw() from main draw()
    }

   /**
    * setup and activate this; to override in extended classes
    */
    void setUpActivateLevel() { }

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

        for(Block curBlock : this.blocksList) {
            curBlock.makeNotActive();
        }

        this.charactersList = new HashSet<ACharacter>();
        this.boundariesList = new HashSet<ABoundary>();
        this.blocksList = new HashSet<Block>();
        
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
    * runs continuously; draws background of this
    */
    void draw() {
        // draw background image horizontally until level width is filled
        int levelWidthLeftToDraw = global_levels_width_array[this.levelIndex];
        int numberHorizontalBackgroundIterations = 
            (int) Math.ceil( (double) global_levels_width_array[this.levelIndex] / global_background_image.width);
        
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
                        loadLevelSong();
                        loopSong();
                        loop();
                        this.closePauseMenu();
                    }
                }

            }   
        }
    }
}
