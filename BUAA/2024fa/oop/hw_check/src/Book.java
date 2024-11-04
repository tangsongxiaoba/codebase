import java.util.Objects;

public class Book {
    private final String name;
    private String magic;

    public Book(String name, String magic) {
        this.name = name;
        this.magic = magic;
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj) { return true; }
        if (obj == null || getClass() != obj.getClass()) { return false; }
        Book other = (Book) obj;
        return Objects.equals(name, other.name) && Objects.equals(magic, other.magic);
    }

    public String getName() {
        return name;
    }

    public String getMagic() { return magic; }

    //@Override
    public Book cloned() {
        return new Book(name, magic);
    }

    public int getScore() {
        int res = 0;
        for (int l = 0; l < magic.length(); l++) {
            for (int r = l + 1; r <= magic.length(); r++) {
                String s = magic.substring(l, r);
                int len = s.length();
                if (len < 2) { continue; }
                int num = 0;
                int alph = 0;
                int jing = 0;
                for (int i = 0; i < len; i++) {
                    if (Character.isDigit(s.charAt(i))) { num++; }
                    else if (s.charAt(i) == '#') { jing++; }
                    else if (Character.isAlphabetic(s.charAt(i))) { alph++; }
                }
                if (s.charAt(0) == '#' && s.charAt(len - 1) == '#'
                        && jing == 2 && num > 0 && num >= alph) {
                    res++;
                }
            }
        }
        return res;
    }

    public void addMagic(String magic) {
        this.magic += magic;
    }

    public void subMagic(int a, int b) {
        if (a <= b) {
            if (a >= magic.length()) {
                magic = "";
            } else {
                magic = magic.substring(a, Integer.min(b + 1, magic.length()));
            }
        } else {
            magic = "";
        }
    }

    public boolean contains(String s) {
        return magic.contains(s);
    }
}
