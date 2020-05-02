/**
 * Used for registerMethod and unregisterMethod
 */
public enum EProcessingMethods {
    DRAW("draw"),
    KEY_EVENT("keyEvent"),
    MOUSE_EVENT("mouseEvent");

    private final String value;

    private EProcessingMethods(final String value) {
        this.value = value;
    }

    @Override
    public String toString() {
        return value;
    }
}
