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

    /**
     * sets this's properties
     */
    ALevel(boolean isActive, int levelNumber) {

        this.charactersList = new HashSet<ACharacter>();
        this.boundariesList = new HashSet<ABoundary>();

        this.levelIndex = levelNumber; // means level 1 is in index 1 of global_levels_list

        if(isActive) {
            this.setUpActivateLevel();
        }
    }

   /**
    * setup and activate this; to override in level classes
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
        
        // make this not active
        this.isActive = false;
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

}
