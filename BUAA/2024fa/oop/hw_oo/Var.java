public class Var implements Factor {
    private final String name;

    public Var(String name) {
        this.name = name;
    }

    @Override
    public String toString() {
        return name;
    }

    public void print() {
        System.out.println("Var " + this);
    }
}
