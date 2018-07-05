/**
 * vertical line boundaries of blocks
 */
public class BlockVerticalBoundary extends VerticalBoundary {

    /**
     * set properties of this;
     * sets this to affect all characters and be visible
     */
    BlockVerticalBoundary(int startXPoint, int startyPoint, int y2Offset, int boundaryLineThickness, 
                            boolean isActive, int levelIndex) {
        super(startXPoint, startyPoint, y2Offset, boundaryLineThickness, isActive, levelIndex);
    }

    /**
     * set properties of this
     * sets this to affect all characters
     */
    BlockVerticalBoundary(int startXPoint, int startyPoint, int y2Offset, int boundaryLineThickness,
                            boolean isVisible, boolean isActive, int levelIndex) {
        super(startXPoint, startyPoint, y2Offset, boundaryLineThickness, isVisible, isActive, levelIndex);
    }

    /**
     * set properties of this
     */
    BlockVerticalBoundary(int startXPoint, int startyPoint, int y2Offset, int boundaryLineThickness,
                            boolean isVisible, boolean doesAffectPlayer, boolean doesAffectNonPlayers, 
                            boolean isActive, int levelIndex) {
        super(startXPoint, startyPoint, y2Offset, boundaryLineThickness,
                isVisible, doesAffectPlayer, doesAffectNonPlayers, isActive, levelIndex);
    }

}