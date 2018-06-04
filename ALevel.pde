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

    // list of all non-playable characters in level
    protected Set<ACharacter> charactersList;

    /**
     * sets level properties
     */
    ALevel(boolean isLevelLoaded, int levelNumber) {
        this.levelIndex = levelNumber - 1; // means level 1 is in index 0 of global_levels_list
        if(isLevelLoaded) {
            this.loadLevel();
        }
    }

   /**
    * load level
    */
    void loadLevel() {
        this.isLevelLoaded = true;
        registerMethod("draw", this); // connect this draw() from main draw()
    }

   /**
    * close level
    */
    void closeLevel() {
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
