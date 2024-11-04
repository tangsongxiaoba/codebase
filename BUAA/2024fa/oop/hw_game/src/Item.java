abstract class Item extends Combat {
    public Item(int id, String name, int combatEffectiveness) {
        super(id, name, combatEffectiveness);
    }

    public abstract int getAttr();

    public abstract void setAttr(int attr);

    public abstract int getEffectiveness();
}
