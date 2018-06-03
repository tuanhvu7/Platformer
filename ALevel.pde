/**
 * common for levels
 */
abstract class ALevel {

    // true means this is loaded
    protected boolean isLevelLoaded;

    // (levelNumber - 1) is index of this in global_levels_list
    protected int levelNumber;

    // list of all non-playable characters in level
    protected Set<ACharacter> charactersList;

    /**
     * sets level properties
     */
    ALevel(boolean isLevelLoaded, int levelNumber) {
        this.levelNumber = levelNumber - 1;
        if(isLevelLoaded) {
            this.loadLevel();
        } else {
            this.closeLevel();
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
    void draw() { }

}