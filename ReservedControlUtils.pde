/**
 * For handling reserved key controls
 */
public class ReservedControlUtils {

    /**
     * @return true if given keycode is reserved
     */
    public boolean isKeyCodeReserved(int keyToTest) {
        String keyStr = (char) keyToTest + "";
        try {
            EReservedControlKeys.valueOf(keyStr.toLowerCase());
            return true;
        } catch (IllegalArgumentException ex) {
            return false;
        }
    }
}
