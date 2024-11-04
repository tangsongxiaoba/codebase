public class Pet {
    private final String name;
    private int hunger;
    private int happiness;
    private int health;
    private int biscuitCount;

    public Pet(String name, int hunger, int happiness, int health) {
        this.name = name;
        this.hunger = hunger;
        this.happiness = happiness;
        this.health = health;
        this.biscuitCount = 0;
    }

    public void eat(String foodName) {
        if (foodName.equals("biscuit")) {
            biscuitCount++;
            int maxBiscuitCount = 3;
            if (biscuitCount > maxBiscuitCount) {
                health -= 5;
            }
            int biscuitHungerReduction = 10;
            hunger -= biscuitHungerReduction;
        } else {
            int fruitHungerReduction = 8;
            hunger -= fruitHungerReduction;
        }
        hunger = Math.max(hunger, 0);
    }

    public void play() {
        happiness += 5;
        if (happiness > 100) {
            happiness = 100;
        }
    }

    public void printStatus() {
        System.out.println(name + ":");
        System.out.println("Hunger: " + hunger);
        System.out.println("Happiness: " + happiness);
        System.out.println("Health: " + health);
    }
}
