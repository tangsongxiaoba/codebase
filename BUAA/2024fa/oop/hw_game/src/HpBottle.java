class HpBottle extends Bottle {
    public HpBottle(int id, String name, int capacity) {
        super(id, name, 0, capacity);
    }

    @Override
    public int getEffectiveness() {
        return getAttr();
    }
}
