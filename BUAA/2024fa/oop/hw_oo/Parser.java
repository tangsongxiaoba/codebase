public class Parser {
    private final Lexer lexer;

    public Parser(Lexer lexer) {
        this.lexer = lexer;
    }

    public Expr parseExpr() {
        Expr expr = new Expr();
        expr.addTerm(parseTerm());
        while (!lexer.isEnd() && lexer.getCurToken().getType() == Token.Type.ADD) {
            lexer.nextToken();
            expr.addTerm(parseTerm());
        }
        expr.print();
        return expr;
    }

    public Term parseTerm() {
        Term term = new Term();
        term.addFactor(parseFactor());
        while (!lexer.isEnd() && lexer.getCurToken().getType() == Token.Type.MUL) {
            lexer.nextToken();
            term.addFactor(parseFactor());
        }
        term.print();
        return term;
    }

    public Factor parseFactor() {
        Token token = lexer.getCurToken();
        if (token.getType() == Token.Type.NUM) {
            return parseNum();
        } else if (token.getType() == Token.Type.VAR) {
            return parseVar();
        } else {
            lexer.nextToken();
            Factor subExprFactor = parseSubExpr();
            lexer.nextToken();
            return subExprFactor;
        }
    }

    public SubExpr parseSubExpr() {
        SubExpr subExpression = new SubExpr();
        subExpression.addTerm(parseSubTerm());
        while (!lexer.isEnd() && lexer.getCurToken().getType() == Token.Type.ADD) {
            lexer.nextToken();
            subExpression.addTerm(parseSubTerm());
        }
        subExpression.print();
        return subExpression;
    }

    public SubTerm parseSubTerm() {
        SubTerm subTerm = new SubTerm();
        subTerm.addFactor(parseNum());
        while (!lexer.isEnd() && lexer.getCurToken().getType() == Token.Type.MUL) {
            lexer.nextToken();
            subTerm.addFactor(parseNum());
        }
        subTerm.print();
        return subTerm;
    }

    public Num parseNum() {
        Token token = lexer.getCurToken();
        lexer.nextToken();
        Num num = new Num(Integer.parseInt(token.getContent()));
        num.print();
        return num;
    }

    public Var parseVar() {
        Token token = lexer.getCurToken();
        lexer.nextToken();
        Var var = new Var(token.getContent());
        var.print();
        return var;
    }
}
