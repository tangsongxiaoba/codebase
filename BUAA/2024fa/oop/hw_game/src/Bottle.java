import static java.lang.Math.floor;

abstract class Bottle extends Item {
    private boolean isEmpty;
    private int capacity;

    public Bottle(int id, String name, int combatEffectiveness, int capacity) {
        super(id, name, combatEffectiveness);
        this.capacity = capacity;
        this.isEmpty = false;
    }

    public int getAttr() {
        return capacity;
    }

    public void setAttr(int attr) {
        this.capacity = attr;
    }

    public boolean isEmpty() {
        return isEmpty;
    }

    public void setEmpty(boolean empty) {
        isEmpty = empty;
    }

    public int getEffectiveness() {
        return (int) (getCombatEffectiveness() + floor((double) capacity / 100));
    }
}