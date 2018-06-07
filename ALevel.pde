/**
 * common for levels
 */
abstract class ALevel {

    // true means this is loaded
    protected boolean isLevelLoaded;

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
     * sets level properties
     */
    ALevel(boolean isLevelLoaded, int levelNumber) {

        this.charactersList = new HashSet<ACharacter>();
        this.boundariesList = new HashSet<ABoundary>();

        this.levelIndex = levelNumber - 1; // means level 1 is in index 0 of global_levels_list
    }

   /**
    * setup level; to override in level classes
    */
    void setUpLevel() { }

    /**
     * deactiviate player
     */
    void deactivatePlayer() {
        this.player.makeNotActive();
    }

    /**
     * deactiviate level
     */
    void deactivateLevel() {
        this.viewBox.makeNotActive();

        for(ACharacter curCharacter : this.charactersList) {
            curCharacter.makeNotActive();
        }

        for(ABoundary curBoundary : this.boundariesList) {
            curBoundary.makeNotActive();
        }
        
        this.makeNotActive();
    }

   /**
    * register draw() for level
    */
    void makeActive() {
        this.isLevelLoaded = true;
        registerMethod("draw", this); // connect this draw() from main draw()
    }

   /**
    * unregister draw() for level
    */
    void makeNotActive() {
        this.isLevelLoaded = false;
        unregisterMethod("draw", this); // disconnect this draw() from main draw()
    }

   /**
    * runs continuously
    */
    void draw() {
        // draw background image horizontally until level width is filled
        int levelWidthLeftToDraw = global_levels_width_array[this.levelIndex];
        int numberHorizontalBackgroundIterations = 
            (int) Math.ceil( (double) global_levels_width_array[this.levelIndex] / backgroundImage.width);
        
        for(int i = 0; i < numberHorizontalBackgroundIterations; i++) {
            int widthToDraw = 
            Math.min(
                backgroundImage.width, 
                levelWidthLeftToDraw);
            
            image(
                backgroundImage, 
                i * backgroundImage.width, 
                0, 
                widthToDraw, 
                backgroundImage.height);

            levelWidthLeftToDraw -= widthToDraw;
        }
    }

}
