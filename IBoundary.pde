/**
 * states required methods for boundaries
 */
interface IBoundary {
    boolean collisionWithCharacter(ACharacter character);
    void draw();
}