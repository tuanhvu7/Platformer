/**
 * for creating appropriate level
 */
public class LevelFactory {

    /**
    * return appropriate level
    */
    public ALevel getLevel(boolean makeActive, boolean loadPlayerFromCheckPoint) {
        switch (global_current_active_level_number) {
            case 1:
                return new LevelOne(makeActive, loadPlayerFromCheckPoint);
            
            case 2:
                return new LevelTwo(makeActive, loadPlayerFromCheckPoint);
            
            default:
                return null;
        }
    }
}