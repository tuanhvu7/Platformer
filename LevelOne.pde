/**
 * Level one
 */
public class LevelOne extends ALevel implements IDrawable {

    /**
     * sets properties, boundaries, and characters of this
     */
    LevelOne(boolean isActive, int levelNumber) {
        super(isActive, levelNumber);
    }

    /**
     * setup and activate this
     */
    void setUpActivateLevel() {
        this.makeActive();

        this.viewBox = new ViewBox(0, 0, this.levelIndex, this.isActive);
        this.player = new Player(200, 0, Constants.PLAYER_DIAMETER, this.isActive, this.levelIndex);

        loopSong(true);

        int stageFloorYPositon = height - 100;

        charactersList.add(new Enemy(
            global_levels_width_array[this.levelIndex] - 500,
            0,
            Constants.REGULAR_ENEMY_DIAMETER,
            false,
            false,
            true,
            this.levelIndex,
            this.isActive)
        );

        this.boundariesList.add(new HorizontalBoundary(
            0,
            height - 200,
            100,
            Constants.DEFAULT_BOUNDARY_LINE_THICKNESS,
            true,
            this.isActive,
            this.levelIndex
        ));

        this.boundariesList.add(new HorizontalBoundary(
            100,
            height - 400,
            100,
            Constants.DEFAULT_BOUNDARY_LINE_THICKNESS,
            true,
            this.isActive,
            this.levelIndex
        ));

        this.boundariesList.add(new HorizontalBoundary(
            200,
            height - 600,
            100,
            Constants.DEFAULT_BOUNDARY_LINE_THICKNESS,
            false,
            this.isActive,
            this.levelIndex
        ));

        this.boundariesList.add(new HorizontalBoundary(
            100,
            height - 800,
            100,
            Constants.DEFAULT_BOUNDARY_LINE_THICKNESS,
            true,
            this.isActive,
            this.levelIndex
        ));

        // this.blocksList.add(new EventBlock( // launch event
        //     global_levels_width_array[this.levelIndex] / 2 - 300,
        //     stageFloorYPositon - Constants.DEFAULT_EVENT_BLOCK_HEIGHT,
        //     Constants.DEFAULT_EVENT_BLOCK_WIDTH,
        //     Constants.DEFAULT_EVENT_BLOCK_HEIGHT,
        //     Constants.DEFAULT_BOUNDARY_LINE_THICKNESS,
        //     true, 
        //     this.isActive,
        //     this.levelIndex
        // ));

        int playerWarpEndXPos = 1000;
        // int playerWarpEndXPos = global_levels_width_array[this.levelIndex] - Constants.PLAYER_DIAMETER - 1;  // test end of state
        // int playerWarpEndXPos = Constants.PLAYER_DIAMETER / 2 + 1;   // test beginning of stage

        this.blocksList.add(new EventBlock( // launch event
            global_levels_width_array[this.levelIndex] / 2 - 300,
            stageFloorYPositon - Constants.DEFAULT_EVENT_BLOCK_HEIGHT,
            Constants.DEFAULT_EVENT_BLOCK_WIDTH,
            Constants.DEFAULT_EVENT_BLOCK_HEIGHT,
            Constants.DEFAULT_BOUNDARY_LINE_THICKNESS,       
            playerWarpEndXPos,
            750,
            true, 
            this.isActive,
            this.levelIndex
        ));

        // this.blocksList.add(new Block(
        //     global_levels_width_array[this.levelIndex] / 2 - 300,
        //     height - 300,
        //     Constants.DEFAULT_BLOCK_SIZE,
        //     Constants.DEFAULT_BLOCK_SIZE,
        //     Constants.DEFAULT_BOUNDARY_LINE_THICKNESS,
        //     false,
        //     this.isActive,
        //     this.levelIndex
        // ));

        // this.blocksList.add(new Block(
        //     global_levels_width_array[this.levelIndex] / 2 - 300 + Constants.DEFAULT_BLOCK_SIZE,
        //     height - 300 - Constants.DEFAULT_BLOCK_SIZE,
        //     Constants.DEFAULT_BLOCK_SIZE,
        //     Constants.DEFAULT_BLOCK_SIZE,
        //     Constants.DEFAULT_BOUNDARY_LINE_THICKNESS,
        //     true,
        //     this.isActive,
        //     this.levelIndex
        // ));

        // stage floor
        this.boundariesList.add(new HorizontalBoundary(
            0,
            stageFloorYPositon,
            global_levels_width_array[this.levelIndex],
            Constants.DEFAULT_BOUNDARY_LINE_THICKNESS,
            true,
            this.isActive,
            this.levelIndex
        ));

        // stage right and left walls
        this.boundariesList.add(new VerticalBoundary(
            0,
            0,
            stageFloorYPositon,
            Constants.DEFAULT_BOUNDARY_LINE_THICKNESS,
            this.isActive,
            this.levelIndex
        ));

        this.boundariesList.add(new VerticalBoundary(
            global_levels_width_array[this.levelIndex],
            0,
            stageFloorYPositon,
            Constants.DEFAULT_BOUNDARY_LINE_THICKNESS,
            this.isActive,
            this.levelIndex
        ));
    }

}
