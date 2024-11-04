class Combat {
    private final int id;
    private final String name;
    private int combatEffectiveness;

    public Combat(int id, String name, int combatEffectiveness) {
        this.id = id;
        this.name = name;
        this.combatEffectiveness = combatEffectiveness;
    }

    public int getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    protected int getCombatEffectiveness() {
        return combatEffectiveness;
    }

    protected void setCombatEffectiveness(int combatEffectiveness) {
        this.combatEffectiveness = combatEffectiveness;
    }
}
