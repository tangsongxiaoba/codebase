import java.util.ArrayList;

public class Expr {
    private final ArrayList<Term> terms = new ArrayList<>();

    public void addTerm(Term term) {
        terms.add(term);
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        for (Term term : terms) {
            sb.append(term.toString());
            sb.append("+");
        }
        return sb.substring(0, sb.length() - 1);
    }

    public void print() {
        System.out.println("Expr " + this);
    }

}
