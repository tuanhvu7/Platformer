/**
 * menu to select level to play;
 */
public class LevelSelectMenu extends AMenu implements IDrawable {

    /**
     * set properties of this
     */
    public LevelSelectMenu(boolean isActive) {
        super(isActive);
    }

    /**
     * setup and activate this
     */
    @Override
    public void setupActivateMenu() {
        // make this active
        this.isActive = true;
        registerMethod("draw", this); // connect this draw() from main draw()

        this.panelsList.add(new LevelSelectMenuPanel(
            1,
            100,
            100,
            Constants.PANEL_WIDTH,
            Constants.PANEL_HEIGHT,
            this.isActive
        ));

        this.panelsList.add(new LevelSelectMenuPanel(
            2,
            400,
            100,
            Constants.PANEL_WIDTH,
            Constants.PANEL_HEIGHT,
            this.isActive
        ));

        loopSong(ESongType.LevelSelectMenu);
    }

    /**
     * runs continuously; draws background of this
     */
    @Override
    public void draw() {
        image(
            getLevelBackgroundImage(),
            0,
            0,
            getLevelBackgroundImage().width,
            getLevelBackgroundImage().height);
    }

}