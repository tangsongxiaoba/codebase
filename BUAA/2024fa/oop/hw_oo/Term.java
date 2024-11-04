import java.util.ArrayList;

public class Term {
    private final ArrayList<Factor> factors = new ArrayList<>();

    public void addFactor(Factor factor) {
        factors.add(factor);
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        for (Factor factor : factors) {
            if (factor instanceof SubExpr) {
                sb.append("(" + factor.toString() + ")");
            } else {
                sb.append(factor.toString());
            }
            sb.append("*");
        }
        return sb.substring(0, sb.length() - 1); // remove the last "*"
    }

    public void print() {
        System.out.println("Term " + this);
    }
}
