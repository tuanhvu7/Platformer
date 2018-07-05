/**
 * horizontal line boundaries of blocks
 */
public class BlockHorizontalBoundary extends HorizontalBoundary {

    /**
     * set properties of this;
     * sets this to affect all characters and be visible
     */
    BlockHorizontalBoundary(int startXPoint, int startyPoint, int x2Offset, int boundaryLineThickness,
                            boolean isFloorBoundary, boolean isActive, int levelIndex) {
        super(startXPoint, startyPoint, x2Offset, boundaryLineThickness,
                isFloorBoundary, isActive, levelIndex);
    }

    /**
     * set properties of this
     * sets this to affect all characters
     */
    BlockHorizontalBoundary(int startXPoint, int startyPoint, int x2Offset, int boundaryLineThickness,
                            boolean isVisible, boolean isFloorBoundary,
                            boolean isActive, int levelIndex) {
        super(startXPoint, startyPoint, x2Offset, boundaryLineThickness,
                isVisible, isFloorBoundary, isActive, levelIndex);
    }

    /**
     * set properties of this
     */
    BlockHorizontalBoundary(int startXPoint, int startyPoint, int x2Offset, int boundaryLineThickness,
                            boolean isVisible, boolean doesAffectPlayer, boolean doesAffectNonPlayers,
                            boolean isFloorBoundary, boolean isActive, int levelIndex) {
        super(startXPoint, startyPoint, x2Offset, boundaryLineThickness,
                isVisible, doesAffectPlayer, doesAffectNonPlayers,
                isFloorBoundary, isActive, levelIndex);
    }

}