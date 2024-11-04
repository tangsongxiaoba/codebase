class Equipment extends Item {
    private int durability;

    public Equipment(int id, String name, int combatEffectiveness, int durability) {
        super(id, name, combatEffectiveness);
        this.durability = durability;
    }

    public int getAttr() {
        return durability;
    }

    public void setAttr(int attr) {
        this.durability = attr;
    }

    public int getEffectiveness() {
        return getCombatEffectiveness();
    }

}