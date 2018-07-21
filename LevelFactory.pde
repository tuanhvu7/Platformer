/**
 * for creating appropriate level
 */
public class LevelFactory {

    /**
    * return appropriate level
    */
    public ALevel getLevel(boolean makeActive) {
        switch (global_current_active_level_number) {
            case 1:
                return new LevelOne(makeActive);
            
            case 2:
                return new LevelTwo(makeActive);
            
            default:
                return null;
        }
    }
}